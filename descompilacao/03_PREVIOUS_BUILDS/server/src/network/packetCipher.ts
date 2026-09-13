/**
 * Joyfun Cryptographic Packet Cipher (TPacketCipher.as reverse engineered)
 * Handles full bidirectional encryption/decryption between the official Flash client and server.
 */

const PACKET_KEY = 3346777707;

const MAPPING_EncryptMap: number[] = [
  112, 47, 64, 95, 68, 142, 110, 69, 126, 171, 44, 31, 180, 172, 157, 145, 13, 54, 155, 11,
  212, 196, 57, 116, 191, 35, 22, 20, 6, 235, 4, 62, 18, 92, 139, 188, 97, 99, 246, 165,
  225, 101, 216, 245, 90, 7, 240, 19, 242, 32, 107, 74, 36, 89, 137, 100, 215, 66, 106, 94,
  61, 10, 119, 224, 128, 39, 184, 197, 140, 14, 250, 138, 213, 41, 86, 87, 108, 83, 103, 65,
  232, 0, 26, 206, 134, 131, 176, 34, 40, 77, 63, 38, 70, 79, 111, 43, 114, 58, 241, 141,
  151, 149, 73, 132, 229, 227, 121, 143, 81, 16, 168, 130, 198, 221, 255, 252, 228, 207, 179, 9,
  93, 234, 156, 52, 249, 23, 159, 218, 135, 248, 21, 5, 60, 211, 164, 133, 46, 251, 238, 71,
  59, 239, 55, 127, 147, 175, 105, 12, 113, 49, 222, 33, 117, 160, 170, 186, 124, 56, 2, 183,
  129, 1, 253, 231, 29, 204, 205, 189, 27, 122, 42, 173, 102, 190, 85, 51, 3, 219, 136, 178,
  30, 78, 185, 230, 194, 247, 203, 125, 201, 98, 195, 166, 220, 167, 80, 181, 75, 148, 192, 146,
  76, 17, 91, 120, 217, 177, 237, 25, 233, 161, 28, 182, 50, 153, 163, 118, 158, 123, 109, 154,
  48, 214, 169, 37, 199, 174, 150, 53, 208, 187, 210, 200, 162, 8, 243, 209, 115, 244, 72, 45,
  144, 202, 226, 88, 193, 24, 82, 254, 223, 104, 152, 84, 236, 96, 67, 15,
];

const MAPPING_CrevasseMap: number[] = [
  81, 161, 158, 176, 30, 131, 28, 45, 233, 119, 61, 19, 147, 16, 69, 255, 109, 201, 32, 47,
  27, 130, 26, 125, 245, 207, 82, 168, 210, 164, 180, 11, 49, 151, 87, 25, 52, 223, 91, 65,
  88, 73, 170, 95, 10, 239, 136, 1, 220, 149, 212, 175, 123, 227, 17, 142, 157, 22, 97,
  140, 132, 60, 31, 90, 2, 79, 57, 254, 4, 7, 92, 139, 238, 102, 51, 196, 200, 89, 181,
  93, 194, 108, 246, 77, 251, 174, 74, 75, 243, 53, 44, 202, 33, 120, 59, 3, 253, 36, 189,
  37, 55, 41, 172, 78, 249, 146, 58, 50, 76, 218, 6, 94, 0, 148, 96, 236, 23, 152, 215,
  62, 203, 106, 169, 217, 156, 187, 8, 143, 64, 160, 111, 85, 103, 135, 84, 128, 178, 54, 71,
  34, 68, 99, 5, 107, 240, 15, 199, 144, 197, 101, 226, 100, 250, 213, 219, 18, 122, 14, 216,
  126, 153, 209, 232, 214, 134, 39, 191, 193, 110, 222, 154, 9, 13, 171, 225, 145, 86, 205, 179,
  118, 12, 195, 211, 159, 66, 182, 155, 229, 35, 167, 173, 24, 198, 244, 184, 190, 21, 67, 112,
  224, 231, 188, 241, 186, 165, 166, 83, 117, 228, 235, 230, 133, 20, 72, 221, 56, 42, 204, 127,
  177, 192, 113, 150, 248, 63, 40, 242, 105, 116, 104, 183, 163, 80, 208, 121, 29, 252, 206, 138,
  141, 46, 98, 48, 234, 237, 43, 38, 185, 129, 124, 70, 137, 115, 162, 247, 114,
];

function seedRandMap(val: number): number {
  return Math.floor((val * 241103 + 2933101) / 65536) & 0xffff;
}

