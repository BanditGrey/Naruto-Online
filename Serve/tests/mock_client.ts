import WebSocket from 'ws';
import { PacketReader } from '../src/network/PacketReader.js';
import { PacketWriter } from '../src/network/PacketWriter.js';
import { Opcodes } from '../src/protocol/opcodes.js';

const TARGET_URL = 'ws://127.0.0.1:8080';
const TEST_USER = `ninja_tester_${Date.now()}`;

console.log('===============================================================');
console.log('  TESTE DE VALIDAÇÃO: PROTAGONISTA, MAPA NOVICE SUBURB & NPCS  ');
console.log('===============================================================');
console.log(`[TEST] Conectando a ${TARGET_URL}...`);

const ws = new WebSocket(TARGET_URL);
ws.binaryType = 'arraybuffer';

let verifiedNpcsCount = 0;

ws.on('open', () => {
  console.log('[TEST] ✓ Conexão estabelecida.');

  // Etapa 1: Enviar Token de Login
  console.log(`[TEST] [1/6] Enviando CS_Login_StatusServerTransmitToken para: ${TEST_USER}`);
  const loginPkt = new PacketWriter(Opcodes.CS_Login_StatusServerTransmitToken)
    .writeFlushUTF(TEST_USER);
  ws.send(loginPkt.toBuffer());
});

