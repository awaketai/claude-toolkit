#!/usr/bin/env bash
# link-agent-skills.sh — 把 ~/.agents/skills/ 下的 skill 软链进本仓库 skills/ 目录
# 幂等：已存在的目标（submodule 或旧软链）不会覆盖
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$HOME/.agents/skills"

if [ ! -d "$SRC" ]; then
  echo "⚠ $SRC 不存在。请先运行: npx skills add larksuite/cli -g -y"
  exit 1
fi

linked=0
skipped=0
for d in "$SRC"/*/; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  target="$REPO/skills/$name"
  if [ -e "$target" ]; then
    skipped=$((skipped + 1))
    continue
  fi
  ln -s "$d" "$target"
  echo "  linked: $name"
  linked=$((linked + 1))
done

echo "✓ linked $linked, skipped $skipped"
