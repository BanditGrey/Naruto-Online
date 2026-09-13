import { Container, Graphics, Sprite, Text, Assets, TextStyle } from 'pixi.js';
import CITIES_DATA from '../../../database/extracted/cities.json';

export interface CityInfo {
  id: number;
  type: number;
  start: number;
  last: number;
  name: string;
  icon: number;
}

export class WorldMapWindow extends Container {
  private contentContainer: Container;
  private listContainer: Container;
  private selectedCity: CityInfo | null = null;
  private txtCityName!: Text;
  private txtCityDesc!: Text;
  private txtCityLevel!: Text;
  private btnTravel!: Container;
  private onCloseCallback?: () => void;
  private onSelectCityCallback?: (city: CityInfo) => void;

  public static readonly WIDTH = 920;
  public static readonly HEIGHT = 580;

  constructor(onClose?: () => void, onSelectCity?: (city: CityInfo) => void) {
    super();
    this.onCloseCallback = onClose;
    this.onSelectCityCallback = onSelectCity;
    this.eventMode = 'static';
    this.zIndex = 50000;

    // Overlay escuro
    const blocker = new Graphics();
    blocker.rect(-2000, -2000, 4000, 4000);
    blocker.fill({ color: 0x000000, alpha: 0.65 });
    blocker.eventMode = 'static';
    blocker.on('pointertap', () => this.close());
    this.addChild(blocker);

    this.contentContainer = new Container();
    this.contentContainer.eventMode = 'static';
    this.addChild(this.contentContainer);

    this.listContainer = new Container();

    this.setupWindow();
    this.renderCities();
  }

  private setupWindow(): void {
    const W = WorldMapWindow.WIDTH;
    const H = WorldMapWindow.HEIGHT;

    // 1. Moldura do Pergaminho Mundial
    const bg = new Graphics();
    bg.roundRect(0, 0, W, H, 14);
    bg.fill(0x0f172a);
    bg.stroke({ color: 0xf59e0b, width: 3 });
    this.contentContainer.addChild(bg);

    // Barra de Título Superior
    const topBar = new Graphics();
    topBar.roundRect(0, 0, W, 50, 12);
    topBar.fill(0x1e293b);
    topBar.stroke({ color: 0xd97706, width: 1.5 });
    this.contentContainer.addChild(topBar);

    const title = new Text({
      text: '🗺️ MAPA DO MUNDO SHINOBI — AS GRANDES VILAS E FRONTEIRAS',
      style: {
        fill: '#fbbf24',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
        letterSpacing: 1.5,
      },
    });
    title.position.set(24, 14);
    this.contentContainer.addChild(title);

    // Botão de Fechar
    const btnClose = new Container();
    btnClose.position.set(W - 40, 13);
    btnClose.eventMode = 'static';
    btnClose.cursor = 'pointer';

    const closeG = new Graphics();
    closeG.circle(12, 12, 12);
    closeG.fill(0xdc2626);
    closeG.stroke({ color: 0xffffff, width: 1.5 });
    btnClose.addChild(closeG);

    const closeX = new Text({
      text: '✕',
      style: { fill: '#ffffff', fontSize: 13, fontWeight: 'bold' },
    });
    closeX.anchor.set(0.5);
    closeX.position.set(12, 12);
    btnClose.addChild(closeX);

    btnClose.on('pointertap', () => this.close());
    this.contentContainer.addChild(btnClose);

    // Painel Esquerdo: Lista de Territórios com Rolagem
    const listBg = new Graphics();
    listBg.roundRect(20, 65, 520, H - 85, 8);
    listBg.fill(0x111827);
    listBg.stroke({ color: 0x334155, width: 1.5 });
    this.contentContainer.addChild(listBg);

    this.listContainer.position.set(25, 70);
    this.contentContainer.addChild(this.listContainer);

    // Painel Direito: Detalhes do Território Selecionado
    const detailsBg = new Graphics();
    detailsBg.roundRect(555, 65, 345, H - 85, 8);
    detailsBg.fill(0x1e293b);
    detailsBg.stroke({ color: 0xf59e0b, width: 1.5 });
    this.contentContainer.addChild(detailsBg);

    this.txtCityName = new Text({
      text: 'Selecione um Território',
      style: { fill: '#f59e0b', fontSize: 16, fontWeight: 'bold' },
    });
    this.txtCityName.position.set(575, 85);
    this.contentContainer.addChild(this.txtCityName);

    this.txtCityLevel = new Text({
      text: 'Nível Recomendado: Genin a Jōnin',
      style: { fill: '#94a3b8', fontSize: 12 },
    });
    this.txtCityLevel.position.set(575, 115);
    this.contentContainer.addChild(this.txtCityLevel);

    this.txtCityDesc = new Text({
      text: 'Explore os territórios do mundo ninja para enfrentar rebeldes, cumprir missões de espionagem e coletar recursos valiosos.',
      style: { fill: '#cbd5e1', fontSize: 12, wordWrap: true, wordWrapWidth: 305 },
    });
    this.txtCityDesc.position.set(575, 150);
    this.contentContainer.addChild(this.txtCityDesc);

    // Botão de Teletransporte / Viagem
    this.btnTravel = new Container();
    this.btnTravel.position.set(575, H - 80);
    this.btnTravel.eventMode = 'static';
    this.btnTravel.cursor = 'pointer';

    const btnBg = new Graphics();
    btnBg.roundRect(0, 0, 305, 48, 8);
    btnBg.fill(0x16a34a);
    btnBg.stroke({ color: 0x4ade80, width: 2 });
    this.btnTravel.addChild(btnBg);

    const btnTxt = new Text({
      text: '⚡ VIAJAR PARA O TERRITÓRIO ⚡',
      style: { fill: '#ffffff', fontSize: 14, fontWeight: 'bold', letterSpacing: 1 },
    });
    btnTxt.anchor.set(0.5);
    btnTxt.position.set(305 / 2, 24);
    this.btnTravel.addChild(btnTxt);

    this.btnTravel.on('pointertap', () => {
      if (this.selectedCity) {
        console.log(`[WorldMap] Viajando para: ${this.selectedCity.name} (#${this.selectedCity.id})`);
        if (this.onSelectCityCallback) {
          this.onSelectCityCallback(this.selectedCity);
        }
        this.close();
      }
    });

    this.contentContainer.addChild(this.btnTravel);
  }

