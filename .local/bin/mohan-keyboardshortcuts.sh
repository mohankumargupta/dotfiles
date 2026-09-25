#!/bin/bash
set -euo pipefail

# --- Shortcut database (one place for all records) ---
# Each record is "<key combination>\t<description>". The tab lets the
# renderer align the LHS key and RHS description like Omarchy's own
# keybindings menu (<combo pads to a column> → <description>).
declare -A SHORTCUTS
SHORTCUTS["Neovim"]=$(cat << 'EOF'
LEADER  	 Space    
LEADER + qq 	Quit
Alt + j 	Move line up
Alt + k 	Move line down
gd 	Go to definition
CTRL + o 	go out from jump
CTRL + i 	go back to jump
LEADER + sj 	 jumplist 
LEADER + / 	Search
LOCALLEADER 	\	
EOF
)
SHORTCUTS["Visual Studio Code"]=$(cat << 'EOF'
Ctrl + Shift + P	Open Command Palette
Ctrl + P	Quick Open / Search Files
Ctrl + K Ctrl + S	Keyboard Shortcuts Map
Alt + Shift + Down	Duplicate Current Line Below
Ctrl + H	Find and Replace Pane
Ctrl + `	Toggle Integrated Terminal
EOF
)

SHORTCUTS["Zed Editor"]=$(cat << 'EOF'
Cmd + Shift + P	Open Command Palette
Cmd + P	Project Search (File Finder)
Ctrl + K Ctrl + S	Open Keymap Configuration
Alt + Enter	Show Available Code Actions
Ctrl + `	Toggle Embedded Dock Panel
EOF
)

SHORTCUTS["System (Omarchy Shell)"]=$(cat << 'EOF'
Super + Space	Open Omarchy Main Menu
Super + K	System Keybindings Viewer
Super + Return	Launch Floating/Tiled Terminal
Super + W	Close Active Focused Window
Super + Escape	Summon System Power Menu
EOF
)

# --- Single renderer (eliminates the duplicated function bodies) ---
# Pads the key to the width of the longest combo + a gap, then appends the
# arrow so every description starts on the same RHS column — the Omarchy
# keybindings-menu look.
show_shortcuts() {
    local title="$1"
    local records="$2"
    local width
    width=$(awk -F '\t' 'length($1) > m { m = length($1) } END { printf "%d", m + 3 }' <<<"$records")
    echo "$records" | awk -F '\t' -v w="$width" '{ printf "%-*s → %s\n", w, $1, $2 }' \
        | omarchy-menu-select "$title" -- --width 750 --height 400
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
