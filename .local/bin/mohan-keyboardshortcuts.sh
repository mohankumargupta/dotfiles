#!/bin/bash
set -euo pipefail

# --- Shortcut database (one place for all records) ---
declare -A SHORTCUTS
SHORTCUTS["Neovim"]=$(cat << 'EOF'
:%y Copy all to clipboard
EOF
)
SHORTCUTS["Visual Studio Code"]=$(cat << 'EOF'
Ctrl + Shift + P Open Command Palette
Ctrl + P Quick Open / Search Files
Ctrl + K Ctrl + S Keyboard Shortcuts Map
Alt + Shift + Down Duplicate Current Line Below
Ctrl + H Find and Replace Pane
Ctrl + ` Toggle Integrated Terminal
EOF
)

SHORTCUTS["Zed Editor"]=$(cat << 'EOF'
Cmd + Shift + P Open Command Palette
Cmd + P Project Search (File Finder)
Ctrl + K Ctrl + S Open Keymap Configuration
Alt + Enter Show Available Code Actions
Ctrl + ` Toggle Embedded Dock Panel
EOF
)

SHORTCUTS["System (Omarchy Shell)"]=$(cat << 'EOF'
Super + Space Open Omarchy Main Menu
Super + K System Keybindings Viewer
Super + Return Launch Floating/Tiled Terminal
Super + W Close Active Focused Window
Super + Escape Summon System Power Menu
EOF
)

# --- Single renderer (eliminates the duplicated function bodies) ---
show_shortcuts() {
    local title="$1"
    local records="$2"
    echo "$records" | omarchy-menu-select "$title" -- --width 750 --height 400
}

# --- Main entry logic (Stage 1 App Picker) ---
CATEGORIES=("Neovim" "Visual Studio Code" "Zed Editor" "System (Omarchy Shell)")
MAIN_SELECTION=$(printf "%s\n" "${CATEGORIES[@]}" | omarchy-menu-select "Select Application Context")

# Route to the matching category
for category in "${CATEGORIES[@]}"; do
    if [[ "$MAIN_SELECTION" == *"$category"* ]]; then
        show_shortcuts "$category" "${SHORTCUTS[$category]}"
        exit 0
    fi
done

exit 0