  private renderCities(): void {
    this.listContainer.removeChildren();

    const cities = (CITIES_DATA as CityInfo[]).slice(0, 45);

    cities.forEach((city, idx) => {
      const col = idx % 2;
      const row = Math.floor(idx / 2);
      if (row > 7) return;

      const card = new Container();
      card.position.set(col * 252, row * 52);
      card.eventMode = 'static';
      card.cursor = 'pointer';

      const cardBg = new Graphics();
      cardBg.roundRect(0, 0, 245, 46, 6);
      cardBg.fill(idx === 0 ? 0x1e3a8a : 0x1f2937);
      cardBg.stroke({ color: idx === 0 ? 0x60a5fa : 0x374151, width: 1.5 });
      card.addChild(cardBg);

      const icon = new Text({
        text: idx === 0 ? '🍃' : '⛩️',
        style: { fontSize: 18 },
      });
      icon.position.set(10, 12);
      card.addChild(icon);

      const name = new Text({
        text: city.name,
        style: { fill: '#f1f5f9', fontSize: 12, fontWeight: '600' },
      });
      name.position.set(38, 8);
      card.addChild(name);

      const tag = new Text({
        text: idx === 0 ? 'Vila Inicial • Segura' : `Área #${city.id % 100} • Batalhas`,
        style: { fill: idx === 0 ? '#4ade80' : '#94a3b8', fontSize: 10 },
      });
      tag.position.set(38, 26);
      card.addChild(tag);

      card.on('pointerenter', () => {
        cardBg.fill({ color: 0x374151, alpha: 0.9 });
      });

      card.on('pointerleave', () => {
        cardBg.fill(this.selectedCity?.id === city.id ? 0x1e3a8a : 0x1f2937);
      });

      card.on('pointertap', () => {
        this.selectCity(city);
      });

      this.listContainer.addChild(card);
    });

    if (cities.length > 0) {
      this.selectCity(cities[0]);
    }
  }

  private selectCity(city: CityInfo): void {
    this.selectedCity = city;
    this.txtCityName.text = `📍 ${city.name}`;
    this.txtCityLevel.text = `Código: #${city.id} • Fases: ${city.start} a ${city.last}`;

    if (city.name.includes('Konoha') || city.id === 15100001) {
      this.txtCityDesc.text =
        'Konohagakure (Vila Oculta da Folha). Capital do País do Fogo e berço da Vontade do Fogo. Zona segura com tabernas, ferreiros e mestres shinobi.';
    } else if (city.name.includes('Death Forest')) {
      this.txtCityDesc.text =
        'Floresta da Morte (44ª Zona de Treinamento). Floresta densa e perigosa habitada por predadores gigantes e ninjas renegados. Local da 2ª etapa do Exame Chūnin.';
    } else if (city.name.includes('Valley of The End')) {
      this.txtCityDesc.text =
        'Vale do Fim. O lendário local do embate histórico entre Hashirama Senju e Madara Uchiha, e entre Naruto Uzumaki e Sasuke Uchiha.';
    } else if (city.name.includes('Sand Country')) {
      this.txtCityDesc.text =
        'País do Vento (Sunagakure). Deserto impiedoso cercado por tempestades de areia e terra natal do Kazekage Gaara.';
    } else {
      this.txtCityDesc.text = `Território avançado ${city.name}. Reúna sua equipe shinobi e prepare-se para desafios estratégicos de alto nível.`;
    }
  }

  public open(parent?: Container): void {
    if (parent && !this.parent) {
      parent.addChild(this);
    }
    this.visible = true;
  }

  public close(): void {
    this.visible = false;
    if (this.onCloseCallback) {
      this.onCloseCallback();
    }
  }
}
