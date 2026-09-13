export class PacketWriter {
  private chunks: Uint8Array[] = [];
  private opcode: number;
  private encoder = new TextEncoder();

  constructor(opcode: number) {
    this.opcode = opcode;
  }

  public writeUInt8(val: number): this {
    const buf = new Uint8Array(1);
    new DataView(buf.buffer).setUint8(0, val);
    this.chunks.push(buf);
    return this;
  }

  public writeUInt16BE(val: number): this {
    const buf = new Uint8Array(2);
    new DataView(buf.buffer).setUint16(0, val, false);
    this.chunks.push(buf);
    return this;
  }

  public writeUInt32BE(val: number): this {
    const buf = new Uint8Array(4);
    new DataView(buf.buffer).setUint32(0, val, false);
    this.chunks.push(buf);
    return this;
  }

  public writeFlushUTF(str: string): this {
    const strBytes = this.encoder.encode(str || '');
    const lenBuf = new Uint8Array(4);
    new DataView(lenBuf.buffer).setUint32(0, strBytes.length, false);
    this.chunks.push(lenBuf);
    if (strBytes.length > 0) {
      this.chunks.push(strBytes);
    }
    return this;
  }

  public toArrayBuffer(): ArrayBuffer {
    let payloadLength = 0;
    for (const chunk of this.chunks) {
      payloadLength += chunk.length;
    }

    const totalLength = 8 + payloadLength;
    const finalBuffer = new Uint8Array(totalLength);
    const view = new DataView(finalBuffer.buffer);

    // 8 bytes de Header: Length + Opcode
    view.setUint32(0, totalLength, false);
    view.setUint32(4, this.opcode, false);

    let offset = 8;
    for (const chunk of this.chunks) {
      finalBuffer.set(chunk, offset);
      offset += chunk.length;
    }

    return finalBuffer.buffer;
  }
}
