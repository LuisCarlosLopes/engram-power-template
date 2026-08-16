# Engram Power — Claude Code Guidelines

Este repositório é um **Engram Power**: um pacote de skills, subagente e ontologia para bases cognitivas / vaults Obsidian.

O núcleo portátil (`plugin.json`, `skills/`, `mcp.json`) segue o padrão [Agent Plugins 1.0](https://agent-plugins.org/). O Claude Code **não implementa esse padrão** — ele carrega este repositório pelo seu próprio formato de plugin, declarado em paralelo:

| Componente | Caminho lido pelo Claude Code |
|---|---|
| Manifesto | `.claude-plugin/plugin.json` |
| Skills | `skills/{nome}/SKILL.md` |
| Subagente | `agents/power-domain-specialist.md` |
| MCP | `.mcp.json` (com ponto) |

O `plugin.json` e o `mcp.json` da raiz existem para os clientes Agent Plugins (Codex, Cursor, Copilot, Kiro) e são ignorados pelo Claude Code.

## Nomenclatura Anti-Colisão
- Subagente: `power-{dominio}-specialist` (em `agents/`).
- Skills: `power-{dominio}-{acao}` (em `skills/power-domain-analyze` e `skills/power-domain-capture`).

Como plugin instalado, as skills ficam namespaced como `/{plugin-name}:power-{dominio}-analyze`.

## Como Usar
- As skills em `skills/` executam diagnósticos técnicos (`power-domain-analyze`) e captura de notas atômicas (`power-domain-capture`).
- Respeite o contrato em `power-config.yaml`.

## Testar localmente
```bash
claude --plugin-dir .
```

Validar o manifesto antes de distribuir:
```bash
claude plugin validate .
```
