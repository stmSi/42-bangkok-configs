#!/usr/bin/env bash
set -euo pipefail

if (( $# == 0 )); then
  printf 'Usage: %s file.c [file2.c ...]\n' "${0##*/}" >&2
  exit 2
fi

for tool in cc norminette; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'Required tool is not installed: %s\n' "$tool" >&2
    exit 1
  fi
done

for source_file in "$@"; do
  if [[ ! -f "$source_file" || "$source_file" != *.c ]]; then
    printf 'Expected an existing .c file: %s\n' "$source_file" >&2
    exit 2
  fi
  # Protect command-line tools from filenames that begin with a dash.
  if [[ "$source_file" == -* ]]; then
    source_file="./$source_file"
  fi
  printf '\nChecking %s\n' "$source_file"
  # Compile to /dev/null: no main() needed and no .o file created.
  cc -Wall -Wextra -Werror -c -o /dev/null "$source_file"
  norminette "$source_file"
done
