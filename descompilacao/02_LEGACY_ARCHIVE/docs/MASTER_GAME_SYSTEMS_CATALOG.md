# Catálogo Mestre de Sistemas e Mecânicas Canônicas do Jogo

**Projeto:** Naruto Online (Joyfun Flash Client $\rightarrow$ Node.js / SQLite / PixiJS v8)  
**Resolução Nativa:** $1250 \times 650$  
**Referência Canônica de Scripts:** `D:\naruto Online\decompiled\scripts_as3_latest\`  
**Referência de Banco de Dados:** `D:\naruto Online\database\extracted\` (254 tabelas extraídas)  
**Protocolo:** WebSocket Binário/JSON compatível com `CONST_NETWORK.as` (141 Módulos Canônicos)

---

## Sumário dos Grandes Domínios de Engenharia

1. [Domínio 1: Autenticação, Sessão e Gestão de Conta](#domínio-1-autenticação-sessão-e-gestão-de-conta)
2. [Domínio 2: Mundo, Navegação e Social](#domínio-2-mundo-navegação-e-social)
3. [Domínio 3: Combate Tático por Turnos e Formação](#domínio-3-combate-tático-por-turnos-e-formação)
4. [Domínio 4: Atributos, Cultivo e Progressão Ninja](#domínio-4-atributos-cultivo-e-progressão-ninja)
5. [Domínio 5: Equipamentos, Forja e Joias (Smithy)](#domínio-5-equipamentos-forja-e-joias-smithy)
6. [Domínio 6: Recrutamento e Invocação (Taverna e Kuchiyose)](#domínio-6-recrutamento-e-invocação-taverna-e-kuchiyose)
7. [Domínio 7: Modos de Jogo PvE e Campanhas de História](#domínio-7-modos-de-jogo-pve-e-campanhas-de-história)
8. [Domínio 8: PvP Competitivo e Torneios](#domínio-8-pvp-competitivo-e-torneios)
9. [Domínio 9: Organizações (Guildas) e Guerras de Clã](#domínio-9-organizações-guildas-e-guerras-de-clã)
10. [Domínio 10: Economia, Lojas, Eventos e Fidelização](#domínio-10-economia-lojas-eventos-e-fidelização)

---

## Domínio 1: Autenticação, Sessão e Gestão de Conta

### 1.1 Módulo Login & Enter (`MODULARID_Login`: 0 | `MODULARID_Enter`: 512)
* **Classes AS3 Originais:** `TProcessorLogin.as`, `TProcessorEnter.as`, `TProcessorAccount.as`
* **O que Faz (Mecânica):** Realiza a autenticação inicial do jogador com credenciais ou token de sessão do portal, obtém a lista de servidores disponíveis com indicador de lotação (verde/amarelo/vermelho), verifica se o usuário já possui personagem criado no servidor e inicializa a sessão ativa.
* **Lógica no Flash AS3:** O cliente envia pacote de handshake com versão do cliente (`VERSION`), ID do servidor e chave hash. O servidor responde com o código de status (`ErrorCode`), dados cadastrais da conta e ID do personagem ativo.
* **Como Vamos Implementar:**
  * **Backend (Node.js):** Endpoint WebSocket escutando mensagens de tipo `login` e `enter_game`. Consulta no SQLite na tabela `accounts` e `characters`. Se o personagem não existir, redireciona para o fluxo de criação.
  * **Frontend (PixiJS v8):** Janela `LoginWindow` estilizada a partir dos assets em `decompiled/web_portal/`.
* **Tabelas do Banco:** `ConfigValue.json`, `SystemLanguage.json`, `error_codes.json`
* **Status:** ✅ **Implementado** (Sessão WebSocket com persistência em SQLite).

---

### 1.2 Módulo Criação de Personagem (`MODULARID_Account`: 256)
* **Classes AS3 Originais:** `TProcessorCreateRole.as`, `TWindowCreateRole.as`
* **O que Faz (Mecânica):** Apresenta ao novo jogador os 3 arquétipos de protagonistas canônicos:
  1. *Taijutsu (Punho Carmesim / Kurosaki / Vanguarda)*: Foco em defesa física, vida e contra-ataque.
  2. *Ninjutsu (Lâmina das Trevas / Olho Carmesim / Assalto)*: Foco em dano elemental devastador e acertos críticos.
  3. *Genjutsu (Dançarina dos Ventos / Suporte)*: Foco em controle de grupo, cura de chakra e buffs.
  Valida o apelido do jogador contra caracteres inválidos e o dicionário de palavrões de 12.622 palavras.
* **Lógica no Flash AS3:** Executa animação idle/attack em SWF do herói selecionado. Envia o pacote `OPCODE_Account_CreateRole` contendo `heroTemplateId` e `characterName`.
* **Como Vamos Implementar:**
  * **Backend:** Validador regex com `censor_words.json`. Insere o registro em `characters`, concedendo inventário inicial padrão, 5.000 Ryo e 100 Cupons.
  * **Frontend:** `CreateRoleScene` em PixiJS v8 com os spritesheets em `client/public/assets/create_role/`, exibição dinâmica dos atributos base e botão de confirmação.
* **Tabelas do Banco:** `BaseHero.json`, `RoleModel.json`, `censor_words.json`
* **Status:** ✅ **Implementado**.

---

### 1.3 Módulo Segurança de Conta e Discord (`MODULARID_BindEmail`: 31749 | `MODULARID_Discord`: 31811)
* **Classes AS3 Originais:** `TProcessorAccountSafe.as`, `TProcessorBindEmail.as`, `TProcessorDiscord.as`
* **O que Faz (Mecânica):** Proteção secundária para o inventário: exige confirmação de PIN de 6 dígitos antes de permitir desmanchar equipamentos de rank S ou dispensar ninjas lendários. Fornece recompensas diárias por conexão com o bot do Discord.
* **Como Vamos Implementar:**
  * **Backend:** Tabela SQLite `account_security` com campo `secondary_pin_hash` e tabela `discord_bindings`.
  * **Frontend:** Modal de diálogo no PixiJS solicitando PIN numérico na forja ou na demissão de ninjas.
* **Tabelas do Banco:** `SystemLanguage.json`, `error_codes.json`
* **Status:** ⏳ **Planejado**.

---

## Domínio 2: Mundo, Navegação e Social

### 2.1 Módulo Cidade e Vilas Ninja (`MODULARID_Town`: 768)
* **Classes AS3 Originais:** `TProcessorTown.as`, `TTownScene.as`, `TSceneEntity.as`, `TSceneNpc.as`
* **O que Faz (Mecânica):** O mundo aberto do jogo. Renderiza o cenário da vila (Aldeia da Folha, Aldeia da Areia, etc.), gerencia a movimentação do personagem com interpolação de caminho (pathfinding), sincroniza jogadores visíveis em tempo real e posiciona os NPCs canônicos nos seus devidos postos (Tsunade, Hiruzen, Kakashi, Naruto, Iruka, Teuchi do Ramen).
* **Lógica no Flash AS3:** As vilas são compostas por fatias de textura em camadas (chão, edifícios, iluminação, primeiro plano). O servidor envia pacotes de broadcast com a posição `(x, y)` dos jogadores na mesma vila.
* **Como Vamos Implementar:**
  * **Backend:** Gerenciador `TownManager` com salas de vilas (`townId`). Transmite movimentação via WebSocket com payload compacto `[charId, x, y, speed]`.
  * **Frontend:** `TownScene` no PixiJS v8 com suporte a parallax, profundidade de camadas (Z-sorting por Y), balões de fala e clique no mapa para andar.
* **Tabelas do Banco:** `City.json`, `Npc.json`, `Dialogue.json`, `music_config.json`
* **Assets:** `client/public/assets/town_konoha/`, áudio BGM `decompiled/audio/100001.mp3`.
* **Status:** ✅ **Implementado** (Vila da Folha funcional com NPCs canônicos, diálogo VN e navegação).

---

### 2.2 Módulo Mapa Mundi Ninja (`MODULARID_WorldMap`: 1280)
* **Classes AS3 Originais:** `TProcessorWorldMap.as`, `TWindowMap.as`
* **O que Faz (Mecânica):** Permite viajar rapidamente entre as grandes nações ninja (País do Fogo, País do Vento, Vale do Fim, País das Ondas, Floresta da Morte). Cada vila possui requisitos de nível de conta e conclusão de capítulos da campanha.
* **Como Vamos Implementar:**
  * **Backend:** Validação de nível do jogador ao solicitar mudança de vila (`OPCODE_Town_ChangeMap`).
  * **Frontend:** Janela `WorldMapWindow` em PixiJS exibindo o mapa estilizado do Continente Ninja com nós clicáveis.
* **Tabelas do Banco:** `City.json`
* **Status:** ✅ **Implementado** (Navegação modal e teleporte entre vilas integrado).

---

### 2.3 Módulo Chat e Comunicação (`MODULARID_Chat`: 1024)
* **Classes AS3 Originais:** `TProcessorChat.as`, `TWindowChat.as`, `TUtilityFilter.as`
* **O que Faz (Mecânica):** Sistema de bate-papo em tempo real dividido em abas:
  * *Mundo:* Broadcast para todo o servidor (consome megafone ou cooldown de 5s).
  * *Vila:* Mensagens locais para jogadores na mesma tela/vila.
  * *Organização (Guilda):* Canal privado de membros do clã.
  * *Privado (Sussurro):* Comunicação direta jogador-a-jogador.
  * *Sistema:* Avisos de anúncios globais (ex: "Jogador X recrutou Minato Namikaze na Taverna!").
* **Lógica no Flash AS3:** Utiliza tags de texto rico em HTML para embutir ícones de itens e apelidos de jogadores com link clicável para abrir o menu contextual (Sussurrar, Adicionar Amigo, Inspecionar Equipamentos).
* **Como Vamos Implementar:**
  * **Backend:** Sanitização de mensagens com o dicionário de 12.622 palavras de `censor_words.json`. Roteamento WebSocket por salas e suporte a whisper.
  * **Frontend:** Painel de chat retrátil no rodapé inferior esquerdo, permitindo arrastar ou rolar com histórico de mensagens.
* **Tabelas do Banco:** `censor_words.json`, `censor_words_en.json`
* **Status:** ⏳ **Em Progresso** (Infraestrutura de socket pronta, interface de chat em expansão).

---

### 2.4 Módulo Correio e Amizade (`MODELARID_Mail`: 5632 | `MODELARID_Friend`: 5376)
* **Classes AS3 Originais:** `TProcessorMail.as`, `TProcessorFriend.as`
* **O que Faz (Mecânica):** Envio e recebimento de cartas com itens anexados (Ryo, Cupons, Scrolls de Invocação). Sistema de lista de amigos com indicador de status online/offline, envio mútuo de stamina (pontos de amizade) e sparring amistoso.
* **Como Vamos Implementar:**
  * **Backend:** Tabelas SQLite `mails` (com campo `attachments_json` e `is_claimed`) e `friendships`.
  * **Frontend:** Modal `MailWindow` e `FriendListWindow` com abas para ler, resgatar todos os anexos e adicionar amigos por ID.
* **Tabelas do Banco:** `Post.json`, `SystemLanguage.json`
* **Status:** ⏳ **Planejado**.

---

## Domínio 3: Combate Tático por Turnos e Formação

### 3.1 Módulo Formação Tática 3x5 (`MODULARID_TacticalDeployment`: 2304)
* **Classes AS3 Originais:** `TProcessorTacticalDeployment.as`, `TWindowTacticalDeployment.as`
* **O que Faz (Mecânica):** Tabuleiro tático canônico composto por uma grade de **15 posições** divididas em 3 colunas de combate:
  * **Vanguarda (Front Row):** 5 posições. Ninjas focados em absorver dano físico/ninjutsu (Tanques: Jiraiya, Chouji, Kiba).
  * **Assalto (Middle Row):** 5 posições. Causadores de dano principal (DPS: Naruto, Sasuke, Itachi, Minato).
  * **Apoio (Back Row):** 5 posições. Curandeiros, buffers e manipuladores de chakra (Sakura, Tsunade, Shikamaru, Ino).
  O posicionamento define a prioridade de alvos dos ataques normais e a área de impacto de jutsus em coluna, linha ou área total (AoE).
* **Lógica no Flash AS3:** O jogador arrasta os avatares dos ninjas recrutados para as células da grade. O cliente calcula a sinergia dos laços (Fetters) ativos e atualiza a soma total de Poder de Combate (Combat Power / CP).
* **Como Vamos Implementar:**
  * **Backend:** Tabela SQLite `formations` salvando o array de posições `[slotIndex: 0..14 $\rightarrow$ heroInstanceId]`. Validação no servidor impedindo que mais de um ninja ocupe o mesmo slot.
  * **Frontend:** `TacticalFormationWindow` em PixiJS v8 com drag-and-drop interativo, destaques de célula verde/amarela e cálculo em tempo real de CP.
* **Tabelas do Banco:** `ninja_fetters.json`, `BaseHero.json`, `RoleModel.json`
* **Status:** ✅ **Implementado** (Tabuleiro 3x5 funcional com persistência e atualização de CP).

---

### 3.2 Módulo Mecânicas de Batalha por Turnos (`MODULARID_Hurdle`: 1536 / Arena: 6400)
* **Classes AS3 Originais:** `TBattleManager.as`, `TBattleEntity.as`, `TBattleSkill.as`, `TProcessorBattle.as`
* **O que Faz (Mecânica):** O motor central de combate Joyfun:
  1. **Iniciativa de Velocidade (Agility):** A ordem de ataque de cada combatente é determinada pelo valor absoluto de sua Agilidade/Speed. Combatentes mais rápidos agem primeiro.
  2. **Acúmulo de Fúria / Chakra (Rage Bar):** Cada ataque básico desferido gera $+25$ a $+50$ de Fúria; cada golpe recebido gera $+15$ de Fúria. Ao atingir 100 de Fúria, o ninja libera seu Jutsu Secreto Canônico (Ougi).
  3. **Tipos de Ataque e Defesa:**
     - Dano Físico (Taijutsu) vs Defesa Física.
     - Dano Elemental (Ninjutsu) vs Defesa Elemental/Resistência.
     - Dano Espiritual/Chakra (Genjutsu) vs Vontade.
  4. **Efeitos de Status (Crowd Control & DoT):** Paralisia, Atordoamento (Stun), Sono, Queimadura (Burn), Envenenamento (Poison), Cegueira (Blind) e Selamento de Chakra.
  5. **Morte e Vitória:** O combate termina quando todos os combatentes de um dos lados têm o HP zerado.
* **Lógica no Flash AS3:** O motor de combate opera em modelo determinístico no servidor. O servidor processa toda a árvore de turnos e envia ao cliente o `BattleReport` contendo a sequência de ações (`round`, `actorId`, `skillId`, `targets`, `damages`, `isCrit`, `isDodge`, `statusEffects`). O cliente apenas executa as animações de acordo com a fita de eventos.
* **Como Vamos Implementar:**
  * **Backend:** Módulo de simulação determinístico `BattleSimulator.ts` no servidor Node.js. Executa a batalha inteira em milissegundos e retorna o log estruturado ao cliente.
  * **Frontend:** `BattleArenaScene` em PixiJS v8 com animações quadro-a-quadro dos spritesheets extraídos de `decompiled/extracted_swf_assets/` (ex: Rasengan, Chidori), números de dano flutuantes (Pop-up Numbers) vermelhos para crítico, amarelos para normal e verdes para cura, barra de vida dinâmica e suporte aos botões "Auto", "Velocidade 2x" e "Pular Batalha".
* **Tabelas do Banco:** `SkillConfig.json`, `occult_effects.json`, `Enemy.json`, `EnemyArmy.json`, `RoleModel.json`
* **Status:** ✅ **Implementado** (Simulação no servidor e renderização com animação em PixiJS v8).

---

## Domínio 4: Atributos, Cultivo e Progressão Ninja

### 4.1 Módulo Atributos do Ninja (`MODULARID_Heros`: 4096)
* **Classes AS3 Originais:** `TProcessorHeros.as`, `TWindowAvatar.as`, `THeroVO.as`
* **O que Faz (Mecânica):** Gerencia a progressão individual de cada ninja:
  * **Atributos Primários:**
    - Força (Strength) $\rightarrow$ Aumenta Ataque Físico e Vida.
    - Chakra $\rightarrow$ Aumenta Ninjutsu e Defesa Ninjutsu.
    - Agilidade (Agility) $\rightarrow$ Aumenta Velocidade de Ataque e Taxa de Esquiva.
    - Resistência (Stamina) $\rightarrow$ Aumenta Defesa Física e Vida máxima.
  * **Atributos Secundários de Combate:**
    - Taxa Crítica (Crit Rate) e Dano Crítico (Crit Damage).
    - Precisão (Hit Rate) vs Esquiva (Dodge).
    - Bloqueio (Block) e Penetração de Defesa (Pierce).
  * **Evolução de Estrelas (Star Rating 1★ a 5★):** O consumo de fragmentos do ninja permite ascender suas estrelas, multiplicando seus atributos base e destravando novas habilidades passivas.
* **Como Vamos Implementar:**
  * **Backend:** Tabela SQLite `ninja_characters` com fórmulas matemáticas de cálculo de atributos idênticas ao ActionScript 3.
  * **Frontend:** Janela modal `NinjaDetailWindow` exibindo o modelo em pé do personagem, barras de atributos, estrelas douradas e abas de cultivo.
* **Tabelas do Banco:** `BaseHero.json`, `HeroTalent.json`, `ninja_upgrade_trans.json`
* **Status:** ⏳ **Em Expansão** (Atributos base integrados, tela de detalhes com estrelas em implementação).

---

### 4.2 Módulo Oito Portões Internos (`MODELARID_EightDoor`: 25088)
* **Classes AS3 Originais:** `TProcessorEightGates.as`, `TWindowEightGates.as`
* **O que Faz (Mecânica):** Sistema canônico de cultivo corporal (Hachimon Tonkou):
  1. Portão da Abertura (Kaimon) $\rightarrow$ $+HP$.
  2. Portão da Cura (Kyumon) $\rightarrow$ $+Ataque Físico$.
  3. Portão da Vida (Seimon) $\rightarrow$ $+Defesa Física$.
  4. Portão da Dor (Shomon) $\rightarrow$ $+Agilidade$.
  5. Portão do Limite (Tomon) $\rightarrow$ $+Ninjutsu$.
  6. Portão da Visão (Keimon) $\rightarrow$ $+Defesa Ninjutsu$.
  7. Portão da Maravilha (Kyomon) $\rightarrow$ $+Crítico$.
  8. Portão da Morte (Shimon) $\rightarrow$ $+Dano Crítico e Imunidade a Selamento$.
  Para abrir cada portão, o jogador gasta Ryo e "Chakra Primitivo" obtido na meditação diária.
* **Como Vamos Implementar:**
  * **Backend:** Tabela SQLite `character_eight_gates` registrando o nível alcançado em cada um dos 8 portões.
  * **Frontend:** Modal `EightGatesWindow` exibindo a silhueta do corpo humano com os 8 pontos de chakra pulsando em verde/azul/vermelho com animação PixiJS.
* **Tabelas do Banco:** `eight_gates.json`, `ConfigValue.json`
* **Status:** ⏳ **Planejado**.

---

### 4.3 Módulo Kekkei Genkai / Blood Soul (`MODELARID_BloodSoulPurgatory`: 20736 | `MODELARID_BloodFete`: 22784)
* **Classes AS3 Originais:** `TProcessorBloodSoul.as`, `TWindowBloodSoul.as`
* **O que Faz (Mecânica):** Cultivo de linhagens sanguíneas avançadas (Sharingan, Byakugan, Mokuton, Shikotsumyaku, Hyoton). Concede aumentos percentuais massivos aos atributos e efeitos especiais de combate (ex: reflexo de dano, roubo de vida, restauração de chakra ao ser golpeado).
* **Tabelas do Banco:** `blood_soul_attr.json` (4.000 registros de atributos extraídos), `OccultEffect.json`
* **Status:** ⏳ **Planejado**.

---

### 4.4 Módulo Transformações da Natureza / Wu Xing (`MODELARID_Elements`: 31792)
* **Classes AS3 Originais:** `TProcessorWuxing.as`, `TWindowWuxing.as`
* **O que Faz (Mecânica):** O ciclo canônico dos 5 Elementos Ninja:
  $$\text{Fogo (Katon)} \succ \text{Vento (Futon)} \succ \text{Trovão (Raiton)} \succ \text{Terra (Doton)} \succ \text{Água (Suiton)} \succ \text{Fogo (Katon)}$$
  Ninjas que atacam alvos do elemento que dominam causam $+20\%$ de dano e têm $+10\%$ de chance de atordoar.
* **Tabelas do Banco:** `wuxing_config.json` (1.125 registros extraídos)
* **Status:** ⏳ **Planejado**.

---

## Domínio 5: Equipamentos, Forja e Joias (Smithy)

### 5.1 Módulo Inventário e Equipamentos (`MODULARID_Equip`: 3328 | `MODULARID_Backpack`: 3840)
* **Classes AS3 Originais:** `TProcessorBackpack.as`, `TProcessorEquip.as`, `TWindowBackpack.as`
* **O que Faz (Mecânica):**
  * **Mochila:** Grade de 36 slots expansível com cupons ou chaves de inventário. Suporta empilhamento de itens consumíveis (scrolls, poções de stamina, pílulas de soldado) e organização automática (Auto-Sort).
  * **Slots de Equipamento (6 Slots por Ninja):**
    1. *Arma (Espada/Kunai):* Aumenta Ataque Físico e Ninjutsu.
    2. *Chapéu/Protetor de Testa:* Aumenta Vida e Defesa Ninjutsu.
    3. *Armadura:* Aumenta Defesa Física e Vida.
    4. *Capa/Manto:* Aumenta Defesa Ninjutsu e Vida.
    5. *Livro de Jutsus/Pergaminho:* Aumenta Ninjutsu e Ataque Crítico.
    6. *Botas:* Aumenta Agilidade e Velocidade.
* **Como Vamos Implementar:**
  * **Backend:** Tabelas SQLite `inventory_items` e `equipped_items`. Endpoints WebSocket para equipar, desequipar, usar consumível e ordenar mochila.
  * **Frontend:** `InventoryWindow` em PixiJS v8 com renderização dos 36 slots, visualização do boneco 3D/2D do ninja e tooltip flutuante detalhando atributos do item ao passar o mouse.
* **Tabelas do Banco:** `Article.json`, `BaseEquip.json`, `suits.json`
* **Status:** ✅ **Implementado** (Inventário 36 slots, 6 equipamentos e cálculo de stats ativo).

---

### 5.2 Módulo Forja do Ferreiro (`MODULARID_Smithy`: 3584)
* **Classes AS3 Originais:** `TProcessorSmithy.as`, `TWindowSmithy.as`
* **O que Faz (Mecânica):**
  1. *Fortalecer (Enhance):* Gasta Ryo para subir o nível do equipamento até o limite do nível da conta. Sucesso de 100%, aumentando atributos exponencialmente.
  2. *Refinar (Refine):* Gasta "Pedras de Refino" para conceder estrelas ao item, aumentando atributos secundários (Crítico, Bloqueio, Esquiva).
  3. *Ascender (Upgrade Quality):* Converte equipamentos de Verde $\rightarrow$ Azul $\rightarrow$ Roxo $\rightarrow$ Dourado $\rightarrow$ Laranja $\rightarrow$ Vermelho consumindo pergaminhos de receita e materiais de instâncias.
* **Tabelas do Banco:** `BuildConsume.json`, `BuildValue.json`, `OrnamentBuildConsume.json`
* **Status:** ⏳ **Em Expansão**.

---

### 5.3 Módulo Joias e Magatamas (`MODULARID_Jade`: 4352)
* **Classes AS3 Originais:** `TProcessorJade.as`, `TWindowJade.as`
* **O que Faz (Mecânica):** Cada equipamento possui até 5 engastes (sockets) para inserção de Magatamas de atributos (Vida, Ataque, Defesa, Ninjutsu, Resistência). 3 Magatamas de nível $N$ podem ser sintetizadas para gerar uma Magatama de nível $N+1$.
* **Tabelas do Banco:** `Article.json`, `EnchantValue.json`
* **Status:** ⏳ **Planejado**.

---

## Domínio 6: Recrutamento e Invocação (Taverna e Kuchiyose)

### 6.1 Módulo Taverna Ninja e Minigame Jokenpô (`MODULARID_Tavern`: 3072)
* **Classes AS3 Originais:** `TProcessorTavern.as`, `TWindowTavern.as`
* **O que Faz (Mecânica):** O método canônico Joyfun para recrutar novos ninjas companheiros:
  1. O jogador escolhe o nível da Taverna (Genin/Azul, Chunin/Roxo, Jonin/Dourado, Sannin/Vermelho).
  2. O jogador desafia os ninjas da Taverna para partidas do minigame **Mora (Pedra, Papel e Tesoura)**.
  3. Vitórias no Mora concedem "Almas Ninja" (Ninja Souls) da cor correspondente.
  4. Ao acumular a quantidade exigida de almas (ex: 100 almas roxas para Gaara, 200 almas douradas para Minato), o ninja é permanentemente recrutado para a equipe.
* **Como Vamos Implementar:**
  * **Backend:** Lógica determinística de Jokenpô no WebSocket, validação de saldo de Ryo e inserção do novo herói na tabela `recruited_ninjas`.
  * **Frontend:** `TavernWindow` em PixiJS v8 exibindo a mesa da taverna, botões clicáveis de Pedra, Papel e Tesoura, placar de vitórias/empates/derrotas e mostrador de almas ninja.
* **Tabelas do Banco:** `tavern_warriors.json`, `tavern_grades.json`, `BaseHero.json`
* **Status:** ✅ **Implementado** (Taverna funcional com minigame Jokenpô e recrutamento).

---

### 6.2 Módulo Bestas de Invocação / Kuchiyose (`MODELARID_Pet`: 5120 | `MODELARID_TongLing`: 24576)
* **Classes AS3 Originais:** `TProcessorPet.as`, `TProcessorTongLing.as`
* **O que Faz (Mecânica):** Invocação de animais místicos canônicos (Gamabunta, Manda, Katsuyu, Pakkun, Enma, Corvos de Itachi). As invocações permanecem em standby durante a luta e atacam automaticamente ao término de cada rodada ou realizam combos de perseguição (Chase combos) quando um inimigo sofre Repulsão (Knockback) ou Queda (Knockdown).
* **Tabelas do Banco:** `BasePet.json`, `PetImage.json`, `PetMonsterExp.json`
* **Status:** ⏳ **Planejado**.

---

## Domínio 7: Modos de Jogo PvE e Campanhas de História

### 7.1 Módulo Campanha de Fases e Capítulos (`MODULARID_Hurdle`: 1536)
* **Classes AS3 Originais:** `TProcessorHurdle.as`, `TWindowHurdle.as`
* **O que Faz (Mecânica):** A jornada principal do enredo seguindo a cronologia do anime/mangá:
  * *Capítulo 1: O Teste dos Sinos (Equipe 7 vs Kakashi).*
  * *Capítulo 2: País das Ondas (Zabuza e Haku).*
  * *Capítulo 3: O Exame Chunin e a Floresta da Morte.*
  * *Capítulo 4: Invasão de Konoha (Orochimaru e Gaara).*
  * *Capítulo 5: A Busca por Tsunade (Jiraiya e Naruto).*
  * *Capítulo 6: O Resgate de Sasuke (Vale do Fim).*
  Cada fase possui classificação de 1 a 3 estrelas baseada no número de ninjas sobreviventes, concedendo baús de capítulo com equipamentos lendários.
* **Como Vamos Implementar:**
  * **Backend:** Tabela SQLite `campaign_progress` com `completed_stages` e estrelas.
  * **Frontend:** `CampaignWindow` em PixiJS v8 com mapa de nós interligados, botões "Desafiar", "Varrer (Sweep)" e prévia de drops.
* **Tabelas do Banco:** `dungeons.json`, `Enemy.json`, `EnemyArmy.json`, `tasks.json`
* **Status:** ✅ **Implementado** (Capítulos 1 a 3 jogáveis com transição para batalha).

---

### 7.2 Módulo Torre dos Desafios (`MODELARID_Tower`: 17920)
* **Classes AS3 Originais:** `TProcessorTower.as`, `TWindowTower.as`
* **O que Faz (Mecânica):** Torre infinita de 100 andares. Cada andar apresenta equipes inimigas progressivamente mais poderosas com condições especiais de combate (ex: inimigos imunes a dano físico, rodadas com veneno ambiental). Drops massivos de pedras de refino e Magatamas.
* **Tabelas do Banco:** `EnemyArmy.json`, `DafubenCondition.json`
* **Status:** ⏳ **Planejado**.

---

### 7.3 Módulo Chefes Mundiais e Invasão das Dez-Caudas (`MODELARID_TenTail`: 15872 | `MODELARID_GlobalBoss`: 31865)
* **Classes AS3 Originais:** `TProcessorTenTail.as`, `TProcessorGlobalBoss.as`
* **O que Faz (Mecânica):** Evento global com hora marcada onde a Kyuubi ou o Juubi ataca as vilas. Todos os jogadores do servidor entram na mesma instância de batalha simultânea, acumulando dano total no chefe. Recompensas massivas em Ryo, Cupons e títulos honoríficos para o Top 10 de dano e para quem desferir o último golpe (Last Hit).
* **Tabelas do Banco:** `ActivityDesc.json`, `Award.json`
* **Status:** ⏳ **Planejado**.

---

## Domínio 8: PvP Competitivo e Torneios

### 8.1 Módulo Arena Ranqueada (`MODELARID_Arena`: 6400)
* **Classes AS3 Originais:** `TProcessorArena.as`, `TWindowArena.as`
* **O que Faz (Mecânica):** Tabela de classificação competitiva do servidor. O jogador visualiza 5 oponentes acima de sua colocação atual. Ao desafiar e vencer, assume a posição do oponente derrotado. Concede recompensas diárias por correio baseadas no ranking atingido às 21:00.
* **Como Vamos Implementar:**
  * **Backend:** Tabela SQLite `arena_rankings` com lógica de swap de posições em caso de vitória. Gravação dos replays das últimas 5 lutas.
  * **Frontend:** Modal `ArenaWindow` com os pódios do Top 3, cartão do próprio jogador e botões de desafio.
* **Tabelas do Banco:** `PvpRankingReward.json`, `RankMoney.json`, `RankReward.json`
* **Status:** ✅ **Implementado** (Fluxo de batalha e ranking funcional).

---

### 8.2 Módulo Batalha Cross-Server e Guerra Ninja (`MODELARID_CrossServerWar`: 15616 | `MODELARID_WorldMatch`: 31834)
* **Classes AS3 Originais:** `TProcessorCrossServerWar.as`, `TWindowCrossServerWar.as`
* **O que Faz (Mecânica):** Torneio de eliminatórias entre servidores no formato melhor de 3 lutas (Bo3). Jogadores de servidores diferentes apostam fichas de torneio nos favoritos antes das finais.
* **Status:** ⏳ **Planejado**.

---

## Domínio 9: Organizações (Guildas) e Guerras de Clã

### 9.1 Módulo Organização Ninja (`MODELARID_Organization`: 9472 | `MODELARID_OrganizationWar`: 9984)
* **Classes AS3 Originais:** `TProcessorOrganization.as`, `TWindowOrganization.as`
* **O que Faz (Mecânica):**
  * Criação de clãs por 500 Cupons ou 100.000 Ryo.
  * Doação diária de recursos para subir o nível da guilda.
  * Árvore de Habilidades de Clã: todos os membros recebem bônus passivos permanentes de Vida, Ataque e Resistência.
  * Guerra da Organização (GvG semanal): disputas em mapa de controle de bases territoriais.
* **Tabelas do Banco:** `ConfigValue.json`, `SystemLanguage.json`
* **Status:** ⏳ **Planejado**.

---

## Domínio 10: Economia, Lojas, Eventos e Fidelização

### 10.1 Módulo Lojas e Mercador (`MODELARID_Mall`: 6656 | `MODELARID_NewMall`: 23552)
* **Classes AS3 Originais:** `TProcessorMall.as`, `TWindowMall.as`
* **O que Faz (Mecânica):**
  * *Loja de Ryo:* Compra de itens consumíveis diários, chaves e pergaminhos de despertar.
  * *Loja de Cupons/Ouro:* Venda de pacotes de ninjas raros, roupas temáticas e Magatamas nível 4+.
  * *Mercador Ambulante:* Loja com temporizador de 2 horas que oferece ofertas com até $70\%$ de desconto.
* **Tabelas do Banco:** `Article.json`, `ItemBox.json`
* **Status:** ⏳ **Planejado**.

---

### 10.2 Módulo Recompensas Diárias e Ramen do Ichiraku (`MODELARID_Ramen`: 5888 | `MODELARID_Sign`: 6912)
* **Classes AS3 Originais:** `TProcessorRamen.as`, `TProcessorSign.as`
* **O que Faz (Mecânica):**
  * *Ramen do Ichiraku:* Servido às 12:00-14:00 e 18:00-20:00. O jogador come uma tigela de ramen com Teuchi e recupera $+50$ de Stamina gratuitamente.
  * *Check-in de 30 Dias:* Calendário mensal onde cada dia logado concede um prêmio (Ryo, Magatamas, fragmentos de ninjas exclusivos de check-in).
* **Tabelas do Banco:** `DailyQuest.json`, `ActivityDesc.json`
* **Status:** ⏳ **Planejado**.

---

## Matriz de Rastreabilidade e Roadmap de Implementação

| Domínio | Módulos AS3 | Tabelas Relacionadas | Status Atual | Próxima Ação de Engenharia |
| :--- | :--- | :--- | :---: | :--- |
| **1. Autenticação & Conta** | 0, 256, 512, 31749 | `ConfigValue`, `censor_words` | ✅ 100% | Adicionar travamento de PIN secundário |
| **2. Vila, Navegação & Chat** | 768, 1024, 1280, 5632 | `City`, `Npc`, `Dialogue` | 🟡 85% | Conectar caixa de texto do Chat com o WebSocket |
| **3. Combate & Formação** | 1536, 2304, 6400 | `EnemyArmy`, `SkillConfig`, `Fetters` | ✅ 90% | Refinar animações de impacto com os frames de SWF |
| **4. Cultivo do Ninja** | 4096, 25088, 20736, 31792 | `BaseHero`, `HeroTalent`, `wuxing` | 🟡 70% | Implementar modal dos Oito Portões Internos |
| **5. Equipamentos & Forja** | 3328, 3584, 3840, 4352 | `Article`, `BaseEquip`, `BuildConsume`| ✅ 85% | Implementar interface de refinamento na forja |
| **6. Recrutamento & Taverna** | 3072, 5120, 24576 | `tavern_warriors`, `BasePet` | ✅ 80% | Adicionar tela de invocações (Kuchiyose) |
| **7. Campanhas PvE** | 1536, 17920, 15872 | `dungeons`, `Enemy`, `tasks` | ✅ 85% | Implementar andares da Torre dos Desafios |
| **8. PvP & Arenas** | 6400, 15616, 31834 | `PvpRankingReward`, `RankMoney` | ✅ 80% | Adicionar gravação e reprodução de replays |
| **9. Guildas & Clãs** | 9472, 9984, 10752 | `ActivityDesc`, `Award` | ⚪ 30% | Criar tabelas SQLite para clãs e doações |
| **10. Economia & Eventos** | 5888, 6656, 6912, 13824 | `Article`, `ItemBox`, `tree_chests` | 🟡 50% | Criar janela da Loja de Itens e Ichiraku Ramen |

---

Com este catálogo canônico e a base de dados consolidada, o projeto possui o guia definitivo de arquitetura, pacotes e fórmulas para evoluir de forma 100% fiel ao jogo original, sem desvios ou retrabalhos.
