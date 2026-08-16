# Engram Power Template — Agent Plugins 1.0

[![Agent Plugins 1.0](https://img.shields.io/badge/Agent%20Plugins-1.0-blue.svg)](https://agent-plugins.org/)
[![Multi-Client Ready](https://img.shields.io/badge/Support-Codex%20%7C%20Claude%20%7C%20Cursor%20%7C%20Copilot%20%7C%20Kiro%20%7C%20Antigravity-green.svg)](#-compatibilidade-multi-assistente)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Scaffold para criar **Engram Powers** — módulos de habilidades e ontologias especializadas para bases cognitivas e vaults Obsidian.

> [!IMPORTANT]
> **Este repositório é um template, não um plugin para instalar.**
>
> As skills aqui são esqueletos: `power-domain-analyze` analisa "o domínio" abstrato e
> `power-config.yaml` cria uma pasta literalmente chamada `Dominio`. Instalar isto num
> vault real não entrega capacidade nenhuma — só polui a lista de skills.
>
> O fluxo correto é **clonar → rodar `scripts/init-power.sh` → preencher → publicar**.

Todos os manifestos são válidos e passam nos validadores oficiais. É isso que o template entrega: **um scaffold comprovadamente correto**, para que o seu fork já nasça conforme.

---

## 🛡️ Padrão Anti-Colisão (Namespacing)

Quando um usuário instala **vários Powers simultaneamente** (ex: um de Jurídico, um de Financeiro e um de Marketing), as IAs precisam distinguir claramente as ferramentas de cada plugin.

Este template implementa o padrão de prefixos **`power-{dominio}-{acao}`**:

| Componente | Padrão Recomendado | Exemplo (Domínio: Tributário) |
|---|---|---|
| **Repositório** | `engram-power-{dominio}` | `engram-power-tributario` |
| **Plugin ID** (`plugin.json`) | `engram-power-{dominio}` | `engram-power-tributario` |
| **Subagente** (`agents/`) | `power-{dominio}-specialist` | `power-tributario-specialist` |
| **Skill de Análise** (`skills/`) | `power-{dominio}-analyze` | `power-tributario-analyze` |
| **Skill de Captura** (`skills/`) | `power-{dominio}-capture` | `power-tributario-capture` |
| **Chave de Entidade** (`power-config.yaml`) | `{dominio}-{entidade}` | `tributario-tese` |
| **Receita de Captura** (`intake_recipes`) | `{dominio}-{receita}` | `tributario-precedente` |

> [!TIP]
> **Por que usar esse padrão?**
> Se dois plugins diferentes criassem uma skill chamada `analyze` ou `capture`, os assistentes de IA sofreriam colisão de ferramentas (tool collision / shadowing). Com o prefixo `power-{dominio}-*`, múltiplos plugins coexistem em perfeita harmonia.

---

## 📁 Estrutura do Template

```text
engram-power-template/
│
├── plugin.json                 # Manifesto canônico Agent Plugins 1.0
├── mcp.json                    # Servidores MCP (Agent Plugins 1.0)
├── power-config.yaml           # Ontologia, entidades e receitas com namespace
├── skills/                     # Núcleo portátil — lido por TODOS os clientes
│   ├── power-domain-analyze/   # Diagnóstico técnico de domínio
│   └── power-domain-capture/   # Captura e gravação de notas estruturadas
├── templates/                  # Templates de notas Markdown
│   └── domain-entity.md
│
├── AGENTS.md                   # Instruções cross-tool (Antigravity, Codex, Cursor)
├── CONTRIBUTING.md             # Guia de manutenção e validação
├── OPENAI.md                   # Notas de integração OpenAI / Codex
├── LICENSE
│
├── agents/                     # Subagente — lido por Claude Code e Cursor
│   └── power-domain-specialist.md
├── rules/                      # Regras de plugin do Cursor (.mdc)
│   └── power.mdc
├── dev.kiro/                   # Namespace de extensão do Kiro
│   └── steering/power.md
├── .claude-plugin/             # Manifestos do Claude Code
│   ├── plugin.json             #   plugin
│   └── marketplace.json        #   catálogo (necessário p/ `marketplace add`)
├── .mcp.json                   # MCP do Claude Code
├── scripts/init-power.sh       # Personaliza o template para o seu domínio
│
├── .cursor/rules/power.mdc     # Regras de workspace do Cursor
├── .agents/rules/power.md      # Regras de workspace do Antigravity
└── .github/                    # Instruções do GitHub Copilot
    ├── copilot-instructions.md
    └── instructions/power.instructions.md
```

---

## 🔌 Compatibilidade Multi-Assistente

O **núcleo portátil** (`plugin.json` + `skills/` + `mcp.json`) é o que realmente viaja entre clientes. Cada assistente adiciona o que precisa por cima:

| Cliente | Agent Plugins 1.0? | O que ele lê aqui |
|---|---|---|
| **Codex / ChatGPT** | ✅ Cliente oficial | `plugin.json`, `skills/`, `mcp.json`, `AGENTS.md` |
| **Cursor** | ✅ Cliente oficial | núcleo + `rules/`, `agents/` (plugin) ou `.cursor/rules/` (workspace) |
| **GitHub Copilot** | ✅ Cliente oficial | núcleo + `.github/copilot-instructions.md`, `.github/instructions/` |
| **Kiro (Powers)** | ✅ Cliente oficial | núcleo + `dev.kiro/steering/` |
| **Claude Code** | ❌ Formato próprio | `.claude-plugin/plugin.json`, `skills/`, `agents/`, `.mcp.json` |
| **Google Antigravity** | ❌ Formato próprio | `AGENTS.md`, `.agents/rules/` (workspace) |

> [!NOTE]
> **Claude Code e Antigravity não implementam Agent Plugins 1.0.** A Anthropic e o
> Antigravity não constam entre os autores da spec (Vercel, AWS, Anysphere, GitHub,
> Microsoft e OpenAI). Por isso este template declara os manifestos deles em paralelo
> — não via `extensions` no `plugin.json`, que eles não leem.

> [!NOTE]
> O campo `extensions` do `plugin.json` foi deliberadamente omitido: dos clientes
> suportados, apenas o Kiro publica um namespace reverso — e ele usa a representação
> em **diretório** (`dev.kiro/`), não o bloco no manifesto.

---

## 🚀 Criando o seu Power a partir deste Template

### 1. Gerar o repositório
Use o botão **Use this template** do GitHub (ou clone) para criar `engram-power-{dominio}` — ex: `engram-power-juridico`, `engram-power-marketing`, `engram-power-devops`.

### 2. Escolher o slug do domínio
Um slug curto em minúsculas: `juridico`, `mkt`, `financas`, `rh`.

### 3. Rodar o bootstrap

Renomeia skills e subagente, substitui todos os placeholders mecânicos e valida:

```bash
./scripts/init-power.sh marketing SEU-USUARIO "Seu Nome ou Empresa"
```

### 4. Preencher o que o script não faz

O script trata identificadores. O conteúdo continua sendo seu:

| Arquivo | O que preencher |
|---|---|
| `skills/power-{dominio}-*/SKILL.md` | o `description` — ver aviso abaixo |
| `power-config.yaml` | `entities`, `intake_recipes`, `design_rules` |
| `templates/` | estrutura da nota do seu domínio |
| `README.md` | descreva o seu Power, não o template |
| `LICENSE` | detentor do copyright |

> [!WARNING]
> O `description` de cada `SKILL.md` é o que o assistente lê para decidir **quando
> acionar a skill**. Deixá-lo genérico é o erro mais caro do processo: a skill ou
> nunca dispara, ou dispara em tudo.

### 5. Testar
```bash
claude --plugin-dir .
```

### 6. Publicar

Suba para o GitHub num repositório **público** e registre:

```bash
claude plugin marketplace add SEU-USUARIO/engram-power-{dominio}
```

> [!CAUTION]
> O `marketplace add` do Claude Code exige `.claude-plugin/marketplace.json` **no repositório**.
> Sem esse arquivo o diálogo responde *"Este repositório não é um marketplace"*. O bootstrap já
> o deixa preenchido — só não o apague.
>
> Cada usuário registra **um marketplace por nome**: adicionar outro com o mesmo nome substitui
> o primeiro. Por isso o script deriva o nome do seu usuário do GitHub.

Ver [CONTRIBUTING.md](CONTRIBUTING.md) para os alvos de validação e o que cada provedor exige.
