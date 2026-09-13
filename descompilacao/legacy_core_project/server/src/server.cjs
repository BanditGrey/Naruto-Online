const http = require('http');
const fs = require('fs');
const path = require('path');
const { WebSocketServer } = require('ws');

const PORT = 8080;
const DATA_DIR = path.join(__dirname, 'data');

// As 3 Escolas canônicas da Joyfun (Masculino / Feminino)
const JOYFUN_CLASSES = [
  { id: 1, school: "Taijutsu", gender: "Male", name: "Guerreiro Taijutsu", title: "Punho Destruidor", role: "Vanguarda", hp: 850, atk: 135, def: 120, spd: 95, icon: "👊" },
  { id: 2, school: "Taijutsu", gender: "Female", name: "Guerreira Taijutsu", title: "Lótus Veloz", role: "Vanguarda", hp: 820, atk: 140, def: 115, spd: 100, icon: "🥋" },
  { id: 3, school: "Ninjutsu", gender: "Male", name: "Mestre Ninjutsu", title: "Ciclone Branco", role: "Dano / Meio", hp: 620, atk: 175, def: 85, spd: 110, icon: "🌀" },
  { id: 4, school: "Ninjutsu", gender: "Female", name: "Mestra Ninjutsu", title: "Demônio Escarlate", role: "Dano / Meio", hp: 600, atk: 180, def: 80, spd: 112, icon: "⚡" },
  { id: 5, school: "Genjutsu", gender: "Male", name: "Sábio Genjutsu", title: "Olho Espiritual", role: "Suporte / Retaguarda", hp: 560, atk: 125, def: 90, spd: 120, icon: "👁" },
  { id: 6, school: "Genjutsu", gender: "Female", name: "Sábia Genjutsu", title: "Sombra Espectral", role: "Suporte / Retaguarda", hp: 550, atk: 130, def: 85, spd: 122, icon: "🔮" }
];

let playerState = null;

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ status: 'online', game: 'Naruto Joyfun Core' }));
});

const wss = new WebSocketServer({ server });

wss.on('connection', (ws) => {
  console.log('[NET] Cliente conectado.');

  ws.on('message', (raw) => {
    try {
      const pkt = JSON.parse(raw);

      if (pkt.type === 0x1001) {
        if (!playerState) {
          ws.send(JSON.stringify({
            type: 0x2005,
            payload: { needsCreation: true, availableClasses: JOYFUN_CLASSES }
          }));
        } else {
          ws.send(JSON.stringify({ type: 0x2001, payload: { success: true } }));
          ws.send(JSON.stringify({ type: 0x2002, payload: playerState }));
        }
      }

      if (pkt.type === 0x1005) {
        const { classId, customName } = pkt.payload;
        const chosen = JOYFUN_CLASSES.find(c => c.id === classId) || JOYFUN_CLASSES[0];
        const finalName = customName && customName.trim().length >= 3 ? customName.trim() : chosen.name;

        playerState = {
          uid: "player_001",
          username: finalName,
          classInfo: chosen,
          silver: 50000,
          gold: 100,
          positionInTown: { x: 500, y: 340 },
          team: [
            { instanceId: "inst_main", heroId: chosen.id, name: finalName, level: 1, exp: 0, position: 4, hp: chosen.hp, maxHp: chosen.hp, atk: chosen.atk, def: chosen.def, spd: chosen.spd },
            { instanceId: "inst_naruto", heroId: 101, name: "Naruto Uzumaki", level: 1, exp: 0, position: 1, hp: 650, maxHp: 650, atk: 120, def: 90, spd: 100 }
          ],
          inventory: [
            { slot: 0, itemId: 14099993, name: "Cuộn kinh nghiệm nhỏ", expGiven: 500, count: 10 }
          ]
        };

        console.log(`[PROTAGONISTA CRIADO] ${finalName} - Escola: ${chosen.school} (${chosen.gender})`);

        ws.send(JSON.stringify({ type: 0x2006, payload: { success: true } }));
        ws.send(JSON.stringify({ type: 0x2002, payload: playerState }));
      }

      if (pkt.type === 0x1015 && playerState) {
        const { x, y } = pkt.payload;
        playerState.positionInTown = { x: Math.max(50, Math.min(1150, x)), y: Math.max(50, Math.min(540, y)) };
        ws.send(JSON.stringify({
          type: 0x2015,
          payload: { position: playerState.positionInTown }
        }));
      }

    } catch (err) {
      console.error('[NET] Erro no pacote:', err.message);
    }
  });

  ws.on('close', () => console.log('[NET] Cliente desconectado.'));
});

server.listen(PORT, () => {
  console.log(`✓ Servidor Core online em http://localhost:${PORT}`);
});
