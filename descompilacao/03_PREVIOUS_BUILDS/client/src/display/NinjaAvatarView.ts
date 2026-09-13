import { Container, Graphics, Sprite, Text, Texture, Assets } from 'pixi.js';

export interface NinjaAvatarOptions {
  name: string;
  roleTitle?: string;
  isLocal?: boolean;
  level?: number;
  idleTextures: Texture[];
  runTextures?: Texture[];
  scale?: number;
  fps?: number;
}

export class NinjaAvatarView extends Container {
  private shadow: Graphics;
  private avatarBody: Container;
  public sprite: Sprite;
  private nameTag: Text;
  private localIndicator?: Graphics;

  private idleTextures: Texture[];
  private runTextures: Texture[];
  private isMoving: boolean = false;
  private facingDirection: number = 1;
  private animTimer: number = 0;
  private breathTimer: number = Math.random() * Math.PI * 2;
  private baseScale: number = 1.0;
  private fps: number = 8;
  private runFps: number = 10;

  constructor(options: NinjaAvatarOptions) {
    super();

    this.idleTextures = options.idleTextures.length > 0 ? options.idleTextures : [Texture.WHITE];
    this.runTextures = (options.runTextures && options.runTextures.length > 0) ? options.runTextures : this.idleTextures;
    this.baseScale = options.scale || 1.0;
    this.fps = options.fps || 8;

    // 1. Sombra suave sob os pés
    this.shadow = new Graphics();
    this.shadow.ellipse(0, 0, 22 * this.baseScale, 7 * this.baseScale);
    this.shadow.fill({ color: 0x000000, alpha: 0.45 });
    this.addChild(this.shadow);

    // 2. Container do corpo para espelhamento horizontal
    this.avatarBody = new Container();
    this.addChild(this.avatarBody);

    // 3. Sprite do ninja
    this.sprite = new Sprite(this.idleTextures[0]);
    this.sprite.anchor.set(0.5, 1);
    this.sprite.scale.set(this.baseScale);
    this.avatarBody.addChild(this.sprite);

    // 4. Etiqueta com nome e posto/nível
    const labelText = options.roleTitle
      ? `${options.name} [${options.roleTitle}]`
      : `${options.name} [Nv.${options.level || 1}]`;

    this.nameTag = new Text({
      text: labelText,
      style: {
        fontFamily: 'Arial, sans-serif',
        fill: options.isLocal ? '#fef08a' : (options.roleTitle ? '#fbbf24' : '#ffffff'),
        fontSize: 12,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    this.nameTag.anchor.set(0.5, 1);
    const spriteHeight = (this.sprite.texture.height || 100) * this.baseScale;
    this.nameTag.position.set(0, -spriteHeight - 8);
    this.addChild(this.nameTag);

    // 5. Indicador triangular verde para jogador local
    if (options.isLocal) {
      this.localIndicator = new Graphics();
      this.localIndicator.poly([-6, -spriteHeight - 26, 6, -spriteHeight - 26, 0, -spriteHeight - 18]);
      this.localIndicator.fill(0x22c55e);
      this.localIndicator.stroke({ color: 0x15803d, width: 1 });
      this.addChild(this.localIndicator);
    }
  }

  public updateAnimation(dt: number, moving: boolean, dir: number = 1): void {
    this.isMoving = moving;
    if (dir !== 0) {
      this.facingDirection = dir > 0 ? 1 : -1;
    }

    // Espelhamento horizontal correto
    this.avatarBody.scale.x = this.facingDirection;

    const textures = this.isMoving ? this.runTextures : this.idleTextures;
    const currentFps = this.isMoving ? this.runFps : this.fps;

    this.animTimer += dt;
    const frameIndex = Math.floor(this.animTimer * currentFps) % textures.length;
    if (textures[frameIndex] && this.sprite.texture !== textures[frameIndex]) {
      this.sprite.texture = textures[frameIndex];
    }

    // Respiração sutil apenas quando em repouso
    if (!this.isMoving) {
      this.breathTimer += dt * 3.5;
      const breath = Math.sin(this.breathTimer) * 0.015;
      this.sprite.scale.y = this.baseScale * (1 + breath);
      this.shadow.scale.x = 1 + breath * 1.5;
    } else {
      this.sprite.scale.y = this.baseScale;
      this.shadow.scale.x = 1.0;
    }
  }

  public getEffectiveHeight(): number {
    return (this.sprite.texture.height || 100) * this.baseScale;
  }
}
