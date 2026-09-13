/**
 * Leitor binário Big Endian estritamente compatível com TTransceiver.as e TUtilityString.as do Flash original.
 */
export class PacketReader {
  private offset = 0;
  private buffer: Buffer;

  constructor(data: Buffer | ArrayBuffer) {
    this.buffer = Buffer.isBuffer(data) ? data : Buffer.from(data);
  }

  public get length(): number {
    return this.buffer.length;
  }

  public get remaining(): number {
    return this.buffer.length - this.offset;
  }

  public get currentOffset(): number {
    return this.offset;
  }

  public readUInt8(): number {
    const val = this.buffer.readUInt8(this.offset);
    this.offset += 1;
    return val;
  }

  public readInt8(): number {
    const val = this.buffer.readInt8(this.offset);
    this.offset += 1;
    return val;
  }

  public readUInt16BE(): number {
    const val = this.buffer.readUInt16BE(this.offset);
    this.offset += 2;
    return val;
  }

  public readInt16BE(): number {
    const val = this.buffer.readInt16BE(this.offset);
    this.offset += 2;
    return val;
  }

  public readUInt32BE(): number {
    const val = this.buffer.readUInt32BE(this.offset);
    this.offset += 4;
    return val;
  }

  public readInt32BE(): number {
    const val = this.buffer.readInt32BE(this.offset);
    this.offset += 4;
    return val;
  }

  public readFloatBE(): number {
    const val = this.buffer.readFloatBE(this.offset);
    this.offset += 4;
    return val;
  }

  public readDoubleBE(): number {
    const val = this.buffer.readDoubleBE(this.offset);
    this.offset += 8;
    return val;
  }

  /**
   * Padrão Flash TUtilityString.FetchUTF:
   * Prefixo uint32 BE indicando a contagem exata de bytes da string UTF-8.
   */
  public readFlushUTF(): string {
    if (this.remaining < 4) return '';
    const byteLength = this.readUInt32BE();
    if (byteLength === 0) return '';
    if (this.remaining < byteLength) {
      throw new Error(`PacketReader: buffer overflow ao ler FlushUTF. Esperado ${byteLength} bytes, restam ${this.remaining}`);
    }
    const str = this.buffer.toString('utf8', this.offset, this.offset + byteLength);
    this.offset += byteLength;
    return str;
  }

  public readBytes(length: number): Buffer {
    const slice = this.buffer.subarray(this.offset, this.offset + length);
    this.offset += length;
    return Buffer.from(slice);
  }
}
