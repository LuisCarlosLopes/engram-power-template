# Engram Power Template — Agent Plugin 1.0

[![Agent Plugins 1.0](https://img.shields.io/badge/Agent%20Plugins-1.0-blue.svg)](https://agent-plugins.org/)
[![Multi-Client Ready](https://img.shields.io/badge/Support-OpenAI%20%7C%20Claude%20%7C%20Cursor%20%7C%20Antigravity%20%7C%20Kiro%20%7C%20Copilot-green.svg)](#compatibilidade-multi-assistente)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Template base para criação de **Engram Powers** (módulos de habilidades e ontologias especializadas) prontos para distribuição e consumo em qualquer base cognitiva ou vault Obsidian gerenciado por IA.

---

## 🛡️ Padrão Anti-Colisão (Namespacing)

Quando um usuário instala **vários Powers simultaneamente** (ex: um de Jurídico, um de Financeiro e um de Marketing), as IAs precisam distinguir claramente as ferramentas de cada plugin. 

Este template implementa o padrão de prefixos **`power-{dominio}-{acao}`**:

| Componente | Padrão Recomendado | Exemplo Real (Domínio: Tributário) |
|---|---|---|
| **Repositório** | `engram-power-{dominio}` | `engram-power-tributario` |
| **Plugin ID** (`plugin.json`) | `engram-power-{dominio}` | `engram-power-tributario` |
| **Subagente** (`agents/`) | `power-{dominio}-specialist` | `power-tributario-specialist` |
| **Skill de Análise** (`skills/`) | `power-{dominio}-analyze` | `power-tributario-auditar` |
| **Skill de Captura** (`skills/`) | `power-{dominio}-capture` | `power-tributario-salvar-tese` |
| **Chave de Entidade** (`power-config.yaml`) | `{dominio}_{entidade}` | `tributario_tese` |
| **Receita de Captura** (`intake_recipes`) | `{dominio}-{receita}` | `tributario-precedente` |

> [!TIP]
> **Por que usar esse padrão?**
> Se dois plugins diferentes criassem uma skill chamada `analyze` ou `capture`, os assistentes de IA sofreriam colisão de ferramentas (tool collision / shadowing). Com o prefixo `power-{dominio}-*`, múltiplos plugins coexistem em perfeita harmonia.

---

## 📁 Estrutura do Template

```text
engram-power-template/
├── plugin.json                 # Manifesto canônico Agent Plugins 1.0
├── mcp.json                    # Servidor MCP de Filesystem
├── power-config.yaml           # Ontologia e receitas com namespace
├── AGENTS.md                   # Diretrizes para Antigravity
├── CLAUDE.md                   # Diretrizes para Claude Code
├── OPENAI.md                   # Diretrizes para OpenAI
├── .cursorrules                # Regras para Cursor
├── agents/                     # Subagente especialista do poder
│   └── power-domain-specialist.md
├── skills/                     # Skills portáveis namespaced
│   ├── power-domain-analyze/   # Diagnóstico técnico de domínio
│   └── power-domain-capture/   # Captura e gravação de notas estruturadas
├── templates/                  # Templates de notas Markdown
│   └── domain-entity.md
├── .openai/                    # Adaptador OpenAI (Assistant + Instruções)
├── .claude/                    # Adaptador Claude Code
├── .cursor/                    # Adaptador Cursor IDE
├── .agents/                    # Adaptador Google Antigravity
├── .kiro/                      # Adaptador AWS Kiro
└── .github/                    # Adaptador GitHub Copilot
```

---

## 🚀 Como Criar o seu Próprio Power a partir deste Template

### 1. Criar um Novo Repositório no GitHub
Use este diretório como base para criar seu novo repositório (ex: `engram-power-juridico`, `engram-power-marketing`, `engram-power-devops`).

### 2. Escolher o Slug do Domínio
Defina um slug curto em minúsculas (ex: `juridico`, `mkt`, `financas`, `rh`).

### 3. Renomear e Configurar:
- **`plugin.json`**: Defina o `name` como `engram-power-{dominio}`.
- **`skills/`**: Renomeie as pastas de `power-domain-*` para `power-{dominio}-*` e atualize o campo `name` no frontmatter de cada `SKILL.md`.
- **`agents/`**: Renomeie `power-domain-specialist.md` para `power-{dominio}-specialist.md` e aponte para as skills renomeadas.
- **`power-config.yaml`**: Declare as entidades e receitas de captura rápida (`intake_recipes`) com os prefixos correspondentes.

### 4. Publicar e Usar
Envie para o GitHub. Qualquer assistente de IA configurado com o Engram poderá carregar seu plugin sem riscos de colisão!
