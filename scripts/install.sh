#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
config_home="${XDG_CONFIG_HOME:-${HOME:?HOME is not set}/.config}"
target_root="$config_home/nvim"

if [[ ! -f "$target_root/init.lua" || ! -d "$target_root/lua/plugins" ]]; then
  printf 'Error: a LazyVim configuration was not found at %s\n' "$target_root" >&2
  printf 'Install LazyVim first; this project only adds 42-specific settings.\n' >&2
  exit 1
fi

files=(
  'after/ftplugin/c.lua'
  'lua/plugins/42-header.lua'
  'lua/plugins/42-format.lua'
  'lua/plugins/42-no-ai.lua'
)

# Preflight every target so a conflict cannot cause a partial installation.
for relative in "${files[@]}"; do
  source_file="$repo_root/nvim/$relative"
  target_file="$target_root/$relative"
  if [[ -e "$target_file" && ! -f "$target_file" ]]; then
    printf 'Error: target exists but is not a regular file: %s\n' "$target_file" >&2
    exit 1
  fi
  if [[ -f "$target_file" ]] && ! cmp -s -- "$source_file" "$target_file"; then
    printf 'Error: would overwrite an existing config: %s\n' "$target_file" >&2
    printf 'Compare it and merge manually; nothing was installed.\n' >&2
    exit 1
  fi
done

for relative in "${files[@]}"; do
  source_file="$repo_root/nvim/$relative"
  target_file="$target_root/$relative"
  if [[ -f "$target_file" ]]; then
    printf 'Already installed: %s\n' "$relative"
  else
    install -Dm644 -- "$source_file" "$target_file"
    printf 'Installed: %s\n' "$relative"
  fi
done

printf '\nRestart Neovim and run :Lazy sync.\n'
printf 'Set FT42_LOGIN and FT42_EMAIL before using :Stdheader.\n'
