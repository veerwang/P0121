# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

ZSH_THEME="fletcherm"
#ZSH_THEME="fino-time"
#ZSH_THEME="bira"
#ZSH_THEME="random"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git yum ruby rvm autojump)

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

source $ZSH/oh-my-zsh.sh

PATH=$PATH:$HOME/bin:/sbin/:/opt/skyeye/bin/:/usr/bin/:/opt/host/arm-wangwei-linux-gnueabi/bin:/opt/host/arm-kevin-linux-gnueabi/bin:/home/kevin/freetype/include/freetype2/:/opt/host/arm-1176-linux-gnueabi/bin:/opt/host/gcc-arm-none-eabi-4_7-2013q3/bin/

# Customize to your needs...
alias gr='cd ~/armworkcopy/Ruby/'
alias ge='cd ~/armworkcopy/git_ELSeries/ELSeries'
alias gs='cd ~/armworkcopy/git_Smart/Smart'
alias gc='cd ~/armworkcopy/git_CurrentProject/CurrentProject'
alias g6='cd ~/armworkcopy/git_ECT6000/ECT6000/'
alias gdft='cd ~/armworkcopy/DFT_Test/'
alias gp='cd ~/work_old/P0711Python/'

alias um='umount /media/KINGSTON/'

alias odn='sudo ifup /etc/sysconfig/network-scripts/ifcfg-ARM_调试网络'
alias cdn='sudo ifdown /etc/sysconfig/network-scripts/ifcfg-ARM_调试网络'

alias onn='sudo ifup /etc/sysconfig/network-scripts/ifcfg-eth0'
alias cnn='sudo ifdown /etc/sysconfig/network-scripts/ifcfg-eth0'

alias config='vim ~/.zshrc' 

hash -d  armgcc='/opt/host/arm-kevin-linux-gnueabi/bin/'

# trash-cli tools command used
alias trm=trash-put
alias tl=trash-list
alias ts=trash-restore
alias tclean=trash-empty

echo  \ \ \ \ \ \ \ ▂▃▅▆█ Hello, Coding Man █▆▅▃▂
echo  \ \ \ \ \ Welcome to your personal terminal!!
echo  \ \ \ \ \ \ \ \ \ \ Have fun with it!
source ~/env_tools_repository/z/z.sh
