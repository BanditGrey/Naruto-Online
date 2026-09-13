/**
 * Constantes canônicas de Personagem extraídas de CONST_CHARACTER.as
 */
export const CharacterConstants = {
  // Gêneros Canônicos (2 tipos)
  GENDER_Female: 0,
  GENDER_Male: 1,

  // As 3 Disciplinas / Classes Oficiais do Jogo (CONST_CHARACTER.as)
  CLASS_Taijutsu: 4, // Strength / Força (Vanguarda)
  CLASS_Ninjutsu: 1, // Agility / Agilidade (Assalto)
  CLASS_Genjutsu: 3, // Intellect / Chakra (Controle e Dano Mágico)

  // Base Mode ID dos Protagonistas
  CHARACTER_BaseModeID: 11100000,

  // Mapeamento dos 6 Heróis Protagonistas Oficiais
  PROTAGONISTS: [
    { id: 11100001, school: 'Taijutsu', gender: 'Male', genderId: 1, profession: 4, name: 'Taijutsu Male' },
    { id: 11100002, school: 'Taijutsu', gender: 'Female', genderId: 0, profession: 4, name: 'Taijutsu Female' },
    { id: 11100003, school: 'Ninjutsu', gender: 'Male', genderId: 1, profession: 1, name: 'Ninjutsu Male' },
    { id: 11100004, school: 'Ninjutsu', gender: 'Female', genderId: 0, profession: 1, name: 'Ninjutsu Female' },
    { id: 11100005, school: 'Genjutsu', gender: 'Male', genderId: 1, profession: 3, name: 'Genjutsu Male' },
    { id: 11100006, school: 'Genjutsu', gender: 'Female', genderId: 0, profession: 3, name: 'Genjutsu Female' }
  ]
} as const;

export type GenderType = typeof CharacterConstants.GENDER_Male | typeof CharacterConstants.GENDER_Female;
export type ClassType = typeof CharacterConstants.CLASS_Taijutsu | typeof CharacterConstants.CLASS_Ninjutsu | typeof CharacterConstants.CLASS_Genjutsu;
