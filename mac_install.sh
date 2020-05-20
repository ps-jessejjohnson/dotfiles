#!/bin/bash
echo ""
echo "Setting up linux dotfiles"
echo ""

# VARIABLES
# these variables are used if you execute the script with --silent
default_gitusername="Thorsten Hans"
default_gitemail="thorsten.hans@gmail.com"
default_codeexec="code"
default_configure_iterm="y"
default_install_code_extensions="n"
# END VARIABLES

silent_mode=1
if [[ "$1" == "--interactive" ]]
then
  echo -e "\033[36mRunning in interactive mode due to --interactive.\033[0m"
  silent_mode=0
fi

working_dir=$(pwd)
echo -e "\033[35mLinking gitconfig and global gitignore\033[0m"

# link git stuff
ln -sfv "${working_dir}/git/gitconfig" "${HOME}/.gitconfig" > /dev/null
ln -sfv "${working_dir}/git/gitignore" "${HOME}/.gitignore" > /dev/null
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
git clone https://github.com/zsh-users/zsh-autosuggestions.git zsh/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git zsh/plugins/zsh-syntax-highlighting > /dev/null
git clone https://github.com/bhilburn/powerlevel9k.git zsh/themes/powerlevel9k > /dev/null

echo "linking zsh stuff"
ln -sfv "${working_dir}/zsh/themes/powerlevel9k" "${HOME}/.oh-my-zsh/custom/themes/powerlevel9k" > /dev/null
ln -sfv "${working_dir}/zsh/plugins/zsh-autosuggestions" "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" > /dev/null
ln -sfv "${working_dir}/zsh/plugins/zsh-syntax-highlighting" "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" > /dev/null
ln -sfv "${working_dir}/zsh/zshrc.zsh" "${HOME}/.zshrc" > /dev/null
echo -e "\033[92mZSH configured\033[0m"
echo ""

# link misc stuff
echo -e '\033[35mLinking: npmrc, angular stuff and editorconfig\033[0m'
ln -sfv "${working_dir}/npmrc" "${HOME}/.npmrc" > /dev/null
ln -sfv "${working_dir}/angular/angular-cli.json" "${HOME}/.angular-cli.json" > /dev/null
ln -sfv "${working_dir}/angular/angular-config.json" "${HOME}/.angular-config.json" > /dev/null
ln -sfv "${working_dir}/editorconfig" "${HOME}/.editorconfig" > /dev/null
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
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${working_dir}/iterm"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
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

codefolder_location="${HOME}/Library/Application Support"
codefolder_name=""

if [[ ${codeexec} == 'code' ]]
then
    codefolder_name="Code"
else
    codeexec="code-insiders"
    codefolder_name="Code - Insiders"
fi

mkdir -p "${codefolder_location}/${codefolder_name}"
userfolder="${codefolder_location}/${codefolder_name}/User"

if [[ -d "${userfolder}" ]]
then
    echo "user folder exists, will remove it"

    rm -rf "${userfolder}"
fi
cd "${codefolder_location}/${codefolder_name}"
ln -sfv "${working_dir}/vscode/User" User > /dev/null
cd "${working_dir}"

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
    echo -e "\033[34mInstalling Extensions ...\033[0m"
    cat "${working_dir}/vscode/.extensions" | xargs -I {} ${codeexec} --install-extension {}
fi
echo -e "\033[92mVSCode configured\033[0m"
echo ""
echo -e "\033[93mRemember to install your SSH Keys!!\033[0m"
echo ""
echo -e "\033[92mdotfiles installed\033[0m"
