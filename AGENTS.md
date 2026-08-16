# Engram Power — Agent Guidelines

Este repositório é um **Engram Power**: um pacote de skills, subagente e ontologia que fornece capacidades especializadas de análise e captura para bases cognitivas e vaults Obsidian.

Segue o padrão [Agent Plugins 1.0](https://agent-plugins.org/). Este arquivo é a instrução cross-tool lida por Antigravity, Codex, Cursor e Claude Code.

## Padrão de Nomenclatura Anti-Colisão
Todas as skills deste plugin utilizam o prefixo namespaced `power-{dominio}-{acao}` para garantir que múltiplos poderes possam ser instalados no mesmo ambiente sem sobreposição.

## Diretrizes de Operação
- Execute as skills especializadas em `skills/`:
  - `skills/power-domain-analyze`: diagnósticos e análises de domínio.
  - `skills/power-domain-capture`: materialização de notas atômicas com frontmatter.
- Respeite as entidades e receitas declaradas em `power-config.yaml`.
- Toda nota nova deve ter frontmatter YAML e wikilinks bidirecionais, em `kebab-case`.
- Nunca crie estruturas desconectadas do grafo: conecte sempre às entidades já existentes no vault (clientes, projetos, reuniões).
