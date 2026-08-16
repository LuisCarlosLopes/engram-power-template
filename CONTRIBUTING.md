# Contribuindo com este Engram Power

Este repositório é um **Engram Power**: um pacote de skills, subagente e ontologia para bases cognitivas / vaults Obsidian.

> [!NOTE]
> Este arquivo se chamava `CLAUDE.md`. Foi renomeado porque um `CLAUDE.md` na raiz de
> um plugin não é carregado como contexto de projeto pelo Claude Code e reprova em
> `claude plugin validate --strict`, bloqueando pipelines de CI. Como documentação de
> contribuição, o conteúdo continua valendo — só não é mais auto-carregado.

## Onde cada cliente lê o quê

O núcleo portátil (`plugin.json`, `skills/`, `mcp.json`) segue o padrão [Agent Plugins 1.0](https://agent-plugins.org/). O Claude Code **não implementa esse padrão** — ele carrega este repositório pelo seu próprio formato de plugin, declarado em paralelo:

| Componente | Caminho lido pelo Claude Code |
|---|---|
| Manifesto do plugin | `.claude-plugin/plugin.json` |
| Manifesto do marketplace | `.claude-plugin/marketplace.json` |
| Skills | `skills/{nome}/SKILL.md` |
| Subagente | `agents/power-domain-specialist.md` |
| MCP | `.mcp.json` (com ponto) |

O `plugin.json` e o `mcp.json` da raiz existem para os clientes Agent Plugins (Codex, Cursor, Copilot, Kiro) e são ignorados pelo Claude Code. Ver a tabela completa de compatibilidade no [README](README.md#-compatibilidade-multi-assistente).

## Nomenclatura Anti-Colisão

- Subagente: `power-{dominio}-specialist` (em `agents/`).
- Skills: `power-{dominio}-{acao}` (em `skills/power-domain-analyze` e `skills/power-domain-capture`).

Como plugin instalado no Claude Code, as skills ficam namespaced como `/{plugin-name}:power-{dominio}-analyze`.

Respeite o contrato declarado em `power-config.yaml`.

## Testar localmente

```bash
claude --plugin-dir .
```

## Validar antes de publicar

O validador escolhe o `marketplace.json` quando ele existe. Rode os dois alvos:

```bash
claude plugin validate . --strict
```

```bash
claude plugin validate ./.claude-plugin/plugin.json --strict
```

Ambos devem terminar com `✔ Validation passed`. Para o núcleo Agent Plugins, valide `plugin.json` e `mcp.json` contra os schemas de `https://agent-plugins.org/schemas/1.0.0/`.

## Regras ao editar

- **Não crie um `CLAUDE.md` na raiz** — reintroduz o aviso de validação.
- Ao renomear as skills, atualize o campo `name` no frontmatter, o nome da pasta, e as referências em `agents/`, `rules/`, `.cursor/rules/`, `.agents/rules/`, `.github/instructions/` e `dev.kiro/steering/`.
- O `description` de cada `SKILL.md` é o que decide o roteamento do assistente: descreva *quando acionar*, não como editar o template.
