# Contribuindo com o Engram Power Template

Este repositório é um **template** para criar Engram Powers — não um plugin destinado a instalação. Ver o [README](README.md) para o fluxo de uso.

O que ele entrega é um **scaffold comprovadamente conforme**: manifestos válidos, caminhos corretos por cliente e placeholders explícitos. Quem faz fork herda essa corretude.

> [!NOTE]
> Este arquivo se chamava `CLAUDE.md`. Foi renomeado porque um `CLAUDE.md` na raiz de
> um plugin não é carregado como contexto de projeto pelo Claude Code e reprova em
> `claude plugin validate --strict`, bloqueando pipelines de CI.

## Onde cada cliente lê o quê

O núcleo portátil (`plugin.json`, `skills/`, `mcp.json`) segue o padrão [Agent Plugins 1.0](https://agent-plugins.org/). O Claude Code **não implementa esse padrão** — ele carrega o repositório pelo seu próprio formato, declarado em paralelo:

| Componente | Caminho lido pelo Claude Code |
|---|---|
| Manifesto do plugin | `.claude-plugin/plugin.json` |
| Manifesto do marketplace | `.claude-plugin/marketplace.json` (inativo aqui — ver abaixo) |
| Skills | `skills/{nome}/SKILL.md` |
| Subagente | `agents/power-domain-specialist.md` |
| MCP | `.mcp.json` (com ponto) |

O `plugin.json` e o `mcp.json` da raiz existem para os clientes Agent Plugins (Codex, Cursor, Copilot, Kiro) e são ignorados pelo Claude Code. Tabela completa no [README](README.md#-compatibilidade-multi-assistente).

## Por que o marketplace está desativado

O catálogo vive em `.claude-plugin/marketplace.json.example`, com o sufixo `.example` de propósito. Com um `marketplace.json` ativo, duas coisas indesejadas acontecem:

1. O template vira instalável — e quem instalasse receberia skills que não fazem nada.
2. `claude plugin validate .` passa a validar **só o marketplace** e devolve exit 0 sem checar o plugin, mascarando avisos.

Por isso, para validar o template, aponte para o manifesto do plugin explicitamente:

```bash
claude plugin validate ./.claude-plugin/plugin.json --strict
```

Deve terminar com `✔ Validation passed`. Para o núcleo Agent Plugins, valide `plugin.json` e `mcp.json` contra os schemas em `https://agent-plugins.org/schemas/1.0.0/`.

## Nomenclatura Anti-Colisão

- Subagente: `power-{dominio}-specialist` (em `agents/`).
- Skills: `power-{dominio}-{acao}` (em `skills/power-domain-analyze` e `skills/power-domain-capture`).

Como plugin instalado no Claude Code, as skills ficam namespaced como `/{plugin-name}:power-{dominio}-analyze`.

## Regras ao editar o template

- **Não crie um `CLAUDE.md` na raiz** — reintroduz o aviso de validação.
- **Não ative o `marketplace.json`** neste repositório — ele é o template, não um Power publicável.
- **Mantenha os placeholders como placeholders.** `SEU-USUARIO`, `SEU-NOME-OU-EMPRESA` e `dominio` são intencionais: trocá-los por valores reais faz todo fork nascer com a identidade errada.
- `plugin.json` e `.claude-plugin/plugin.json` devem ficar em sincronia nos campos comuns.
- O `description` de cada `SKILL.md` decide o roteamento do assistente: descreva *quando acionar*, não como editar o template.
- Ao renomear as skills, atualize também `agents/`, `rules/`, `.cursor/rules/`, `.agents/rules/`, `.github/instructions/` e `dev.kiro/steering/`.
