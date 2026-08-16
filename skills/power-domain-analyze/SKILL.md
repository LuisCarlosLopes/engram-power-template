---
name: power-domain-analyze
description: >
  Executa análise técnica profunda de um problema, dado ou documento do domínio e
  produz um parecer estruturado com diagnóstico e recomendações acionáveis. Use quando
  o usuário pedir para analisar, auditar, diagnosticar ou emitir parecer sobre um caso
  do domínio, antes de arquivar o resultado no vault.
license: MIT
---

# power-{dominio}-analyze — Análise Especializada de Domínio

> [!NOTE]
> **Ao criar seu Power a partir deste template**: renomeie a pasta e o campo `name`
> para `power-{dominio}-analyze` (ex: `power-tributario-analyze`) e reescreva o
> `description` acima descrevendo *quando acionar* a skill no seu domínio — é esse
> texto que o assistente usa para decidir o roteamento.

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
