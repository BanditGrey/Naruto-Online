/**
 * Configurações e manifesto de todos os assets animados autênticos das Cidades Ninja
 * Base canônica: database/extracted/npcs.json e CONST_NPC.as
 */

import { NpcFunctionType } from './NpcFunctionBadge.ts';

export interface NPCConfig {
  id: number;
  cityId: number;
  name: string;
  role: string;
  userType: NpcFunctionType;
  folder?: string;
  frameCount?: number;
  isStatic?: boolean;
  path?: string;
  scale?: number;
  x: number;
  y: number;
  talk: string;
}

export interface HeroAnimationConfig {
  folder: string;
  idleCount: number;
  runCount: number;
}

// 1. CIDADÃOS DO SUBÚRBIO DOS PRINCIPIANTES (Novice Suburb - ID: 23100001)
export const NOVICE_SUBURB_NPCS: NPCConfig[] = [
  {
    id: 22100001,
    cityId: 23100001,
    name: 'City Gate',
    role: 'Portão da Vila',
    userType: NpcFunctionType.GATE,
    folder: 'city_gate',
    frameCount: 10,
    x: 2144,
    y: 450,
    talk: '⛩️ Portão de Saída: O caminho além leva à Grande Aldeia de Konohagakure e ao Mundo Ninja.',
  },
  {
    id: 22100003,
    cityId: 23100001,
    name: '3º Hokage',
    role: 'Hiruzen Sarutobi',
    userType: NpcFunctionType.STORY,
    folder: 'hokage3',
    frameCount: 11,
    x: 350,
    y: 430,
    talk: '🔥 3º Hokage: A sombra do fogo brilhará sobre a vila... e novas folhas brotarão.',
  },
  {
    id: 22100008,
    cityId: 23100001,
    name: 'Ibiki Morino',
    role: 'Examinador ANBU',
    userType: NpcFunctionType.STORY,
    folder: 'ibiki',
    frameCount: 6,
    x: 240,
    y: 420,
    talk: '🛡️ Ibiki: O futuro está em suas próprias mãos! Não tema a pressão da batalha.',
  },
  {
    id: 22100010,
    cityId: 23100001,
    name: 'Gekkou Hayate',
    role: 'Examinador Tokubetsu',
    userType: NpcFunctionType.STORY,
    folder: 'hayate',
    frameCount: 7,
    x: 500,
    y: 430,
    talk: '🗡️ Hayate: *Cof, cof*... Mostre do que é capaz nas preliminares.',
  },
  {
    id: 22100014,
    cityId: 23100001,
    name: 'Konohamaru',
    role: 'Neto do Hokage',
    userType: NpcFunctionType.STORY,
    folder: 'konohamaru',
    frameCount: 5,
    x: 622,
    y: 420,
    talk: '🔥 Konohamaru: Não existem atalhos no caminho para se tornar um Hokage!',
  },
  {
    id: 22100013,
    cityId: 23100001,
    name: 'Tsunade',
    role: 'Taverna dos Iniciantes',
    userType: NpcFunctionType.PUB,
    folder: 'sakura',
    frameCount: 6,
    x: 820,
    y: 430,
    talk: '🍺 Tsunade: Eu não sou uma garota frágil. Tenho um poder lendário!',
  },
  {
    id: 22100004,
    cityId: 23100001,
    name: 'Iruka Umino',
    role: 'Instrutor da Academia',
    userType: NpcFunctionType.STORY,
    folder: 'iruka',
    frameCount: 8,
    x: 950,
    y: 430,
    talk: '📘 Iruka: Não se preocupe com o que ficou para trás. Continue avançando!',
  },
  {
    id: 22100012,
    cityId: 23100001,
    name: 'Gaara',
    role: 'Genin de Sunagakure',
    userType: NpcFunctionType.STORY,
    folder: 'gaara',
    frameCount: 6,
    x: 1078,
    y: 430,
    talk: '⏳ Gaara: Não acredite cegamente no destino! Acredite no poder que você constrói.',
  },
  {
    id: 22100009,
    cityId: 23100001,
    name: 'Anko Mitarashi',
    role: 'Examinadora da Floresta',
    userType: NpcFunctionType.PUB,
    folder: 'anko',
    frameCount: 4,
    x: 1225,
    y: 430,
    talk: '🐍 Anko: Comportem-se! A Floresta da Morte engole quem hesita!',
  },
  {
    id: 22100011,
    cityId: 23100001,
    name: 'Jiraiya',
    role: 'Sábio dos Sapos',
    userType: NpcFunctionType.WAREHOUSE,
    folder: 'jiraiya',
    frameCount: 6,
    x: 1385,
    y: 430,
    talk: '🐸 Jiraiya: Eu sou o lendário Gama Sennin de Myōbokuzan!',
  },
  {
    id: 22100006,
    cityId: 23100001,
    name: 'Naruto Uzumaki',
    role: 'Genin da Folha',
    userType: NpcFunctionType.STORY,
    folder: 'naruto',
    frameCount: 10,
    x: 1535,
    y: 430,
    talk: '🍥 Naruto: Eu nunca volto atrás na minha palavra... esse é meu jeito ninja de ser!',
  },
  {
    id: 22100007,
    cityId: 23100001,
    name: 'Sasuke Uchiha',
    role: 'Genin Prodígio',
    userType: NpcFunctionType.STORY,
    folder: 'sasuke',
    frameCount: 5,
    x: 1700,
    y: 430,
    talk: '⚡ Sasuke: Eu restaurarei meu clã e eliminarei aquele homem.',
  },
  {
    id: 22100005,
    cityId: 23100001,
    name: 'Kakashi Hatake',
    role: 'Jōnin Líder Time 7',
    userType: NpcFunctionType.STORY,
    folder: 'kakashi',
    frameCount: 6,
    x: 1900,
    y: 430,
    talk: '📖 Kakashi: Aqueles que quebram as regras são lixo, mas quem abandona os amigos é pior que lixo.',
  },
];

