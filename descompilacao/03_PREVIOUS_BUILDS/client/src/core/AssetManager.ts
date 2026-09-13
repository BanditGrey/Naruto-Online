import { Assets, Texture, Graphics, RenderTexture } from 'pixi.js';
import { gameApp } from './GameApp.ts';

export const ASSET_ALIASES = {
  // Preloader Oficial (index.swf / MC_Loading)
  'loader/bg_splash': '/assets/loader/bg_splash.jpg',
  'loader/logo': '/assets/loader/logo.png',
  'loader/logo_official': '/assets/loader/logo_official.png',
  'loader/bar_frame': '/assets/loader/bar_frame.png',
  'loader/bar_track': '/assets/loader/bar_track.png',
  'loader/bar_fill': '/assets/loader/bar_fill.png',
  'loader/emblem': '/assets/loader/emblem.png',
  'loader/head': '/assets/loader/head.png',

  // Interface de Usuário & Login Oficial
  'login/bg': '/assets/login/login_bg.jpg',
  'login/server_bg': '/assets/login/sever_bg.png',
  'login/server_top': '/assets/login/sever_top.png',
  'login/server_box': '/assets/login/sever_box.png',
  'login/server_sprite': '/assets/login/server_sprite.png',
  'login/btn_choose': '/assets/login/choose.png',
  'login/btn_choose_hover': '/assets/login/choose_hover.png',
  'login/btn_play': '/assets/login/play.png',
  'login/btn_quick': '/assets/login/quick_start.png',
  'ui/login_splash': '/assets/ui/login_splash.jpg',
  'ui/profile_frame': '/assets/ui/profile_frame.png',
  'ui/currency_bar': '/assets/ui/currency_bar.png',
  'ui/bottom_bar': '/assets/ui/bottom_bar.png',
  'ui/avatar_blade': '/assets/ui/avatar_blade.png',
  'ui/btn_team': '/assets/ui/btn_team.png',
  'ui/btn_bag': '/assets/ui/btn_bag.png',
  'ui/btn_formation': '/assets/ui/btn_formation.png',
  'ui/btn_summon': '/assets/ui/btn_summon.png',
  'ui/btn_map': '/assets/ui/btn_map.png',

  // Vila da Folha (Konoha)
  'town/bg_shrine': '/assets/town/bg_konoha_shrine.jpg',
  'town/ichiraku_shop': '/assets/town/ichiraku_shop.png',
  'town/ichiraku_noren': '/assets/town/ichiraku_noren.png',
  'town/prop_lanterns': '/assets/town/prop_lanterns.png',
  'town/prop_sign': '/assets/town/prop_sign.png',
  'town/ninja_blade': '/assets/town/ninja_blade.png',
  'town/npc_teuchi': '/assets/town/npc_teuchi.png',
  'town/npc_ayame': '/assets/town/npc_ayame.png',

  // Criação de Personagem Oficial (3 Disciplinas Ninjas & 6 Protagonistas)
  'create_char/bg_create': '/assets/create_char/bg_create.jpg',
  'create_char/name_bar': '/assets/create_char/name_bar.png',
  'create_char/btn_create': '/assets/create_char/btn_create.png',
  'create_char/btn_dice': '/assets/create_char/btn_dice.png',
  'create_char/tab_genjutsu': '/assets/create_char/tab_genjutsu.png',
  'create_char/tab_taijutsu': '/assets/create_char/tab_taijutsu.png',
  'create_char/tab_ninjutsu': '/assets/create_char/tab_ninjutsu.png',
  'create_char/hero_genjutsu_m': '/assets/create_char/hero_genjutsu_m.png',
  'create_char/hero_genjutsu_f': '/assets/create_char/hero_genjutsu_f.png',
  'create_char/hero_taijutsu_m': '/assets/create_char/hero_taijutsu_m.png',
  'create_char/hero_taijutsu_f': '/assets/create_char/hero_taijutsu_f.png',
  'create_char/hero_ninjutsu_m': '/assets/create_char/hero_ninjutsu_m.png',
  'create_char/hero_ninjutsu_f': '/assets/create_char/hero_ninjutsu_f.png',
  'create_char/thumb_genjutsu_m': '/assets/create_char/thumb_genjutsu_m.png',
  'create_char/thumb_genjutsu_f': '/assets/create_char/thumb_genjutsu_f.png',
  'create_char/thumb_taijutsu_m': '/assets/create_char/thumb_taijutsu_m.png',
  'create_char/thumb_taijutsu_f': '/assets/create_char/thumb_taijutsu_f.png',
  'create_char/thumb_ninjutsu_m': '/assets/create_char/thumb_ninjutsu_m.png',
  'create_char/thumb_ninjutsu_f': '/assets/create_char/thumb_ninjutsu_f.png',

  // Arena de Batalha
  'battle/bg_arena': '/assets/battle/bg_arena.jpg',
} as const;

