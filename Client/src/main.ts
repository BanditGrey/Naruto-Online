import { Application } from 'pixi.js';
import { NetworkClient } from './network/NetworkClient.js';
import { PacketWriter } from './network/PacketWriter.js';
import { PacketReader } from './network/PacketReader.js';
import { Opcodes } from './protocol/opcodes.js';
import { CreateRoleScene } from './display/CreateRoleScene.js';
import { TownScene, PlayerProfile } from './display/TownScene.js';

class GameApp {
  private app: Application;
  private currentScene: any = null;
  private playerProfile: PlayerProfile | null = null;
  private statusBar: HTMLElement | null = null;

  constructor() {
    this.app = new Application();
    this.statusBar = document.getElementById('status-bar');
  }

  public async start(): Promise<void> {
    this.updateStatus('Inicializando motor gráfico PixiJS v8 (1250x650)...');

    // 1. Inicializar PixiJS v8
    await this.app.init({
      width: 1250,
      height: 650,
      backgroundColor: 0x05070a,
      antialias: true,
      resolution: window.devicePixelRatio || 1
    });

    const container = document.getElementById('game-container');
    if (container) {
      container.appendChild(this.app.canvas);
    }

    // 2. Conectar ao Servidor WebSocket (Porta 8080)
    const net = NetworkClient.getInstance();
    this.setupNetwork(net);

    try {
      this.updateStatus('Conectando ao Konohagakure Server (ws://127.0.0.1:8080)...');
      await net.connect('ws://127.0.0.1:8080');
      this.updateStatus('Conectado! Enviando Token de Autenticação...');

      // Enviar Token de Login
      const loginToken = 'shinobi_player_1';
      const loginPkt = new PacketWriter(Opcodes.CS_Login_StatusServerTransmitToken)
        .writeFlushUTF(loginToken);
      net.send(loginPkt);
    } catch (err: any) {
      this.updateStatus(`Erro de conexão com o servidor: ${err.message}. Certifique-se de que o backend Serve está rodando.`);
    }
  }

  private setupNetwork(net: NetworkClient): void {
    // 1. SC_CREATECHAR_CreateCharCmd: Usuário novo precisa criar personagem
    net.on(Opcodes.SC_CREATECHAR_CreateCharCmd, () => {
      this.updateStatus('Novo jogador detectado: Selecione sua Disciplina Ninja (Taijutsu, Ninjutsu ou Genjutsu).');
      this.switchScene(new CreateRoleScene());
    });

    // 2. SC_CREATECHAR_CreateCharRet: Confirmação de criação
    net.on(Opcodes.SC_CREATECHAR_CreateCharRet, (reader: PacketReader) => {
      const code = reader.readUInt8();
      if (code === 0) {
        this.updateStatus('Shinobi criado com sucesso! Carregando mundo...');
      } else {
        this.updateStatus(`Falha ao criar personagem. Código: ${code}`);
      }
    });

    // 3. SC_Account_CharInfoNtf: Dados do personagem criados ou carregados
    net.on(Opcodes.SC_Account_CharInfoNtf, (reader: PacketReader) => {
      const charId = reader.readUInt32BE();
      const name = reader.readFlushUTF();
      const profession = reader.readUInt8();
      const gender = reader.readUInt8();
      const level = reader.readUInt16BE();
      const curHp = reader.readFloatBE();
      const maxHp = reader.readFloatBE();
      const silver = reader.readUInt32BE();
      const gold = reader.readUInt32BE();

      this.playerProfile = {
        charId,
        name,
        profession,
        gender,
        level,
        curHp,
        maxHp,
        silver,
        gold
      };

      const profName = profession === 4 ? 'Taijutsu' : profession === 1 ? 'Ninjutsu' : 'Genjutsu';
      this.updateStatus(`Ninja Autenticado: "${name}" [${profName} Nv.${level}] | Silver: ${silver} | Gold: ${gold}`);

      // Transitar para a Vila Inicial (TownScene)
      this.switchScene(new TownScene(this.playerProfile));
    });

    // 4. SC_SingleBattleResult / SC_Battle_StartReportDataReq: Relatório de Batalha
    net.on(Opcodes.SC_Battle_StartReportDataReq, (reader: PacketReader) => {
      this.updateStatus('⚔ Relatório de Batalha Recebido! Combate computado pelo backend.');
      alert('⚔ [BATTLE REPORT] Combate PvE computado com sucesso pelo Servidor!');
    });
  }

  private switchScene(newScene: any): void {
    if (this.currentScene) {
      this.app.stage.removeChild(this.currentScene);
      this.currentScene.destroy({ children: true });
    }
    this.currentScene = newScene;
    this.app.stage.addChild(newScene);
  }

  private updateStatus(text: string): void {
    if (this.statusBar) {
      this.statusBar.textContent = `● Konoha Core // ${text}`;
    }
    console.log(`[APP] ${text}`);
  }
}

// Inicializar aplicação ao carregar a página
window.addEventListener('DOMContentLoaded', () => {
  const game = new GameApp();
  game.start();
});
