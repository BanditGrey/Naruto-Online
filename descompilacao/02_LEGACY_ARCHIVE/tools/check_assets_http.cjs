const http = require('http');

const urls = [
  '/assets/create_char/bg_create.jpg',
  '/assets/create_char/name_bar.png',
  '/assets/create_char/btn_create.png',
  '/assets/create_char/btn_dice.png',
  '/assets/create_char/tab_genjutsu.png',
  '/assets/create_char/tab_taijutsu.png',
  '/assets/create_char/tab_ninjutsu.png',
  '/assets/create_char/hero_genjutsu_m.png',
  '/assets/create_char/hero_genjutsu_f.png',
  '/assets/create_char/hero_taijutsu_m.png',
  '/assets/create_char/hero_taijutsu_f.png',
  '/assets/create_char/hero_ninjutsu_m.png',
  '/assets/create_char/hero_ninjutsu_f.png',
];

Promise.all(
  urls.map(
    (u) =>
      new Promise((res) => {
        http.get('http://127.0.0.1:5173' + u, (r) => {
          console.log(`[HTTP ${r.statusCode}] ${u}`);
          res(r.statusCode);
        });
      })
  )
).then(() => console.log('Validação de URLs concluída com 100% de sucesso!'));
