# DOCUMENTAÇÃO MESTRE DO PROJETO: NARUTO ONLINE (STATUS & TRANSIÇÃO)

> **DATA DA DOCUMENTAÇÃO:** 13/09/2026  
> **OBJETIVO:** Registro integral do estado atual do projeto para preservação antes da formatação do computador do usuário, definindo exatamente o que está concluído (100% original), o que está pendente, onde estão as referências canônicas e como retomar o desenvolvimento sem desvios.

---

## 1. DIRETRIZ FUNDAMENTAL DO PROJETO (REGRA DE OURO)

1. **Apenas a Criação de Personagem está 100% original até o momento.**
2. **TODO O RESTANTE ESTÁ PENDENTE** de ser refeito para paridade 1:1 com o jogo oficial.
3. **PROIBIDO CRIAR TELAS SINTÉTICAS OU INVENTADAS POR IA:**
   - Nenhuma janela, modal, botão ou layout deve ser desenhado do zero com formas genéricas ou retângulos procedurais.
   - Qualquer menu (Formação, Mochila, Ninjas, Batalha, Habilidades, Diálogos, etc.) deve ser **cópia fiel 1:1** do jogo oficial (*Naruto Online - Joyfun / Tencent / Namco Bandai / 568Play*).

---

## 2. STATUS REAL DOS MÓDULOS

| Módulo | Status | Observações |
| :--- | :--- | :--- |
| **Criação de Personagem** | **100% CONCLUÍDO & ORIGINAL** | Utiliza os assets canônicos extraídos (`00A95F62.TexClient`, `00A95F64`, etc.), 6 protagonistas autênticos com animações completas (idle/run), layout, músicas e estatísticas originais. |
| **Formação / Equipe (Team)** | **PENDENTE DE REFAZER (URGENTE)** | O layout anterior (baseado no módulo de pedra marrom 16000000) foi rejeitado pelo usuário. Deve ser substituído pela tela canônica oficial (ver Seção 3). |
| **Batalha (Battle Scene)** | **PENDENTE DE REFAZER 1:1** | O backend de turnos e pacotes de PvE foi estruturado, mas a cena visual precisa de alinhamento visual idêntico à batalha oficial (ver Seção 3). |
| **HUD da Vila (Town Scene)** | **PENDENTE DE REFAZER 1:1** | A vila tem movimentação e NPCs posicionados, mas os botões de HUD, minimapa e molduras superiores/inferiores precisam ser os oficiais. |
| **Mochila / Inventário** | **PENDENTE DE REFAZER 1:1** | Requer o grid, abas e molduras originais canônicas. |
| **Sistema de Ninjas / Talentos** | **PENDENTE** | Tela de detalhes do ninja, despertar de estrelas e árvore de talentos do protagonista. |
| **Guilda, Correio, Missões, Loja**| **PENDENTE** | Modais precisam ser reconstruídos usando os cortes 1:1 dos SWFs oficiais. |

---

## 3. REFERÊNCIAS VISUAIS OFICIAIS CANÔNICAS

Durante o alinhamento, o usuário forneceu as imagens canônicas exatas do jogo oficial:

### A. Tela de Formação / Equipe Oficial (`MY TEAM`):
- **Abas superiores direitas:** `TEAM`, `TRAIN`, `TRANSFORM` com botões circulares canônicos de ajuda (?) e fechar (X).
- **Coluna da esquerda (`MY TEAM`):** Lista vertical de ninjas com seus retratos, nível (Lv), estrelas (1 a 5 estrelas douradas), atributo elemental (Water, Fire, Earth, Wind, Lightning) e tag dourada `IN BATTLE`.
- **Presets da formação:** Botões à esquerda do campo de batalha: `Normal`, `Kyuubi`, `Set 3`, `Set 4`, `Set 5`.
- **Campo de Batalha Central 3x3:**
  - 9 plataformas circulares em espiral azul / vórtice de chakra.
  - Personagens em pé sobre as plataformas (sprites/modelos dos ninjas).
  - Indicadores numéricos canônicos de ordem de ataque acima de cada ninja: `1. ACTION`, `2. ACTION`, `3. ACTION`, `4. ACTION`.
  - Exibição de `POWER <valor>` (em tipografia estilizada vermelha) e contador `In Battle Ninja 4/4`.
- **Barra de Talentos Inferior (`Talents`):**
  - Mostra os 5 talentos ativos do Personagem Principal (Esotérica/Mistério, Ataque Comum, Perseguição 1, Perseguição 2, Passiva) com os custos de chakra (ex: 40, 20, 20, 20) e atalhos de teclado (Q, W, E, R).
- **Painel da Direita (`NINJAS YOU HAVE RECRUITED:`):**
  - Campo de busca: `Enter Ninja's name`.
  - Filtros suspensos: `Star Level`, `Attributes`, `Chase Status`, `Create Status`, `Chakra`.
  - Grid com os cards dos ninjas recrutados (Lee, Sakura, Naruto, Haku, Kankuro, Kakashi, Temari, Kiba, Shino, Anko, Tenten, etc.).

### B. Tela de Batalha Oficial:
- Fundo panorâmico 2.5D (ex: Vale do Fim com as estátuas de Hashirama e Madara).
- Formação 3x3 do jogador à esquerda contra a formação 3x3 inimiga à direita.
- Retratos dos ninjas em combate no topo esquerdo e topo direito com Lv, barra de vida e ícone de chakra/invocação.
- Barras de vida verdes acima de cada personagem com o nome e nível (`Tenten Lv. 57 | 2209/3093`).
- Efeito de impacto e contador de combo canônico (`77 Hit` estilizado em vermelho/preto/laranja).
- Barra inferior com os jutsus esotéricos disponíveis prontos para ativação.

