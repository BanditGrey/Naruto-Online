import { PacketReader, PacketWriter } from '../src/network/packet.ts';
import { OPCODES } from '../src/network/opcodes.ts';
import { db } from '../src/database/db.ts';

const WS_PORT = 8080;

const acc = db.getOrCreateAccount('cycle_tester', 'token_cycle');
let char = db.getCharacterByAccountId(acc.id);
if (!char) {
  char = db.createCharacter(acc.id, 'Naruto_Uzumaki', 1, 1);
}

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

async function testFullCombatCycle() {
  return new Promise<void>((resolve, reject) => {
    const timeout = setTimeout(() => {
      reject(new Error("Timeout (10s) atingido no ciclo de combate!"));
    }, 10000);

    const ws = new WebSocket(`ws://127.0.0.1:${WS_PORT}`);
    ws.binaryType = 'arraybuffer';

    let stage = 'login';

    ws.onopen = () => {
      console.log("[Ciclo de Teste] Conectado ao servidor WebSocket.");
      ws.send(buildClientLoginPacket(acc.user_id, acc.token));
    };

    ws.onmessage = (event) => {
      const buffer = Buffer.from(event.data as ArrayBuffer);
      const decoded = PacketReader.fromBuffer(buffer);
      if (!decoded) return;

      const opcode = decoded.packetId;
      const reader = decoded.reader;

      if (opcode === OPCODES.SC_Account_CharInfoNtf && stage === 'login') {
        stage = 'entering_town';
        console.log("[Ciclo de Teste] 1. Personagem autenticado. Enviando CS_LOBBY_Enter_Town...");
        const writer = new PacketWriter();
        writer.writeUnsignedInt(1);
        ws.send(writer.toPacket(OPCODES.CS_LOBBY_Enter_Town));
      } else if (opcode === OPCODES.SC_Enter_Town && stage === 'entering_town') {
        stage = 'in_town';
        console.log("[Ciclo de Teste] 2. Spawn na Vila da Folha confirmado! Solicitando CS_BattleStart...");
        const battleWriter = new PacketWriter();
        battleWriter.writeInt16(1);
        ws.send(battleWriter.toPacket(OPCODES.CS_BattleStart));
      } else if (opcode === OPCODES.SC_Battle_StartReportDataReq && stage === 'in_town') {
        stage = 'in_battle';
        const battleId = reader.readStringUTF();
        console.log(`[Ciclo de Teste] 3. Arena de Batalha iniciada! ID: ${battleId}`);
        console.log("[Ciclo de Teste] 4. Simulando finalização dos 3 turnos e clique em 'Voltar para Konoha'...");

        setTimeout(() => {
          stage = 'returning_town';
          const returnWriter = new PacketWriter();
          returnWriter.writeUnsignedInt(1);
          ws.send(returnWriter.toPacket(OPCODES.CS_LOBBY_Enter_Town));
        }, 1000);
      } else if (opcode === OPCODES.SC_Enter_Town && stage === 'returning_town') {
        stage = 'completed';
        console.log("[Ciclo de Teste] 5. ✅ Retorno à Vila da Folha confirmado via SC_Enter_Town!");
        clearTimeout(timeout);
        ws.close();
        resolve();
      }
    };

    ws.onerror = (err) => {
      reject(err);
    };
  });
}

testFullCombatCycle()
  .then(() => {
    console.log("\n=======================================================");
    console.log("🎉 CICLO COMPLETO VILA -> BATALHA -> VILA VALIDADO COM SUCESSO!");
    console.log("=======================================================\n");
    process.exit(0);
  })
  .catch((err) => {
    console.error("❌ Falha no teste:", err);
    process.exit(1);
  });
