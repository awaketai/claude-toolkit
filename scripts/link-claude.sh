#!/usr/bin/env bash
# link-claude.sh — 每台机器一次性运行：把本仓库挂载到 Claude Code 的用户级目录
# 幂等：已存在的目标不会覆盖
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 新增 CLI home 在此数组追加即可
CLI_HOMES=("$HOME/.claude" "$HOME/.claude-glm")

linked=0
skipped=0

for home in "${CLI_HOMES[@]}"; do
  mkdir -p "$home"
  for target in skills commands; do
    link="$home/$target"
    if [ -e "$link" ] || [ -L "$link" ]; then
      skipped=$((skipped + 1))
    else
      ln -s "$REPO/$target" "$link"
      echo "  linked: $link -> $REPO/$target"
      linked=$((linked + 1))
    fi
  done
done

echo "✓ linked $linked, skipped $skipped"
