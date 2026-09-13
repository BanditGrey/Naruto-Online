export class PacketReader {
  private view: DataView;
  private offset = 0;
  private decoder = new TextDecoder('utf-8');

  constructor(buffer: ArrayBuffer) {
    this.view = new DataView(buffer);
  }

  public get remaining(): number {
    return this.view.byteLength - this.offset;
  }

  public readUInt8(): number {
    const val = this.view.getUint8(this.offset);
    this.offset += 1;
    return val;
  }

  public readInt8(): number {
    const val = this.view.getInt8(this.offset);
    this.offset += 1;
    return val;
  }

  public readUInt16BE(): number {
    const val = this.view.getUint16(this.offset, false);
    this.offset += 2;
    return val;
  }

  public readInt16BE(): number {
    const val = this.view.getInt16(this.offset, false);
    this.offset += 2;
    return val;
  }

  public readUInt32BE(): number {
    const val = this.view.getUint32(this.offset, false);
    this.offset += 4;
    return val;
  }

  public readInt32BE(): number {
    const val = this.view.getInt32(this.offset, false);
    this.offset += 4;
    return val;
  }

  public readFloatBE(): number {
    const val = this.view.getFloat32(this.offset, false);
    this.offset += 4;
    return val;
  }

  public readFlushUTF(): string {
    if (this.remaining < 4) return '';
    const byteLength = this.readUInt32BE();
    if (byteLength === 0) return '';
    if (this.remaining < byteLength) {
      throw new Error(`PacketReader: buffer overflow ao ler FlushUTF. Esperado ${byteLength}, restam ${this.remaining}`);
    }
    const bytes = new Uint8Array(this.view.buffer, this.view.byteOffset + this.offset, byteLength);
    this.offset += byteLength;
    return this.decoder.decode(bytes);
  }
}
