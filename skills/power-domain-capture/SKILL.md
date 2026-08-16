---
name: power-domain-capture
description: >
  Materializa uma nota atômica de domínio no vault Obsidian, gerando o caminho pela
  receita de captura, aplicando o frontmatter YAML completo e conectando a nota à MOC
  e às entidades relacionadas via wikilinks. Use quando o usuário pedir para capturar,
  registrar, arquivar ou salvar um item, parecer ou análise do domínio no vault.
license: MIT
---

# power-{dominio}-capture — Captura Estruturada de Domínio

> [!NOTE]
> **Ao criar seu Power a partir deste template**: renomeie a pasta e o campo `name`
> para `power-{dominio}-capture` (ex: `power-tributario-capture`) e reescreva o
> `description` acima descrevendo *quando acionar* a skill no seu domínio — é esse
> texto que o assistente usa para decidir o roteamento.

Esta skill grava a nota atômica no diretório correto do vault e atualiza a MOC correspondente.

## Fluxo de Execução

1. **Geração do Slug e Caminho**:
   - Determine o caminho conforme a receita em `power-config.yaml` (ex: `Dominio/YYYY-MM/YYYY-MM-DD-titulo-em-kebab.md`).

2. **Formatação Atômica**:
   - Aplique o frontmatter YAML completo:
     ```yaml
     ---
     tipo: domain-item
     titulo: "Título Claro e Afirmativo"
     criado: YYYY-MM-DD
     atualizado: YYYY-MM-DD
     tags: [dominio, categoria]
     relacionado:
       - "[[MOC - Dominio]]"
     ---
     ```

3. **Conexão no Grafo**:
   - Adicione links bidirecionais para entidades contextuais (ex: `[[Cliente X]]`, `[[Projeto Y]]`).
   - Se for uma nota de destaque, referencie na MOC principal do domínio.
