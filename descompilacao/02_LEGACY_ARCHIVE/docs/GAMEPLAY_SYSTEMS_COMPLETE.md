# Walkthrough: Reconstrução dos 5 Pilares de Gameplay
## Naruto Online Web — Engenharia Reversa Joyfun AS3, SQLite e PixiJS v8

Concluímos com **100% de sucesso e autonomia técnica** a implementação e validação de ponta a ponta dos **5 Pilares de Gameplay** do Naruto Online Web, respeitando estritamente a resolução canônica de 1250x650, os pacotes e opcodes do protocolo de rede original Flash Joyfun e a persistência em banco de dados relacional SQLite.

---

## 📸 Galeria de Validação Visual (Capturas E2E In-Browser via CDP)

### Visão Geral de Konohagakure com População Canônica
A Vila da Folha foi repovoada com os 11 NPCs canônicos posicionados com coordenadas exatas, ciclos de animação de respiração e repouso, fachada do Ichiraku Ramen e HUD completo.

![Vila da Folha com NPCs Canônicos](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\town_canonical_npcs.png)

---

### Pilar 1: Diálogos Estilo Visual Novel com NPCs Canônicos
Sistema de diálogo posicionado no terço inferior com moldura oriental de madeira e ouro, retrato do ninja, insígnia de patente, diálogos canônicos e botões de ação contextuais.

#### Diálogo com o 3º Hokage (Hiruzen Sarutobi)
Opções de missões de Rank elevado, modos de combate e inventário.
![Diálogo com o 3º Hokage](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\npc_dialog_hokage.png)

#### Diálogo com Naruto Uzumaki
Opções de aposta no minigame Mora (Jokenpô), recrutamento para equipe e duelo de treino.
![Diálogo com Naruto Uzumaki](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\npc_dialog_naruto.png)

---

### Pilar 2: Mochila Shinobi & Equipamentos (36 Slots + 6 Equipamentos)
Ficha corporal completa com 6 slots (Arma, Bandana, Colete, Cinto, Calçado, Anel), cálculo em tempo real dos atributos combinados (HP, Atk, Def, Spd) e Poder de Luta Total. Grade 6x6 com 36 slots de bolsa, contagem de itens, rodapé de moedas (Ryo e Ouro) e ações de Equipar, Usar e Vender.

![Mochila Shinobi e Equipamentos](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\inventory_modal_sheet.png)

---

### Pilar 3: Taverna da Folha & Minigame Mora (Jokenpô)
Sistema de apostas interativo contra o taverneiro para acúmulo de Almas Ninjas (+25 em vitória, +5 em empate, +2 em derrota) e lista de ninjas visitantes recrutáveis com custos em almas (Naruto, Sasuke, Sakura, Kakashi, Rock Lee, Neji).

#### Interface da Taverna com Lista de Ninjas Visitantes
![Taverna Shinobi](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\tavern_modal_ninjas.png)

#### Rodada de Mora Jogada (Pedra ✊) e Almas Ninjas Concedidas
Concessão de almas sincronizada em tempo real com SQLite (`120 -> 125 Almas Ninjas`).
![Rodada de Mora Disputada](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\tavern_mora_played.png)

---

### Pilar 4: Tabuleiro Tático de Formação Shinobi (15 Slots)
Tabuleiro oficial de 15 posições (5 linhas x 3 colunas: Apoio/Fundo, Assalto/Meio, Vanguarda/Frente). Lista de heróis recrutados à esquerda com status ("Em Combate" vs "Reserva") e atribuição instantânea por clique com pacote `CS_TacticalDeployment_ChangePositionReq`.

#### Tabuleiro Tático de 15 Posições
![Tabuleiro Tático 15 Slots](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\formation_modal_board.png)

#### Shinobi Posicionado no Slot #1 da Formação
Herói alocado com avatar, nome e feedback imediato na lista de membros.
![Ninja Posicionado no Slot #1](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\formation_slot_assigned.png)

---

### Pilar 5: Campanhas PvE & Arena de Batalha por Turnos
Progressão por capítulos históricos com requisitos de nível, recompensas em moedas e equipamentos, e botão de combate que dispara `CS_BattleStart` e transiciona perfeitamente para a `BattleScene` com combate 3x3 por turnos.

#### Janela de Campanhas Shinobi
![Janela de Campanhas PvE](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\campaign_window_chapters.png)

#### Arena de Combate por Turnos Ativa (Naruto vs Kakashi Hatake)
Círculos de combate táticos, barras de vida e chakra, e reprodução de relatório de batalha.
![Arena de Batalha PvE](C:\Users\Daniel\.gemini\antigravity\brain\4b9d6c43-306d-4909-8f14-3fc2f6b1848a\battle_pve_arena.png)

---

## 🛠️ Detalhes das Correções Técnicas e Arquitetura

1. **Ciclo de Vida de Herança de Classes PixiJS (`BaseModal`)**:
   - Identificamos e corrigimos o erro de inicialização em subclasses JavaScript/TypeScript: o construtor base chamava `this.initContent()` antes que os inicializadores de campos da subclasse (`equipSlots = new Map()`, `items = []`) tivessem sido executados. Movido `this.initContent()` para o construtor das subclasses após inicialização de campos.
2. **Prevenção de Recursão Infinita em Janelas Modais**:
   - `WorldMapWindow`, `PetWindow` e `GameModesWindow` possuíam callbacks `onCloseCallback` que chamavam recursivamente `this.close()`, gerando estouro de pilha (`Maximum call stack size exceeded`). Corrigido para callbacks limpos e seguros.
3. **Gestão Segura de Janelas Ativas (`toggleWindow`)**:
   - Atualizada a função `toggleWindow` para fechar apenas as janelas ativas concorrentes que não sejam o alvo atual, permitindo alternância fluida entre Mochila, Taverna, Formação, Missões e Mapa Mundi.
4. **Visibilidade e Inicialização Assíncrona de Cenas (`TownScene`)**:
   - Criada propriedade `initPromise` que permite ao `GameApp.changeScene` aguardar o download completo de todos os 256 assets de Konoha antes de sinalizar `isReady = true`.
   - Modais (`inventoryModal`, `tavernModal`, `formationModal`, `npcDialogModal`, etc.) e métodos auxiliares tornados públicos para permitir inspeção e automação confiáveis.

---

## ✅ Resumo dos Testes e Validação

- **Testes de Backend SQLite & Opcodes (`tools/test_systems_expansion.cjs`)**: 8/8 suites passaram (100% verde).
- **Compilação do Cliente PixiJS (`npm run build`)**: 0 erros de TypeScript e bundling Vite (`✓ 747 modules transformed`).
- **Automação E2E via CDP (`scratch/test_gameplay_systems_e2e.cjs`)**: Todos os 5 pilares foram executados contra o servidor WebSocket real e fotografados com alta fidelidade visual.
