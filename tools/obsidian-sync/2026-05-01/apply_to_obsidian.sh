#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SYNC_DIR="${REPO_ROOT}/tools/obsidian-sync/2026-05-01"

VAULT_ROOT="/Users/rahul.shah/Documents/Obsidian Vault"
PROJECT_NOTE="${VAULT_ROOT}/Projects/Dice Battler.md"
PROJECT_DIR="${VAULT_ROOT}/Projects/Dice Battler"
CURATED_DIR="${PROJECT_DIR}/curated"

mkdir -p "${PROJECT_DIR}" "${CURATED_DIR}"

cp -a "${SYNC_DIR}/official/." "${PROJECT_DIR}/"
cp -a "${SYNC_DIR}/curated/." "${CURATED_DIR}/"

if [[ -f "${PROJECT_NOTE}" ]]; then
  printf "\n\n" >> "${PROJECT_NOTE}"
fi
cat "${SYNC_DIR}/sync_entry.md" >> "${PROJECT_NOTE}"

echo "Updated note: ${PROJECT_NOTE}"
echo "Copied official outputs → ${PROJECT_DIR}/"
echo "Copied curated outputs → ${CURATED_DIR}/"

