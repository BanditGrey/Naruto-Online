# Arquitetura do Projeto Naruto Online (HTML5 & WebSocket Emulator)

## 1. Visão Geral e Estrutura Monorepo

O projeto está organizado no formato de **Monorepo** com suporte a workspaces para garantir separação limpa entre código legado (referência), backend (Node.js) e frontend (PixiJS/Vite):

```
├── legacy/                  # CÓDIGO E ASSETS LEGADOS (SOMENTE LEITURA)
│   ├── scripts_as3/         # Código ActionScript 3 descompilado (lógicas, processadores, constantes)
│   └── raw_assets/          # Assets extraídos originais (SWFs, PNGs, MP3s, XMLs)
├── server/                  # BACKEND DO EMULADOR (Node.js / TypeScript)
│   └── src/
│       ├── network/         # Serialização de pacotes binários (PacketReader, PacketWriter)
│       ├── database/        # Persistência nativa SQLite (contas, personagens, itens)
│       ├── world/           # Instâncias de mapa (TownManager, posicionamento, broadcast)
│       ├── battle/          # Gerenciador de combate por turnos (BattleManager)
│       └── server.ts        # Servidor WebSocket nativo RFC 6455
├── client/                  # CLIENTE WEB (HTML5 / PixiJS / Vite)
│   ├── src/                 # Engine gráfica, renderizadores de mapa e cenas de batalha
│   └── public/
│       └── assets/          # Texturas, spritesheets, áudios e dados processados para a Web
├── shared/                  # CÓDIGO E TIPOS COMPARTILHADOS
│   └── opcodes.ts           # Mapeamento oficial de opcodes do protocolo
├── docs/                    # DOCUMENTAÇÃO TÉCNICA E ENGENHARIA REVERSA
│   └── ARCHITECTURE.md      # Este documento
├── package.json             # Raiz configurando workspaces (server, client, shared)
└── tsconfig.json            # Base TypeScript (ES2022, NodeNext, alias @shared/*)
```

---

## 2. A Função da Pasta `legacy/`

- **Estritamente somente leitura**: serve exclusivamente como base de consulta de engenharia reversa e referência de regras de negócio.
- **`legacy/scripts_as3/`**: Contém classes ActionScript 3 descompiladas (`Foundation.Network.*`, `Processors.Game.*`, `Logics.Battle.*`, `CONST_NETWORK.as`). Nenhuma alteração manual deve ser feita aqui.
- **`legacy/raw_assets/`**: Contém a extração total dos recursos legados do jogo original. Scripts de pipeline de assets devem ler desta pasta e converter spritesheets/PNGs para `client/public/assets/`.

---

## 3. Protocolo Binário de Rede Identificado

Todas as trocas de mensagens seguem o padrão binário plano do cliente Flash original, traduzido para **Big Endian**:

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                 PacketLength (uint32 BE, 4B)                  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   PacketID (uint32 BE, 4B)                    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Payload Binário (N Bytes)                  |
|                              ...                              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### Características Principais:
1. **Cabeçalho (Header):** 8 bytes fixos:
   - `PacketLength` (uint32 BE): Tamanho total do pacote = `8 + Payload.length`.
   - `PacketID` (uint32 BE): Identificador numérico do Opcode da ação.
2. **Ausência de Cifra ou Checksum:** No modo padrão (Modo Plano), os dados trafegam diretamente sem RC4 ou AES sobre o canal de rede.
3. **Strings:** Strings utilizam o padrão Flash `TUtilityString.FlushUTF / FetchUTF` com prefixo uint32 BE indicando a quantidade exata de bytes antes dos caracteres UTF-8.
4. **Campos Numéricos:**
   - Coordenadas de mapa $(X, Y)$: `uint16` ou `int16`.
   - Vidas e Dano (`CurHealth`, `HurtHp`): `float32` Big Endian.
   - Atributos e identificadores de Ninja: `uint32` ou `int32`.

---

## 4. Opcodes Mapeados e Implementados

| Opcode Nome | Valor Decimal | Hexadecimal | Sentido | Função |
| :--- | :--- | :--- | :--- | :--- |
| `CS_Login_StatusServerTransmitToken` | `25231360` | `0x01810000` | C $\rightarrow$ S | Envio do token/usuário para login |
| `SC_Login_StatusServerTransmitTokenRet` | `18350080` | `0x01180000` | S $\rightarrow$ C | Confirmação de sessão de login |
| `CS_CREATECHAR_CreateChar` | `25231616` | `0x01810100` | C $\rightarrow$ S | Solicitação de criação de novo personagem |
| `SC_CREATECHAR_CreateCharCmd` | `18350336` | `0x01180100` | S $\rightarrow$ C | Solicita criação de char caso usuário seja novo |
| `SC_CREATECHAR_CreateCharRet` | `18350337` | `0x01180101` | S $\rightarrow$ C | Retorno de criação (sucesso ou erro) |
| `SC_Account_CharInfoNtf` | `18350338` | `0x01180102` | S $\rightarrow$ C | Dados completos do personagem (HP, nível, heróis) |
| `CS_LOBBY_Enter_Town` | `25231872` | `0x01810200` | C $\rightarrow$ S | Solicitação para entrar no mapa da vila |
| `SC_Enter_Town` | `18350592` | `0x01180200` | S $\rightarrow$ C | Confirma entrada no mapa com spawn $(X, Y)$ |
| `CS_LOBBY_Town_Move` | `25232128` | `0x01810300` | C $\rightarrow$ S | Solicitação de deslocamento $(X, Y)$ do ninja |
| `SC_LOBBY_Town_NewRoleNtf` | `18350848` | `0x01180300` | S $\rightarrow$ C | Notifica a presença de avatares no mapa |
| `SC_LOBBY_Town_RoleMove` | `18350849` | `0x01180301` | S $\rightarrow$ C | Broadcast de movimentação de ninja em tempo real |
| `SC_LOBBY_Town_RemoveRole` | `18350850` | `0x01180302` | S $\rightarrow$ C | Notifica saída/desconexão de um ninja da vila |
| `CS_BattleStart` | `22315008` | `0x01548000` | C $\rightarrow$ S | Solicita início de combate contra grupo de monstros |
| `SC_Battle_StartReportDataReq` | `21331968` | `0x01458000` | S $\rightarrow$ C | Pacote inicial de combate (equipes, turnos e danos) |
| `SC_SingleBattleResult` | `21331969` | `0x01458001` | S $\rightarrow$ C | Resultado do combate (Vitória/Derrota e Recompensas) |

---

## 5. Roteiro de Migração para WebSocket e PixiJS

1. **Protocolo no Navegador:**
   - O cliente web abre um `WebSocket` nativo conectado em `ws://localhost:8080` com `binaryType = 'arraybuffer'`.
   - O tráfego de dados é 100% binário via frames opcode `0x02` (Binary).
2. **Frontend PixiJS:**
   - O canvas do PixiJS renderiza o mapa em camadas (`Background`, `WalkableEntities`, `Foreground`, `UI`).
   - Movimentações utilizam cliques com cálculo de caminho e disparo imediato de `CS_LOBBY_Town_Move`.
   - Ao receber `SC_Battle_StartReportDataReq`, uma transição de tela carrega a cena de combate por turnos (`BattleStage`), executando as animações das ações calculadas pelo servidor.
