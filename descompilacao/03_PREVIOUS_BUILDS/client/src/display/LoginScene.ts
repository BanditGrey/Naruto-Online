import { Container, Graphics, Text, TextStyle, Sprite, Texture, Rectangle } from 'pixi.js';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';
import { gameApp, type Scene } from '../core/GameApp.ts';
import { assetManager } from '../core/AssetManager.ts';
import { CreateRoleScene } from './CreateRoleScene.ts';
import { TownScene, type LocalNinjaData } from './TownScene.ts';

/**
 * Tela Oficial de Autenticação e Seleção de Servidor (LoginScene)
 * 100% Autêntica com os assets Flash originais:
 * - sever_bg.png (moldura e pergaminho dos ninjas)
 * - sever_top.png (topo ornato)
 * - sever_box.png (caixa interna)
 * - choose.png (banner SERVER LIST)
 * - server_sprite.png (botões de servidor dourados e gemas de status)
 * - play.png (botão dourado JOGAR)
 * Resolução nativa: 1250 x 650
 */
export class LoginScene extends Container implements Scene {
  private localNinja: LocalNinjaData | null = null;
  private statusText!: Text;
  private txtUser!: Text;
  private btnPlay!: Container;
  private currentUser: string = 'ninja_web_1';
  private selectedServer: number = 1;
  private isAuthenticating: boolean = false;
  private unsubs: (() => void)[] = [];

  constructor() {
    super();

    // Recupera usuário salvo da sessão ou da URL (?user=nome)
    const urlParams = new URLSearchParams(window.location.search);
    const paramUser = urlParams.get('user');
    if (paramUser) {
      this.currentUser = paramUser;
    } else {
      let stored = sessionStorage.getItem('ninja_user');
      if (!stored) {
        stored = 'daniel';
        sessionStorage.setItem('ninja_user', stored);
      }
      this.currentUser = stored;
    }

    this.setupUI();
    this.registerNetworkEvents();

    if (!clientSocket.isConnected()) {
      clientSocket.connect();
    }
  }

