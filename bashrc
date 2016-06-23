# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

#./opt/spb16/env
export CDS_DIR=/opt/spb16
export CDS_ROOT=/opt/spb16
export CDS_INST_DIR=/opt/spb16
export CDS_INSTALL_DIR=/opt/spb16/tools/dfII
export CDS_Netlisting_Node=Analog
export LD_ASSUME_KERNEL=3.2.0
export CONCEPT_INST_DIR=$CDS_DIR
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export CDS_SITE=$CDS_DIR/share/local/
export LD_LIBRARY_PATH=/usr/local/lib:/lib:/usr/lib:/opt/spb16/tools.lnx86/lib:/opt/spb16/tools.lnx86/mainwin520/mw/lib-linux_optimized/:/opt/host/arm-kevin-linux-gnueabi/bin/
export CDSDOC_PROJECT=$CDS_INST_DIR/doc
export PATH=$PATH:$CDS_INST_DIR/tools.lnx86/jre/bin:$CDS_INST_DIR/tools.lnx86/bin:$CDS_INST_DIR/tools.lnx86/pcb/bin:$CDS_INST_DIR/tools.lnx86/fet/bin:$CDS_INST_DIR/tools.lnx86/specctra/bin/:$CDS_INST_DIR/tools.lnx86/plot/bin:$CDS_INST_DIR/stream_mgt/bin/:$CDS_INST_DIR/tools.lnx86/fet/concept/bin:$CDS_INST_DIR/tools.lnx86/dfII/bin:$CCDS_INST_DIR/tools.lnx86/spectre/bin
#export CDS_LIC_FILE=$CDS_DIR/share/license/license.dat
export CDS_LIC_FILE=/usr/local/flexlm/licenses/license.dat
#export CDS_LIC_FILE=27000@localhost.localdomain	                    #the port will differce depands on your settings in licensefile

PATH=$PATH:/home/kevin/bin

function _update_ps1() {
export PS1="$(~/.powerline-shell.py $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