---

## 4. O CLIENTE OFICIAL DO USUÁRIO (`568Play`)

Foi identificado que o usuário possui o cliente oficial instalado no Windows em:
- **Caminho:** `D:\Naruto-568Play\`
- **Executável:** `D:\Naruto-568Play\naruto.exe`
- **Tecnologia:** Electron/Chromium com wrapper Flash (`pepflashplayer.dll`).
- **Como utilizar na retomada:**
  - O usuário pode rodar o jogo oficial para navegar nas telas reais.
  - A IA pode tirar screenshots diretas em alta definição das janelas abertas do `naruto.exe` via scripts de automação do Windows (`BitBlt` / `PrintWindow`).
  - Os arquivos `.swf` e `.png` baixados pelo launcher ficam gravados no cache do sistema (`%AppData%` ou `%LocalAppData%`), permitindo extrair os arquivos canônicos diretamente.

---

## 5. ARQUITETURA TÉCNICA E PROTOCOLOS ATUAIS

### Estrutura dos Projetos:
1. **`Serve/` (Backend):**
   - TypeScript + Node.js nativo rodando WebSocket Server na porta `8080`.
   - Protocolo binário compatível com os pacotes oficiais.
   - Como rodar:
     ```powershell
     cd "d:\naruto Online\Serve"
     npm.cmd run build
     node dist/index.js
     ```

2. **`Client/` (Frontend):**
   - TypeScript + Vite + PixiJS v8 rodando na porta `3000`.
   - Conecta via WebSocket em `ws://localhost:8080`.
   - Como rodar:
     ```powershell
     cd "d:\naruto Online\Client"
     npm.cmd run dev
     ```

### Tabela de Opcodes Implementados no Protocolo:
- `0x01810001` / `0x01180001`: Autenticação e Login (`CS_Account_LoginReq` / `SC_Account_LoginRet`)
- `0x01810101` / `0x01180102`: Criação de Personagem (`CS_Account_CreateCharReq` / `SC_Account_CreateCharRet`)
- `0x01810200` / `0x01180200`: Entrada no Mapa da Vila (`CS_Map_EnterReq` / `SC_Map_EnterRet`)
- `0x01810201` / `0x01180201`: Movimentação de Jogadores (`CS_Map_MoveReq` / `SC_Map_MoveRet`)
- `0x01810600` / `0x01180601`: Chat Público / Privado / Sistema (`CS_Chat_SendReq` / `SC_Chat_BroadcastRet`)
- `0x01810102` / `0x01180103`: Evolução / Level Up (`CS_Account_CharUpgradeReq` / `SC_Account_CharUpgradeNtf`)
- `0x01810400` / `0x01180400`: Atualização de Formação (`CS_Formation_UpdateReq` / `SC_Formation_UpdateRet`)
- `0x01811300` / `0x01181300`: Painel da Guilda (`CS_Guild_InitReq` / `SC_Guild_InitRet`)
- `0x01811301` / `0x01181301`: Doação para a Guilda (`CS_Guild_DonateReq` / `SC_Guild_DonateRet`)
- `0x01811400` / `0x01181400`: Resgate de Gift Code (`CS_Gift_RedeemCodeReq` / `SC_Gift_RedeemCodeRet`)
- `0x01810500` / `0x01180501` / `0x01180502`: Batalha PvE (`CS_Battle_StartReq`, `SC_Battle_StartReportDataReq`, `SC_SingleBattleResult`)

---

## 6. CHECKLIST OBRIGATÓRIO PARA O USUÁRIO ANTES DE FORMATAR O COMPUTADOR

> [!CAUTION]
> Para não perder nenhum progresso ao formatar a máquina, faça o backup dos seguintes itens em um disco externo, pen drive ou nuvem:

1. **Pasta do Projeto Inteira:**
   - Copiar a pasta `D:\naruto Online\` completa.
   - Garantir que a pasta `.git` seja copiada junta (ou realizar `git push` para seu repositório remoto GitHub/GitLab).
2. **Pasta do Cliente Oficial:**
   - Copiar a pasta `D:\Naruto-568Play\` (para não precisar baixar e instalar novamente o launcher oficial em vietnamita após a formatação).
3. **Credenciais / Links:**
   - Anotar o login ou link de acesso do servidor 568Play onde a conta de testes está criada.

---

## 7. GUIA DE RETOMADA PARA A PRÓXIMA IA (APÓS A FORMATAÇÃO)

Quando o usuário abrir esta conversa ou uma nova conversa após formatar o computador:

1. **Leia imediatamente este arquivo (`DOCUMENTACAO_PROJETO_E_STATUS.md`).**
2. **Tenha plena consciência:** A única tela 100% pronta e canônica é a **Criação de Personagem**. Todo o resto deve ser construído tendo como referência visual obrigatória os menus oficiais do Naruto Online.
3. **Primeira Tarefa Prioritária da Retomada:**
   - Reconstruir a **Tela de Formação / Equipe (`MY TEAM`)** com o design exato canônico da imagem oficial:
     - 3 Abas superiores (`TEAM`, `TRAIN`, `TRANSFORM`).
     - Lista `MY TEAM` à esquerda.
     - Presets `Normal`, `Kyuubi`, `Set 3`, `Set 4`, `Set 5`.
     - 9 círculos de espiral azul com os ninjas em pé e ordem de ação `1. ACTION` a `4. ACTION`.
     - Barra de talentos inferior com os 5 jutsus e custo de chakra.
     - Painel de `NINJAS YOU HAVE RECRUITED:` com filtros e cards dos ninjas.
4. **Validar visualmente antes de entregar:**
   - Utilizar o script de auditoria e inspeção de imagens (`view_file`) para garantir paridade 1:1 absoluta.
