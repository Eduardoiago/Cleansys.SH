#!/bin/bash

# --- CleanSYS LINUX (C) | Version 2.0.0
# --- Development by Iago
# Shell script para otimizar a limpeza do sistema linux baseado em FHS

if [ "$EUID" -ne 0 ]; then
    	echo -e "\e[1;31m[ERROR] Por favor, execute o script como root. \e[0m"
    	exit 1
fi

displayTitle() {
    echo " "
    echo -e "\n\e[1;32m                                .-=========="
    echo -e "                             .-' O    ====="
    echo -e "                            /___       ==="
    echo -e "                               \_      |"
    echo -e "    _____________________________)    (_____________________________"
    echo -e "    \___________               .'      '.              ____________/"
    echo -e "      \__________'.     |||<   '.      .'   >|||     .'__________/"
    echo -e "         \_________'._  |||  <   '-..-'   >  |||  _.'_________/"
    echo -e "               \___ CleanSYS LINUX (c) | Version 2.0.0 ___/"
    echo -e "                          - Development by Iago -\e[0m\n"
    echo " "
}

display_section() {
    echo -e "\e[1;32m[*]$1 \e[0m"
}
display_action() {
    echo -e "\e[1;33m[+]\e[0m$1"
}
display_result() {
    echo -e "\e[1;31m[REMOVED]\e[0m$1"
}

GREEN_C='\e[1;32m'
YELLOW_C='\e[1;33m'
RED_C='\e[1;31m'
END_C='\e[0m'

displayTitle
display_section "$GREEN_C CleanSYS LINUX (c) | Iniciando a limpeza do sistema $END_C"

display_section "$GREEN_C Limpando Cache e Pacotes Obsoletos do APT $END_C"
display_action "$YELLOW_C Executando apt clean $END_C"
sudo apt clean
display_action "$YELLOW_C Executando apt autoclean $END_C"
sudo apt autoclean
display_result "$RED_C /var/cache/apt/archives/* $END_C"
display_result "$RED_C Cache e Pacotes Obsoletos do APT foram deletados! $END_C"

display_section "$GREEN_C Limpeza de historys do terminal $END_C"
display_action "$YELLOW_C Realizando a limpeza do history $END_C"
display_action "$YELLOW_C Executando history -c $END_C"
history -c
display_action "$YELLOW_C Realizando a limpeza do Bash e Zsh -c $END_C"
cat /dev/null > /root/.bash_history
cat /dev/null > ~/.bash_history
cat /dev/null > ~/.zsh_history
display_result "$RED_C /root/.bash_history $END_C"
display_result "$RED_C ~/.bash_history $END_C"
display_result "$RED_C ~/.zsh_history $END_C"
display_section "$GREEN_C Limpeza do history do sistema realizado com sucesso! $END_C"

display_section "$GREEN_C Limpando Arquivos Temporários $END_C"
sudo rm -rf /tmp/*
display_result "$RED_C /tmp/* $END_C"
sudo rm -rf /var/tmp/*
display_result "$RED_C /var/tmp/* $END_C"

display_section "$GREEN_C Limpando Arquivos de Log do Sistema $END_C"
sudo journalctl --vacuum-time=7d
sudo rm -rf /var/log/*.log
display_result "$RED_C /var/log/*.log $END_C"
sudo rm -rf /var/log/journal/*
display_result "$RED_C /var/log/journal/* $END_C"

display_section "$GREEN_C Removendo Arquivos de Configuração Obsoletos $END_C"
sudo apt autoremove --purge -y
display_result "$RED_C Configurações antigas e pacotes obsoletos foram removidos! $END_C"

display_section "$GREEN_C Removendo Módulos de Kernel Antigos $END_C"
sudo apt autoremove -y
display_result "$RED_C Módulos de kernel antigos foram deletados! $END_C"

display_section "$GREEN_C Esvaziando arquivos e infos da Lixeira $END_C"
trash-list
trash-empty
display_result "$RED_C $HOME/.local/share/Trash/files/* $END_C"
display_result "$RED_C $HOME/.local/share/Trash/info/* $END_C"
display_result "$RED_C Arquivos e infos da Lixeira $END_C"

echo -e "\n$GREEN_C[COMPLETED] Limpeza do sistema finalizada com sucesso! $END_C \n"
