# Engram Power — OpenAI / Codex Integration

Este repositório é um **Engram Power** compatível com [Agent Plugins 1.0](https://agent-plugins.org/), padrão co-autorado pela OpenAI. ChatGPT e Codex consomem o plugin diretamente pelo núcleo portátil:

| Componente | Caminho |
|---|---|
| Manifesto | `plugin.json` |
| Skills | `skills/{nome}/SKILL.md` |
| Servidores MCP | `mcp.json` |
| Instruções de workspace | `AGENTS.md` |

Não há adaptador dedicado: `AGENTS.md` é a convenção cross-tool que o Codex já lê, e as skills seguem o padrão [Agent Skills](https://agentskills.io/).

## Padrão de Skills
`power-{dominio}-{acao}` no diretório `skills/` — ver `README.md` para a tabela completa de namespacing.

> [!WARNING]
> Este template **não** inclui um adaptador para a Assistants API. Ela foi descontinuada
> pela OpenAI e é desligada em **26 de agosto de 2026**; o substituto é a
> [Responses API](https://developers.openai.com/api/docs/guides/migrate-to-responses).
> Se você precisar de um assistant hospedado, construa-o sobre a Responses API
> reaproveitando o conteúdo de `AGENTS.md` e das skills.
