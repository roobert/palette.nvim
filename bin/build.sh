#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
THEME_DIR="${DIR}/.."

THEME_NAME="${1}"
MAIN_PALETTE_NAME="${2:-dark}"
ACCENT_PALETTE_NAME="${3:-pastel}"
STATE_PALETTE_NAME="${4:-pastel}"

# Update the theme name/directories/import paths
mv -v ./colors/palette.lua "${THEME_DIR}/colors/${THEME_NAME}.lua"
mv -v ./lua/palette "${THEME_DIR}/lua/${THEME_NAME}"
find "${THEME_DIR}" -type f -name "*.lua" -exec sed -i '' -e "s/require(\"palette/require(\"${THEME_NAME}/g" {} \;

# Update the defaults so specifying them is not required when loading the theme
sed -i '' -e "s/vim.g.colors_name = \"palette\"/vim.g.colors_name = \"${THEME_NAME}\"/" "${THEME_DIR}/lua/${THEME_NAME}/init.lua"
sed -i '' -e "s/main = \"dark\"/main = \"${MAIN_PALETTE_NAME}\"/g" "${THEME_DIR}/lua/${THEME_NAME}/init.lua"
sed -i '' -e "s/accent = \"pastel\"/accent = \"${ACCENT_PALETTE_NAME}\"/g" "${THEME_DIR}/lua/${THEME_NAME}/init.lua"
sed -i '' -e "s/state = \"pastel\"/state = \"${STATE_PALETTE_NAME}\"/g" "${THEME_DIR}/lua/${THEME_NAME}/init.lua"

echo "# ${THEME_NAME}" >${THEME_DIR}/README.md
