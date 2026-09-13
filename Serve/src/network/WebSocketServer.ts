import http from 'http';
import { WebSocketServer as WSS, WebSocket } from 'ws';
import { Session } from './Session.js';
import { ServerConfig } from '../config/index.js';

export class WebSocketServer {
  private server: http.Server;
  private wss: WSS;

  constructor() {
    this.server = http.createServer((req, res) => {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({
        status: 'online',
        name: ServerConfig.serverName,
        version: ServerConfig.version
      }));
    });

    this.wss = new WSS({ server: this.server });

    this.wss.on('connection', (ws: WebSocket) => {
      console.log('[NET] Nova conexão WebSocket recebida.');
      new Session(ws);
    });
  }

  public start(): Promise<void> {
    return new Promise((resolve) => {
      this.server.listen(ServerConfig.port, ServerConfig.host, () => {
        console.log(`[NET] ✓ Servidor WebSocket ativo em ws://${ServerConfig.host}:${ServerConfig.port}`);
        resolve();
      });
    });
  }

  public stop(): Promise<void> {
    return new Promise((resolve) => {
      this.wss.close(() => {
        this.server.close(() => resolve());
      });
    });
  }
}
