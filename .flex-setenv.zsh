#!/usr/bin/env zsh

dev_root=$(dirname "$0:a:h");
app_root="${dev_root}/Applications"

npp_bin="${app_root}/Notepad++/notepad++.exe";

alias edit="${npp_bin}";
alias code="'${app_root}/Microsoft VS Code/bin/code'";

export DOCKER_HOST="tcp://localhost:2375";
echo "Thank you for choosing zsh!";