export type AssetAlias = keyof typeof ASSET_ALIASES;

export const ASSET_BUNDLES: Record<string, AssetAlias[]> = {
  loader: [
    'loader/bg_splash',
    'loader/logo',
    'loader/logo_official',
    'loader/bar_frame',
    'loader/bar_track',
    'loader/bar_fill',
    'loader/emblem',
    'loader/head',
  ],
  login: [
    'login/bg',
    'login/server_bg',
    'login/server_top',
    'login/server_box',
    'login/server_sprite',
    'login/btn_choose',
    'login/btn_choose_hover',
    'login/btn_play',
    'login/btn_quick',
    'loader/logo_official',
  ],
  core: ['ui/login_splash'],
  create_char: [
    'create_char/bg_create',
    'create_char/name_bar',
    'create_char/btn_create',
    'create_char/btn_dice',
    'create_char/tab_genjutsu',
    'create_char/tab_taijutsu',
    'create_char/tab_ninjutsu',
    'create_char/hero_genjutsu_m',
    'create_char/hero_genjutsu_f',
    'create_char/hero_taijutsu_m',
    'create_char/hero_taijutsu_f',
    'create_char/hero_ninjutsu_m',
    'create_char/hero_ninjutsu_f',
  ],
  ui: [
    'ui/profile_frame',
    'ui/currency_bar',
    'ui/bottom_bar',
    'ui/avatar_blade',
    'ui/btn_team',
    'ui/btn_bag',
    'ui/btn_formation',
    'ui/btn_summon',
    'ui/btn_map',
  ],
  town: [
    'town/bg_shrine',
    'town/ichiraku_shop',
    'town/ichiraku_noren',
    'town/prop_lanterns',
    'town/prop_sign',
    'town/ninja_blade',
    'town/npc_teuchi',
    'town/npc_ayame',
  ],
  battle: ['battle/bg_arena'],
};

/**
 * Gerenciador centralizado de recursos e texturas do jogo
 */
export class AssetManager {
  private static instance: AssetManager;
  private loadedMap: Map<string, Texture> = new Map();
  private fallbackTexture: Texture | null = null;

  public static getInstance(): AssetManager {
    if (!AssetManager.instance) {
      AssetManager.instance = new AssetManager();
    }
    return AssetManager.instance;
  }

  /**
   * Retorna a textura pelo alias tipado ou caminho direto com fallback seguro
   */
  public getTexture(alias: AssetAlias | string): Texture {
    const resolvedPath = ASSET_ALIASES[alias as AssetAlias] || alias;

    if (this.loadedMap.has(resolvedPath)) {
      return this.loadedMap.get(resolvedPath)!;
    }
    if (this.loadedMap.has(alias)) {
      return this.loadedMap.get(alias)!;
    }

    const fromPixi = Assets.get(resolvedPath) || Assets.get(alias);
    if (fromPixi && fromPixi instanceof Texture) {
      this.loadedMap.set(resolvedPath, fromPixi);
      this.loadedMap.set(alias, fromPixi);
      return fromPixi;
    }

    // Inicia carregamento assíncrono proativo caso não esteja no cache
    Assets.load(resolvedPath)
      .then((tex) => {
        if (tex && tex instanceof Texture) {
          this.loadedMap.set(resolvedPath, tex);
          this.loadedMap.set(alias, tex);
        }
      })
      .catch(() => {});

    return Texture.EMPTY;
  }

  /**
   * Retorna textura vazia segura para evitar sobreposição de caixas cinzas
   */
  public getFallbackTexture(): Texture {
    return Texture.EMPTY;
  }

  /**
   * Carrega uma lista de aliases ou bundle com relatório progressivo
   */
  public async loadList(
    aliases: (AssetAlias | string)[],
    onProgress?: (ratio: number, currentAsset: string) => void
  ): Promise<void> {
    const total = aliases.length;
    let completed = 0;

    for (const item of aliases) {
      const path = ASSET_ALIASES[item as AssetAlias] || item;
      try {
        const tex = await Assets.load(path);
        if (tex) {
          this.loadedMap.set(path, tex);
          this.loadedMap.set(item, tex);
        }
      } catch (err) {
        console.warn(`[AssetManager] Falha ao carregar textura '${item}' (${path}):`, err);
      }
      completed++;
      if (onProgress) {
        onProgress(completed / total, item);
      }
    }
  }

  /**
   * Carrega um bundle predefinido ('core', 'ui', 'town', 'battle')
   */
  public async loadBundle(
    bundleName: keyof typeof ASSET_BUNDLES,
    onProgress?: (ratio: number, currentAsset: string) => void
  ): Promise<void> {
    const list = ASSET_BUNDLES[bundleName];
    if (!list) {
      console.warn(`[AssetManager] Bundle '${bundleName}' não catalogado.`);
      return;
    }
    await this.loadList(list, onProgress);
  }
}

export const assetManager = AssetManager.getInstance();
