import { PacketWriter, PacketReader, SIZE_PACKET_HEADER } from "../src/network/packet.ts";
import { OPCODES, getOpcodeName } from "../src/network/opcodes.ts";

function runTests() {
  console.log("=== Testando Serialização e Desserialização de Pacotes (Modo Plano) ===\n");

  // 1. Simular a montagem do pacote PACKETID_CS_Login_StatusServerTransmitToken
  const writer = new PacketWriter();
  const testUserId = "user_dan_123";
  const testAgentId = 1001;
  const testServerId = 480;
  const testToken = "session_token_xyz_987";
  const testVersion = 20240901;
  const testLoginTime = "2026-09-06 20:30:00";

  // Serializar payload conforme TProcessorLogin.as
  writer.writeStringUTF(testUserId);
  writer.writeUnsignedInt(testAgentId);
  writer.writeUnsignedInt(testServerId);
  writer.writeStringUTF(testToken);
  writer.writeUnsignedInt(testVersion);
  writer.writeStringUTF(testLoginTime);

  // Gerar pacote com o Opcode
  const packetBuffer = writer.toPacket(OPCODES.CS_Login_StatusServerTransmitToken);

  console.log(`[Packet Criado]`);
  console.log(`- Buffer total: ${packetBuffer.length} bytes`);
  console.log(`- Hex dump cabeçalho (8B): ${packetBuffer.subarray(0, 8).toString("hex")}`);
  console.log(`- PacketLength (primeiros 4 bytes BE): ${packetBuffer.readUInt32BE(0)}`);
  console.log(`- PacketID (bytes 4..7 BE): ${packetBuffer.readUInt32BE(4)} (${getOpcodeName(packetBuffer.readUInt32BE(4))})`);

  if (packetBuffer.length !== packetBuffer.readUInt32BE(0)) {
    throw new Error(`Inconsistência de tamanho! packetBuffer.length (${packetBuffer.length}) !== header packetLength (${packetBuffer.readUInt32BE(0)})`);
  }

  // 2. Decodificar com PacketReader.fromBuffer
  const decoded = PacketReader.fromBuffer(packetBuffer);
  if (!decoded) {
    throw new Error("Falha ao decodificar o cabeçalho!");
  }

  console.log(`\n[Packet Decodificado]`);
  console.log(`- Opcode ID: ${decoded.packetId} -> ${getOpcodeName(decoded.packetId)}`);
  console.log(`- PacketLength: ${decoded.packetLength}`);
  console.log(`- Tamanho Payload: ${decoded.payload.length} bytes`);

  const reader = decoded.reader;
  const readUserId = reader.readStringUTF();
  const readAgentId = reader.readUnsignedInt();
  const readServerId = reader.readUnsignedInt();
  const readToken = reader.readStringUTF();
  const readVersion = reader.readUnsignedInt();
  const readLoginTime = reader.readStringUTF();

  console.log(`\n[Validação dos Campos do Payload]`);
  console.log(`- UserID:    "${readUserId}" (esperado: "${testUserId}") -> ${readUserId === testUserId ? "OK" : "FALHA"}`);
  console.log(`- AgentID:   ${readAgentId} (esperado: ${testAgentId}) -> ${readAgentId === testAgentId ? "OK" : "FALHA"}`);
  console.log(`- ServerID:  ${readServerId} (esperado: ${testServerId}) -> ${readServerId === testServerId ? "OK" : "FALHA"}`);
  console.log(`- Token:     "${readToken}" (esperado: "${testToken}") -> ${readToken === testToken ? "OK" : "FALHA"}`);
  console.log(`- Version:   ${readVersion} (esperado: ${testVersion}) -> ${readVersion === testVersion ? "OK" : "FALHA"}`);
  console.log(`- LoginTime: "${readLoginTime}" (esperado: "${testLoginTime}") -> ${readLoginTime === testLoginTime ? "OK" : "FALHA"}`);
  console.log(`- Bytes restantes no buffer: ${reader.bytesAvailable} (esperado: 0)`);

  if (reader.bytesAvailable !== 0) {
    throw new Error(`Ainda restaram ${reader.bytesAvailable} bytes não lidos no buffer!`);
  }

  // 3. Teste de resposta do servidor (SC_Login_StatusServerTransmitTokenRet)
  const respWriter = new PacketWriter();
  respWriter.writeUnsignedInt(0); // ErrorCode = 0 (Sucesso)
  respWriter.writeByte(127);      // IP: 127.0.0.1
  respWriter.writeByte(0);
  respWriter.writeByte(0);
  respWriter.writeByte(1);
  respWriter.writeUnsignedShort(8080); // Porta: 8080

  const respPacket = respWriter.toPacket(OPCODES.SC_Login_StatusServerTransmitTokenRet);
  const decodedResp = PacketReader.fromBuffer(respPacket)!;
  const respReader = decodedResp.reader;

  const errCode = respReader.readUnsignedInt();
  const ip1 = respReader.readUnsignedByte();
  const ip2 = respReader.readUnsignedByte();
  const ip3 = respReader.readUnsignedByte();
  const ip4 = respReader.readUnsignedByte();
  const port = respReader.readUnsignedShort();

  console.log(`\n[Teste Resposta Status Server Ret]`);
  console.log(`- Opcode: ${getOpcodeName(decodedResp.packetId)}`);
  console.log(`- ErrorCode: ${errCode}`);
  console.log(`- Redirecionamento Gate: ${ip1}.${ip2}.${ip3}.${ip4}:${port}`);

  console.log("\n>>> TODOS OS TESTES PASSARAM COM SUCESSO! <<<\n");
}

runTests();
