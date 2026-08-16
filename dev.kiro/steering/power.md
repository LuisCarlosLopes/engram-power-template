# Engram Power — Kiro Steering

1. **Spec de Domínio**: Toda a estrutura fornecida por este poder é governada por `power-config.yaml`.
2. **Ciclo de Tarefas**:
   - `power-{dominio}-analyze`: Realiza diagnóstico técnico a partir de dados fornecidos.
   - `power-{dominio}-capture`: Grava e conecta os registros no grafo de conhecimento.
3. **Atomicidade**: Garanta integridade de frontmatter e rastreabilidade nos wikilinks.
