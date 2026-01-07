#!/bin/bash
python_path=$(grep "\$HOME/python" | sed -E 's/export PYTHONPATH=//g') < "$HOME/.dotfiles/.shellrc"

export PYTHONPATH="${python_path}:$PYTHONPATH"
export PATH="${PYTHONPATH}:${PATH}"

export TESTERONI=$(echo -e "\033[31m SOMETEST \033[0m")
