#!/bin/bash
echo ""
echo "Updating ZSH Plugins and Themes"
echo ""

cwd=$(pwd)
cd "${cwd}/zsh/plugins/zsh-autosuggestions"
git pull > /dev/null
cd "${cwd}/zsh/plugins/zsh-syntax-highlighting"
git pull > /dev/null
cd "${cwd}/zsh/themes/powerlevel9k"
git pull > /dev/null
cd $cwd
echo -e "\033[92mZSH Plugins and Themes updated\033[0m"
