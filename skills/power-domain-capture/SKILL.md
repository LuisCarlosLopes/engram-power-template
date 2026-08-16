---
name: power-domain-capture
description: >
  Captura e materializa notas estruturadas de domínio no vault Obsidian,
  garantindo frontmatter, links bidirecionais e atualização da MOC correspondente. Substitua 'domain' pelo slug do seu domínio.
---

# power-{dominio}-capture — Captura Estruturada de Domínio

> [!NOTE]
> **Convenção de Nomenclatura (Anti-Colisão)**:
> Mantenha o padrão `power-{dominio}-{acao}` no `name` do frontmatter e no nome da pasta da skill para evitar conflitos com outros plugins instalados simultaneamente.

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
