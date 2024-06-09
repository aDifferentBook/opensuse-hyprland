#!/bin/bash
# clear
echo

####################################################
#
# Name      - ZSH-SETUP
# Version   - --
# Use       - Bash script to setup ZSH Shell
# Bugs      - ---
# Notes     - 1.
# Author    - aDifferentBook
# URL       - https://github.com/aDifferentBook
#
####################################################

# Colours
# 1. bold - Bold         # 2. dim - Dim or Dark
# 3. sitm - Italics      # 4. smul - Underlined
# 5. blink - Blinking    # 6. rev - Inverted or Reversed
# 7. invis - Invisible   # 8. smxx - Strike-through

# red=$(tput bold setaf 1)
green=$(tput bold setaf 2)
yellow=$(tput bold setaf 3)
# blue=$(tput bold setaf 14)
# magenta=$(tput bold setaf 5)
# cyan=$(tput bold setaf 6)
# white=$(tput bold setaf 7)
# white_dim=$(tput dim setaf 7)
normal=$(tput sgr0)

# Installing required packages
echo -e "${green}Installing ZSH shell -${normal}"
sudo dnf install -y git zsh wget powerline-fonts

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo -e "${yellow}Found old zsh installation directory${normal}"
    mv ~/.oh-my-zsh ~/.oh-my-zsh-old
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo
sleep 5

# Clonning plugins -
echo -e "${green}Installing ZSH plugins -${normal}"
echo
# 1. zsh-autosuggestions -
git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
echo

# 2. zsh-syntax-highlighting -
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
echo

# 3. zsh-history-substring-search -
git clone https://github.com/zsh-users/zsh-history-substring-search \
    "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-history-substring-search
echo

# 4. powerlevel10k theme -
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
echo

# 5. antidote -
git clone --depth=1 https://github.com/mattmc3/antidote.git \
    "${ZDOTDIR:-$HOME}"/.antidote
echo

# Adding git-completion support -
echo -e "${green}Installing git-completion -${normal}"
echo

# Download the scripts
if [[ ! -d ~/.git-autocompletion ]]; then
    echo -e "${green}Installing git-autocompletion -${normal}"
    mkdir -p ~/.git-autocompletion

    # shellcheck disable=SC2164
    cd ~/.git-autocompletion

    curl -o git-completion.bash \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

    curl -o _git \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
    echo

    # Changing permissions for ~/.git-completion
    sudo chown -R "$USERNAME":root ~/.git-autocompletion
    sudo chmod -R 755 ~/.git-autocompletion
else
    # Changing permissions for ~/.git-completion
    sudo chown -R "$USERNAME":root ~/.git-autocompletion
    sudo chmod -R 755 ~/.git-autocompletion
    echo
fi

# Regenerating zsh zdump files -
if [[ -f ~/.zcompdump ]]; then
    rm ~/.zcompdump*
fi

# shellcheck disable=SC1090
source ~/.zshrc

# ZSH as default shell -
echo -e "${green}Setting ZSH as default shell -${normal}"
chsh -s "$(which zsh)"
echo

echo -e "${green}Done...!${normal}"
echo