  private setupUI(): void {
    const W = 1250;
    const H = 650;
    const cx = W / 2;
    const cy = H / 2;

    // 1. Fundo Oficial de Login (login_bg.jpg - 1920x1052)
    const bg = new Sprite(assetManager.getTexture('login/bg'));
    bg.width = W;
    bg.height = H;
    this.addChild(bg);

    // Overlay escuro suave com vinheta
    const vignette = new Graphics();
    vignette.rect(0, 0, W, H);
    vignette.fill({ color: 0x000000, alpha: 0.45 });
    this.addChild(vignette);

    // 2. Container Central da Janela de Servidores (Pergaminho Ninja)
    const modalContainer = new Container();
    const modalW = 820;
    const modalH = 490;
    const modalX = cx - modalW / 2;
    const modalY = cy - modalH / 2 - 10;
    modalContainer.position.set(modalX, modalY);
    this.addChild(modalContainer);

    // 2.1 Moldura / Fundo do Pergaminho (sever_bg.png - 980 x 587)
    const serverBg = new Sprite(assetManager.getTexture('login/server_bg'));
    serverBg.width = modalW;
    serverBg.height = modalH;
    modalContainer.addChild(serverBg);

    // 2.2 Topo Decorativo Ornato (sever_top.png - 980 x 162)
    const serverTop = new Sprite(assetManager.getTexture('login/server_top'));
    serverTop.width = modalW;
    serverTop.height = (modalW / 980) * 162;
    serverTop.position.set(0, -35);
    modalContainer.addChild(serverTop);

    // 2.3 Logo Oficial Ninja World
    const logo = new Sprite(assetManager.getTexture('loader/logo_official'));
    logo.anchor.set(0.5, 0.5);
    logo.scale.set(0.72);
    logo.position.set(modalW / 2, 28);
    modalContainer.addChild(logo);

    // 2.4 Caixa Interna de Servidores (sever_box.png - 620 x 240)
    const boxW = 600;
    const boxH = 205;
    const boxX = (modalW - boxW) / 2;
    const boxY = 105;

    const serverBox = new Sprite(assetManager.getTexture('login/server_box'));
    serverBox.width = boxW;
    serverBox.height = boxH;
    serverBox.position.set(boxX, boxY);
    modalContainer.addChild(serverBox);

    // 2.5 Banner "SERVER LIST" oficial (choose.png - 249x44)
    const chooseBanner = new Sprite(assetManager.getTexture('login/btn_choose'));
    chooseBanner.scale.set(0.75);
    chooseBanner.position.set(boxX + 20, boxY + 12);
    modalContainer.addChild(chooseBanner);

    // Subtítulo do servidor
    const subTitle = new Text({
      text: 'Selecione a aldeia para ingressar:',
      style: {
        fontFamily: 'Segoe UI, sans-serif',
        fontSize: 12,
        fill: '#94a3b8',
      },
    });
    subTitle.position.set(boxX + 220, boxY + 20);
    modalContainer.addChild(subTitle);

    // 2.6 Fatias da Spritesheet Oficial (server_sprite.png)
    const baseSpriteTex = assetManager.getTexture('login/server_sprite');
    const btnNormalTex = new Texture({
      source: baseSpriteTex.source,
      frame: new Rectangle(0, 0, 187, 40),
    });
    const btnHoverTex = new Texture({
      source: baseSpriteTex.source,
      frame: new Rectangle(0, 44, 187, 40),
    });
    const btnSelectedTex = new Texture({
      source: baseSpriteTex.source,
      frame: new Rectangle(0, 137, 187, 44),
    });
    const dotGreenTex = new Texture({
      source: baseSpriteTex.source,
      frame: new Rectangle(5, 95, 22, 22),
    });

    // Lista de Servidores com botões dourados da spritesheet
    const serverButtonsContainer = new Container();
    serverButtonsContainer.position.set(boxX + 25, boxY + 58);
    modalContainer.addChild(serverButtonsContainer);

    const serverList = [
      { id: 1, name: 'S1: Aldeia da Folha (Local)', desc: 'Recomendado', isHot: true },
    ];

    serverList.forEach((srv) => {
      const srvBtn = new Container();
      // Centraliza o botão único na caixa de servidores
      srvBtn.position.set((boxW - 260) / 2, 0);
      srvBtn.eventMode = 'static';
      srvBtn.cursor = 'pointer';

      const isSelected = this.selectedServer === srv.id;
      const btnBg = new Sprite(isSelected ? btnSelectedTex : btnNormalTex);
      btnBg.width = 260;
      btnBg.height = 48;
      srvBtn.addChild(btnBg);

      // Gema verde da spritesheet
      const gem = new Sprite(dotGreenTex);
      gem.scale.set(0.8);
      gem.position.set(12, 14);
      srvBtn.addChild(gem);

      // Nome do servidor estilizado
      const nameTxt = new Text({
        text: srv.name,
        style: {
          fontFamily: 'Segoe UI, sans-serif',
          fontSize: 13,
          fontWeight: 'bold',
          fill: isSelected ? '#ffffff' : '#fef08a',
          stroke: { color: '#000000', width: 2 },
        },
      });
      nameTxt.position.set(38, 14);
      srvBtn.addChild(nameTxt);

      // Descrição de estado
      const descTxt = new Text({
        text: srv.desc,
        style: {
          fontFamily: 'Segoe UI, sans-serif',
          fontSize: 11,
          fill: '#86efac',
        },
      });
      descTxt.position.set(175, 16);
      srvBtn.addChild(descTxt);

      srvBtn.on('pointerover', () => {
        if (this.selectedServer !== srv.id) {
          btnBg.texture = btnHoverTex;
        }
      });
      srvBtn.on('pointerout', () => {
        if (this.selectedServer !== srv.id) {
          btnBg.texture = btnNormalTex;
        }
      });
      srvBtn.on('pointertap', () => {
        this.selectedServer = srv.id;
        this.statusText.text = `Servidor selecionado: ${srv.name}`;
        // Atualiza texturas dos botões
        serverButtonsContainer.children.forEach((child, cIdx) => {
          const bgSprite = child.children[0] as Sprite;
          bgSprite.texture = serverList[cIdx].id === this.selectedServer ? btnSelectedTex : btnNormalTex;
        });
      });

      serverButtonsContainer.addChild(srvBtn);
    });

    // 2.7 Barra de Usuário / Identificador de Conta
    const userBar = new Graphics();
    userBar.roundRect(boxX, boxY + boxH + 10, boxW, 36, 6);
    userBar.fill({ color: 0x0f172a, alpha: 0.9 });
    userBar.stroke({ color: 0xf59e0b, width: 1.2 });
    userBar.eventMode = 'static';
    userBar.cursor = 'pointer';
    userBar.on('pointertap', () => this.promptForUser());
    modalContainer.addChild(userBar);

    this.txtUser = new Text({
      text: `👤 Conta Ativa: ${this.currentUser}  [Clique aqui para alternar de ninja/conta]`,
      style: {
        fontFamily: 'Segoe UI, sans-serif',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#fde68a',
      },
    });
    this.txtUser.anchor.set(0.5, 0.5);
    this.txtUser.position.set(boxX + boxW / 2, boxY + boxH + 28);
    modalContainer.addChild(this.txtUser);

    // 2.8 Botão Oficial "PLAY" (play.png - 244 x 86)
    this.btnPlay = new Container();
    this.btnPlay.eventMode = 'static';
    this.btnPlay.cursor = 'pointer';
    this.btnPlay.position.set(modalW / 2, boxY + boxH + 85);

    const playSprite = new Sprite(assetManager.getTexture('login/btn_play'));
    playSprite.anchor.set(0.5, 0.5);
    playSprite.scale.set(0.85);
    this.btnPlay.addChild(playSprite);

    this.btnPlay.on('pointerover', () => {
      playSprite.scale.set(0.92);
    });
    this.btnPlay.on('pointerout', () => {
      playSprite.scale.set(0.85);
    });
    this.btnPlay.on('pointertap', () => {
      this.doLogin();
    });
    modalContainer.addChild(this.btnPlay);

    // 2.9 Mensagem de Status da Conexão
    const statusStyle = new TextStyle({
      fontFamily: 'Segoe UI, monospace',
      fontSize: 12,
      fill: '#38bdf8',
      stroke: { color: '#000000', width: 2 },
    });
    this.statusText = new Text({ text: 'Pronto para entrar no mundo ninja!', style: statusStyle });
    this.statusText.anchor.set(0.5, 0.5);
    this.statusText.position.set(modalW / 2, boxY + boxH + 130);
    modalContainer.addChild(this.statusText);
  }

