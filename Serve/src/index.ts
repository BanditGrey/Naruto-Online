import { DatabaseManager } from './database/DatabaseManager.js';
import { WebSocketServer } from './network/WebSocketServer.js';

async function main() {
  console.log('===============================================================');
  console.log('  NARUTO ONLINE — CANONICAL EMULATION SERVER (FROM SCRATCH)   ');
  console.log('===============================================================');

  // 1. Inicializar banco de dados canônico
  const db = DatabaseManager.getInstance();
  await db.initialize();

  // 2. Iniciar servidor WebSocket binário
  const server = new WebSocketServer();
  await server.start();

  console.log('===============================================================');
  console.log('  SERVIÇO INICIADO COM SUCESSO. AGUARDANDO CONEXÕES DO CLIENTE ');
  console.log('===============================================================');

  process.on('SIGINT', async () => {
    console.log('\n[SERVER] Encerrando servidor com segurança...');
    await server.stop();
    process.exit(0);
  });
}

main().catch((err) => {
  console.error('[FATAL] Falha durante inicialização do servidor:', err);
  process.exit(1);
});
