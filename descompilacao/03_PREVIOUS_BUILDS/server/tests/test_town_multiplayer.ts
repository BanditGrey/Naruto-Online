import { PacketReader, PacketWriter } from '../src/network/packet.ts';
import { OPCODES } from '../src/network/opcodes.ts';
import { db } from '../src/database/db.ts';

// Configurações de teste
const WS_PORT = 8080;
const MAP_ID = 10101;

// Cria duas contas e personagens no banco caso não existam
const accA = db.getOrCreateAccount('player_a_test', 'token_a');
let charA = db.getCharacterByAccountId(accA.id);
if (!charA) {
    charA = db.createCharacter(accA.id, 'Naruto_A', 1, 1);
}

const accB = db.getOrCreateAccount('player_b_test', 'token_b');
let charB = db.getCharacterByAccountId(accB.id);
if (!charB) {
    charB = db.createCharacter(accB.id, 'Sasuke_B', 2, 1);
}

console.log(`[TEST SETUP] Jogador A: ${charA.name} (Conta: ${accA.user_id}, ID: ${charA.id})`);
console.log(`[TEST SETUP] Jogador B: ${charB.name} (Conta: ${accB.user_id}, ID: ${charB.id})`);

function buildClientLoginPacket(userId: string, token: string = "token"): Buffer {
    const writer = new PacketWriter();
    writer.writeStringUTF(userId);
    writer.writeUnsignedInt(1001);     // AgentID
    writer.writeUnsignedInt(480);      // ServerID
    writer.writeStringUTF(token);      // Token
    writer.writeUnsignedInt(20240901); // Version
    writer.writeStringUTF(new Date().toISOString()); // LoginTime
    return writer.toPacket(OPCODES.CS_Login_StatusServerTransmitToken);
}

