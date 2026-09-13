import { Application, Sprite, Assets, Container, Text, TextStyle, Graphics, AnimatedSprite, Texture } from 'pixi.js';

let ws: WebSocket;
let allClasses: any[] = [];
let myPlayer: any = null;

let currentSchool = 'Taijutsu';
let currentGender = 'Male';
let selectedClassId = 1;

const classArts: Record<number, string> = {
  1: '/textures/00A98683.png',
  2: '/textures/00A98688.png',
  3: '/textures/00A98693.png',
  4: '/textures/00A986A0.png',
  5: '/textures/00A986A3.png',
  6: '/textures/00AAE601.png'
};

const createModal = document.getElementById('create-modal')!;
const previewArt = document.getElementById('previewArt') as HTMLImageElement;
const classNameTitle = document.getElementById('classNameTitle')!;
const statsBox = document.getElementById('statsBox')!;
const charNameInput = document.getElementById('charName') as HTMLInputElement;

const app = new Application();
const townContainer = new Container();
const npcContainer = new Container();
const playerContainer = new Container();

let idleTextures: Texture[] = [];
let runTextures: Texture[] = [];
let playerAnimSprite: AnimatedSprite | null = null;

let targetX = 500;
let targetY = 400;
let isMoving = false;

async function init() {
  await app.init({ width: 1000, height: 580, backgroundColor: 0x05070a });
  document.getElementById('game-canvas')!.appendChild(app.canvas);

  app.stage.addChild(townContainer);
  app.stage.addChild(npcContainer);
  app.stage.addChild(playerContainer);

  // Carrega a textura autêntica de 1C000000 (layer_main.png)
  try {
    const bgTexture = await Assets.load('/textures/konoha_1c/layer_main.png');
    const bgSprite = new Sprite(bgTexture);
    bgSprite.width = 1000;
    bgSprite.height = 580;
    townContainer.addChild(bgSprite);
  } catch (e) {
    console.warn("Textura 1C não carregada, aplicando fallback:", e);
    const fallback = new Graphics().rect(0, 0, 1000, 580).fill(0x1a2119);
    townContainer.addChild(fallback);
  }

  // Carrega frames do jogador
  const idleUrls = [0, 1, 2, 3, 4, 5].map(i => `/sprites/player/neji_idle_${i}.png`);
  const runUrls = [0, 1, 2, 3, 4, 5, 6, 7].map(i => `/sprites/player/neji_run_${i}.png`);

  idleTextures = await Promise.all(idleUrls.map(u => Assets.load<Texture>(u)));
  runTextures = await Promise.all(runUrls.map(u => Assets.load<Texture>(u)));

  setupNPC();
  initWS();

  // Clique de movimentação
  app.canvas.addEventListener('click', (e) => {
    if (!myPlayer) return;
    const rect = app.canvas.getBoundingClientRect();
    targetX = Math.max(40, Math.min(960, e.clientX - rect.left));
    targetY = Math.max(260, Math.min(520, e.clientY - rect.top)); // Delimita área transitável do chão

    ws.send(JSON.stringify({
      type: 0x1015,
      payload: { x: targetX, y: targetY }
    }));
  });

  // Loop de Animação e Movimentação
  app.ticker.add(() => {
    if (!myPlayer || !playerAnimSprite) return;

    const dx = targetX - playerContainer.x;
    const dy = targetY - playerContainer.y;
    const dist = Math.sqrt(dx * dx + dy * dy);

    if (dist > 4) {
      const speed = 4.5;
      playerContainer.x += (dx / dist) * speed;
      playerContainer.y += (dy / dist) * speed;

      if (Math.abs(dx) > 1) {
        playerAnimSprite.scale.x = dx >= 0 ? 1.2 : -1.2;
      }

      if (!isMoving) {
        isMoving = true;
        playerAnimSprite.textures = runTextures;
        playerAnimSprite.animationSpeed = 0.22;
        playerAnimSprite.play();
      }
    } else {
      if (isMoving) {
        isMoving = false;
        playerAnimSprite.textures = idleTextures;
        playerAnimSprite.animationSpeed = 0.12;
        playerAnimSprite.play();
      }
    }
  });
}

