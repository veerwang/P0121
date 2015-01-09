# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

ZSH_THEME="fletcherm"
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

#export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.25-3.b17.el6_6.i386/
#export JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.25-3.b17.el6_6.i386/jre

export JAVA_HOME=/usr/java/jdk1.7.0_71/
export JRE_HOME=/usr/java/jdk1.7.0_71/jre

export M2_HOME=/usr/local/apache-maven-3.0.5

export CLASSPATH=/usr/local/lib/antlrworks-1.5.jar:/usr/local/lib/antlr-3.4-complete.jar:/usr/local/lib/antlr-runtime-3.4.jar:/usr/local/lib/antlr.jar:$CLASSPATH

export PATH=$PATH:$HOME/bin:/usr/bin/:/usr/local/bin:/usr/local/sbin:/sbin/:/usr/sbin:/opt/skyeye/bin/:/opt/host/arm-wangwei-linux-gnueabi/bin:/opt/host/arm-kevin-linux-gnueabi/bin:/home/kevin/freetype/include/freetype2/:/opt/host/arm-1176-linux-gnueabi/bin:/opt/host/gcc-arm-none-eabi-4_7-2013q3/bin/:/opt/host/gcc-linaro/bin/:$M2_HOME/bin:$JAVA_HOME/bin:$JRE_HOME/bin

export LD_LIBRARY_PATH=nn/home/kevin/library_tools_game_repository/llvm/lib/:/usr/local/lib:/lib:/usr/lib:/opt/spb16/tools.lnx86/lib:/opt/spb16/tools.lnx86/mainwin520/mw/lib-linux_optimized/:/home/kevin/armworkcopy/Venture_Game/lib_x86/lib

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# export TERM=xterm-256color

# Customize to your needs...
alias gr='cd ~/armworkcopy/Ruby/'
alias gs='cd ~/armworkcopy/git_Smart/Smart'
alias gc='cd ~/armworkcopy/git_CurrentProject/CurrentProject'
alias g6='cd ~/armworkcopy/git_ECT6000/ECT6000/'
alias gdft='cd ~/armworkcopy/DFT_Test/'
alias gp='cd ~/work_old/P0711Python/'
alias gv='cd ~/armworkcopy/Venture_Game'

alias ge='cd ~/library_tools_game_repository/elementary_library/src_git/library-src-repository/'
alias tool='~/library_tools_game_repository'

alias um='umount /media/KINGSTON/'

alias odn='sudo ifup /etc/sysconfig/network-scripts/ifcfg-ARM_调试网络'
alias cdn='sudo ifdown /etc/sysconfig/network-scripts/ifcfg-ARM_调试网络'

alias onn='sudo ifup /etc/sysconfig/network-scripts/ifcfg-eth0'
alias cnn='sudo ifdown /etc/sysconfig/network-scripts/ifcfg-eth0'

alias config='vim ~/.zshrc' 

hash -d  armgcc='/opt/host/arm-kevin-linux-gnueabi/bin/'

alias ccheck='~/bin/cppcheck --enable=all --library=std,posix'

# trash-cli tools command used
alias trm=trash-put
alias tl=trash-list
alias ts=trash-restore
alias tclean=trash-empty
alias rm!="/bin/rm -vi"
alias rm=trash

alias t=todo.sh

echo " Welcom to The Programer Home "
echo
echo  " ¤╭⌒╮ ╭⌒╮"
echo  "╱◥████████◣ ╭╭ ⌒╮"
echo "︱田︱田 田|╰------"
echo "╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬"
echo
echo

#source ~/library_tools_game_repository/incr-0.2.zsh

source ~/library_tools_game_repository/z/z.sh

        function powerline_precmd() {
          export PS1="$(~/.powerline-shell.py $? --shell zsh 2> /dev/null)"
        }

        function install_powerline_precmd() {
          for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
              return
            fi
          done
          precmd_functions+=(powerline_precmd)
        }

#install_powerline_precmd
