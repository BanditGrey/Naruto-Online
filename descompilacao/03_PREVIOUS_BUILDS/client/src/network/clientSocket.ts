import { OPCODES, getOpcodeName } from '../../../shared/opcodes.ts';

export const SIZE_PACKET_HEADER = 8;

/**
 * Utilitário de leitura de pacotes binários para o Browser usando DataView
 */
export class WebPacketReader {
  private view: DataView;
  private offset: number;

  constructor(buffer: ArrayBuffer, offset: number = 0) {
    this.view = new DataView(buffer);
    this.offset = offset;
  }

  public get bytesAvailable(): number {
    return Math.max(0, this.view.byteLength - this.offset);
  }

  public get position(): number {
    return this.offset;
  }

  public readByte(): number {
    const val = this.view.getInt8(this.offset);
    this.offset += 1;
    return val;
  }

  public readUnsignedByte(): number {
    const val = this.view.getUint8(this.offset);
    this.offset += 1;
    return val;
  }

  public readShort(littleEndian: boolean = false): number {
    const val = this.view.getInt16(this.offset, littleEndian);
    this.offset += 2;
    return val;
  }

  public readInt16(littleEndian: boolean = false): number {
    return this.readShort(littleEndian);
  }

  public readUnsignedShort(littleEndian: boolean = false): number {
    const val = this.view.getUint16(this.offset, littleEndian);
    this.offset += 2;
    return val;
  }

  public readUInt16(littleEndian: boolean = false): number {
    return this.readUnsignedShort(littleEndian);
  }

  public readInt(littleEndian: boolean = false): number {
    const val = this.view.getInt32(this.offset, littleEndian);
    this.offset += 4;
    return val;
  }

  public readInt32(littleEndian: boolean = false): number {
    return this.readInt(littleEndian);
  }

  public readUnsignedInt(littleEndian: boolean = false): number {
    const val = this.view.getUint32(this.offset, littleEndian);
    this.offset += 4;
    return val;
  }

  public readUInt32(littleEndian: boolean = false): number {
    return this.readUnsignedInt(littleEndian);
  }

  public readFloat(littleEndian: boolean = false): number {
    const val = this.view.getFloat32(this.offset, littleEndian);
    this.offset += 4;
    return val;
  }

  public readDouble(littleEndian: boolean = false): number {
    const val = this.view.getFloat64(this.offset, littleEndian);
    this.offset += 8;
    return val;
  }

  /**
   * Lê uma string no formato Flash FlushUTF / FetchUTF (uint32 BE tamanho + bytes UTF-8)
   */
  public readStringUTF(): string {
    const len = this.readUnsignedInt(false);
    if (len === 0) return '';
    const bytes = new Uint8Array(this.view.buffer, this.view.byteOffset + this.offset, len);
    this.offset += len;
    return new TextDecoder().decode(bytes);
  }

  public readFlushUTF(): string {
    return this.readStringUTF();
  }
}

/**
 * Utilitário de escrita de pacotes binários para o Browser
 */
export class WebPacketWriter {
  private chunks: Uint8Array[] = [];
  private currentLength: number = 0;

  constructor() {}

  public writeByte(value: number): this {
    const u8 = new Uint8Array(1);
    u8[0] = value & 0xff;
    this.chunks.push(u8);
    this.currentLength += 1;
    return this;
  }

  public writeShort(value: number, littleEndian: boolean = false): this {
    const buf = new ArrayBuffer(2);
    new DataView(buf).setInt16(0, value, littleEndian);
    this.chunks.push(new Uint8Array(buf));
    this.currentLength += 2;
    return this;
  }

  public writeInt16(value: number, littleEndian: boolean = false): this {
    return this.writeShort(value, littleEndian);
  }

  public writeUnsignedShort(value: number, littleEndian: boolean = false): this {
    const buf = new ArrayBuffer(2);
    new DataView(buf).setUint16(0, value, littleEndian);
    this.chunks.push(new Uint8Array(buf));
    this.currentLength += 2;
    return this;
  }

  public writeUInt16(value: number, littleEndian: boolean = false): this {
    return this.writeUnsignedShort(value, littleEndian);
  }

  public writeInt(value: number, littleEndian: boolean = false): this {
    const buf = new ArrayBuffer(4);
    new DataView(buf).setInt32(0, value, littleEndian);
    this.chunks.push(new Uint8Array(buf));
    this.currentLength += 4;
    return this;
  }

  public writeInt32(value: number, littleEndian: boolean = false): this {
    return this.writeInt(value, littleEndian);
  }

  public writeUnsignedInt(value: number, littleEndian: boolean = false): this {
    const buf = new ArrayBuffer(4);
    new DataView(buf).setUint32(0, value, littleEndian);
    this.chunks.push(new Uint8Array(buf));
    this.currentLength += 4;
    return this;
  }

  public writeUInt32(value: number, littleEndian: boolean = false): this {
    return this.writeUnsignedInt(value, littleEndian);
  }

  public writeStringUTF(str: string): this {
    const encoded = new TextEncoder().encode(str ?? '');
    this.writeUnsignedInt(encoded.length, false);
    this.chunks.push(encoded);
    this.currentLength += encoded.length;
    return this;
  }

