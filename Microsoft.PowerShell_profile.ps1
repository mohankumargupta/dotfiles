# edit from powershell with notepad $PROFILE

# Define cache file location
$FZF_CACHE_FILE = "$HOME\.fzf-index"

# 1. Function to manually Update/Build the index
function Update-FzfIndex {
    Write-Host "Rebuilding fzf index cache..." -ForegroundColor Cyan
    # Uses fd if installed, otherwise falls back to Get-ChildItem
    if (Get-Command fd -ErrorAction SilentlyContinue) {
        fd --type f --hidden --exclude .git --exclude .venv --exclude .gradle --exclude .pnpm . "$HOME\Developer" ${env:APPDATA}/.emacs.d > $FZF_CACHE_FILE
    } else {
        Get-ChildItem -Path $HOME -Recurse -File -ErrorAction SilentlyContinue | 
            Select-Object -ExpandProperty FullName > $FZF_CACHE_FILE
    }
    Write-Host "Index updated at $FZF_CACHE_FILE" -ForegroundColor Green
}

function f {
    if (Test-Path .\.fzf-index) {
        $file = Get-Content .\.fzf-index | fzf
        if ($file) { micro $file }
    } else {
        Write-Warning "No .fzf-index found in the current directory."
    }
}