// 2. CIDADÃOS DA GRANDE ALDEIA DA FOLHA (Konoha Village - ID: 23200001)
export const KONOHA_VILLAGE_NPCS: NPCConfig[] = [
  {
    id: 22200013,
    cityId: 23200001,
    name: 'City Gate',
    role: 'Grande Portão de Konoha',
    userType: NpcFunctionType.GATE,
    folder: 'city_gate',
    frameCount: 10,
    x: 2306,
    y: 450,
    talk: '⛩️ Sentinela: Entrada e saída oficial de Konohagakure. Escolha seu destino no Mapa Mundi.',
  },
  {
    id: 22200007,
    cityId: 23200001,
    name: 'Gaara do Deserto',
    role: 'Kazekage / Aliado',
    userType: NpcFunctionType.STORY,
    folder: 'gaara',
    frameCount: 6,
    x: 210,
    y: 440,
    talk: '⏳ Gaara: A aliança entre Konoha e Suna permanecerá inabalável.',
  },
  {
    id: 22200008,
    cityId: 23200001,
    name: 'Gekkou Hayate',
    role: 'Arena de Batalhas',
    userType: NpcFunctionType.GODEQUIP,
    folder: 'hayate',
    frameCount: 7,
    x: 383,
    y: 440,
    talk: '🗡️ Hayate: Nunca subestime os shinobi que buscam a glória na Arena!',
  },
  {
    id: 22200010,
    cityId: 23200001,
    name: 'Sasuke (Manto Branco)',
    role: 'Treinamento Taka',
    userType: NpcFunctionType.STORY,
    folder: 'sasuke',
    frameCount: 5,
    x: 523,
    y: 440,
    talk: '⚡ Sasuke: Minha visão agora enxerga a verdadeira escuridão.',
  },
  {
    id: 22200009,
    cityId: 23200001,
    name: 'Naruto (Modo Sábio)',
    role: 'Herói de Konoha',
    userType: NpcFunctionType.STORY,
    folder: 'naruto',
    frameCount: 10,
    x: 630,
    y: 440,
    talk: '🍥 Naruto: Com o chakra senjutsu, protegerei todos os meus companheiros!',
  },
  {
    id: 22200030,
    cityId: 23200001,
    name: '1º Hokage (Hashirama)',
    role: 'Caminho do Mestre',
    userType: NpcFunctionType.MASTERROAD,
    folder: 'hokage3',
    frameCount: 11,
    x: 750,
    y: 440,
    talk: '🌳 Hashirama: Você está pronto para o treinamento definitivo dos fundadores de Konoha!',
  },
  {
    id: 22200005,
    cityId: 23200001,
    name: 'Iruka Umino',
    role: 'Academia Ninja',
    userType: NpcFunctionType.STORY,
    folder: 'iruka',
    frameCount: 8,
    x: 845,
    y: 440,
    talk: '📘 Iruka: O verdadeiro exame de um shinobi é nunca perder a sua determinação.',
  },
  {
    id: 22200011,
    cityId: 23200001,
    name: 'Jiraiya',
    role: 'Armazém da Folha',
    userType: NpcFunctionType.WAREHOUSE,
    folder: 'jiraiya',
    frameCount: 6,
    x: 950,
    y: 440,
    talk: '📦 Jiraiya: Guarde seus tesouros e pergaminhos mais valiosos no Armazém da Folha.',
  },
  {
    id: 22200002,
    cityId: 23200001,
    name: 'Kakashi Hatake',
    role: 'Transformação & Cartas',
    userType: NpcFunctionType.COPY,
    folder: 'kakashi',
    frameCount: 6,
    x: 1130,
    y: 440,
    talk: '🎭 Kakashi: Domine a arte da transformação para assumir o poder dos grandes ninjas.',
  },
  {
    id: 22200004,
    cityId: 23200001,
    name: 'Tsunade Senju',
    role: 'Taverna Ninja (Recrutamento)',
    userType: NpcFunctionType.PUB,
    folder: 'sakura',
    frameCount: 6,
    x: 1275,
    y: 440,
    talk: '🍺 Tsunade: Venha disputar no Jokenpô! Ganhe almas ninjas para recrutar companheiros lendários!',
  },
  {
    id: 22200031,
    cityId: 23200001,
    name: 'Terumi Mei',
    role: 'Laços & Casamento',
    userType: NpcFunctionType.YUELAO,
    folder: 'hinata',
    frameCount: 6,
    x: 1383,
    y: 440,
    talk: '💖 Terumi Mei: Encontre um parceiro leal para lutar ao seu lado no Mundo Shinobi!',
  },
  {
    id: 22200012,
    cityId: 23200001,
    name: 'God of Craftsman',
    role: 'Forja do Ferreiro',
    userType: NpcFunctionType.MADE,
    folder: 'neji',
    frameCount: 6,
    x: 1491,
    y: 440,
    talk: '🔨 Ferreiro: Ano após ano, forjando as lâminas e armaduras mais resistentes de Konoha!',
  },
  {
    id: 22200001,
    cityId: 23200001,
    name: 'Sasuke Uchiha',
    role: 'Genin da Folha',
    userType: NpcFunctionType.STORY,
    folder: 'sasuke',
    frameCount: 5,
    x: 1665,
    y: 440,
    talk: '⚡ Sasuke: Chidori... não fique no caminho dos meus objetivos.',
  },
  {
    id: 22200003,
    cityId: 23200001,
    name: 'Naruto Uzumaki',
    role: 'Genin da Folha',
    userType: NpcFunctionType.STORY,
    folder: 'naruto',
    frameCount: 10,
    x: 1810,
    y: 440,
    talk: '🍥 Naruto: Vamos treinar juntos! Um dia você verá que serei o maior Hokage de todos!',
  },
  {
    id: 22200006,
    cityId: 23200001,
    name: 'Morino Ibiki',
    role: 'Engastes de Jade / Magatama',
    userType: NpcFunctionType.STONE,
    folder: 'ibiki',
    frameCount: 6,
    x: 2018,
    y: 440,
    talk: '💎 Ibiki: Para a vila, o que mais importa são shinobis resilientes fortificados com Magatamas.',
  },
  // NPCs Especiais de Estabelecimento (Quiosque do Rámen)
  {
    id: 99900001,
    cityId: 23200001,
    name: 'Teuchi',
    role: 'Chef do Ichiraku Rámen',
    userType: NpcFunctionType.STORY,
    isStatic: true,
    path: '/assets/town/npc_teuchi.png',
    scale: 0.65,
    x: 1220,
    y: 440,
    talk: '🍜 Teuchi: O ingrediente secreto do meu lámen é o carinho pelos jovens shinobi de Konoha! Recupere sua Stamina!',
  },
  {
    id: 99900002,
    cityId: 23200001,
    name: 'Ayame',
    role: 'Atendente Ichiraku',
    userType: NpcFunctionType.STORY,
    isStatic: true,
    path: '/assets/town/npc_ayame.png',
    scale: 0.7,
    x: 1390,
    y: 440,
    talk: '✨ Ayame: Bem-vindo! Uma tigela bem quente de lámen dá forças para qualquer missão Rank-S!',
  },
];

