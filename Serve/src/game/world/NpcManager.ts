import { DatabaseManager, NpcTemplate } from '../../database/DatabaseManager.js';
import { Player } from '../player/Player.js';

export interface NpcDialogResponse {
  npcId: number;
  name: string;
  npcTitle: string;
  talk: string;
  availableAction?: 'quest_accept' | 'quest_finish' | 'tavern' | 'gate' | 'none';
  actionData?: any;
}

export class NpcManager {
  private static instance: NpcManager;

  private constructor() {}

  public static getInstance(): NpcManager {
    if (!NpcManager.instance) {
      NpcManager.instance = new NpcManager();
    }
    return NpcManager.instance;
  }

  public getNpcsInCity(cityId: number): NpcTemplate[] {
    return DatabaseManager.getInstance().getNpcsByCity(cityId);
  }

  public interactWithNpc(player: Player, npcId: number): NpcDialogResponse | null {
    const db = DatabaseManager.getInstance();
    const npc = db.getNpc(npcId);
    if (!npc) return null;

    let action: 'quest_accept' | 'quest_finish' | 'tavern' | 'gate' | 'none' = 'none';
    let talkText = npc.talk;

    // Se for o 3º Hokage (#22100003): Missão Inicial #16100001
    if (npcId === 22100003) {
      const task1 = db.getTask(16100001);
      if (task1) {
        talkText = task1.talkBefor || npc.talk;
        action = 'quest_accept';
      }
    } else if (npcId === 22100014) {
      // Konohamaru (#22100014): Entrega da Missão #16100001
      const task1 = db.getTask(16100001);
      if (task1) {
        talkText = task1.talkEnd || npc.talk;
        action = 'quest_finish';
      }
    } else if (npcId === 22100013) {
      // Tsunade (#22100013): Taverna de Recrutamento
      action = 'tavern';
    } else if (npcId === 22100001) {
      // City Gate (#22100001): Saída para o Mapa Mundi / Fases
      action = 'gate';
    }

    console.log(`[NPC] Jogador "${player.data.name}" interagiu com ${npc.name} (#${npc.id}) — Ação: ${action}`);

    return {
      npcId: npc.id,
      name: npc.name,
      npcTitle: npc.npcTitle,
      talk: talkText,
      availableAction: action
    };
  }
}
