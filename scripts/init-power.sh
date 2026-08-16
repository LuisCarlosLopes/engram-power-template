#!/usr/bin/env bash
#
# init-power.sh — personaliza este template para um domínio específico.
#
# Uso:
#   ./scripts/init-power.sh <dominio> <usuario-github> "<Nome ou Empresa>"
#
# Exemplo:
#   ./scripts/init-power.sh marketing LuisCarlosLopes "Luis Carlos Lopes Jr."
#
# Renomeia skills/subagente e substitui todos os placeholders mecânicos.
# NÃO reescreve prosa: os `description` das skills e o README continuam sendo
# trabalho seu — e são a parte que mais importa.

set -euo pipefail

if [ $# -lt 3 ]; then
  sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'
  exit 1
fi

DOMAIN="$1"
GH_USER="$2"
AUTHOR="$3"

if ! printf '%s' "$DOMAIN" | grep -qE '^[a-z][a-z0-9-]*$'; then
  echo "erro: o slug do domínio deve ser minúsculo, começar com letra e conter apenas [a-z0-9-]" >&2
  echo "      recebido: '$DOMAIN'" >&2
  exit 1
fi

cd "$(dirname "$0")/.."

if [ ! -f .claude-plugin/plugin.json ]; then
  echo "erro: rode a partir do repositório do Engram Power (não encontrei .claude-plugin/plugin.json)" >&2
  exit 1
fi

if [ ! -d skills/power-domain-analyze ]; then
  echo "erro: este template já parece ter sido personalizado (skills/power-domain-analyze não existe)" >&2
  exit 1
fi

# Capitalização portátil (bash 3.2 do macOS não tem ${var^})
CAP="$(printf '%s' "$DOMAIN" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')"

echo "→ domínio ......: $DOMAIN"
echo "→ usuário ......: $GH_USER"
echo "→ autor ........: $AUTHOR"
echo

echo "1/3 renomeando componentes"
git mv skills/power-domain-analyze  "skills/power-${DOMAIN}-analyze"
git mv skills/power-domain-capture  "skills/power-${DOMAIN}-capture"
git mv agents/power-domain-specialist.md "agents/power-${DOMAIN}-specialist.md"

echo "2/3 substituindo placeholders"
FILES="$(find . \
  -path ./.git -prune -o \
  -path ./scripts -prune -o \
  -type f \( -name '*.json' -o -name '*.md' -o -name '*.mdc' -o -name '*.yaml' \) -print)"

# shellcheck disable=SC2086
DOMAIN="$DOMAIN" CAP="$CAP" GH_USER="$GH_USER" AUTHOR="$AUTHOR" \
perl -pi -e '
  s/power-domain-/power-$ENV{DOMAIN}-/g;
  s/engram-power-(dominio|template)/engram-power-$ENV{DOMAIN}/g;
  s/SEU-USUARIO/$ENV{GH_USER}/g;
  s/SEU-NOME-OU-EMPRESA/$ENV{AUTHOR}/g;
  s/\bDominio\b/$ENV{CAP}/g;
' $FILES

echo "3/3 validando"
if command -v claude >/dev/null 2>&1; then
  claude plugin validate ./.claude-plugin/plugin.json --strict || true
  claude plugin validate . --strict || true
else
  echo "  (claude CLI não encontrado — pulei a validação)"
fi

cat <<EOF

✔ Scaffold personalizado para "$DOMAIN".

Ainda manual — e é o que mais importa:
  1. skills/power-${DOMAIN}-*/SKILL.md → reescreva o 'description'. É ele que decide
     quando o assistente aciona a skill. Genérico = nunca dispara ou dispara sempre.
  2. power-config.yaml → 'entities', 'intake_recipes' e 'design_rules' do seu domínio.
  3. README.md → descreva o seu Power, não o template.
  4. LICENSE → confirme o detentor do copyright.
  5. Remova este script: git rm -r scripts

EOF
