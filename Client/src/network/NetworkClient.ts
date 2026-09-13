import { PacketReader } from './PacketReader.js';
import { PacketWriter } from './PacketWriter.js';
import { Opcodes } from '../protocol/opcodes.js';

export type PacketHandler = (reader: PacketReader) => void;

export class NetworkClient {
  private static instance: NetworkClient;
  private ws: WebSocket | null = null;
  private handlers: Map<number, PacketHandler[]> = new Map();
  private isConnected = false;

  private constructor() {}

  public static getInstance(): NetworkClient {
    if (!NetworkClient.instance) {
      NetworkClient.instance = new NetworkClient();
    }
    return NetworkClient.instance;
  }

  public connect(url: string = 'ws://127.0.0.1:8080'): Promise<void> {
    return new Promise((resolve, reject) => {
      this.ws = new WebSocket(url);
      this.ws.binaryType = 'arraybuffer';

      this.ws.onopen = () => {
        this.isConnected = true;
        console.log('[NET] Conectado ao servidor:', url);
        resolve();
      };

      this.ws.onmessage = (event) => {
        if (event.data instanceof ArrayBuffer) {
          this.handlePacket(event.data);
        }
      };

      this.ws.onerror = (err) => {
        console.error('[NET] Erro no socket:', err);
        reject(err);
      };

      this.ws.onclose = () => {
        this.isConnected = false;
        console.warn('[NET] Conexão com o servidor encerrada.');
      };
    });
  }

  public on(opcode: number, handler: PacketHandler): void {
    let list = this.handlers.get(opcode);
    if (!list) {
      list = [];
      this.handlers.set(opcode, list);
    }
    list.push(handler);
  }

  public send(writer: PacketWriter): void {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(writer.toArrayBuffer());
    }
  }

  private handlePacket(buffer: ArrayBuffer): void {
    const reader = new PacketReader(buffer);
    if (reader.remaining < 8) return;

    const length = reader.readUInt32BE();
    const opcode = reader.readUInt32BE();

    const handlers = this.handlers.get(opcode);
    if (handlers) {
      for (const h of handlers) {
        h(reader);
      }
    } else {
      console.log(`[NET] Pacote sem handler registrado: Opcode ${opcode} (0x${opcode.toString(16).toUpperCase()})`);
    }
  }
}
