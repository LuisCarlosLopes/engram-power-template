# Engram Power Template — Agent Plugins 1.0

[![Agent Plugins 1.0](https://img.shields.io/badge/Agent%20Plugins-1.0-blue.svg)](https://agent-plugins.org/)
[![Multi-Client Ready](https://img.shields.io/badge/Support-Codex%20%7C%20Claude%20%7C%20Cursor%20%7C%20Copilot%20%7C%20Kiro%20%7C%20Antigravity-green.svg)](#compatibilidade-multi-assistente)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Template base para criação de **Engram Powers** (módulos de habilidades e ontologias especializadas) prontos para distribuição e consumo em qualquer base cognitiva ou vault Obsidian gerenciado por IA.

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
│
├── agents/                     # Subagente — lido por Claude Code e Cursor
│   └── power-domain-specialist.md
├── rules/                      # Regras de plugin do Cursor (.mdc)
│   └── power.mdc
├── dev.kiro/                   # Namespace de extensão do Kiro
│   └── steering/power.md
├── .claude-plugin/             # Manifestos do Claude Code
│   ├── plugin.json             #   plugin
│   └── marketplace.json        #   marketplace (distribuição)
├── .mcp.json                   # MCP do Claude Code
├── LICENSE
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

## 🚀 Como Criar o seu Próprio Power a partir deste Template

### 1. Criar um Novo Repositório no GitHub
Use este diretório como base para criar seu novo repositório (ex: `engram-power-juridico`, `engram-power-marketing`, `engram-power-devops`).

### 2. Escolher o Slug do Domínio
Defina um slug curto em minúsculas (ex: `juridico`, `mkt`, `financas`, `rh`).

### 3. Renomear e Configurar
- **`plugin.json`** e **`.claude-plugin/plugin.json`**: defina `name` como `engram-power-{dominio}` e atualize `author`, `repository` e `homepage`.
- **`LICENSE`**: atualize o detentor do copyright.
- **`skills/`**: renomeie as pastas de `power-domain-*` para `power-{dominio}-*`, atualize o campo `name` no frontmatter de cada `SKILL.md` e **reescreva o `description`** — é ele que decide quando o assistente aciona a skill.
- **`agents/`**: renomeie `power-domain-specialist.md` para `power-{dominio}-specialist.md` e aponte para as skills renomeadas.
- **`power-config.yaml`**: declare as entidades e receitas de captura (`intake_recipes`) com os prefixos correspondentes.

### 4. Validar
```bash
claude plugin validate .
```

Teste local no Claude Code:
```bash
claude --plugin-dir .
```

### 5. Publicar
Envie para o GitHub. Qualquer assistente configurado com o Engram poderá carregar seu plugin sem riscos de colisão.
