import { PacketWriter, PacketReader } from "../src/network/packet.ts";
import { OPCODES, getOpcodeName } from "../src/network/opcodes.ts";
import { db } from "../src/database/db.ts";

const TEST_USER = "ninja_auto_test";
const TEST_CHAR_NAME = "NarutoUzumaki_Test";
const TEST_PROFESSION = 1; // Lâmina das Trevas
const TEST_GENDER = 1;

async function runSequentialTest() {
  console.log("=============================================================");
  console.log("Iniciando Teste Automatizado de Fluxo Sequencial (Trilha A)");
  console.log("=============================================================\n");

  // 0. Limpa dados de teste prévios para garantir que a conta inicia sem personagem
  db.clearTestData(TEST_USER);
  console.log(`[Setup] Dados anteriores do usuário '${TEST_USER}' limpos no SQLite.\n`);

  const ws = new WebSocket("ws://127.0.0.1:8080");
  ws.binaryType = "arraybuffer";

  let step = 0;

  ws.onopen = () => {
    console.log("[1. Conexão] WebSocket conectado com sucesso em ws://127.0.0.1:8080");

    // Passo 1: Enviar Login (CS_Login_StatusServerTransmitToken)
    console.log(`\n[Passo 1] Enviando CS_Login_StatusServerTransmitToken...`);
    const writer = new PacketWriter();
    writer.writeStringUTF(TEST_USER);
    writer.writeUnsignedInt(1001); // AgentID
    writer.writeUnsignedInt(480);  // ServerID
    writer.writeStringUTF("auth_token_secret_999");
    writer.writeUnsignedInt(20240901); // Version
    writer.writeStringUTF("2026-09-06 20:30:00");

    const packet = writer.toPacket(OPCODES.CS_Login_StatusServerTransmitToken);
    ws.send(packet);
    console.log(`  -> Pacote enviado: ${packet.length} bytes (Opcode 25231360)`);
  };

  ws.onmessage = (event) => {
    if (!(event.data instanceof ArrayBuffer)) return;

    const buffer = Buffer.from(event.data);
    const decoded = PacketReader.fromBuffer(buffer);
    if (!decoded) {
      console.error("[Erro] Não foi possível decodificar cabeçalho do pacote recebido!");
      process.exit(1);
    }

    const { packetId, packetLength, reader } = decoded;
    const opcodeName = getOpcodeName(packetId);

    console.log(`\n[Pacote Recebido] Opcode: ${packetId} (${opcodeName}) | Tamanho: ${packetLength}B`);

    // Tratamento dos pacotes sequenciais
    if (packetId === OPCODES.SC_Login_StatusServerTransmitTokenRet) {
      const errorCode = reader.readUnsignedInt();
      const ip1 = reader.readUnsignedByte();
      const ip2 = reader.readUnsignedByte();
      const ip3 = reader.readUnsignedByte();
      const ip4 = reader.readUnsignedByte();
      const port = reader.readUnsignedShort();
      console.log(`  [Passo 1 OK] Login confirmado! ErrorCode: ${errorCode}, Gate: ${ip1}.${ip2}.${ip3}.${ip4}:${port}`);
      step = 1;
    } else if (packetId === OPCODES.SC_CREATECHAR_CreateCharCmd) {
      // Passo 2: Recebeu ordem para criar personagem
      console.log(`  [Passo 2 OK] Ordem de criação recebida: conta nova sem personagem!`);

      // Passo 3: Enviar criação de personagem (CS_CREATECHAR_CreateChar)
      console.log(`\n[Passo 3] Enviando CS_CREATECHAR_CreateChar...`);
      const createWriter = new PacketWriter();
      createWriter.writeStringUTF(TEST_CHAR_NAME);
      createWriter.writeByte(TEST_PROFESSION);
      createWriter.writeByte(TEST_GENDER);

      const createPacket = createWriter.toPacket(OPCODES.CS_CREATECHAR_CreateChar);
      ws.send(createPacket);
      console.log(`  -> Pacote enviado: ${createPacket.length} bytes (Nome: "${TEST_CHAR_NAME}", Profissão: ${TEST_PROFESSION})`);
      step = 2;
    } else if (packetId === OPCODES.SC_CREATECHAR_CreateCharRet) {
      const errorCode = reader.readUnsignedInt();
      console.log(`  [Passo 3 OK] Resposta de criação de personagem! Código: ${errorCode} (${errorCode === 0 ? "Sucesso" : "Erro"})`);
      if (errorCode !== 0) {
        console.error("Falha na criação de personagem!");
        process.exit(1);
      }
      step = 3;
    } else if (packetId === OPCODES.SC_Account_CharInfoNtf) {
      // Passo 4: Dados completos do personagem recebidos
      const agentOpId = reader.readUnsignedInt();
      const serverId = reader.readUnsignedInt();
      const agentUserId = reader.readStringUTF();
      const guidHigh = reader.readUnsignedInt();
      const guidLow = reader.readUnsignedInt();
      const nickName = reader.readStringUTF();
      const country = reader.readUnsignedInt();
      const militaryRank = reader.readUnsignedInt();
      const prestige = reader.readUnsignedInt();
      const silverHigh = reader.readUnsignedInt();
      const silverLow = reader.readUnsignedInt();
      const gold = reader.readUnsignedInt();
      const tickets = reader.readUnsignedInt();
      const militaryOrders = reader.readUnsignedInt();
      const vipLevel = reader.readUnsignedInt();
      const vipExp = reader.readUnsignedInt();
      const backpackCap = reader.readUnsignedShort();
      const backpackExp = reader.readUnsignedByte();

      console.log(`  [Passo 4 OK] Notificação de dados do personagem (SC_Account_CharInfoNtf):`);
      console.log(`     - Character ID: #${guidLow}`);
      console.log(`     - Nome:         "${nickName}"`);
      console.log(`     - Usuário:      "${agentUserId}"`);
      console.log(`     - Moedas Prata: ${silverLow}`);
      console.log(`     - Ouro/Cupons:  ${gold}`);
      console.log(`     - Mochila Cap.: ${backpackCap}`);

      if (nickName !== TEST_CHAR_NAME) {
        console.error(`Inconsistência no nome! Esperado "${TEST_CHAR_NAME}", recebido "${nickName}"`);
        process.exit(1);
      }

      if (step === 3) {
        step = 4;
        // Passo 5: Testar requisição de atributos (CS_Account_CharBaseAttributeReq)
        console.log(`\n[Passo 5] Enviando CS_Account_CharBaseAttributeReq...`);
        const attrWriter = new PacketWriter();
        attrWriter.writeUnsignedInt(guidLow);
        const attrPacket = attrWriter.toPacket(OPCODES.CS_Account_CharBaseAttributeReq);
        ws.send(attrPacket);
        console.log(`  -> Pacote enviado: ${attrPacket.length} bytes (HeroID: #${guidLow})`);
      } else if (step === 4) {
        console.log(`  [Passo 5 OK] Atributos atualizados retornados com sucesso!`);
        console.log("\n=============================================================");
        console.log(">>> [SUCESSO TOTAL] TODOS OS 5 PASSOS DO FLUXO FORAM CONCLUÍDOS! <<<");
        console.log("=============================================================\n");

        ws.close();
        db.close();
        process.exit(0);
      }
    }
  };

  ws.onerror = (err) => {
    console.error("[Erro Cliente WebSocket]", err);
    process.exit(1);
  };
}

runSequentialTest();
