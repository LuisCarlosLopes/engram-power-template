---
name: power-domain-analyze
description: >
  Executa análise técnica profunda de um problema ou documento conforme as melhores
  práticas deste Engram Power. Substitua 'domain' pelo slug do seu domínio (ex: power-juridico-analisar, power-tributario-auditar).
---

# power-{dominio}-analyze — Análise Especializada de Domínio

> [!NOTE]
> **Convenção de Nomenclatura (Anti-Colisão)**:
> Mantenha o padrão `power-{dominio}-{acao}` no `name` do frontmatter e no nome da pasta da skill para evitar conflitos com outros plugins instalados simultaneamente.

Esta skill avalia dados de entrada ou documentos e produz um parecer estruturado pronto para ser arquivado ou deliberado.

## Fluxo de Execução

1. **Leitura e Contexto**:
   - Identifique a questão central ou documento a ser analisado.
   - Verifique se existem notas relacionadas no vault do usuário (clientes, projetos, regras anteriores).

2. **Diagnóstico Estruturado**:
   - Avalie os pontos fortes, vulnerabilidades e conformidades.
   - Aplique as regras de ouro definidas em `power-config.yaml`.

3. **Recomendações e Próximos Passos**:
   - Forneça ações práticas numeradas com critérios de sucesso.
   - Indique se a análise deve ser arquivada via `power-{dominio}-capture`.
