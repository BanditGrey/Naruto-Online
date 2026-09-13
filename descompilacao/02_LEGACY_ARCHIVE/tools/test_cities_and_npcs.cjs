const OPCODES = {
  CS_Login_StatusServerTransmitToken: 25231360,
  SC_Login_StatusServerTransmitTokenRet: 18350080,
  SC_CREATECHAR_CreateCharCmd: 18350336,
  CS_CREATECHAR_CreateChar: 25231616,
  SC_CREATECHAR_CreateCharRet: 18350337,
  SC_Account_CharInfoNtf: 18350338,
  CS_LOBBY_Enter_Town: 25231872,
  SC_Enter_Town: 18350592,
  CS_Equip_EnhanceReq: 25234688,
  SC_Equip_EnhanceRet: 18353408,
};

function writePacket(opcode, payloadBuffer = Buffer.alloc(0)) {
  const packetLength = payloadBuffer.length + 8;
  const header = Buffer.alloc(8);
  header.writeUInt32BE(packetLength, 0);
  header.writeUInt32BE(opcode, 4);
  return Buffer.concat([header, payloadBuffer]);
}

function writeStringUTF(str) {
  const strBytes = Buffer.from(str, 'utf8');
  const lenBuf = Buffer.alloc(4);
  lenBuf.writeUInt32BE(strBytes.length, 0);
  return Buffer.concat([lenBuf, strBytes]);
}

function readStringUTF(buffer, offset = 0) {
  const len = buffer.readUInt32BE(offset);
  const str = buffer.subarray(offset + 4, offset + 4 + len).toString('utf8');
  return { str, nextOffset: offset + 4 + len };
}

async function runCitiesTest() {
  console.log('=== TESTE DE TRANSIÇÃO DE CIDADES E FORJA CANÔNICA DE EQUIPAMENTOS ===\n');

  const ws = new WebSocket('ws://127.0.0.1:8080');

  await new Promise((resolve, reject) => {
    ws.addEventListener('open', resolve);
    ws.addEventListener('error', reject);
  });
  console.log('[OK] Conexão WebSocket estabelecida com o servidor!\n');

  const testUser = `ninja_city_${Date.now()}`;
  const testCharName = `Shinobi_${Date.now().toString().slice(-4)}`;
  let step = 0;

  ws.addEventListener('message', async (event) => {
    const arrayBuffer = await event.data.arrayBuffer();
    const raw = Buffer.from(arrayBuffer);
    if (raw.length < 8) return;

    const opcode = raw.readUInt32BE(4);
    const payload = raw.subarray(8);

    if (opcode === OPCODES.SC_Login_StatusServerTransmitTokenRet) {
      console.log('✓ [1/6] Login transmit token aceito.');
    } else if (opcode === OPCODES.SC_CREATECHAR_CreateCharCmd) {
      console.log('✓ [2/6] Criando personagem de teste:', testCharName);
      const payloadBuf = Buffer.concat([
        writeStringUTF(testCharName),
        Buffer.from([1, 1]) // Taijutsu, Masculino
      ]);
      ws.send(writePacket(OPCODES.CS_CREATECHAR_CreateChar, payloadBuf));
    } else if (opcode === OPCODES.SC_Account_CharInfoNtf) {
      console.log('✓ [3/6] Personagem autenticado. Testando entrada no Subúrbio dos Novatos (#23100001)...');
      const townBuf = Buffer.alloc(4);
      townBuf.writeUInt32BE(23100001, 0);
      ws.send(writePacket(OPCODES.CS_LOBBY_Enter_Town, townBuf));
      step = 1;
    } else if (opcode === OPCODES.SC_Enter_Town) {
      if (step === 1) {
        console.log('✓ [4/6] SC_Enter_Town recebido para Subúrbio dos Novatos (#23100001)!');
        console.log('  -> Agora testando transição para a Grande Vila de Konoha (#23200001)...');
        step = 2;
        const konohaBuf = Buffer.alloc(4);
        konohaBuf.writeUInt32BE(23200001, 0);
        ws.send(writePacket(OPCODES.CS_LOBBY_Enter_Town, konohaBuf));
      } else if (step === 2) {
        console.log('✓ [5/6] SC_Enter_Town recebido para Vila de Konoha (#23200001)!');
        console.log('  -> Testando aprimoramento de equipamento na Forja (God of Craftsman - Slot 0: Espada Kusanagi)...');
        step = 3;
        const enhanceBuf = Buffer.alloc(4);
        enhanceBuf.writeUInt32BE(0, 0); // Slot 0
        ws.send(writePacket(OPCODES.CS_Equip_EnhanceReq, enhanceBuf));
      }
    } else if (opcode === OPCODES.SC_Equip_EnhanceRet) {
      const { str } = readStringUTF(payload);
      const data = JSON.parse(str);
      console.log(`✓ [6/6] SC_Equip_EnhanceRet recebido!`);
      console.log(`  -> Mensagem do Ferreiro: "${data.msg}"`);
      console.log(`  -> Slot #${data.slotIndex} Aprimorado para Nível: +${data.level}`);
      console.log(`  -> Saldo Atualizado de Ryo: ${data.currency.ryo}`);
      console.log('\n============================================================');
      console.log('🎉 SUCESSO TOTAL: AS CIDADES E O SISTEMA DA FORJA ESTÃO 100% OPERACIONAIS!');
      console.log('============================================================\n');
      ws.close();
      process.exit(0);
    }
  });

  // Dispara login inicial
  const loginPayload = Buffer.concat([
    writeStringUTF(testUser),
    Buffer.alloc(8),
    writeStringUTF('token_test'),
    Buffer.alloc(4),
    writeStringUTF(new Date().toISOString())
  ]);
  ws.send(writePacket(OPCODES.CS_Login_StatusServerTransmitToken, loginPayload));

  setTimeout(() => {
    console.error('[TIMEOUT] Teste de cidades expirou em 10s.');
    process.exit(1);
  }, 10000);
}

runCitiesTest().catch(e => {
  console.error('[ERRO]', e);
  process.exit(1);
});
