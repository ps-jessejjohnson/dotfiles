#!/bin/bash
echo ""
echo "Setting up dotfiles"
echo ""

# VARIABLES
# these variables are used if you execute the script with --silent
default_gitusername="Thorsten Hans"
default_gitemail="thorsten.hans@gmail.com"
default_codeexec="insiders"
default_configure_iterm="y"
default_install_code_extensions="y"
# END VARIABLES

silent_mode=0
if [[ "$1" == "--silent" ]]
then
  echo -e "\033[36mRunning in silent mode due to --silent.\033[0m"
  silent_mode=1
fi

cwd=$(pwd)
echo -e "\033[35mLinking gitconfig and global gitignore\033[0m"

# link git stuff
ln -sfv "${cwd}/git/gitconfig" "${HOME}/.gitconfig" > /dev/null
ln -sfv "${cwd}/git/gitignore" "${HOME}/.gitignore" > /dev/null
if [[ ${silent_mode} == 0 ]]
then
    read -p 'Git Username: ' gitusername
    read -p 'Git Email: ' gitemail
else
    gitusername=${default_gitusername}
    gitemail=${default_gitemail}
fi

git config --global user.name "${gitusername}"
git config --global user.email "${gitemail}"

echo -e "Linked git stuff and configured username to \033[92m'${gitusername}'\033[0m and mail to \033[92m'${gitemail}'\033[0m"
echo -e "\033[92mgit configured\033[0m"
echo ""

# link zsh stuff
echo -e '\033[35mConfiguring ZSH\033[0m'
echo "cloning plugins (auto-suggestions and syntax-highlighting)..."
git clone git@github.com:zsh-users/zsh-autosuggestions.git zsh/plugins/zsh-autosuggestions > /dev/null
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git zsh/plugins/zsh-syntax-highlighting > /dev/null
git clone git@github.com:bhilburn/powerlevel9k.git zsh/themes/powerlevel9k > /dev/null

echo "linking zsh stuff"
ln -sfv "${cwd}/zsh/themes/powerlevel9k" "${HOME}/.oh-my-zsh/custom/themes/powerlevel9k" > /dev/null
ln -sfv "${cwd}/zsh/plugins/zsh-autosuggestions" "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" > /dev/null
ln -sfv "${cwd}/zsh/plugins/zsh-syntax-highlighting" "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" > /dev/null
ln -sfv "${cwd}/zsh/zshrc.zsh" "${HOME}/.zshrc" > /dev/null
echo -e "\033[92mZSH configured\033[0m"
echo ""

# link misc stuff
echo -e '\033[35mLinking: npmrc, angular stuff and editorconfig\033[0m'
ln -sfv "${cwd}/npmrc" "${HOME}/.npmrc" > /dev/null
ln -sfv "${cwd}/angular/angular-cli.json" "${HOME}/.angular-cli.json" > /dev/null
ln -sfv "${cwd}/angular/angular-config.json" "${HOME}/.angular-config.json" > /dev/null
ln -sfv "${cwd}/editorconfig" "${HOME}/.editorconfig" > /dev/null
echo -e "\033[92mLined: npmrc, angular stuff and editorconfig\033[0m"
echo ""

# iTerm
echo -e '\033[35mConfiguring iTerm2\033[0m'
if [[ ${silent_mode} == 0 ]]
then
    echo 'Do you want to configure iTerm2?'
    read -p '[y]es or [n]o: ' configure_iterm
else
    configure_iterm=${default_configure_iterm}
fi
if [[ ${configure_iterm} == 'y' ]]
then
    if [[ $OSTYPE == darwin* ]]
    then
        defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${cwd}/iterm"
        defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    fi
    echo -e "\033[92miTerm2 configured\033[0m"
fi
echo ""

# vscode
echo -e '\033[35mLinking VSCode / VSCode Insiders stuff\033[0m'
echo ''
echo 'Are you using VSCode or VSCode Insiders? (code for VSCode / insiders for VSCode Insiders)'
if [[ ${silent_mode} == 0 ]]
then
    read -p 'code or insiders: ' codeexec
else
    codeexec=${default_codeexec}
fi

codefolder_location=""
codeexec=""
codefolder_name=""
if [[ ${codeexec} == 'code' ]]
then
    codeexec="code"
    codefolder_name="Code"
else
    codeexec="code-insiders"
    codefolder_name="Code\ -\ Insiders"
fi
if [[ $OSTYPE == darwin* ]]
then
    codefolder_location="${HOME}/Library/Application\ Support"
else
    codefolder_location="${HOME}/.config"
fi
mkdir -p "${codefolder_location}/${codefolder_name}"
if [[ -d "${codefolder_location}/${codefolder_name}/User" ]]
then
    rm -rf "${codefolder_location}/${codefolder_name}/User"
fi
ln -sfv "${cwd}/vscode/User" "${codefolder_location}/${codefolder_name}/User" > /dev/null

if [[ ${silent_mode} == 0 ]]
then
    echo ""
    echo 'Is either VSCode or VSCode Insiders installed on your machine?'
    echo 'If so, extensions will be installed now, if not, you can re-run the script once installed!'
    read -p '[y]es or [n]o: ' install_code_extensions
    echo ""
else
    install_code_extensions=${default_install_code_extensions}
fi
if [[ ${install_code_extensions} == 'y' ]]
then
    echo -e '\033[34mInstalling Extensions ...\033[0m'
    cat ./vscode/.extensions | xargs -I {} ${codeexec} --install-extension {} > /dev/null
fi
echo -e "\033[92mVSCode configured\033[0m"
echo ""
echo -e "\033[93mRemember to install your SSH Keys!!\033[0m"
echo ""
echo -e "\033[92mdotfiles installed\033[0m"