export interface DecryptedPacket {
  packetId: number;
  data: Buffer;
}

export class JoyfunCipher {
  private sendRound: number = 0;
  private recvRound: number = 0;
  private sendRoundEx: number = 0;
  private recvRoundEx: number = 0;
  private sendXorKey: number = 0;
  private recvXorKey: number = 0;
  private sendPacketCount: number = 0;
  private recvPacketCount: number = 0;
  private roundStep: number = 7;
  private encryptMaps: Buffer;
  private crevasseMaps: Buffer;

  constructor() {
    this.encryptMaps = Buffer.from(MAPPING_EncryptMap);
    this.crevasseMaps = Buffer.from(MAPPING_CrevasseMap);
    this.sendXorKey = (Math.random() * 0x7fffffff) >>> 0;
  }

  public getRecvPacketCount(): number {
    return this.recvPacketCount;
  }

  public getSendPacketCount(): number {
    return this.sendPacketCount;
  }

  /**
   * Decrypts an incoming client packet payload (without the leading 4-byte total length).
   */
  public decryptClientPacket(payload: Buffer): DecryptedPacket {
    if (this.recvPacketCount === 0) {
      // Packet #0 from client has 4-byte LE initial XOR key prefix
      const initialKey = payload.readUInt32LE(0);
      this.recvXorKey = initialKey;
      let curKey = initialKey;
      const cipherBody = payload.subarray(4);

      const padNeeded = (4 - (cipherBody.length % 4)) % 4;
      const paddedCipher = Buffer.concat([cipherBody, Buffer.alloc(padNeeded, 0)]);

      const plainWords = Buffer.alloc(paddedCipher.length);
      for (let i = 0; i < paddedCipher.length; i += 4) {
        if (i === paddedCipher.length - 4 && padNeeded > 0) {
          const keyBuf = Buffer.alloc(4);
          keyBuf.writeUInt32LE(curKey, 0);
          for (let k = 0; k < padNeeded; k++) {
            paddedCipher[i + (4 - padNeeded) + k] = keyBuf[k];
          }
        }
        const cWord = paddedCipher.readUInt32LE(i);
        const pWord = (cWord ^ curKey) >>> 0;
        plainWords.writeUInt32LE(pWord, i);
        const low = cWord & 0xffff;
        const high = (cWord >>> 16) & 0xffff;
        curKey = (((seedRandMap(low) | (seedRandMap(high) << 16))) ^ PACKET_KEY) >>> 0;
      }
      this.recvXorKey = curKey;

      // Unmap bytes with MAPPING_CrevasseMap
      const unmapped = Buffer.alloc(plainWords.length);
      for (let i = 0; i < plainWords.length; i++) {
        const b = plainWords[i];
        const orig = (MAPPING_CrevasseMap[b] - this.recvRound + 256) % 256;
        this.recvRound = (this.recvRound + 3) % 256;
        unmapped[i] = orig;
      }

      this.recvPacketCount++;
      const packetId = unmapped.readUInt32BE(0);
      const rawData = unmapped.subarray(4, cipherBody.length - 1);
      return { packetId, data: Buffer.from(rawData) };
    } else {
      // Packet #1+ from client uses running recvXorKey and crevasseMaps
      let curKey = this.recvXorKey;
      const padNeeded = (4 - (payload.length % 4)) % 4;
      const paddedCipher = Buffer.concat([payload, Buffer.alloc(padNeeded, 0)]);

      const plainWords = Buffer.alloc(paddedCipher.length);
      for (let i = 0; i < paddedCipher.length; i += 4) {
        if (i === paddedCipher.length - 4 && padNeeded > 0) {
          const keyBuf = Buffer.alloc(4);
          keyBuf.writeUInt32LE(curKey, 0);
          for (let k = 0; k < padNeeded; k++) {
            paddedCipher[i + (4 - padNeeded) + k] = keyBuf[k];
          }
        }
        const cWord = paddedCipher.readUInt32LE(i);
        const pWord = (cWord ^ curKey) >>> 0;
        plainWords.writeUInt32LE(pWord, i);
        const low = cWord & 0xffff;
        const high = (cWord >>> 16) & 0xffff;
        curKey = (((seedRandMap(low) | (seedRandMap(high) << 16))) ^ PACKET_KEY) >>> 0;
      }
      this.recvXorKey = curKey;

      const unmapped = Buffer.alloc(payload.length - 1);
      for (let i = 0; i < unmapped.length; i++) {
        const b = plainWords[i];
        const orig = (this.crevasseMaps[b] - this.recvRoundEx + 256) % 256;
        this.recvRoundEx = (this.recvRoundEx + this.roundStep) % 256;
        unmapped[i] = orig;
      }

      this.recvPacketCount++;
      const packetId = unmapped.readUInt32BE(0);
      const data = unmapped.subarray(4);
      return { packetId, data: Buffer.from(data) };
    }
  }

