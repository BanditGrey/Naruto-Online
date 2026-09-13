import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const ServerConfig = {
  port: parseInt(process.env.PORT || '8080', 10),
  host: process.env.HOST || '0.0.0.0',
  dataDir: path.resolve(__dirname, '../../data'),
  version: '2021082410',
  serverName: 'Naruto Online — Konohagakure S1',

  // Cidade Inicial Canônica: Novice Suburb (Subúrbio de Noviços #23100001)
  spawnCityId: 23100001,

  // Coordenadas de Spawn Canônicas: Em frente ao 3º Hokage (x: 350, y: 382)
  defaultSpawnPosition: { x: 400, y: 382 },

  // Dimensões Canônicas do Mapa da Vila (TLayerBackGround.as)
  mapDimensions: { width: 2500, height: 650 },
  walkableYRange: { min: 360, max: 640 }
};