  private promptForUser(): void {
    const u = window.prompt('Digite o identificador da conta ou ninja:', this.currentUser);
    if (u && u.trim().length > 0) {
      this.currentUser = u.trim();
      sessionStorage.setItem('ninja_user', this.currentUser);
      this.txtUser.text = `👤 Conta Ativa: ${this.currentUser}  [Clique aqui para alternar de ninja/conta]`;
      this.statusText.text = `Conta alterada para: ${this.currentUser}`;
    }
  }

  private registerNetworkEvents(): void {
    clientSocket.onConnect(() => {
      this.statusText.text = 'Conectado ao Gateway de Konohagakure!';
      this.statusText.style.fill = '#4ade80';
    });

    clientSocket.onDisconnect(() => {
      this.statusText.text = 'Desconectado do servidor. Tentando reconectar...';
      this.statusText.style.fill = '#f87171';
      this.isAuthenticating = false;
    });

    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Login_StatusServerTransmitTokenRet, () => {
        this.statusText.text = 'Autenticado com sucesso! Verificando cadastro do ninja...';
        this.statusText.style.fill = '#38bdf8';
      })
    );

    // Se a conta for nova (sem personagem), abre a tela de criação oficial
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_CREATECHAR_CreateCharCmd, () => {
        this.statusText.text = 'Conta nova: Abrindo seleção dos protagonistas ninjas...';
        console.log('[LoginScene] Conta sem ninja cadastrado. Abrindo CreateRoleScene...');
        gameApp.changeScene(new CreateRoleScene());
      })
    );

    // Se a conta já possuir ninja, entra direto ou guarda os dados
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Account_CharInfoNtf, (reader) => {
        reader.readUnsignedInt(); // operator
        reader.readUnsignedInt(); // serverId
        reader.readStringUTF(); // userId
        reader.readUnsignedInt(); // guidHigh
        const charId = reader.readUnsignedInt();
        const nickName = reader.readStringUTF();
        reader.readUnsignedInt(); // Country
        reader.readUnsignedInt(); // MilitaryRank
        reader.readUnsignedInt(); // Prestige
        reader.readUnsignedInt(); // Silver High
        const silverCoins = reader.readUnsignedInt(); // Silver Low
        const gold = reader.readUnsignedInt(); // Gold

        this.localNinja = {
          charId,
          name: nickName,
          profession: 1, // Padrão Ninjutsu
          level: 1,
        };

        this.statusText.text = `Ninja carregado: ${nickName} (ID #${charId}). Entrando na vila...`;
        this.statusText.style.fill = '#4ade80';

        console.log(`[LoginScene] Personagem existente "${nickName}" (#${charId}). Enviando CS_LOBBY_Enter_Town...`);
        const pw = new WebPacketWriter();
        clientSocket.send(OPCODES.CS_LOBBY_Enter_Town, pw);
      })
    );

    // Resposta de entrada na vila
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Enter_Town, (reader) => {
        const mapId = reader.readUInt32();
        const x = reader.readUInt16();
        const y = reader.readUInt16();
        this.statusText.text = `Entrando em Konoha... (Spawn: ${x}, ${y})`;

        if (this.localNinja) {
          console.log(`[LoginScene] Transicionando para TownScene com ninja:`, this.localNinja);
          gameApp.changeScene(new TownScene(this.localNinja, x, y));
        }
      })
    );
  }

  public doLogin(): void {
    if (this.isAuthenticating) return;
    this.isAuthenticating = true;

    this.statusText.text = `Autenticando conta "${this.currentUser}" no Servidor S${this.selectedServer}...`;
    this.statusText.style.fill = '#fbbf24';

    const writer = new WebPacketWriter();
    writer.writeStringUTF(this.currentUser); // 1. userId (string UTF)
    writer.writeUnsignedInt(1); // 2. agentId (uint32)
    writer.writeUnsignedInt(this.selectedServer); // 3. serverId (uint32)
    writer.writeStringUTF('TOKEN_DEMO_SECRET_AUTH'); // 4. token (string UTF)
    writer.writeUnsignedInt(1); // 5. version (uint32)
    writer.writeStringUTF(new Date().toISOString()); // 6. loginTime (string UTF)

    clientSocket.send(OPCODES.CS_Login_StatusServerTransmitToken, writer);
  }

  public override destroy(options?: any): void {
    this.unsubs.forEach((u) => u());
    this.unsubs = [];
    super.destroy(options);
  }
}
