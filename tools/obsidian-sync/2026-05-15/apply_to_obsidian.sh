#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_ROOT="/Users/rahul.shah/Documents/Codex/Dice Battler"
SYNC_DIR="${WORKSPACE_ROOT}/tools/obsidian-sync/2026-05-15"

OBSIDIAN_NOTE="/Users/rahul.shah/Documents/Obsidian Vault/Projects/Dice Battler.md"
OBSIDIAN_PROJECT_DIR="/Users/rahul.shah/Documents/Obsidian Vault/Projects/Dice Battler"
OBSIDIAN_OFFICIAL_DIR="${OBSIDIAN_PROJECT_DIR}"
OBSIDIAN_CURATED_DIR="${OBSIDIAN_PROJECT_DIR}/curated"

mkdir -p "${OBSIDIAN_OFFICIAL_DIR}" "${OBSIDIAN_CURATED_DIR}"

# Copy refreshed graph outputs
cp -f "${SYNC_DIR}/official/"* "${OBSIDIAN_OFFICIAL_DIR}/"
cp -f "${SYNC_DIR}/curated/"* "${OBSIDIAN_CURATED_DIR}/"

# Append dated sync entry to the project note (preserves prior entries)
mkdir -p "$(dirname "${OBSIDIAN_NOTE}")"
touch "${OBSIDIAN_NOTE}"
printf "\n" >> "${OBSIDIAN_NOTE}"
cat "${SYNC_DIR}/sync_entry.md" >> "${OBSIDIAN_NOTE}"

echo "Applied Dice Battler sync (2026-05-15) to Obsidian."

