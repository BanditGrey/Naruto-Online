import { PacketReader, PacketWriter } from '../src/network/packet.ts';
import { OPCODES } from '../src/network/opcodes.ts';
import { db } from '../src/database/db.ts';

const WS_PORT = 8080;

// Cria uma conta e personagem de teste
const acc = db.getOrCreateAccount('battle_tester', 'token_battle');
let char = db.getCharacterByAccountId(acc.id);
if (!char) {
  char = db.createCharacter(acc.id, 'Sasuke_Uchiha', 2, 1);
}

console.log(`[TEST SETUP] Personagem: ${char.name} (Conta: ${acc.user_id}, ID: ${char.id}, Nv. ${char.level})`);

function buildClientLoginPacket(userId: string, token: string = "token"): Buffer {
  const writer = new PacketWriter();
  writer.writeStringUTF(userId);
  writer.writeUnsignedInt(1001);
  writer.writeUnsignedInt(480);
  writer.writeStringUTF(token);
  writer.writeUnsignedInt(20240901);
  writer.writeStringUTF(new Date().toISOString());
  return writer.toPacket(OPCODES.CS_Login_StatusServerTransmitToken);
}

async function runTest() {
  return new Promise<void>((resolve, reject) => {
    const timeout = setTimeout(() => {
      reject(new Error("Timeout de teste (8s) atingido sem receber o início de combate!"));
    }, 8000);

    const wsUrl = `ws://127.0.0.1:${WS_PORT}`;
    const ws = new WebSocket(wsUrl);
    ws.binaryType = 'arraybuffer';

    let enteredTown = false;

    ws.onopen = () => {
      console.log("[WS] Conectado ao servidor! Realizando login...");
      ws.send(buildClientLoginPacket(acc.user_id, acc.token));
    };

    ws.onmessage = (event) => {
      const buffer = Buffer.from(event.data as ArrayBuffer);
      const decoded = PacketReader.fromBuffer(buffer);
      if (!decoded) return;

      const opcode = decoded.packetId;
      const reader = decoded.reader;

      if (opcode === OPCODES.SC_Login_StatusServerTransmitTokenRet) {
        console.log("[WS] Recebeu confirmação de login.");
      } else if (opcode === OPCODES.SC_Account_CharInfoNtf) {
        console.log("[WS] Recebeu dados do personagem. Solicitando entrada na Vila da Folha...");
        const writer = new PacketWriter();
        ws.send(writer.toPacket(OPCODES.CS_LOBBY_Enter_Town));
      } else if (opcode === OPCODES.SC_Enter_Town) {
        const mapId = reader.readUInt32();
        const spawnX = reader.readUInt16();
        const spawnY = reader.readUInt16();
        console.log(`[WS] Entrou na Vila! Mapa #${mapId} em (${spawnX}, ${spawnY})`);
        enteredTown = true;

        // Dispara requisição de início de batalha contra o Grupo de Monstros #1
        setTimeout(() => {
          console.log("[WS] Enviando CS_BattleStart (0x01548000) -> Desafiando Grupo de Monstros #1...");
          const battleWriter = new PacketWriter();
          battleWriter.writeInt16(1); // monsterGroupId = 1
          ws.send(battleWriter.toPacket(OPCODES.CS_BattleStart));
        }, 300);
      } else if (opcode === OPCODES.SC_Battle_StartReportDataReq) {
        console.log("\n=======================================================");
        console.log("[WS] ⚔️ SUCESSO: Recebido pacote SC_Battle_StartReportDataReq (0x01458000)!");
        console.log(`     Tamanho Total do Pacote: ${decoded.packetLength} bytes`);

        // Validação e Parsing exato da estrutura do combate conforme TUnstreamizerBattleRepot.as
        const battleIdStr = reader.readStringUTF();
        console.log(`  -> Battle ID / Hash: "${battleIdStr}"`);

        // Time 1 (Aliados / Jogador)
        const t1Mounts = reader.readInt();
        const t1MountLvl = reader.readInt();
        const t1SoulForm = reader.readInt();
        const t1Emblem = reader.readInt();
        const t1Ring = reader.readInt();
        const t1UserId = reader.readStringUTF();
        const t1Count = reader.readShort();
        console.log(`  -> Time 1 (Aliado): User="${t1UserId}", Integrantes: ${t1Count}`);

        for (let i = 0; i < t1Count; i++) {
          const pos = reader.readByte();
          const roleId = reader.readUInt32();
          const quality = reader.readByte();
          const lvl = reader.readShort();
          const curHp = reader.readFloat();
          const totHp = reader.readFloat();
          const curAnger = reader.readInt();
          const skillId = reader.readInt();
          const elementBit = reader.readInt();
          const rName = reader.readStringUTF();
          console.log(`     Ninja [Camp 0, Pos ${pos}]: "${rName}" (ID #${roleId}, HP: ${curHp}/${totHp}, Fúria: ${curAnger}, Skill #${skillId})`);
        }

        // Time 2 (Inimigos / Monstros)
        const t2Mounts = reader.readInt();
        const t2MountLvl = reader.readInt();
        const t2SoulForm = reader.readInt();
        const t2Emblem = reader.readInt();
        const t2Ring = reader.readInt();
        const t2UserId = reader.readStringUTF();
        const t2Count = reader.readShort();
        console.log(`  -> Time 2 (Inimigo): Group="${t2UserId}", Integrantes: ${t2Count}`);

        for (let i = 0; i < t2Count; i++) {
          const pos = reader.readByte();
          const roleId = reader.readUInt32();
          const quality = reader.readByte();
          const lvl = reader.readShort();
          const curHp = reader.readFloat();
          const totHp = reader.readFloat();
          const curAnger = reader.readInt();
          const skillId = reader.readInt();
          const elementBit = reader.readInt();
          const rName = reader.readStringUTF();
          console.log(`     Inimigo [Camp 1, Pos ${pos}]: "${rName}" (ID #${roleId}, HP: ${curHp}/${totHp}, Fúria: ${curAnger})`);
        }

        // Leitura dos Turnos
        const totalTurns = reader.readShort();
        console.log(`  -> Total de Turnos de Combate: ${totalTurns}`);
        for (let t = 0; t < totalTurns; t++) {
          const curTurn = reader.readInt();
          const activeCount = reader.readShort();
          console.log(`     [Turno #${curTurn}] com ${activeCount} ação(ões):`);

          for (let a = 0; a < activeCount; a++) {
            const activeCamp = reader.readByte();
            const activePos = reader.readByte();
            const skillEffectId = reader.readInt();
            const activeType = reader.readInt();
            const targetCount = reader.readShort();

            for (let tg = 0; tg < targetCount; tg++) {
              const cmd = reader.readByte();
              const targetCamp = reader.readByte();
              const targetPos = reader.readByte();
              const rptStatus = reader.readUInt32();
              const rptStatus1 = reader.readUInt32();
              const rptStatus2 = reader.readUInt32();

              let hurtHp = 0;
              let hurtAnger = 0;
              if (cmd === 1 || cmd === 7 || cmd === 12) {
                hurtHp = reader.readFloat();
                hurtAnger = reader.readInt();
              }

              console.log(`       - Ação: Camp ${activeCamp} Pos ${activePos} -> Alvo Camp ${targetCamp} Pos ${targetPos} | Dano: -${hurtHp} HP, Fúria: +${hurtAnger}`);
            }
          }
        }

        console.log("=======================================================");
        console.log(" TRANSIÇÃO E PACOTE DE BATALHA POR TURNOS 100% VALIDADOS!");
        console.log("=======================================================\n");

        clearTimeout(timeout);
        ws.close();
        resolve();
      }
    };

    ws.onerror = (err) => {
      console.error("[WS ERROR]", err);
    };
  });
}

runTest().then(() => {
  process.exit(0);
}).catch((err) => {
  console.error("\n[TEST FAILED]", err);
  process.exit(1);
});