function setupNPC() {
  npcContainer.x = 280;
  npcContainer.y = 380;

  const shadow = new Graphics().ellipse(0, 36, 20, 7).fill({ color: 0x000000, alpha: 0.55 });
  
  const questMarker = new Text({
    text: '!',
    style: new TextStyle({ fill: '#ffd700', fontSize: 24, fontWeight: 'bold', stroke: { color: '#000', width: 4 } })
  });
  questMarker.anchor.set(0.5);
  questMarker.y = -68;

  const name = new Text({
    text: 'Iruka Umino',
    style: new TextStyle({ fill: '#7ee787', fontSize: 12, fontWeight: 'bold', stroke: { color: '#000', width: 3 } })
  });
  name.anchor.set(0.5);
  name.y = -44;

  npcContainer.addChild(shadow, questMarker, name);

  let markerTick = 0;
  app.ticker.add(() => {
    markerTick += 0.06;
    questMarker.y = -68 + Math.sin(markerTick) * 4;
  });
}

function setupPlayerAvatar(player: any) {
  playerContainer.removeChildren();

  const shadow = new Graphics().ellipse(0, 36, 22, 8).fill({ color: 0x000000, alpha: 0.55 });
  playerContainer.addChild(shadow);

  playerAnimSprite = new AnimatedSprite(idleTextures);
  playerAnimSprite.anchor.set(0.5, 0.5);
  playerAnimSprite.scale.set(1.2);
  playerAnimSprite.animationSpeed = 0.12;
  playerAnimSprite.play();
  playerContainer.addChild(playerAnimSprite);

  const name = new Text({
    text: `${player.username}`,
    style: new TextStyle({
      fill: '#ffffff',
      fontSize: 12,
      fontWeight: 'bold',
      stroke: { color: '#000000', width: 3 }
    })
  });
  name.anchor.set(0.5);
  name.y = -52;
  playerContainer.addChild(name);

  playerContainer.x = player.positionInTown?.x || 500;
  playerContainer.y = player.positionInTown?.y || 400;
  targetX = playerContainer.x;
  targetY = playerContainer.y;
}

function initWS() {
  ws = new WebSocket('ws://localhost:8080');

  ws.onopen = () => {
    document.getElementById('netStatus')!.textContent = '● Conectado ao servidor Core (8080)';
    document.getElementById('netStatus')!.style.color = '#04d361';
    ws.send(JSON.stringify({ type: 0x1001, payload: {} }));
  };

  ws.onmessage = (ev) => {
    const pkt = JSON.parse(ev.data);

    if (pkt.type === 0x2005) {
      allClasses = pkt.payload.availableClasses;
      createModal.style.display = 'flex';
      updateUI();
    }

    if (pkt.type === 0x2002) {
      myPlayer = pkt.payload;
      createModal.style.display = 'none';
      document.getElementById('playerName')!.textContent = `${myPlayer.username} [${myPlayer.classInfo.school}]`;
      document.getElementById('ryo')!.textContent = myPlayer.silver.toLocaleString();
      document.getElementById('gold')!.textContent = myPlayer.gold.toLocaleString();
      setupPlayerAvatar(myPlayer);
    }

    if (pkt.type === 0x2015) {
      targetX = pkt.payload.position.x;
      targetY = pkt.payload.position.y;
    }
  };

  ws.onclose = () => {
    document.getElementById('netStatus')!.textContent = '○ Desconectado do servidor';
    document.getElementById('netStatus')!.style.color = '#ff4d4d';
  };
}

(window as any).selectSchool = (school: string) => {
  currentSchool = school;
  document.querySelectorAll('.btn-school').forEach(b => b.classList.toggle('active', b.textContent === school));
  updateUI();
};

(window as any).selectGender = (gender: string) => {
  currentGender = gender;
  document.getElementById('btnMale')!.classList.toggle('active', gender === 'Male');
  document.getElementById('btnFemale')!.classList.toggle('active', gender === 'Female');
  updateUI();
};

function updateUI() {
  const c = allClasses.find(x => x.school === currentSchool && x.gender === currentGender);
  if (!c) return;
  selectedClassId = c.id;
  previewArt.src = classArts[c.id];
  classNameTitle.textContent = c.name;
  statsBox.innerHTML = `<b>Título:</b> ${c.title}<br><b>Especialidade:</b> ${c.role}<br><br><b>HP:</b> ${c.hp} &nbsp;|&nbsp; <b>ATK:</b> ${c.atk}<br><b>DEF:</b> ${c.def} &nbsp;|&nbsp; <b>VEL:</b> ${c.spd}`;
}

(window as any).submitCharacter = () => {
  const name = charNameInput.value.trim();
  ws.send(JSON.stringify({
    type: 0x1005,
    payload: { classId: selectedClassId, customName: name || undefined }
  }));
};

init();
