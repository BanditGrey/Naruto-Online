import * as fs from "node:fs";
import * as path from "node:path";
import { getOpcodeName } from "./opcodes.ts";

const LOG_FILE = path.join(process.cwd(), "docs", "OFFICIAL_CLIENT_TRAFFIC.log");

// Ensure docs directory exists
const logDir = path.dirname(LOG_FILE);
if (!fs.existsSync(logDir)) {
  fs.mkdirSync(logDir, { recursive: true });
}

/**
 * Produz um dump canônico Hexadecimal + ASCII de 16 bytes por linha
 */
export function formatHexAsciiDump(buf: Buffer): string {
  const lines: string[] = [];
  for (let i = 0; i < buf.length; i += 16) {
    const chunk = buf.subarray(i, Math.min(i + 16, buf.length));
    const offsetHex = i.toString(16).padStart(8, "0");

    const hexParts: string[] = [];
    for (let j = 0; j < 16; j++) {
      if (j < chunk.length) {
        hexParts.push(chunk[j].toString(16).padStart(2, "0"));
      } else {
        hexParts.push("  ");
      }
      if (j === 7) hexParts.push("");
    }

    let ascii = "";
    for (let j = 0; j < chunk.length; j++) {
      const b = chunk[j];
      ascii += b >= 32 && b <= 126 ? String.fromCharCode(b) : ".";
    }

    lines.push(`  ${offsetHex}: ${hexParts.join(" ")}  |${ascii}|`);
  }
  return lines.join("\n");
}

/**
 * Sniffer de Pacotes em Tempo Real
 * Registra pacotes de rede recebidos ou enviados, exibindo no terminal e gravando em log
 */
export function logPacketTraffic(
  direction: "RECV" | "SEND",
  clientType: "TCP" | "WS",
  rawBytes: Buffer,
  clientEndpoint?: string
) {
  const timestamp = new Date().toISOString();

  let opcodeDec = 0;
  let opcodeHex = "0x00000000";
  let opcodeName = "UNKNOWN_OPCODE";
  let packetLen = rawBytes.length;

  if (rawBytes.length >= 8) {
    packetLen = rawBytes.readUInt32BE(0);
    opcodeDec = rawBytes.readUInt32BE(4);
    opcodeHex = "0x" + opcodeDec.toString(16).toUpperCase().padStart(8, "0");
    opcodeName = getOpcodeName(opcodeDec);
  }

  const endpointStr = clientEndpoint ? ` [${clientEndpoint}]` : "";
  const headerLine = `[${timestamp}] [${direction}] [${clientType}]${endpointStr}`;
  const metaLine = `Opcode: ${opcodeHex} (${opcodeDec}) [${opcodeName}] | Tamanho Declarado: ${packetLen}B | Bytes Reais: ${rawBytes.length}B`;
  const dump = formatHexAsciiDump(rawBytes);

  const fullLog = `\n${"=".repeat(75)}\n${headerLine}\n${metaLine}\n--- DUMP HEX / ASCII ---\n${dump}\n${"=".repeat(75)}`;

  // Imprime no console do servidor
  console.log(fullLog);

  // Grava de forma assíncrona no arquivo oficial de log
  try {
    fs.appendFileSync(LOG_FILE, fullLog + "\n", "utf8");
  } catch (err: any) {
    console.error(`[PacketSniffer] Erro ao gravar em ${LOG_FILE}:`, err.message);
  }
}
