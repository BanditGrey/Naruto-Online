const fs = require('fs');
const path = require('path');

const npcs = [
  // Zona Oeste: Academia Ninja e Residência do Hokage (X: 200 - 800)
  { name: '3º Hokage', role: 'Hiruzen Sarutobi', folder: 'hokage3', frameCount: 11, x: 280, y: 520, talk: '🔥 3º Hokage: A Vontade do Fogo que arde em Konoha continuará iluminando o futuro de nossas crianças.' },
  { name: 'Morino Ibiki', role: 'Comandante ANBU', folder: 'ibiki', frameCount: 6, x: 420, y: 460, talk: '🛡️ Ibiki: Informação é a arma mais letal de um shinobi. Uma mente fraca perece antes do corpo.' },
  { name: 'Gekkou Hayate', role: 'Examinador Tokubetsu', folder: 'hayate', frameCount: 7, x: 570, y: 540, talk: '🗡️ Hayate: *Cof, cof*... A batalha decisiva entre os aspirantes a Chūnin começará em breve.' },
  { name: 'Konohamaru', role: 'Neto do Hokage', folder: 'konohamaru', frameCount: 5, x: 720, y: 480, talk: '🔥 Konohamaru: Meu rival e meu mestre é o Naruto! Um dia serei o 7º Hokage!' },

  // Zona Central-Oeste: Treinamento e Academia (X: 850 - 1100)
  { name: 'Iruka', role: 'Instrutor Chefe', folder: 'iruka', frameCount: 8, x: 880, y: 510, talk: '📘 Iruka: Naruto pode ter sido um aluno travesso, mas tem o coração mais nobre de Konoha!' },
  { name: 'Anko Mitarashi', role: 'Examinadora Especial', folder: 'anko', frameCount: 4, x: 1040, y: 470, talk: '🐍 Anko: Comportem-se como ninjas de verdade! O Exame Chūnin não perdoa hesitações!' },

  // Zona Central: Largo do Ichiraku Ramen (X: 1150 - 1650)
  { name: 'Teuchi', role: 'Chef Ichiraku', isStatic: true, path: '/assets/town/npc_teuchi.png', scale: 0.65, x: 1250, y: 440, talk: '🍜 Teuchi: O ingrediente secreto do meu rámen é a dedicação aos jovens de Konoha!' },
  { name: 'Ayame', role: 'Atendente Ichiraku', isStatic: true, path: '/assets/town/npc_ayame.png', scale: 0.70, x: 1420, y: 440, talk: '✨ Ayame: Bem-vindo! Uma tigela bem quente de lámen dá forças para qualquer missão Rank-S!' },
  { name: 'Naruto Uzumaki', role: 'Genin da Folha', folder: 'naruto', frameCount: 10, x: 1340, y: 580, talk: '🍥 Naruto: Eu nunca volto atrás na minha palavra... esse é o meu jeito ninja de ser! Dattebayo!' },
  { name: 'Jiraiya', role: 'Sábio dos Sapos', folder: 'jiraiya', frameCount: 6, x: 1540, y: 500, talk: '🐸 Jiraiya: Gama Sennin em pessoa! O destino do mundo ninja repousa na próxima geração.' },
  { name: 'Rock Lee', role: 'Furacão de Konoha', folder: 'rock_lee', frameCount: 6, x: 1680, y: 570, talk: '🥊 Rock Lee: Se você não pode dar mil socos, dê dois mil chutes! A juventude nunca para!' },

  // Zona Central-Leste: Time 7 e Aliados (X: 1750 - 2050)
  { name: 'Sasuke Uchiha', role: 'Genin Prodígio', folder: 'sasuke', frameCount: 5, x: 1840, y: 540, talk: '⚡ Sasuke: Chidori... o som de mil pássaros relampejantes. Não fique no meu caminho.' },
  { name: 'Neji Hyuga', role: 'Gênio do Byakugan', folder: 'neji', frameCount: 6, x: 1980, y: 480, talk: '👁️ Neji: Oito Trigramas, Sessenta e Quatro Golpes! Nenhum ponto de chakra fica oculto.' },

  // Zona Leste: Portão Principal de Konoha e Visitantes (X: 2100 - 2480)
  { name: 'Kakashi Hatake', role: 'Jōnin do Sharingan', folder: 'kakashi', frameCount: 6, x: 2100, y: 530, talk: '📖 Kakashi: Um ninja deve enxergar através da decepção... e valorizar os laços de amizade acima de tudo.' },
  { name: 'Itachi Uchiha', role: 'Gênio Renegado', folder: 'itachi', frameCount: 6, x: 2220, y: 470, talk: '🌙 Itachi: As pessoas vivem suas vidas presas pelo que aceitam como correto e verdadeiro...' },
  { name: 'Portão de Konoha', role: 'Sentinela da Folha', folder: 'city_gate', frameCount: 10, x: 2340, y: 450, talk: '⛩️ Sentinela: Entrada supervisionada de Konohagakure. Identifique-se com sua bandana ninja!' },
  { name: 'Gaara', role: 'Defesa Absoluta', folder: 'gaara', frameCount: 6, x: 2440, y: 560, talk: '⏳ Gaara: A areia protege aqueles que encontram um verdadeiro propósito na vida.' }
];

const heroes = {
  taijutsu_m: { folder: 'hero_taijutsu_m', idleCount: 6, runCount: 8 },
  taijutsu_f: { folder: 'hero_taijutsu_f', idleCount: 6, runCount: 8 },
  ninjutsu_m: { folder: 'hero_ninjutsu_m', idleCount: 10, runCount: 10 },
  ninjutsu_f: { folder: 'hero_ninjutsu_f', idleCount: 6, runCount: 8 },
  genjutsu_m: { folder: 'hero_genjutsu_m', idleCount: 6, runCount: 8 },
  genjutsu_f: { folder: 'hero_genjutsu_f', idleCount: 6, runCount: 8 },
};

const allUrls = [];

for (const npc of npcs) {
  if (npc.isStatic) {
    allUrls.push(npc.path);
  } else {
    for (let i = 0; i < npc.frameCount; i++) {
      allUrls.push('/assets/animated/npcs/' + npc.folder + '/idle_' + i + '.png');
    }
  }
}

for (const [key, h] of Object.entries(heroes)) {
  for (let i = 0; i < h.idleCount; i++) {
    allUrls.push('/assets/animated/heroes/' + h.folder + '/idle_' + i + '.png');
  }
  for (let i = 0; i < h.runCount; i++) {
    allUrls.push('/assets/animated/heroes/' + h.folder + '/run_' + i + '.png');
  }
}

const content = `/**
 * Configurações e manifesto de todos os assets animados autênticos de Konohagakure
 */

export interface NPCConfig {
  name: string;
  role: string;
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

export const AUTHENTIC_NPCS: NPCConfig[] = ${JSON.stringify(npcs, null, 2)};

export const AUTHENTIC_HEROES: Record<string, HeroAnimationConfig> = ${JSON.stringify(heroes, null, 2)};

export const ALL_ANIMATED_ASSETS: string[] = ${JSON.stringify(allUrls, null, 2)};
`;

fs.writeFileSync('D:/naruto Online/client/src/display/animatedAssets.ts', content, 'utf8');
console.log('Successfully generated client/src/display/animatedAssets.ts with ' + allUrls.length + ' assets!');
