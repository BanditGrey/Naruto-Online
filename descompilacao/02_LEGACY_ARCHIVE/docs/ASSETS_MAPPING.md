# Naruto Online - Catálogo e Mapeamento Definitivo de Assets

Documentação oficial gerada pelo Antigravity através de engenharia reversa do código ActionScript 3 (`legacy/scripts_as3/`) e catalogação automatizada dos assets descompactados (`legacy/raw_assets/`).

---

## 1. Engenharia Reversa do Sistema de Resolução de IDs (AS3)

O cliente original do Naruto Online Flash empregava o padrão **Hexadecimal de 8 Dígitos** em todas as suas requisições de rede e carregadores de recursos (`Foundation.Utilities.TUtilityHexadecimal.Format(id, 8)`).

### Mecanismo de Resolução (`TResourceLoader.as`)
```actionscript
protected function ResourceURL(param1:TResourceRequest) : String
{
   return this.FResourcePath + TUtilityHexadecimal.Format(param1.Identifier, 8) + this.FResourceSuffix;
}
```

### Mapeamento dos Módulos Principais
| Prefixo Hexadecimal | Repositório Virtual AS3 | Identificador Decimal | Descrição e Conteúdo |
| :--- | :--- | :--- | :--- |
| **`00000000`** | `Resources/Swf/Common/` | `0` | Controles comuns, popups, `MC_DefaultRoleTexture` (boneco manequim). |
| **`01000000`** | `Resources/Swf/CreateChar/` | `16777216` | Tela de criação de personagem: 5 classes ninjas e ilustrações. |
| **`02000000`** | `Resources/Swf/Chat/` | `33554432` | Sistema de chat, caixas de diálogo e emoticons. |
| **`07000000`** | `Resources/Swf/Illustration/`| `117440512` | Retratos ilustrados de alta resolução dos protagonistas. |
| **`13000000`** | `Resources/Swf/Lobby/` | `318767104` | HUD da Vila da Folha, barra inferior, menu, botões de atalho, avatar. |
| **`17000000`** | `Resources/Swf/Battle/` | `385875968` | Cenários da Arena (`155.jpg`), barras de HP de combate, slots de grade. |
| **`17000003`** | `Resources/Swf/Plot/` | `385875971` | Cenários exteriores de Konoha (Pórtico/Templo xintoísta `1.jpg`). |
| **`28000000`** | `Resources/Swf/NPC/` | `671088640` | NPCs autênticos da Vila (Teuchi, Ayame, placas de rua, lanternas). |
| **`3C000000`** | `Resources/Swf/Shop/` | `1006632960` | Molduras de janelas e painéis de loja/inventário. |
| **`81000000`** | `Resources/Swf/BattleCore/` | `2164260864` | Núcleo do motor de batalha (`RESOURCE_Battle`). |
| **`00CFXXXX`** | `Resources/Swf/Skill/` | `13600000+` | Animações de jutsus e auras de chakra (`00CF8507` = Skill `13600007`). |
| **`9800XXXX`** | `Resources/Swf/Events/` | Variável | Instalações e eventos (Restaurante Ichiraku `98000155`, banners). |

---

## 2. Estatísticas Consolidadas da Varredura

- **Total de Imagens Mapeadas:** `5910` arquivos (.png e .jpg)
- **Cenários / Fundos Panorâmicos (>800x350):** `35`
- **Personagens, NPCs e Mascotes Identificados:** `8`
- **Elementos de Interface de Usuário (HUD/UI):** `1523`
- **Frames de Habilidades e Efeitos (Jutsus):** `320`
- **Ícones Quadrados de Itens/Equipamentos:** `2033`

---

## 3. Identificação Específica dos Elementos da Vila da Folha (Konoha)

Abaixo estão os endereços exatos para replicar pixel por pixel a Vila de Konoha original:

### A. Cenário Exterior e Instalações
| Elemento | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| **Pórtico Exterior Konoha** | `Scripts_AS/17000003/images/1.jpg` | `town/bg_konoha_shrine.jpg` | $1250 \times 650$ | Entrada exterior com corda sagrada shimenawa, colunas e nuvens |
| **Fachada Ichiraku Ramen** | `Scripts_AS/98000155/images/1.png` | `town/ichiraku_ramen_shop.png` | $1000 \times 500$ | Prédio completo do Restaurante Ichiraku com toldo e balcão |
| **Cortina Noren Ichiraku** | `Scripts_AS/28000000/images/122.png` | `town/ichiraku_noren.png` | $285 \times 109$ | Faixa tradicional pendurada sobre a entrada do restaurante |
| **Poste / Placa da Vila** | `Scripts_AS/28000000/images/130.png` | `town/prop_street_sign.png` | $53 \times 110$ | Poste de madeira com placa e emblema da Folha |
| **Lanternas Japonesas** | `Scripts_AS/28000000/images/133.png` | `town/prop_lanterns.png` | $51 \times 135$ | Três lanternas tradicionais iluminadas penduradas |

