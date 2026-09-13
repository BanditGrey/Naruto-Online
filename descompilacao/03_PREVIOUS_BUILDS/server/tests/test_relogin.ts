import { PacketWriter, PacketReader } from "../src/network/packet.ts";
import { OPCODES, getOpcodeName } from "../src/network/opcodes.ts";

async function testRelogin() {
  console.log("\n[Teste Re-login] Conectando com usuário que JÁ possui personagem cadastrado...");
  const ws = new WebSocket("ws://127.0.0.1:8080");
  ws.binaryType = "arraybuffer";

  ws.onopen = () => {
    const writer = new PacketWriter();
    writer.writeStringUTF("ninja_auto_test");
    writer.writeUnsignedInt(1001);
    writer.writeUnsignedInt(480);
    writer.writeStringUTF("auth_token_secret_999");
    writer.writeUnsignedInt(20240901);
    writer.writeStringUTF("2026-09-06 20:30:00");
    const packet = writer.toPacket(OPCODES.CS_Login_StatusServerTransmitToken);
    ws.send(packet);
  };

  ws.onmessage = (event) => {
    if (!(event.data instanceof ArrayBuffer)) return;
    const buffer = Buffer.from(event.data);
    const decoded = PacketReader.fromBuffer(buffer)!;
    console.log(`[Re-login Recebido] Opcode: ${decoded.packetId} (${getOpcodeName(decoded.packetId)})`);

    if (decoded.packetId === OPCODES.SC_Account_CharInfoNtf) {
      console.log(">>> [SUCESSO] Servidor enviou diretamente SC_Account_CharInfoNtf sem solicitar criação! <<<");
      ws.close();
      process.exit(0);
    }
  };
}

testRelogin();