async function runTest() {
    return new Promise<void>((resolve, reject) => {
        const timeout = setTimeout(() => {
            reject(new Error("Timeout de teste (10s) atingido!"));
        }, 10000);

        const wsUrl = `ws://127.0.0.1:${WS_PORT}`;
        const wsA = new WebSocket(wsUrl);
        const wsB = new WebSocket(wsUrl);

        let stageA = 0;
        let stageB = 0;

        let bSawAInTown = false;
        let aSawBInTown = false;
        let aSawBMove = false;

        function checkCompletion() {
            if (bSawAInTown && aSawBInTown && aSawBMove) {
                console.log("\n=======================================================");
                console.log(" TODOS OS TESTES DE SINCRONIZAÇÃO MULTIPLAYER PASSARAM!");
                console.log("=======================================================");
                clearTimeout(timeout);
                wsA.close();
                wsB.close();
                resolve();
            }
        }

        // Helper para envio de pacotes sem payload adicional
        function sendSimplePacket(ws: WebSocket, opcode: number) {
            const writer = new PacketWriter();
            ws.send(writer.toPacket(opcode));
        }

        // -------------------------
        // Conexão e Handlers do Jogador A
        // -------------------------
        wsA.binaryType = 'arraybuffer';
        wsA.onopen = () => {
            console.log("[WS A] Conectado ao servidor! Enviando login...");
            wsA.send(buildClientLoginPacket(accA.user_id, accA.token));
        };

        wsA.onmessage = (event) => {
            const buffer = Buffer.from(event.data as ArrayBuffer);
            const decoded = PacketReader.fromBuffer(buffer);
            if (!decoded) return;

            const opcode = decoded.packetId;
            const reader = decoded.reader;

            if (opcode === OPCODES.SC_Login_StatusServerTransmitTokenRet) {
                console.log("[WS A] Recebeu confirmação de login.");
            } else if (opcode === OPCODES.SC_Account_CharInfoNtf) {
                console.log("[WS A] Recebeu dados do personagem (SC_Account_CharInfoNtf). Solicitando entrada na vila...");
                sendSimplePacket(wsA, OPCODES.CS_LOBBY_Enter_Town);
            } else if (opcode === OPCODES.SC_Enter_Town) {
                const mapId = reader.readUInt32();
                const x = reader.readUInt16();
                const y = reader.readUInt16();
                const dir = reader.readByte();
                console.log(`[WS A] Entrou na Vila! Mapa: ${mapId}, Spawn: (${x}, ${y}), Dir: ${dir}`);
                stageA = 1;
            } else if (opcode === OPCODES.SC_LOBBY_Town_NewRoleNtf) {
                const count = reader.readInt16();
                console.log(`[WS A] Recebeu SC_LOBBY_Town_NewRoleNtf com ${count} jogador(es):`);
                for (let i = 0; i < count; i++) {
                    const guidH = reader.readUInt32();
                    const guidL = reader.readUInt32();
                    const proto = reader.readUInt32();
                    const name = reader.readFlushUTF();
                    reader.readUInt32(); // rank
                    reader.readUInt32(); // level
                    reader.readUInt32(); // family
                    reader.readByte();   // relex
                    reader.readUInt32(); // texture
                    const mapX = reader.readUInt16();
                    const mapY = reader.readUInt16();
                    // pular atributos restantes do role
                    reader.readByte();   // quality
                    reader.readUInt32(); // baseHero
                    reader.readUInt32(); // title
                    reader.readUInt32(); // pet1
                    reader.readUInt32(); // pet2
                    reader.readUInt32(); // wing
                    reader.readUInt32(); // transform
                    reader.readInt32();  // hideWing
                    reader.readUInt32(); // jade
                    reader.readInt16();  // badgeCount

                    console.log(`  -> [WS A avistou] Ninja #${guidL} ("${name}") em (${mapX}, ${mapY})`);
                    if (name === charB.name) {
                        console.log(`  [VERIFICAÇÃO SUCESSO] Jogador A avistou o Jogador B (${charB.name}) entrando na vila!`);
                        aSawBInTown = true;
                        checkCompletion();
                    }
                }
            } else if (opcode === OPCODES.SC_LOBBY_Town_RoleMove) {
                const guidH = reader.readUInt32();
                const guidL = reader.readUInt32();
                const targetX = reader.readUInt16();
                const targetY = reader.readUInt16();
                console.log(`[WS A] Recebeu SC_LOBBY_Town_RoleMove -> Jogador GUID ${guidL} moveu para (${targetX}, ${targetY})`);
                if (guidL === charB.id && targetX === 1450 && targetY === 880) {
                    console.log(`  [VERIFICAÇÃO SUCESSO] Jogador A recebeu o movimento em tempo real de Jogador B!`);
                    aSawBMove = true;
                    checkCompletion();
                }
            }
        };

        // -------------------------
        // Conexão e Handlers do Jogador B
        // -------------------------
        wsB.binaryType = 'arraybuffer';
        wsB.onopen = () => {
            console.log("[WS B] Conectado ao servidor! Aguardando Jogador A entrar na vila...");
            const checkAInterval = setInterval(() => {
                if (stageA === 1) {
                    clearInterval(checkAInterval);
                    console.log("[WS B] Enviando login...");
                    wsB.send(buildClientLoginPacket(accB.user_id, accB.token));
                }
            }, 200);
        };

        wsB.onmessage = (event) => {
            const buffer = Buffer.from(event.data as ArrayBuffer);
            const decoded = PacketReader.fromBuffer(buffer);
            if (!decoded) return;

            const opcode = decoded.packetId;
            const reader = decoded.reader;

            if (opcode === OPCODES.SC_Login_StatusServerTransmitTokenRet) {
                console.log("[WS B] Recebeu confirmação de login.");
            } else if (opcode === OPCODES.SC_Account_CharInfoNtf) {
                console.log("[WS B] Recebeu dados do personagem (SC_Account_CharInfoNtf). Solicitando entrada na vila...");
                sendSimplePacket(wsB, OPCODES.CS_LOBBY_Enter_Town);
            } else if (opcode === OPCODES.SC_Enter_Town) {
                const mapId = reader.readUInt32();
                const x = reader.readUInt16();
                const y = reader.readUInt16();
                console.log(`[WS B] Entrou na Vila! Mapa: ${mapId}, Spawn: (${x}, ${y})`);
                stageB = 1;
            } else if (opcode === OPCODES.SC_LOBBY_Town_NewRoleNtf) {
                const count = reader.readInt16();
                console.log(`[WS B] Recebeu lista de jogadores na vila (${count} jogadores):`);
                for (let i = 0; i < count; i++) {
                    const guidH = reader.readUInt32();
                    const guidL = reader.readUInt32();
                    const proto = reader.readUInt32();
                    const name = reader.readFlushUTF();
                    reader.readUInt32(); // rank
                    reader.readUInt32(); // level
                    reader.readUInt32(); // family
                    reader.readByte();   // relex
                    reader.readUInt32(); // texture
                    const mapX = reader.readUInt16();
                    const mapY = reader.readUInt16();
                    reader.readByte();   // quality
                    reader.readUInt32(); // baseHero
                    reader.readUInt32(); // title
                    reader.readUInt32(); // pet1
                    reader.readUInt32(); // pet2
                    reader.readUInt32(); // wing
                    reader.readUInt32(); // transform
                    reader.readInt32();  // hideWing
                    reader.readUInt32(); // jade
                    reader.readInt16();  // badgeCount

                    console.log(`  -> [WS B avistou] Ninja #${guidL} ("${name}") em (${mapX}, ${mapY})`);
                    if (name === charA.name) {
                        console.log(`  [VERIFICAÇÃO SUCESSO] Jogador B avistou o Jogador A (${charA.name}) que já estava no mapa!`);
                        bSawAInTown = true;
                    }
                }

                // Assim que B entrar e ver A, B envia comando de movimentação para (1450, 880)
                setTimeout(() => {
                    console.log("[WS B] Enviando CS_LOBBY_Town_Move para (1450, 880)...");
                    const moveWriter = new PacketWriter();
                    moveWriter.writeInt16(1450);
                    moveWriter.writeInt16(880);
                    wsB.send(moveWriter.toPacket(OPCODES.CS_LOBBY_Town_Move));
                }, 300);
            }
        };

        wsA.onerror = (err) => console.error("[WS A ERROR]", err);
        wsB.onerror = (err) => console.error("[WS B ERROR]", err);
    });
}

runTest().then(() => {
    process.exit(0);
}).catch((err) => {
    console.error("\n[TEST ERROR]", err);
    process.exit(1);
});
