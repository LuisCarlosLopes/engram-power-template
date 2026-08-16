# Engram Power — Claude Code Guidelines

Este repositório é um **Engram Power (Agent Plugin 1.0)** para o Claude Code.

## Nomenclatura Anti-Colisão
- Subagente: `power-{dominio}-specialist` (em `.claude/agents/power-domain-specialist.md`).
- Skills: `power-{dominio}-{acao}` (em `skills/power-domain-analyze` e `skills/power-domain-capture`).

## Como Usar
- As skills em `skills/` executam diagnósticos técnicos (`power-domain-analyze`) e captura de notas atômicas (`power-domain-capture`).
- Respeite o contrato em `power-config.yaml`.
