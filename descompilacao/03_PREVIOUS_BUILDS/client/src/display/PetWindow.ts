import { Container, Graphics, Sprite, Text, Assets, TextStyle } from 'pixi.js';
import PET_IMAGES_DATA from '../../../database/extracted/pet_images.json';
import PETS_DATA from '../../../database/extracted/pets.json';

export interface PetImageInfo {
  id: number;
  name: string;
  desc: string;
  level: number;
  lockDesc: string;
  headPic: number;
}

export class PetWindow extends Container {
  private contentContainer: Container;
  private petListContainer: Container;
  private selectedPet: PetImageInfo | null = null;
  private activeEquippedPetId: number = 18100800; // Padrão: 9-Tails Kurama
  private txtPetName!: Text;
  private txtPetDesc!: Text;
  private txtPetStats!: Text;
  private txtPersonality!: Text;
  private btnEquipSummon!: Container;
  private onCloseCallback?: () => void;

  public static readonly WIDTH = 880;
  public static readonly HEIGHT = 560;

  constructor(onClose?: () => void) {
    super();
    this.onCloseCallback = onClose;
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

    this.petListContainer = new Container();

    this.setupWindow();
    this.renderPetsList();
  }

  private setupWindow(): void {
    const W = PetWindow.WIDTH;
    const H = PetWindow.HEIGHT;

    // Moldura principal com tema sagrado das Invocações
    const bg = new Graphics();
    bg.roundRect(0, 0, W, H, 14);
    bg.fill(0x0f172a);
    bg.stroke({ color: 0xa855f7, width: 3 });
    this.contentContainer.addChild(bg);

    // Barra de Título Superior
    const topBar = new Graphics();
    topBar.roundRect(0, 0, W, 50, 12);
    topBar.fill(0x3b0764);
    topBar.stroke({ color: 0xc084fc, width: 1.5 });
    this.contentContainer.addChild(topBar);

    const title = new Text({
      text: '🐾 BESTAS COM CAUDAS & CONTRATOS DE INVOCAÇÃO (BIJŪ)',
      style: {
        fill: '#f3e8ff',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
        letterSpacing: 1.5,
      },
    });
    title.position.set(24, 14);
    this.contentContainer.addChild(title);

    // Botão Fechar
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

    // Painel Esquerdo: Lista das 10 Bestas (Bijū)
    const listBg = new Graphics();
    listBg.roundRect(20, 65, 460, H - 85, 8);
    listBg.fill(0x1e1b4b);
    listBg.stroke({ color: 0x6366f1, width: 1.5 });
    this.contentContainer.addChild(listBg);

    this.petListContainer.position.set(28, 72);
    this.contentContainer.addChild(this.petListContainer);

    // Painel Direito: Detalhes, Poder e Vínculo de Chakra
    const detailsBg = new Graphics();
    detailsBg.roundRect(495, 65, 365, H - 85, 8);
    detailsBg.fill(0x1e293b);
    detailsBg.stroke({ color: 0xa855f7, width: 1.5 });
    this.contentContainer.addChild(detailsBg);

    this.txtPetName = new Text({
      text: 'Kurama (Nove Caudas)',
      style: { fill: '#f59e0b', fontSize: 18, fontWeight: 'bold' },
    });
    this.txtPetName.position.set(515, 85);
    this.contentContainer.addChild(this.txtPetName);

    this.txtPersonality = new Text({
      text: '🌟 Nível de Evolução: 10 Estrelas • Classe Divina',
      style: { fill: '#e9d5ff', fontSize: 12, fontWeight: '600' },
    });
    this.txtPersonality.position.set(515, 115);
    this.contentContainer.addChild(this.txtPersonality);

    this.txtPetStats = new Text({
      text: 'BÔNUS DE COMBATE:\n⚔️ Poder: +450\n💨 Agilidade: +450\n🔮 Chakra / Inteligência: +450\n❤️ Vida Total (HP): +900\n💥 Habilidade Suprema: Bijuudama Devastadora',
      style: { fill: '#38bdf8', fontSize: 12, lineHeight: 20 },
    });
    this.txtPetStats.position.set(515, 150);
    this.contentContainer.addChild(this.txtPetStats);

    this.txtPetDesc = new Text({
      text: 'A raposa demoníaca de nove caudas selada dentro do protagonista. Ao invocar em combate, desfere dano catastrófico em todos os inimigos da linha de frente à retaguarda.',
      style: { fill: '#cbd5e1', fontSize: 11, wordWrap: true, wordWrapWidth: 325 },
    });
    this.txtPetDesc.position.set(515, 275);
    this.contentContainer.addChild(this.txtPetDesc);

    // Botão de Invocação Ativa
    this.btnEquipSummon = new Container();
    this.btnEquipSummon.position.set(515, H - 80);
    this.btnEquipSummon.eventMode = 'static';
    this.btnEquipSummon.cursor = 'pointer';

    const btnBg = new Graphics();
    btnBg.roundRect(0, 0, 325, 48, 8);
    btnBg.fill(0x7e22ce);
    btnBg.stroke({ color: 0xd8b4fe, width: 2 });
    this.btnEquipSummon.addChild(btnBg);

    const btnTxt = new Text({
      text: '🔮 EQUIPAR BESTA DE INVOCAÇÃO 🔮',
      style: { fill: '#ffffff', fontSize: 13, fontWeight: 'bold', letterSpacing: 1 },
    });
    btnTxt.anchor.set(0.5);
    btnTxt.position.set(325 / 2, 24);
    this.btnEquipSummon.addChild(btnTxt);

    this.btnEquipSummon.on('pointertap', () => {
      if (this.selectedPet) {
        this.activeEquippedPetId = this.selectedPet.id;
        console.log(`[PetSystem] Besta ${this.selectedPet.name} equipada como Invocação Ativa!`);
        this.renderPetsList();
      }
    });

    this.contentContainer.addChild(this.btnEquipSummon);
  }

