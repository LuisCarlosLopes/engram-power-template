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

## O que cada provedor exige para publicar

O conceito de "marketplace" **não é o mesmo** entre clientes. Só o Claude Code exige um arquivo de catálogo no repositório:

| Provedor | Precisa de catálogo no repo? | Como se publica |
|---|---|---|
| **Claude Code** (auto-hospedado) | ✅ `.claude-plugin/marketplace.json` | `claude plugin marketplace add owner/repo` |
| **Claude Code** (community) | ❌ | Formulário de submissão; a Anthropic fixa o commit no catálogo dela |
| **Cursor** | ❌ para plugin único (`.cursor-plugin/marketplace.json` só p/ monorepo) | Submeter o repo em `cursor.com/marketplace/publish` — revisão manual, precisa ser open source |
| **Kiro Powers** | ❌ | `plugin.json` na raiz basta; instala do marketplace ou direto do GitHub |
| **GitHub Copilot** | ❌ | Não há marketplace: as instruções valem por repositório |
| **Codex / OpenAI** | ⚠️ não confirmado | O repo `openai/plugins` indica `.codex-plugin/plugin.json`; não achei doc que diga se o `plugin.json` da raiz basta |

> [!IMPORTANT]
> **Não apague o `.claude-plugin/marketplace.json`.** Sem ele, o diálogo *Adicionar
> marketplace* do Claude Code responde *"Este repositório não é um marketplace — nenhum
> manifest encontrado em .claude-plugin/marketplace.json"*. É o erro mais provável ao
> publicar um Power gerado a partir deste template.

## Alvos de validação

Com um `marketplace.json` presente, `claude plugin validate .` valida **só o marketplace** e devolve exit 0 sem checar o plugin. Rode os dois alvos:

```bash
claude plugin validate . --strict
```

```bash
claude plugin validate ./.claude-plugin/plugin.json --strict
```

Ambos devem terminar com `✔ Validation passed`. Para o núcleo Agent Plugins, valide `plugin.json` e `mcp.json` contra os schemas em `https://agent-plugins.org/schemas/1.0.0/`.

## Nomenclatura Anti-Colisão

- Subagente: `power-{dominio}-specialist` (em `agents/`).
- Skills: `power-{dominio}-{acao}` (em `skills/power-domain-analyze` e `skills/power-domain-capture`).

Como plugin instalado no Claude Code, as skills ficam namespaced como `/{plugin-name}:power-{dominio}-analyze`.

> [!WARNING]
> **Ponto não documentado.** O subagente em `agents/` declara `skills: [power-domain-analyze, power-domain-capture]`
> com nomes nus. A documentação do Claude Code só exemplifica esse campo com skills de
> escopo project/user e **não define** se skills vindas de um plugin precisam do prefixo
> `{plugin-name}:`. O carregamento do plugin foi verificado (`claude --plugin-dir .`
> descobre subagente e as duas skills), mas o *preload* em si não foi confirmado.
>
> Se o subagente do seu Power não vier com as skills já em contexto, tente o nome
> namespaced ou remova o campo — ele é opcional e controla apenas o preload, não o
> acesso: sem ele o subagente ainda invoca as skills pela ferramenta Skill.

## Regras ao editar o template

- **Não crie um `CLAUDE.md` na raiz** — reintroduz o aviso de validação.
- **Mantenha os placeholders como placeholders.** `SEU-USUARIO`, `SEU-NOME-OU-EMPRESA` e `dominio` são intencionais: trocá-los por valores reais faz todo fork nascer com a identidade errada. É o `scripts/init-power.sh` que os resolve, no momento do fork.
- **Ao mexer no `init-power.sh`, teste numa cópia descartável.** Ele faz `git mv` e `perl -pi` em massa; um regex frouxo corrompe a prosa. A substituição de `Dominio` é deliberadamente sem acento, para não tocar em "Domínio" no texto corrido.
- `plugin.json` e `.claude-plugin/plugin.json` devem ficar em sincronia nos campos comuns.
- O `description` de cada `SKILL.md` decide o roteamento do assistente: descreva *quando acionar*, não como editar o template.
- Ao renomear as skills, atualize também `agents/`, `rules/`, `.cursor/rules/`, `.agents/rules/`, `.github/instructions/` e `dev.kiro/steering/`.