  public toPacket(opcode: number): ArrayBuffer {
    const totalLen = SIZE_PACKET_HEADER + this.currentLength;
    const finalBuf = new ArrayBuffer(totalLen);
    const view = new DataView(finalBuf);

    // Cabeçalho no Modo Plano (Big Endian)
    view.setUint32(0, totalLen, false);
    view.setUint32(4, opcode >>> 0, false);

    let offset = SIZE_PACKET_HEADER;
    const target = new Uint8Array(finalBuf);
    for (const chunk of this.chunks) {
      target.set(chunk, offset);
      offset += chunk.length;
    }

    return finalBuf;
  }
}

export type PacketCallback = (reader: WebPacketReader, length: number) => void;

/**
 * Cliente WebSocket oficial para Naruto Online Web
 */
export class ClientSocket {
  private ws: WebSocket | null = null;
  private listeners: Map<number, Set<PacketCallback>> = new Map();
  private onConnectCallbacks: Set<() => void> = new Set();
  private onDisconnectCallbacks: Set<() => void> = new Set();

  constructor(private url?: string) {
    if (!this.url) {
      const host = typeof window !== 'undefined' && window.location.hostname ? window.location.hostname : '127.0.0.1';
      this.url = `ws://${host}:8080`;
    }
  }

  public isConnected(): boolean {
    return this.ws !== null && this.ws.readyState === WebSocket.OPEN;
  }

  public connect(): void {
    if (this.ws && (this.ws.readyState === WebSocket.OPEN || this.ws.readyState === WebSocket.CONNECTING)) {
      return;
    }

    console.log(`[ClientSocket] Conectando a ${this.url}...`);
    try {
      this.ws = new WebSocket(this.url!);
      this.ws.binaryType = 'arraybuffer';

      this.ws.onopen = () => {
        console.log(`[ClientSocket] Conexão WebSocket estabelecida com sucesso!`);
        const badge = document.getElementById('net-status');
        if (badge) {
          badge.textContent = 'Conectado';
          badge.className = 'badge badge-connected';
        }
        this.onConnectCallbacks.forEach((cb) => cb());
      };

      this.ws.onclose = (event) => {
        console.log(`[ClientSocket] Conexão encerrada (code: ${event.code}, reason: ${event.reason || 'sem razão'}).`);
        const badge = document.getElementById('net-status');
        if (badge) {
          badge.textContent = 'Desconectado';
          badge.className = 'badge badge-disconnected';
        }
        this.onDisconnectCallbacks.forEach((cb) => cb());
      };

      this.ws.onerror = (err) => {
        console.error(`[ClientSocket Error] Falha ao conectar em ${this.url}:`, err);
      };

      this.ws.onmessage = (event) => {
        if (!(event.data instanceof ArrayBuffer)) return;
        this.handleIncomingBuffer(event.data);
      };
    } catch (e) {
      console.error(`[ClientSocket] Exceção ao abrir WebSocket:`, e);
    }
  }

  public on(opcode: number, callback: PacketCallback): () => void {
    if (!this.listeners.has(opcode)) {
      this.listeners.set(opcode, new Set());
    }
    this.listeners.get(opcode)!.add(callback);
    return () => this.off(opcode, callback);
  }

  public off(opcode: number, callback?: PacketCallback): void {
    if (callback) {
      this.listeners.get(opcode)?.delete(callback);
    } else {
      this.listeners.delete(opcode);
    }
  }

  public onConnect(callback: () => void): void {
    this.onConnectCallbacks.add(callback);
    if (this.ws?.readyState === WebSocket.OPEN) {
      callback();
    }
  }

  public onDisconnect(callback: () => void): void {
    this.onDisconnectCallbacks.add(callback);
  }

  public send(opcode: number, writer?: WebPacketWriter): void {
    if (!this.ws || this.ws.readyState !== WebSocket.OPEN) {
      console.warn(`[ClientSocket] Não é possível enviar pacote ${getOpcodeName(opcode)}: socket não está aberto.`);
      return;
    }

    const payload = writer ? writer.toPacket(opcode) : new WebPacketWriter().toPacket(opcode);
    this.ws.send(payload);
    console.log(`[ClientSocket Envio] Opcode: ${getOpcodeName(opcode)} (${opcode}) | Tamanho: ${payload.byteLength}B`);
  }

  private handleIncomingBuffer(buffer: ArrayBuffer): void {
    if (buffer.byteLength < SIZE_PACKET_HEADER) {
      console.warn(`[ClientSocket] Buffer recebido menor que o cabeçalho (${buffer.byteLength}B)`);
      return;
    }

    const view = new DataView(buffer);
    const packetLen = view.getUint32(0, false);
    const packetId = view.getUint32(4, false);

    console.log(`[ClientSocket Recebido] Opcode: ${getOpcodeName(packetId)} (${packetId}) | Tamanho: ${packetLen}B`);

    const reader = new WebPacketReader(buffer, SIZE_PACKET_HEADER);
    const cbs = this.listeners.get(packetId);
    if (cbs && cbs.size > 0) {
      cbs.forEach((cb) => {
        try {
          reader['offset'] = SIZE_PACKET_HEADER; // reinicia offset caso múltiplos callbacks leiam
          cb(reader, packetLen);
        } catch (e) {
          console.error(`[ClientSocket Callback Exception - Opcode ${packetId}]:`, e);
        }
      });
    }
  }
}

export const clientSocket = new ClientSocket();
