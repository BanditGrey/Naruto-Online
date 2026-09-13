const OPCODES = {
  CS_Login_StatusServerTransmitToken: 25231360,
  SC_Login_StatusServerTransmitTokenRet: 18350080,
  SC_CREATECHAR_CreateCharCmd: 18350336,
  CS_CREATECHAR_CreateChar: 25231616,
  SC_CREATECHAR_CreateCharRet: 18350337,
  SC_Account_CharInfoNtf: 18350338,
  CS_LOBBY_Enter_Town: 25231872,
  SC_Enter_Town: 18350592,
  CS_Backpack_LoadBag: 25235200,
  SC_Backpack_InventoryNtf: 18353926,
  CS_Backpack_UseAppliance: 25235201,
  CS_Enter_Tavern: 25231877,
  SC_Enter_Tavern: 18350597,
  CS_TavernMoraReq: 25234432,
  SC_TavernMoraRet: 18353152,
  CS_TavernRecruitReq: 25234434,
  SC_TavernRecruitRet: 18353154,
  CS_TacticalDeployment_ChangePositionReq: 25233664,
  SC_TacticalDeploymentChangePositonRet: 18352384,
  CS_Enter_Hurdle: 25231874,
  SC_Enter_Hurdle: 18350594,
  CS_BattleStart: 22315008,
  SC_Battle_StartReportDataReq: 21331968,
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

async function runTest() {
  console.log('=== TESTE INTEGRADO E AUTÔNOMO: EXPANSÃO DOS SISTEMAS DO JOGO ===\n');

  const ws = new WebSocket('ws://127.0.0.1:8080');

  await new Promise((resolve, reject) => {
    ws.addEventListener('open', resolve);
    ws.addEventListener('error', reject);
  });
  console.log('[OK] Conexão WebSocket estabelecida com ws://127.0.0.1:8080\n');

  let passedTests = 0;
  const testUser = `ninja_master_${Date.now()}`;
  const testCharName = `Kage_${Date.now().toString().slice(-5)}`;

  ws.addEventListener('message', async (event) => {
    const arrayBuffer = await event.data.arrayBuffer();
    const raw = Buffer.from(arrayBuffer);
    if (raw.length < 8) return;

    const opcode = raw.readUInt32BE(4);
    const payload = raw.subarray(8);

    if (opcode === OPCODES.SC_Login_StatusServerTransmitTokenRet) {
      console.log('✓ [1/8] SC_Login_StatusServerTransmitTokenRet recebido');
      passedTests++;
    } else if (opcode === OPCODES.SC_CREATECHAR_CreateCharCmd) {
      console.log('✓ [2/8] SC_CREATECHAR_CreateCharCmd recebido. Criando ninja:', testCharName);
      passedTests++;
      const payloadBuf = Buffer.concat([
        writeStringUTF(testCharName),
        Buffer.from([1, 1]) // Taijutsu, Masculino
      ]);
      ws.send(writePacket(OPCODES.CS_CREATECHAR_CreateChar, payloadBuf));
    } else if (opcode === OPCODES.SC_Account_CharInfoNtf) {
      console.log('✓ [3/8] SC_Account_CharInfoNtf recebido. Entrando na vila...');
      passedTests++;
      ws.send(writePacket(OPCODES.CS_LOBBY_Enter_Town, Buffer.from([0, 0, 0, 1])));
    } else if (opcode === OPCODES.SC_Enter_Town) {
      console.log('✓ [4/8] SC_Enter_Town recebido. Solicitando carga da Mochila (CS_Backpack_LoadBag)...');
      passedTests++;
      ws.send(writePacket(OPCODES.CS_Backpack_LoadBag));
    } else if (opcode === OPCODES.SC_Backpack_InventoryNtf) {
      const { str } = readStringUTF(payload);
      const bagData = JSON.parse(str);
      console.log(`✓ [5/8] SC_Backpack_InventoryNtf recebido! Itens no inventário: ${bagData.items.length}, Ryo: ${bagData.currency.ryo}`);
      passedTests++;

      // Teste de Mora na Taverna
      console.log('  -> Despachando CS_TavernMoraReq (Pedra = 0)...');
      ws.send(writePacket(OPCODES.CS_TavernMoraReq, Buffer.from([0])));
    } else if (opcode === OPCODES.SC_TavernMoraRet) {
      const { str } = readStringUTF(payload);
      const mora = JSON.parse(str);
      console.log(`✓ [6/8] SC_TavernMoraRet recebido! Resultado: ${mora.result.toUpperCase()} (+${mora.soulsAwarded} Almas Ninjas). Total de Almas: ${mora.currency.ninja_souls}`);
      passedTests++;

      // Recrutamento de Naruto Uzumaki (heroId = 101)
      console.log('  -> Despachando CS_TavernRecruitReq para Naruto Uzumaki (#101)...');
      const heroBuf = Buffer.alloc(4);
      heroBuf.writeInt32BE(101, 0);
      ws.send(writePacket(OPCODES.CS_TavernRecruitReq, heroBuf));
    } else if (opcode === OPCODES.SC_TavernRecruitRet) {
      const { str } = readStringUTF(payload);
      const rec = JSON.parse(str);
      console.log(`✓ [7/8] SC_TavernRecruitRet recebido! Mensagem: "${rec.message}" | Equipe agora tem: ${rec.team.length} ninjas.`);
      passedTests++;

      // Formação Tática: Coloca Naruto no Slot #1 (Vanguarda)
      console.log('  -> Despachando CS_TacticalDeployment_ChangePositionReq para Naruto no Slot #1...');
      const formBuf = Buffer.alloc(5);
      formBuf.writeInt32BE(101, 0);
      formBuf.writeUInt8(1, 4);
      ws.send(writePacket(OPCODES.CS_TacticalDeployment_ChangePositionReq, formBuf));
    } else if (opcode === OPCODES.SC_TacticalDeploymentChangePositonRet) {
      const { str } = readStringUTF(payload);
      const form = JSON.parse(str);
      const naruto = form.team.find(m => m.hero_id === 101);
      console.log(`✓ [8/8] SC_TacticalDeploymentChangePositonRet recebido! Naruto agora está no Slot #${naruto.formation_pos}!`);
      passedTests++;

      // Início de combate da Campanha (Capítulo 1: O Teste dos Guizos)
      console.log('  -> Despachando CS_BattleStart para a Campanha Capítulo 1 (monsterGroupId = 1)...');
      const bBuf = Buffer.alloc(2);
      bBuf.writeInt16BE(1, 0);
      ws.send(writePacket(OPCODES.CS_BattleStart, bBuf));
    } else if (opcode === OPCODES.SC_Battle_StartReportDataReq) {
      console.log('✓ [BÔNUS] SC_Battle_StartReportDataReq recebido! Arena de combate inicializada com sucesso!');
      console.log('\n=============================================================');
      console.log('🎉 TODOS OS 8 MARCOS DE EXPANSÃO FORAM TESTADOS E VALIDADOS!');
      console.log('   Mochila, Taverna, Mora Jokenpô, Recrutamento e Formação OK!');
      console.log('=============================================================\n');
      ws.close();
      process.exit(0);
    }
  });

  // Dispara login inicial
  const loginPayload = Buffer.concat([
    writeStringUTF(testUser),
    Buffer.alloc(8), // agentId + serverId
    writeStringUTF('token_test'),
    Buffer.alloc(4), // version
    writeStringUTF(new Date().toISOString())
  ]);
  ws.send(writePacket(OPCODES.CS_Login_StatusServerTransmitToken, loginPayload));

  setTimeout(() => {
    console.error(`[TIMEOUT] Teste não concluiu em 15 segundos. Passos concluídos: ${passedTests}`);
    process.exit(1);
  }, 15000);
}

runTest().catch((err) => {
  console.error('[ERRO FATAL]', err);
  process.exit(1);
});