  /**
   * Encrypts a packet to send to the official Flash client.
   * Returns a complete wire buffer ready to write directly to the raw TCP socket (includes 4-byte BE length header).
   */
  public encryptServerPacket(packetId: number, data: Buffer = Buffer.alloc(0)): Buffer {
    const plainPkt = Buffer.alloc(4 + data.length);
    plainPkt.writeUInt32BE(packetId, 0);
    if (data.length > 0) {
      data.copy(plainPkt, 4);
    }

    if (this.sendPacketCount === 0) {
      // Server Packet #0: sends roundStep, encryptMaps, crevasseMaps, and mapped payload
      let sum = 0;
      const mappedPkt = Buffer.alloc(plainPkt.length + 1);
      for (let i = 0; i < plainPkt.length; i++) {
        const b = plainPkt[i];
        sum = (sum + b) % 256;
        mappedPkt[i] = this.encryptMaps[(b + this.sendRoundEx) % 256];
        this.sendRoundEx = (this.sendRoundEx + this.roundStep) % 256;
      }
      mappedPkt[plainPkt.length] = ((~sum + 1) & 0xff);

      const unencStream = Buffer.concat([
        Buffer.from([this.roundStep]),
        this.encryptMaps,
        this.crevasseMaps,
        mappedPkt,
      ]);

      const initKey = (Math.random() * 0x7fffffff) >>> 0;
      const padNeeded = (4 - (unencStream.length % 4)) % 4;
      const paddedStream = Buffer.concat([unencStream, Buffer.alloc(padNeeded, 0)]);

      let curKey = initKey;
      const cipherBody = Buffer.alloc(paddedStream.length);
      for (let i = 0; i < paddedStream.length; i += 4) {
        const pWord = paddedStream.readUInt32LE(i);
        const cWord = (pWord ^ curKey) >>> 0;
        cipherBody.writeUInt32LE(cWord, i);
        const low = cWord & 0xffff;
        const high = (cWord >>> 16) & 0xffff;
        curKey = (((seedRandMap(low) | (seedRandMap(high) << 16))) ^ PACKET_KEY) >>> 0;
      }
      this.sendXorKey = curKey;
      this.sendPacketCount++;

      const totalLen = 4 + 4 + cipherBody.length;
      const wireBuf = Buffer.alloc(totalLen);
      wireBuf.writeUInt32BE(totalLen, 0);
      wireBuf.writeUInt32LE(initKey, 4);
      cipherBody.copy(wireBuf, 8);
      return wireBuf;
    } else {
      // Server Packet #1+: mapped with encryptMaps and encrypted with running sendXorKey
      let sum = 0;
      const mappedPkt = Buffer.alloc(plainPkt.length + 1);
      for (let i = 0; i < plainPkt.length; i++) {
        const b = plainPkt[i];
        sum = (sum + b) % 256;
        mappedPkt[i] = this.encryptMaps[(b + this.sendRoundEx) % 256];
        this.sendRoundEx = (this.sendRoundEx + this.roundStep) % 256;
      }
      mappedPkt[plainPkt.length] = ((~sum + 1) & 0xff);

      const padNeeded = (4 - (mappedPkt.length % 4)) % 4;
      const padded = Buffer.concat([mappedPkt, Buffer.alloc(padNeeded, 0)]);

      let curKey = this.sendXorKey;
      const cipherBody = Buffer.alloc(padded.length);
      for (let i = 0; i < padded.length; i += 4) {
        const pWord = padded.readUInt32LE(i);
        const cWord = (pWord ^ curKey) >>> 0;
        cipherBody.writeUInt32LE(cWord, i);
        const low = cWord & 0xffff;
        const high = (cWord >>> 16) & 0xffff;
        curKey = (((seedRandMap(low) | (seedRandMap(high) << 16))) ^ PACKET_KEY) >>> 0;
      }
      this.sendXorKey = curKey;
      this.sendPacketCount++;

      const totalLen = 4 + cipherBody.length;
      const wireBuf = Buffer.alloc(totalLen);
      wireBuf.writeUInt32BE(totalLen, 0);
      cipherBody.copy(wireBuf, 4);
      return wireBuf;
    }
  }
}
