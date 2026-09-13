/**
 * Escritor binário Big Endian estritamente compatível com TTransceiver.as e TPacket.as.
 * Constrói pacotes com cabeçalho canônico de 8 Bytes:
 * [PacketLength: uint32 BE (8 + payload)] + [PacketID/Opcode: uint32 BE] + [Payload]
 */
export class PacketWriter {
  private chunks: Buffer[] = [];
  private opcode: number;

  constructor(opcode: number) {
    this.opcode = opcode;
  }

  public writeUInt8(val: number): this {
    const buf = Buffer.allocUnsafe(1);
    buf.writeUInt8(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeInt8(val: number): this {
    const buf = Buffer.allocUnsafe(1);
    buf.writeInt8(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeUInt16BE(val: number): this {
    const buf = Buffer.allocUnsafe(2);
    buf.writeUInt16BE(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeInt16BE(val: number): this {
    const buf = Buffer.allocUnsafe(2);
    buf.writeInt16BE(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeUInt32BE(val: number): this {
    const buf = Buffer.allocUnsafe(4);
    buf.writeUInt32BE(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeInt32BE(val: number): this {
    const buf = Buffer.allocUnsafe(4);
    buf.writeInt32BE(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeFloatBE(val: number): this {
    const buf = Buffer.allocUnsafe(4);
    buf.writeFloatBE(val, 0);
    this.chunks.push(buf);
    return this;
  }

  public writeDoubleBE(val: number): this {
    const buf = Buffer.allocUnsafe(8);
    buf.writeDoubleBE(val, 0);
    this.chunks.push(buf);
    return this;
  }

  /**
   * Padrão Flash TUtilityString.FlushUTF:
   * Escreve o prefixo uint32 BE com o tamanho em bytes seguido pela string UTF-8.
   */
  public writeFlushUTF(str: string): this {
    const strBuf = Buffer.from(str || '', 'utf8');
    const lenBuf = Buffer.allocUnsafe(4);
    lenBuf.writeUInt32BE(strBuf.length, 0);
    this.chunks.push(lenBuf);
    if (strBuf.length > 0) {
      this.chunks.push(strBuf);
    }
    return this;
  }

  public writeBytes(buf: Buffer): this {
    this.chunks.push(Buffer.from(buf));
    return this;
  }

  /**
   * Gera o Buffer final pronto para envio via WebSocket.
   * Cabeçalho de 8 bytes:
   * - 4 bytes: PacketLength (8 + payload.length)
   * - 4 bytes: PacketID / Opcode
   */
  public toBuffer(): Buffer {
    const payload = Buffer.concat(this.chunks);
    const totalLength = 8 + payload.length;

    const header = Buffer.allocUnsafe(8);
    header.writeUInt32BE(totalLength, 0);
    header.writeUInt32BE(this.opcode, 4);

    return Buffer.concat([header, payload]);
  }
}