export const AUTHENTIC_NPCS: NPCConfig[] = KONOHA_VILLAGE_NPCS;

export const AUTHENTIC_HEROES: Record<string, HeroAnimationConfig> = {
  taijutsu_m: { folder: 'hero_taijutsu_m', idleCount: 6, runCount: 8 },
  taijutsu_f: { folder: 'hero_taijutsu_f', idleCount: 6, runCount: 8 },
  ninjutsu_m: { folder: 'hero_ninjutsu_m', idleCount: 10, runCount: 10 },
  ninjutsu_f: { folder: 'hero_ninjutsu_f', idleCount: 6, runCount: 8 },
  genjutsu_m: { folder: 'hero_genjutsu_m', idleCount: 6, runCount: 8 },
  genjutsu_f: { folder: 'hero_genjutsu_f', idleCount: 6, runCount: 8 },
};

// Coleta todos os URLs para pré-carregamento automático
const allNpcs = [...NOVICE_SUBURB_NPCS, ...KONOHA_VILLAGE_NPCS];
const uniqueUrls = new Set<string>();

for (const npc of allNpcs) {
  if (npc.isStatic && npc.path) {
    uniqueUrls.add(npc.path);
  } else if (npc.folder && npc.frameCount) {
    for (let i = 0; i < npc.frameCount; i++) {
      uniqueUrls.add(`/assets/animated/npcs/${npc.folder}/idle_${i}.png`);
    }
  }
}

for (const [, h] of Object.entries(AUTHENTIC_HEROES)) {
  for (let i = 0; i < h.idleCount; i++) {
    uniqueUrls.add(`/assets/animated/heroes/${h.folder}/idle_${i}.png`);
  }
  for (let i = 0; i < h.runCount; i++) {
    uniqueUrls.add(`/assets/animated/heroes/${h.folder}/run_${i}.png`);
  }
}

export const ALL_ANIMATED_ASSETS: string[] = Array.from(uniqueUrls);
