#!/bin/zsh
GREEN='\033[32m'
RED='\033[31m'
RESET='\033[0m'

uv pip list --outdated | awk '{print $1}' | grep -oP "^[a-z0-9_]+(-?[a-z0-9]+)?" | xargs -d\\n uv pip install -U

function uvx_upgrade_all() {
    echo -e "$GREEN Updating uvx binaries $RESET"
    uv tool upgrade --all
}
function pipx_upgrade_all(){
    echo -e "$GREEN Updating pipx $RESET"
    pipx upgrade-all
}

pipx_upgrade_all
uvx_upgrade_all