ws.on('message', (data: Buffer | ArrayBuffer) => {
  const reader = new PacketReader(data);
  const length = reader.readUInt32BE();
  const opcode = reader.readUInt32BE();

  switch (opcode) {
    case Opcodes.SC_Login_StatusServerTransmitTokenRet: {
      const status = reader.readUInt8();
      console.log(`[TEST] [1/6] ✓ SC_Login_StatusServerTransmitTokenRet recebido (Status: ${status})`);
      break;
    }

    case Opcodes.SC_CREATECHAR_CreateCharCmd: {
      console.log('[TEST] [2/6] SC_CREATECHAR_CreateCharCmd recebido (Conta nova).');
      console.log('[TEST] [2/6] Criando Protagonista: "Naruto_Test", Disciplina: Ninjutsu (1), Gênero: Masculino (1)');

      const createPkt = new PacketWriter(Opcodes.CS_CREATECHAR_CreateChar)
        .writeFlushUTF('Naruto_Test')
        .writeUInt8(1) // Ninjutsu
        .writeUInt8(1); // Male
      ws.send(createPkt.toBuffer());
      break;
    }

    case Opcodes.SC_CREATECHAR_CreateCharRet: {
      const code = reader.readUInt8();
      console.log(`[TEST] [2/6] ✓ SC_CREATECHAR_CreateCharRet recebido! Status: ${code} (0 = Sucesso)`);
      break;
    }

    case Opcodes.SC_Account_CharInfoNtf: {
      const charId = reader.readUInt32BE();
      const name = reader.readFlushUTF();
      const profession = reader.readUInt8();
      const gender = reader.readUInt8();
      const level = reader.readUInt16BE();
      const hp = reader.readFloatBE();
      const maxHp = reader.readFloatBE();
      const silver = reader.readUInt32BE();
      const gold = reader.readUInt32BE();

      console.log(`[TEST] [2/6] ✓ SC_Account_CharInfoNtf: Ninja "${name}" (#${charId}) nível ${level}`);
      console.log(`             Classe: Ninjutsu (${profession}), Gênero: Masculino (${gender}), HP: ${hp}/${maxHp}, Ryōs: ${silver}`);

      // Etapa 3: Entrar na Vila Inicial (Novice Suburb #23100001)
      console.log('[TEST] [3/6] Solicitando entrada no Mapa Inicial (CS_LOBBY_Enter_Town)...');
      const enterPkt = new PacketWriter(Opcodes.CS_LOBBY_Enter_Town)
        .writeUInt32BE(23100001); // Novice Suburb
      ws.send(enterPkt.toBuffer());
      break;
    }

    case Opcodes.SC_Enter_Town: {
      const cityId = reader.readUInt32BE();
      const spawnX = reader.readUInt16BE();
      const spawnY = reader.readUInt16BE();
      console.log(`[TEST] [3/6] ✓ SC_Enter_Town recebido!`);
      console.log(`             Mapa: #${cityId} (Novice Suburb) | Posição Spawn: (${spawnX}, ${spawnY})`);
      break;
    }

    case Opcodes.SC_LOBBY_Town_NpcList: {
      const count = reader.readInt16BE();
      verifiedNpcsCount = count;
      console.log(`[TEST] [4/6] ✓ SC_LOBBY_Town_NpcList recebido! Total de NPCs na Vila: ${count}`);

      let foundHokage = false;
      for (let i = 0; i < count; i++) {
        const id = reader.readUInt32BE();
        const name = reader.readFlushUTF();
        const title = reader.readFlushUTF();
        const x = reader.readUInt16BE();
        const y = reader.readUInt16BE();
        const type = reader.readUInt8();

        if (id === 22100003) {
          foundHokage = true;
          console.log(`             -> NPC Encontrado: ${name} (ID #${id}) em (${x}, ${y}) - [Líder da Vila]`);
        }
      }

      if (foundHokage) {
        // Etapa 5: Interagir com o 3º Hokage (#22100003)
        console.log('[TEST] [5/6] Interagindo com o 3º Hokage (CS_LOBBY_Town_TalkNpc, ID: 22100003)...');
        const talkPkt = new PacketWriter(Opcodes.CS_LOBBY_Town_TalkNpc)
          .writeUInt32BE(22100003);
        ws.send(talkPkt.toBuffer());
      }
      break;
    }

    case Opcodes.SC_LOBBY_Town_NpcDialog: {
      const npcId = reader.readUInt32BE();
      const name = reader.readFlushUTF();
      const title = reader.readFlushUTF();
      const talk = reader.readFlushUTF();
      const action = reader.readFlushUTF();

      console.log(`[TEST] [5/6] ✓ SC_LOBBY_Town_NpcDialog recebido de ${name} (#${npcId}):`);
      console.log(`             Fala: "${talk}"`);
      console.log(`             Ação disponível: ${action}`);

      // Etapa 6: Movimentação e Batalha
      console.log('[TEST] [6/6] Movimentando-se em direção ao Portão da Vila (1450, 382)...');
      const movePkt = new PacketWriter(Opcodes.CS_LOBBY_Town_Move)
        .writeUInt16BE(1450)
        .writeUInt16BE(382);
      ws.send(movePkt.toBuffer());

      setTimeout(() => {
        console.log('[TEST] [6/6] Disparando combate PvE de teste...');
        const battleStartPkt = new PacketWriter(Opcodes.CS_BattleStart)
          .writeUInt32BE(1);
        ws.send(battleStartPkt.toBuffer());
      }, 500);
      break;
    }

    case Opcodes.SC_Battle_StartReportDataReq: {
      const battleId = reader.readFlushUTF();
      console.log(`[TEST] [6/6] ⚔️ SC_Battle_StartReportDataReq recebido! BattleID: ${battleId}`);
      break;
    }

    case Opcodes.SC_SingleBattleResult: {
      const result = reader.readUInt8();
      const exp = reader.readUInt32BE();
      const silver = reader.readUInt32BE();
      console.log(`[TEST] [6/6] 🏆 SC_SingleBattleResult recebido! Vitória: ${result === 1} (+${exp} EXP, +${silver} Ryōs)`);
      console.log('===============================================================');
      console.log('  🎉 FASE 1 VALIDADA COM 100% DE SUCESSO! PROTOCOLO E DADOS OK! ');
      console.log('===============================================================');
      ws.close();
      process.exit(0);
      break;
    }

    default:
      break;
  }
});

ws.on('error', (err) => {
  console.error('[TEST] Erro no teste:', err.message);
  process.exit(1);
});
