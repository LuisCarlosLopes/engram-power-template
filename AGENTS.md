# Engram Power — Google Antigravity Guidelines

Este repositório é um **Engram Power (Agent Plugin 1.0)**. Ele fornece capacidades especializadas de análise e captura para serem consumidas por bases cognitivas Engram e assistentes Antigravity.

## Padrão de Nomenclatura Anti-Colisão
Todas as skills deste plugin utilizam o prefixo namespaced `power-{dominio}-{acao}` para garantir que múltiplos poderes possam ser instalados no mesmo ambiente sem sobreposição.

## Diretrizes de Operação
- Execute as skills especializadas em `skills/`:
  - `skills/power-domain-analyze`: Para realizar diagnósticos e análises de domínio.
  - `skills/power-domain-capture`: Para materializar notas estruturadas com frontmatter.
- Respeite as entidades e receitas declaradas em `power-config.yaml`.
