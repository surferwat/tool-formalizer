#!/usr/bin/env bash
set -eu

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <tools-directory>" >&2
  exit 1
fi

tools_path="$1"

if [[ "$tools_path" == "~/"* ]]; then
  tools_path="$HOME/${tools_path#~/}"
fi

if [[ ! -d "$tools_path" ]]; then
  echo "Error: tools directory does not exist: $tools_path" >&2
  exit 1
fi

for config_file in "$ROOT/CLAUDE.md" "$ROOT/AGENTS.md"; do
  if [[ ! -f "$config_file" ]]; then
    echo "Error: missing config file: $config_file" >&2
    exit 1
  fi

  sed -i '' \
    -e "s|{{TOOLS_PATH}}|$tools_path|g" \
    "$config_file"
done

echo "TOOLS_PATH configured"