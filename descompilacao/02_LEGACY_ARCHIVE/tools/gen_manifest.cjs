const fs = require('fs');

const npcs = [
  { name: '3º Hokage', role: 'Líder de Konoha', folder: 'hokage3', frameCount: 11, x: 350, y: 382, talk: '🔥 3º Hokage: A Vontade do Fogo que arde em Konoha continuará iluminando o futuro e fazendo brotar novas folhas...' },
  { name: 'Iruka', role: 'Instrutor da Academia', folder: 'iruka', frameCount: 8, x: 950, y: 382, talk: '📘 Iruka: Não fique se lamentando pelos erros do passado! Erga a cabeça e siga em frente no seu caminho ninja!' },
  { name: 'Kakashi Hatake', role: 'Jōnin Líder', folder: 'kakashi', frameCount: 6, x: 1900, y: 382, talk: '📖 Kakashi: No mundo shinobi, aqueles que quebram as regras são escória. Mas quem abandona seus companheiros é pior do que escória.' },
  { name: 'Naruto Uzumaki', role: 'Genin', folder: 'naruto', frameCount: 10, x: 1535, y: 382, talk: '🍥 Naruto: Eu nunca volto atrás na minha palavra... esse é o meu jeito ninja de ser! Dattebayo!' },
  { name: 'Sasuke Uchiha', role: 'Genin', folder: 'sasuke', frameCount: 5, x: 1700, y: 382, talk: '⚡ Sasuke: Meu objetivo não é um mero sonho, é uma ambição real: restaurar meu clã e destruir aquele homem.' },
  { name: 'Sakura Haruno', role: 'Genin', folder: 'sakura', frameCount: 6, x: 1620, y: 382, talk: '🌸 Sakura: Eu não vou ficar apenas olhando para as costas de vocês dois... Agora é a minha vez de proteger!' },
  { name: 'Rock Lee', role: 'Genin Especialista', folder: 'rock_lee', frameCount: 6, x: 1450, y: 382, talk: '🥊 Rock Lee: Um perdedor com muito esforço pode superar um gênio nato! A juventude brilha intensamente!' },
  { name: 'Neji Hyuga', role: 'Gênio Hyūga', folder: 'neji', frameCount: 6, x: 1800, y: 382, talk: '👁️ Neji: O destino das pessoas não é decidido por ninguém além de si mesmas.' },
  { name: 'Hinata Hyuga', role: 'Herdeira Hyūga', folder: 'hinata', frameCount: 6, x: 820, y: 382, talk: '💜 Hinata: Quando olho para você, sinto coragem no meu peito... Eu quero ser forte e continuar tentando!' },
  { name: 'Jiraiya', role: 'Sábio dos Sapos', folder: 'jiraiya', frameCount: 6, x: 1385, y: 382, talk: '🐸 Jiraiya: A verdadeira medida de um shinobi não é como ele vive, mas sim como ele morre.' },
  { name: 'Anko Mitarashi', role: 'Examinadora Especial', folder: 'anko', frameCount: 4, x: 1225, y: 382, talk: '🐍 Anko: Comportem-se como ninjas de verdade! O Exame Chūnin não perdoa hesitações nem fraquezas!' },
  { name: 'Morino Ibiki', role: 'Comandante de Interrogatório', folder: 'ibiki', frameCount: 6, x: 240, y: 382, talk: '🛡️ Ibiki: A mente de um ninja sob pressão revela o verdadeiro guerreiro.' },
  { name: 'Gekkou Hayate', role: 'Examinador Tokubetsu', folder: 'hayate', frameCount: 7, x: 500, y: 382, talk: '🗡️ Hayate: *Cof, cof*... A terceira fase preliminar do exame começará agora.' },
  { name: 'Gaara', role: 'Genin da Areia', folder: 'gaara', frameCount: 6, x: 1078, y: 382, talk: '⏳ Gaara: Eu luto apenas por mim mesmo e amo apenas a mim mesmo... Essa é a existência que encontrei.' },
  { name: 'Konohamaru', role: 'Neto do Hokage', folder: 'konohamaru', frameCount: 5, x: 622, y: 382, talk: '🔥 Konohamaru: Não há atalhos no caminho para se tornar Hokage, chefe Naruto!' },
  { name: 'Portão de Konoha', role: 'Sentinela', folder: 'city_gate', frameCount: 10, x: 2144, y: 410, talk: '⛩️ Sentinela: Os grandes portões de Konohagakure estão sempre abertos para os defensores da Folha.' },
  { name: 'Teuchi', role: 'Chef Ichiraku', isStatic: true, path: '/assets/town/npc_teuchi.png', scale: 0.65, x: 1150, y: 465, talk: '🍜 Teuchi: Bem-vindo ao Ichiraku! Uma tigela fumegante de missô chashu sai em um instante!' },
  { name: 'Ayame', role: 'Atendente Ichiraku', isStatic: true, path: '/assets/town/npc_ayame.png', scale: 0.70, x: 1320, y: 475, talk: '✨ Ayame: Olá, nobre ninja! Venha renovar seu chakra e energia com o melhor caldo do País do Fogo!' }
];

const heroes = {
  taijutsu_m: { folder: 'hero_taijutsu_m', idleCount: 6, runCount: 8 },
  taijutsu_f: { folder: 'hero_taijutsu_f', idleCount: 6, runCount: 8 },
  ninjutsu_m: { folder: 'hero_ninjutsu_m', idleCount: 10, runCount: 10 },
  ninjutsu_f: { folder: 'hero_ninjutsu_f', idleCount: 6, runCount: 8 },
  genjutsu_m: { folder: 'hero_genjutsu_m', idleCount: 6, runCount: 8 },
  genjutsu_f: { folder: 'hero_genjutsu_f', idleCount: 6, runCount: 8 }
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

for (const key of Object.keys(heroes)) {
  const h = heroes[key];
  for (let i = 0; i < h.idleCount; i++) {
    allUrls.push('/assets/animated/heroes/' + h.folder + '/idle_' + i + '.png');
  }
  for (let i = 0; i < h.runCount; i++) {
    allUrls.push('/assets/animated/heroes/' + h.folder + '/run_' + i + '.png');
  }
}

let out = '';
out += 'export interface NPCConfig {\n';
out += '  name: string;\n';
out += '  role: string;\n';
out += '  folder?: string;\n';
out += '  frameCount?: number;\n';
out += '  isStatic?: boolean;\n';
out += '  path?: string;\n';
out += '  scale?: number;\n';
out += '  x: number;\n';
out += '  y: number;\n';
out += '  talk: string;\n';
out += '}\n\n';
out += 'export interface HeroAnimationConfig {\n';
out += '  folder: string;\n';
out += '  idleCount: number;\n';
out += '  runCount: number;\n';
out += '}\n\n';
out += 'export const AUTHENTIC_NPCS: NPCConfig[] = ' + JSON.stringify(npcs, null, 2) + ';\n\n';
out += 'export const AUTHENTIC_HEROES: Record<string, HeroAnimationConfig> = ' + JSON.stringify(heroes, null, 2) + ';\n\n';
out += 'export const ALL_ANIMATED_ASSETS: string[] = ' + JSON.stringify(allUrls, null, 2) + ';\n';

fs.writeFileSync('D:/naruto Online/client/src/display/animatedAssets.ts', out, 'utf8');
console.log('Successfully generated client/src/display/animatedAssets.ts with ' + allUrls.length + ' assets!');