### B. Personagens e NPCs da Vila
| Personagem | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Papel no Jogo |
| :--- | :--- | :--- | :--- | :--- |
| **Lâmina das Trevas** | `Scripts_AS/01000000/images/47.png` | `town/ninja_class_1.png` | $398 \times 448$ | Protagonista Relâmpago com bandana da Folha e Fūma Shuriken |
| **Teuchi (Chef Ramen)** | `Scripts_AS/28000000/images/116.png` | `town/npc_teuchi.png` | $175 \times 156$ | Dono do Ichiraku cozinhando e conversando com clientes |
| **Ayame (Garçonete)** | `Scripts_AS/28000000/images/128.png` | `town/npc_ayame.png` | $94 \times 124$ | Filha do Teuchi servindo clientes no balcão de ramen |
| **Sasuke Uchiha** | `Scripts_AS/98000104/images/3.png` | `town/npc_sasuke.png` | $185 \times 220$ | Pose com kunai e pergaminho na boca |
| **Sakura Haruno** | `Scripts_AS/98000114/images/4.png` | `town/npc_sakura.png` | $190 \times 230$ | Pose ninja com luvas medicinais |
| **Hinata Hyūga** | `Scripts_AS/98000003/images/2.png` | `town/npc_hinata.png` | $120 \times 180$ | Hinata chibi com máscara anbu |
| **Mascote Bebê Naruto** | `Scripts_AS/98000155/images/39.png` | `town/mascot_baby_naruto.png` | $141 \times 235$ | Mascote especial com chupeta e bandana |
| **Manequim Provisório** | `Scripts_AS/00000000/images/356.png` | `town/puppet_dummy.png` | $47 \times 125$ | Boneco manequim oficial da Tencent (`MC_DefaultRoleTexture`) |

### C. Barra Inferior de Atalhos Clássica
| Elemento | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Função |
| :--- | :--- | :--- | :--- | :--- |
| **Barra Dourada Curvada** | `Scripts_AS/13000000/images/183.png` | `ui/bottom_bar_frame.png` | $813 \times 83$ | Base de madeira e suporte dourado circular inferior |
| **Botão Equipe (Team)** | `Scripts_AS/13000000/images/283.png` | `ui/btn_team.png` | $47 \times 52$ | Ícone do Time 7 (Naruto, Sasuke e Sakura) |
| **Botão Mochila (Bag)** | `Scripts_AS/13000000/images/288.png` | `ui/btn_bag.png` | $52 \times 53$ | Bolsa ninja de couro marrom com shuriken e kunai |
| **Botão Formação** | `Scripts_AS/13000000/images/221.png` | `ui/btn_formation.png` | $53 \times 54$ | Tabuleiro tático com 3 peças de formação |
| **Botão Invocação** | `Scripts_AS/13000000/images/226.png` | `ui/btn_summon.png` | $52 \times 54$ | Pergaminho de contrato de invocação da Kurama |
| **Botão Mapa Mundi** | `Scripts_AS/13000000/images/160.png` | `ui/btn_world_map.png` | $74 \times 84$ | Globo terrestre em pergaminho (encaixe circular direito) |

### D. Painel Superior Esquerdo (Perfil do Jogador)
| Elemento | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Função |
| :--- | :--- | :--- | :--- | :--- |
| **Moldura do Status** | `Scripts_AS/13000000/images/323.png` | `ui/avatar_status_frame.png` | $260 \times 105$ | Base entalhada com encaixe circular de retrato e barras HP/Chakra |
| **Barra de Recursos/Moedas**| `Scripts_AS/13000000/images/376.png` | `ui/currency_bar.png` | $473 \times 49$ | Exibição de Ryo (Prata), Lingotes de Ouro e Cupons |
| **Retrato Lâmina das Trevas**| `Scripts_AS/13000000/images/329.png` | `ui/avatar_blade.png` | $80 \times 80$ | Retrato circular do protagonista com máscara Anbu |
| **Retrato Kunoichi Vento** | `Scripts_AS/13000000/images/327.png` | `ui/avatar_dancer.png` | $80 \times 80$ | Retrato circular da Dançarina dos Ventos |
| **Retrato Olho das Chamas** | `Scripts_AS/13000000/images/325.png` | `ui/avatar_fire.png` | $80 \times 80$ | Retrato circular do ninja de Fogo |

---

## 4. Estrutura Recomendada para o Cliente PixiJS

Para montar a cena visual definitiva em `client/public/assets/`:

```text
client/public/assets/
├── town/
│   ├── bg_konoha.jpg           <-- 17000003/images/1.jpg (1250x650)
│   ├── ichiraku_shop.png       <-- 98000155/images/1.png (Fachada Ichiraku)
│   ├── prop_lanterns.png       <-- 28000000/images/133.png (Lanternas)
│   ├── prop_sign.png           <-- 28000000/images/130.png (Poste)
│   ├── ninja_class_1.png       <-- 01000000/images/47.png (Lâmina das Trevas)
│   ├── npc_teuchi.png          <-- 28000000/images/116.png (Chef Teuchi)
│   └── npc_ayame.png           <-- 28000000/images/128.png (Ayame)
│
├── battle/
│   ├── bg_arena.jpg            <-- 17000000/images/155.jpg (Arena 1250x650)
│   └── hp_bar.png              <-- 17000000/images/14.png
│
└── ui/
    ├── bottom_bar.png          <-- 13000000/images/183.png
    ├── btn_team.png            <-- 13000000/images/283.png
    ├── btn_bag.png             <-- 13000000/images/288.png
    ├── btn_formation.png       <-- 13000000/images/221.png
    ├── btn_summon.png          <-- 13000000/images/226.png
    ├── btn_map.png             <-- 13000000/images/160.png
    ├── avatar_frame.png        <-- 13000000/images/323.png
    ├── currency_bar.png        <-- 13000000/images/376.png
    └── avatar_blade.png        <-- 13000000/images/329.png
```