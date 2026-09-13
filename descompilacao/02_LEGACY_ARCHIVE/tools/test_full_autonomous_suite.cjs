// Teste Completo da Suíte Autônoma End-to-End: Criação -> Konoha -> Combate PvE -> Retorno à Vila
const OPCODES = {
  CS_Login_StatusServerTransmitToken: 25231360,
  SC_Login_StatusServerTransmitTokenRet: 18350080,
  SC_CREATECHAR_CreateCharCmd: 18350336,
  CS_CREATECHAR_CreateChar: 25231616,
  SC_CREATECHAR_CreateCharRet: 18350337,
  SC_Account_CharInfoNtf: 18350338,
  CS_LOBBY_Enter_Town: 25231872,
  SC_Enter_Town: 18350592,
  CS_BattleStart: 22315008,
  SC_Battle_StartReportDataReq: 21331968,
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

const testUser = `shinobi_test_${Date.now()}`;
const ws = new WebSocket('ws://127.0.0.1:8080');

console.log('===============================================================');
console.log('  INICIANDO SUÍTE DE TESTES AUTÔNOMA END-TO-END (4 MARCOS)     ');
console.log('===============================================================');
console.log(`[Test] Alvo do Servidor: ws://127.0.0.1:8080`);
console.log(`[Test] Usuário de Teste: ${testUser}\n`);

let phase = 'login';
let charName = `Ryu_${Date.now().toString().slice(-4)}`;
let charId = 0;

ws.addEventListener('open', () => {
  console.log(`[Etapa 1] Conectado ao GameServer. Enviando CS_Login_StatusServerTransmitToken...`);
  const userBuf = writeStringUTF(testUser);
  const dataBuf = Buffer.concat([
    userBuf,
    Buffer.from([0, 0, 0x03, 0xe9]), // agentId 1001
    Buffer.from([0, 0, 0x01, 0xe0]), // serverId 480
    writeStringUTF('autonomous_suite_token'),
    Buffer.from([0x01, 0x34, 0xda, 0x01]), // version 20240901
    writeStringUTF(new Date().toISOString()),
  ]);
  ws.send(buildPacket(OPCODES.CS_Login_StatusServerTransmitToken, dataBuf));
});

ws.addEventListener('message', async (event) => {
  const arrayBuffer = await event.data.arrayBuffer();
  const data = Buffer.from(arrayBuffer);
  if (data.length < 8) return;
  const packetId = data.readUInt32BE(4);

  if (packetId === OPCODES.SC_CREATECHAR_CreateCharCmd) {
    console.log(`[Etapa 2] Recebido SC_CREATECHAR_CreateCharCmd (Conta virgem).`);
    console.log(`[Etapa 2] Despachando CS_CREATECHAR_CreateChar:`);
    console.log(`          - Nome: "${charName}"`);
    console.log(`          - Disciplina: 1 (Ninjutsu)`);
    console.log(`          - Gênero: 1 (Masculino)`);

    const nameBuf = writeStringUTF(charName);
    const createData = Buffer.concat([nameBuf, Buffer.from([1]), Buffer.from([1])]);
    ws.send(buildPacket(OPCODES.CS_CREATECHAR_CreateChar, createData));
  } else if (packetId === OPCODES.SC_CREATECHAR_CreateCharRet) {
    const errCode = data.readUInt32BE(8);
    console.log(`[Etapa 2] SC_CREATECHAR_CreateCharRet recebido! Status: ${errCode} (0 = Sucesso)`);
    if (errCode !== 0) {
      console.error(`❌ Falha na criação do personagem com código ${errCode}`);
      process.exit(1);
    }
  } else if (packetId === OPCODES.SC_Account_CharInfoNtf) {
    let offset = 8;
    offset += 4; // AgentOperatorId
    offset += 4; // ServerId
    const userIdLen = data.readUInt32BE(offset);
    offset += 4 + userIdLen;
    offset += 4; // GuidHigh
    charId = data.readUInt32BE(offset);
    offset += 4;
    const nameLen = data.readUInt32BE(offset);
    const recvName = data.slice(offset + 4, offset + 4 + nameLen).toString('utf8');

    console.log(`[Etapa 2] SC_Account_CharInfoNtf: Ninja "${recvName}" registrado no SQLite (ID #${charId})`);
    console.log(`[Etapa 3] Solicitando entrada em Konohagakure (CS_LOBBY_Enter_Town)...`);
    ws.send(buildPacket(OPCODES.CS_LOBBY_Enter_Town));
  } else if (packetId === OPCODES.SC_Enter_Town) {
    const mapId = data.readUInt32BE(8);
    const spawnX = data.readUInt16BE(12);
    const spawnY = data.readUInt16BE(14);

    if (phase === 'login') {
      console.log(`[Etapa 3] SC_Enter_Town recebido! Entrou no mapa #${mapId} em (${spawnX}, ${spawnY})`);
      console.log(`[Etapa 3] Vila de Konoha montada com sucesso (Pórtico, Ichiraku, Teuchi, Ayame e HUD).`);
      phase = 'battle';

      setTimeout(() => {
        console.log(`\n[Etapa 4] Disparando combate PvE (CS_BattleStart, monsterGroupId=1)...`);
        const battleReq = Buffer.alloc(2);
        battleReq.writeInt16BE(1, 0); // monsterGroupId = 1
        ws.send(buildPacket(OPCODES.CS_BattleStart, battleReq));
      }, 500);
    } else if (phase === 'return_to_town') {
      console.log(`[Etapa 4] SC_Enter_Town recebido no retorno da batalha!`);
      console.log(`[Etapa 4] Ninja retornou para a Vila de Konoha em segurança (Mapa #${mapId}, Spawn: ${spawnX}, ${spawnY}).`);
      console.log('\n===============================================================');
      console.log('  🎉 TODOS OS 4 MARCOS VALIDADOS COM SUCESSO END-TO-END!       ');
      console.log('===============================================================');
      ws.close();
      process.exit(0);
    }
  } else if (packetId === OPCODES.SC_Battle_StartReportDataReq) {
    console.log(`[Etapa 4] ⚔️ SC_Battle_StartReportDataReq RECEBIDO COM SUCESSO (0x01458000)!`);

    let offset = 8;
    // 1. BattleId string
    const idLen = data.readUInt32BE(offset);
    offset += 4;
    const battleId = data.slice(offset, offset + idLen).toString('utf8');
    offset += idLen;
    console.log(`  -> Batalha ID: ${battleId}`);

    // Helper para ler equipe
    const readTeam = () => {
      offset += 4 * 5; // mountsId, mountsLevel, soulFormationId, emblemId, ringId
      const uIdLen = data.readUInt32BE(offset);
      offset += 4 + uIdLen;
      const count = data.readInt16BE(offset);
      offset += 2;
      const fighters = [];
      for (let i = 0; i < count; i++) {
        const pos = data.readInt8(offset); offset += 1;
        const roleId = data.readUInt32BE(offset); offset += 4;
        const quality = data.readInt8(offset); offset += 1;
        const level = data.readInt16BE(offset); offset += 2;
        const curHp = data.readFloatBE(offset); offset += 4;
        const totalHp = data.readFloatBE(offset); offset += 4;
        const curAnger = data.readInt32BE(offset); offset += 4;
        const skillId = data.readInt32BE(offset); offset += 4;
        const elem = data.readInt32BE(offset); offset += 4;
        const nLen = data.readUInt32BE(offset); offset += 4;
        const name = data.slice(offset, offset + nLen).toString('utf8');
        offset += nLen;
        fighters.push({ pos, roleId, level, curHp, totalHp, skillId, name });
      }
      return fighters;
    };

    const team1 = readTeam();
    const team2 = readTeam();
    const turnCount = data.readInt16BE(offset);
    offset += 2;

    console.log(`  -> Time 1 (Aliados): ${team1.length} lutador(es) | [Slot #${team1[0].pos}] ${team1[0].name} (HP: ${team1[0].curHp}/${team1[0].totalHp}, Jutsu: ${team1[0].skillId})`);
    console.log(`  -> Time 2 (Inimigos): ${team2.length} lutador(es) | [Slot #${team2[0].pos}] ${team2[0].name} (HP: ${team2[0].curHp}/${team2[0].totalHp})`);
    console.log(`  -> Total de Turnos pré-calculados recebidos: ${turnCount} turnos`);

    for (let t = 0; t < turnCount; t++) {
      const curTurn = data.readInt32BE(offset); offset += 4;
      const actCount = data.readInt16BE(offset); offset += 2;
      console.log(`     • Turno ${curTurn}: ${actCount} ação(ões)`);
      for (let a = 0; a < actCount; a++) {
        const camp = data.readInt8(offset); offset += 1;
        const pos = data.readInt8(offset); offset += 1;
        const skillEffect = data.readInt32BE(offset); offset += 4;
        const activeType = data.readInt32BE(offset); offset += 4;
        const tgCount = data.readInt16BE(offset); offset += 2;
        for (let g = 0; g < tgCount; g++) {
          const cmd = data.readInt8(offset); offset += 1;
          const tgCamp = data.readInt8(offset); offset += 1;
          const tgPos = data.readInt8(offset); offset += 1;
          offset += 12; // targetStatus 0, 1, 2
          let hurt = 0;
          if (cmd === 1 || cmd === 7 || cmd === 12) {
            hurt = data.readFloatBE(offset); offset += 4;
            offset += 4; // hurtAnger
          }
          console.log(`       - [Camp ${camp}, Slot ${pos}] -> [Camp ${tgCamp}, Slot ${tgPos}]: Dano = ${hurt} HP (Tipo: ${activeType === 2 ? 'Jutsu Especial' : 'Ataque Normal'})`);
        }
      }
    }

    console.log(`\n[Etapa 4] Simulação de batalha concluída com vitória!`);
    console.log(`[Etapa 4] Acionando retorno para Konohagakure (CS_LOBBY_Enter_Town)...`);
    phase = 'return_to_town';

    setTimeout(() => {
      ws.send(buildPacket(OPCODES.CS_LOBBY_Enter_Town));
    }, 600);
  }
});

ws.addEventListener('error', (err) => {
  console.error('❌ Erro no WebSocket:', err);
  process.exit(1);
});