  private renderPetsList(): void {
    this.petListContainer.removeChildren();

    // Filtra as 10 grandes feras com cauda de pet_images.json
    const beasts = (PET_IMAGES_DATA as PetImageInfo[]).slice(0, 10);

    beasts.forEach((pet, idx) => {
      const card = new Container();
      card.position.set(0, idx * 45);
      card.eventMode = 'static';
      card.cursor = 'pointer';

      const isEquipped = pet.id === this.activeEquippedPetId;
      const isSelected = pet.id === this.selectedPet?.id;

      const cardBg = new Graphics();
      cardBg.roundRect(0, 0, 444, 40, 6);
      cardBg.fill(isEquipped ? 0x581c87 : isSelected ? 0x312e81 : 0x0f172a);
      cardBg.stroke({
        color: isEquipped ? 0xc084fc : isSelected ? 0x818cf8 : 0x334155,
        width: isEquipped || isSelected ? 2 : 1,
      });
      card.addChild(cardBg);

      const icon = new Text({
        text: isEquipped ? '🌟' : '🦊',
        style: { fontSize: 16 },
      });
      icon.position.set(10, 10);
      card.addChild(icon);

      const name = new Text({
        text: pet.name,
        style: { fill: '#f8fafc', fontSize: 12, fontWeight: 'bold' },
      });
      name.position.set(36, 6);
      card.addChild(name);

      const statusTag = new Text({
        text: isEquipped ? '✨ INVOCADOR ATIVO' : `Nv. ${pet.level} • Desbloqueado`,
        style: { fill: isEquipped ? '#facc15' : '#a5b4fc', fontSize: 10, fontWeight: '600' },
      });
      statusTag.position.set(36, 22);
      card.addChild(statusTag);

      card.on('pointertap', () => {
        this.selectPet(pet);
        this.renderPetsList();
      });

      this.petListContainer.addChild(card);
    });

    if (!this.selectedPet && beasts.length > 0) {
      this.selectPet(beasts[8] || beasts[0]); // Padrão Kurama (índice 8)
    }
  }

  private selectPet(pet: PetImageInfo): void {
    this.selectedPet = pet;
    this.txtPetName.text = `🐾 ${pet.name}`;
    this.txtPersonality.text = `🌟 Requisito: Nível ${pet.level} • Vínculo de Espírito Ativo`;

    const cleanDesc = (pet.desc || '').replace(/\\n/g, '\n');
    this.txtPetDesc.text = cleanDesc || 'Besta guardiã lendária com poder destrutivo imensurável.';

    // Calcula bônus baseados no número de caudas
    const tailNum = (pet.id % 100) / 100 + 1;
    const bonusStat = Math.floor(80 * (tailNum + 1));
    this.txtPetStats.text = `BÔNUS DE COMBATE:\n⚔️ Força Física: +${bonusStat}\n💨 Agilidade Ninjutsu: +${bonusStat}\n🔮 Dano em Área (Chakra): +${bonusStat}\n❤️ Vida Total (HP): +${bonusStat * 2}\n💥 Habilidade: Rugido das Bestas com Cauda`;
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
