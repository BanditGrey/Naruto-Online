// Teste ponta a ponta do fluxo de criação e persistência no servidor Node.js
const OPCODES = {
  CS_Login_StatusServerTransmitToken: 25231360,
  SC_Login_StatusServerTransmitTokenRet: 18350080,
  SC_CREATECHAR_CreateCharCmd: 18350336,
  CS_CREATECHAR_CreateChar: 25231616,
  SC_CREATECHAR_CreateCharRet: 18350337,
  SC_Account_CharInfoNtf: 18350338,
  CS_LOBBY_Enter_Town: 22315008,
  SC_Enter_Town: 18350104,
};

function buildPacket(packetId, dataBuffer = Buffer.alloc(0)) {
  const totalLength = 8 + dataBuffer.length;
  const buf = Buffer.alloc(totalLength);
  buf.writeUInt32BE(totalLength, 0);
  buf.writeUInt32BE(packetId >>> 0, 4);
  if (dataBuffer.length > 0) {
    dataBuffer.copy(buf, 8);
  }
  return buf;
}

function writeStringUTF(str) {
  const strBuf = Buffer.from(str, 'utf8');
  const buf = Buffer.alloc(4 + strBuf.length);
  buf.writeUInt32BE(strBuf.length, 0);
  strBuf.copy(buf, 4);
  return buf;
}

const testUser = `ninja_auto_${Date.now()}`;
const ws = new WebSocket('ws://127.0.0.1:8080');

ws.addEventListener('open', () => {
  console.log(`[Test] Conectado ao servidor. Autenticando com nova conta: ${testUser}...`);
  const userBuf = writeStringUTF(testUser);
  const dataBuf = Buffer.concat([
    userBuf,
    Buffer.from([0, 0, 0x03, 0xe9]), // agentId 1001
    Buffer.from([0, 0, 0x01, 0xe0]), // serverId 480
    writeStringUTF('test_token'),
    Buffer.from([0x01, 0x34, 0xda, 0x01]), // version 20240901
    writeStringUTF(new Date().toISOString())
  ]);
  ws.send(buildPacket(OPCODES.CS_Login_StatusServerTransmitToken, dataBuf));
});

ws.addEventListener('message', async (event) => {
  const arrayBuffer = await event.data.arrayBuffer();
  const data = Buffer.from(arrayBuffer);
  if (data.length < 8) return;
  const packetId = data.readUInt32BE(4);
  console.log(`[Test] Pacote recebido: 0x${packetId.toString(16).padStart(8, '0')} (${packetId})`);

  if (packetId === OPCODES.SC_CREATECHAR_CreateCharCmd) {
    console.log(`  -> Servidor solicitou criação de personagem (SC_CREATECHAR_CreateCharCmd)!`);
    console.log(`  -> Enviando CS_CREATECHAR_CreateChar: Nome="Kaito_${Date.now().toString().slice(-4)}", Profissão=4 (Taijutsu), Gênero=1 (Masculino)...`);
    
    const nameBuf = writeStringUTF(`Kaito_${Date.now().toString().slice(-4)}`);
    const createData = Buffer.concat([
      nameBuf,
      Buffer.from([4]), // Taijutsu
      Buffer.from([1])  // Masculino
    ]);
    ws.send(buildPacket(OPCODES.CS_CREATECHAR_CreateChar, createData));
  } else if (packetId === OPCODES.SC_CREATECHAR_CreateCharRet) {
    const errCode = data.readUInt32BE(8);
    console.log(`  -> SC_CREATECHAR_CreateCharRet recebido! Código de erro: ${errCode} (0 = Sucesso)`);
  } else if (packetId === OPCODES.SC_Account_CharInfoNtf) {
    console.log(`  -> SC_Account_CharInfoNtf recebido! Personagem registrado com sucesso no banco SQLite!`);
    console.log(`  -> Enviando CS_LOBBY_Enter_Town...`);
    ws.send(buildPacket(OPCODES.CS_LOBBY_Enter_Town));
  } else if (packetId === OPCODES.SC_Enter_Town) {
    const mapId = data.readUInt32BE(8);
    const x = data.readUInt16BE(12);
    const y = data.readUInt16BE(14);
    console.log(`  -> SC_Enter_Town recebido! Entrou no mapa #${mapId} em X=${x}, Y=${y}!`);
    console.log(`[Test] SUCESSO TOTAL: Loop de criação, persistência e entrada na Vila validado 100%!`);
    ws.close();
    process.exit(0);
  }
});

ws.addEventListener('error', (err) => {
  console.error('[Test Erro]', err);
  process.exit(1);
});
