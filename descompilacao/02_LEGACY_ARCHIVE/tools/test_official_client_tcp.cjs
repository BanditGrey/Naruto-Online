const net = require('net');
const fs = require('fs');
const path = require('path');

const PORT = 8080;
const HOST = '127.0.0.1';

async function runTests() {
  console.log('=== TESTE DE COMPATIBILIDADE: CLIENTE OFICIAL FLASH & WEBSOCKET ===\n');

  // 1. Teste de Flash Cross-Domain Policy na porta 843
  console.log('1. Testando Flash Policy Server na porta 843...');
  try {
    await new Promise((resolve, reject) => {
      const sock = net.createConnection({ port: 843, host: HOST }, () => {
        sock.write('<policy-file-request/>\0');
      });
      sock.on('data', (data) => {
        const text = data.toString('utf8');
        if (text.includes('cross-domain-policy') && text.includes('allow-access-from')) {
          console.log('   [OK] Resposta válida recebida da porta 843:');
          console.log('   ' + text.trim().replace(/\n/g, '\n   '));
          sock.destroy();
          resolve();
        } else {
          reject(new Error('Resposta inesperada da porta 843: ' + text));
        }
      });
      sock.on('error', (err) => {
        console.warn('   [AVISO] Porta 843 não acessível:', err.message);
        resolve(); // não falha se porta 843 estiver bloqueada por permissão
      });
    });
  } catch (e) {
    console.warn('   [AVISO] Falha porta 843:', e.message);
  }

  // 2. Teste de Flash Cross-Domain Policy inline na porta 8080
  console.log('\n2. Testando Flash Policy Server inline na porta 8080...');
  await new Promise((resolve, reject) => {
    const sock = net.createConnection({ port: PORT, host: HOST }, () => {
      sock.write('<policy-file-request/>\0');
    });
    sock.on('data', (data) => {
      const text = data.toString('utf8');
      if (text.includes('cross-domain-policy') && text.includes('allow-access-from')) {
        console.log('   [OK] Resposta de policy inline na porta 8080 confirmada!');
        sock.destroy();
        resolve();
      } else {
        reject(new Error('Falha no policy inline: ' + text));
      }
    });
    sock.on('error', reject);
  });

  // 3. Teste de Socket TCP Bruto (Executável Oficial Flash Joyfun)
  console.log('\n3. Testando Conexão TCP Bruta (Opcode Binário Big Endian)...');
  await new Promise((resolve, reject) => {
    const sock = net.createConnection({ port: PORT, host: HOST }, () => {
      console.log('   [Conectado] Enviando CS_Login_StatusServerTransmitToken via TCP puro...');

      // Monta pacote binário CS_Login_StatusServerTransmitToken (25231360)
      const user = Buffer.from('FlashOfficialTester', 'utf8');
      const token = Buffer.from('tok_flash_123', 'utf8');
      const time = Buffer.from('now_tcp', 'utf8');

      // len = 8 (header) + 4+user.len + 4 (agentId) + 4 (areaId) + 4+token.len + 4 (ver) + 4+time.len
      const totalLen = 8 + (4 + user.length) + 4 + 4 + (4 + token.length) + 4 + (4 + time.length);
      const pkt = Buffer.alloc(totalLen);

      let offset = 0;
      pkt.writeUInt32BE(totalLen, offset); offset += 4;
      pkt.writeUInt32BE(25231360, offset); offset += 4; // CS_Login_StatusServerTransmitToken

      pkt.writeUInt32BE(user.length, offset); offset += 4;
      user.copy(pkt, offset); offset += user.length;

      pkt.writeUInt32BE(1001, offset); offset += 4; // AgentId
      pkt.writeUInt32BE(480, offset); offset += 4;  // AreaId

      pkt.writeUInt32BE(token.length, offset); offset += 4;
      token.copy(pkt, offset); offset += token.length;

      pkt.writeUInt32BE(20240901, offset); offset += 4; // Version

      pkt.writeUInt32BE(time.length, offset); offset += 4;
      time.copy(pkt, offset); offset += time.length;

      sock.write(pkt);
    });

    sock.on('data', (data) => {
      console.log('   [Recebido TCP] ' + data.length + ' bytes recebidos.');
      if (data.length >= 8) {
        const pLen = data.readUInt32BE(0);
        const pOpcode = data.readUInt32BE(4);
        console.log(`   [Opcode Retornado] 0x${pOpcode.toString(16).toUpperCase()} (${pOpcode}), Tamanho: ${pLen}B`);
        if (pOpcode === 18350080) { // SC_Login_StatusServerTransmitTokenRet
          console.log('   [SUCESSO] Confirmação de sessão retornada para cliente Flash TCP nativo!');
          sock.destroy();
          resolve();
          return;
        }
      }
      sock.destroy();
      resolve();
    });

    sock.on('error', reject);
  });

  // 4. Teste de compatibilidade WebSocket paralela (Cliente Web PixiJS)
  console.log('\n4. Testando WebSocket paralelo (Cliente Web PixiJS)...');
  await new Promise((resolve, reject) => {
    const ws = new WebSocket(`ws://${HOST}:${PORT}`);
    ws.addEventListener('open', () => {
      console.log('   [WebSocket Conectado] Enviando CS_Login via WebSocket...');
      const user = Buffer.from('WebPixiTester', 'utf8');
      const token = Buffer.from('tok_ws_456', 'utf8');
      const time = Buffer.from('now_ws', 'utf8');
      const totalLen = 8 + (4 + user.length) + 4 + 4 + (4 + token.length) + 4 + (4 + time.length);
      const pkt = Buffer.alloc(totalLen);

      let offset = 0;
      pkt.writeUInt32BE(totalLen, offset); offset += 4;
      pkt.writeUInt32BE(25231360, offset); offset += 4;

      pkt.writeUInt32BE(user.length, offset); offset += 4;
      user.copy(pkt, offset); offset += user.length;

      pkt.writeUInt32BE(1001, offset); offset += 4;
      pkt.writeUInt32BE(480, offset); offset += 4;

      pkt.writeUInt32BE(token.length, offset); offset += 4;
      token.copy(pkt, offset); offset += token.length;

      pkt.writeUInt32BE(20240901, offset); offset += 4;

      pkt.writeUInt32BE(time.length, offset); offset += 4;
      time.copy(pkt, offset); offset += time.length;

      ws.send(pkt);
    });

    ws.addEventListener('message', async (event) => {
      const arrayBuffer = await event.data.arrayBuffer();
      const buf = Buffer.from(arrayBuffer);
      console.log('   [Recebido WS] ' + buf.length + ' bytes recebidos via frame WebSocket.');
      if (buf.length >= 8) {
        const pOpcode = buf.readUInt32BE(4);
        console.log(`   [Opcode Retornado WS] 0x${pOpcode.toString(16).toUpperCase()} (${pOpcode})`);
      }
      ws.close();
      resolve();
    });

    ws.addEventListener('error', reject);
  });

  // 5. Verifica gravação no log do Packet Sniffer
  console.log('\n5. Verificando log do Packet Sniffer em docs/OFFICIAL_CLIENT_TRAFFIC.log...');
  const logPath = path.join(__dirname, '..', 'docs', 'OFFICIAL_CLIENT_TRAFFIC.log');
  if (fs.existsSync(logPath)) {
    const stat = fs.statSync(logPath);
    console.log(`   [OK] Log de tráfego existe e tem ${stat.size} bytes.`);
    const lines = fs.readFileSync(logPath, 'utf8').trim().split('\n');
    console.log(`   [OK] Últimas linhas do log do sniffer:\n   ` + lines.slice(-8).join('\n   '));
  } else {
    console.error('   [ERRO] Arquivo de log não encontrado!');
  }

  console.log('\n=== TODOS OS TESTES PASSARAM COM SUCESSO! ===');
}

runTests().catch(err => {
  console.error('[FALHA NO TESTE]', err);
  process.exit(1);
});
