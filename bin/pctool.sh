#! /bin/bash

PRODIR=`pwd`

CRETOPMAKEFILE()
{
	{
		echo "export PROJ     :="
		echo "export DEBUG    :="
		echo 'export EXEC     := main_$(PROJ)'
		echo '###########################################################'
		echo '#     Select which cross compiler tools to be used'
		echo '#     Selection: armv41,armv42,myarm or x86; '
		echo '#     default value is x86'
		echo 'export COMPILE  := myarm'
		echo 'ifeq ($(COMPILE),armv41)'
		echo '	CROSS := /opt/host/armv3l/bin/armv4l-unknown-linux-'
	        echo '	EXOBJS := etio-4.0.1.o'
		echo 'endif'
		echo 'ifeq ($(COMPILE),armv42)'
		echo '	CROSS := /opt/host/arm40_new/bin/arm-unknown-linux-gnu-'
		echo '	EXOBJS := etio-4.0.1.o'
		echo 'endif'
		echo 'ifeq ($(COMPILE),myarm)'
		echo '	CROSS := /opt/host/arm-kevin-linux-gnueabi/bin/arm-kevin-linux-gnueabi-'
		echo '	EXOBJS := etio-4.3.2.o'
		echo 'endif'
		echo 'ifeq ($(COMPILE),x86)'
		echo '	CROSS ?='
		echo 'endif'
		echo 'CROSS ?='
		echo '###########################################################'
		echo 'export MAKE_DIR := $(shell pwd)'
		echo 'export PARENTS_DIR := $(dir $(MAKE_DIR))'
		echo 'export DIR_NAME    := $(notdir $(MAKE_DIR))'
		echo 'export INST_DIR     := /media/disk/et/'
		echo 'export INST_NAME    := main '
		echo 'export EXOBJS'
		echo '###########################################################'
		echo 'export CROSS'
		echo 'export CC := $(CROSS)gcc'
		echo 'export CPP := $(CROSS)g++'
		echo 'export AS := $(CROSS)as'
		echo 'export RM := rm'
		echo 'export AR := $(CROSS)ar'
		echo 'export OBJCP := $(CROSS)objcopy'
		echo 'export STRIP := $(CROSS)strip'
		echo 'export FLAG := -Wall'
		echo 'export LIBS := pthread dl'
		echo '###########################################################'
		echo 'MAKEFLAG := -s -j2'
		echo '.PHONY : all'
		echo 'all:'
		echo 'ifeq ($(PROJ),)'
		echo '	$(make_msg)'
		echo 'else'
		echo '	@cd $(MAKE_DIR)/src;$(MAKE) $(MAKEFLAG) $(MAKECMDGOALS)'
		echo '	@cp $(MAKE_DIR)/src/$(PROJ)/$(EXEC) $(MAKE_DIR)/bin/$(EXEC)'
		echo 'ifeq ($(DEBUG),yes)' 
		echo 'else'
		echo '	@$(STRIP) $(MAKE_DIR)/bin/$(EXEC)'
		echo 'endif'
		echo '	@echo Copy the $(MAKE_DIR)/bin/$(EXEC) /tftpboot/$(EXEC)'
		echo '	@cp $(MAKE_DIR)/bin/$(EXEC) /tftpboot/$(EXEC)'
		echo '	@chmod +x /tftpboot/$(EXEC)'
		echo 'endif'
		echo '.PHONY : clean '
		echo 'clean:'
		echo '	@set -e;cd src;$(MAKE) $(MAKEFLAG) $(MAKECMDGOALS)'
		echo '	@$(RM) -f $(MAKE_DIR)/bin/$(EXEC)'
		echo '.PHONY : install '
		echo 'install: '
		echo '	@echo Copy  $(MAKE_DIR)/bin/$(EXEC) to $(INST_DIR)$(INST_NAME)'
		echo '	@cp $(MAKE_DIR)/bin/$(EXEC) $(INST_DIR)$(INST_NAME)'
		echo '.PHONY : tar '
		echo 'tar: '
		echo '	@echo tar the Smart serial project '
		echo '	@cd $(PARENTS_DIR);tar -cjf $(DIR_NAME).tar.bz2 $(DIR_NAME);cd $(MAKE_DIR) '
		echo '###########################################################'
		echo 'define make_msg'
		echo '@echo " "'
		echo '@echo Usage:'
		echo '@echo "        make PROJ=project COMPILE=tool DEBUG=yes/(others)"'
		echo '@echo "        make PROJ=project clean"'
		echo '@echo " "'
		echo 'endef'
	} > $1 
}

CREMIDMAKEFILE()
{
	{
		echo '.PHONY : all'
		echo 'all:'
		echo '	@echo Building $(PROJ) Project...'
		echo '	@cd $(MAKE_DIR)/src/$(PROJ);$(MAKE) $(MAKECMDGOALS)'
		echo '.PHONY : clean'
		echo 'clean:'
		echo '	@set -e;cd $(PROJ);$(MAKE) $(MAKECMDGOALS)'
	} > $1
}

CRESUBMAKEFILE()
{
	{
		echo 'TXTOBJS:=objs'
		echo 'TXTDEPS:=deps'
		echo 'OBJS_DIR:=./$(TXTOBJS)/'
		echo 'DEPS_DIR:=./$(TXTDEPS)/'
		echo 'SRCS:=$(wildcard *.cpp *.c *.s *.jpg)'
		echo 'OBJS:=$(SRCS:=.o)'
		echo 'DEPS:=$(SRCS:=.dep)'
		echo 'OBJS:=$(addprefix $(OBJS_DIR),$(OBJS))'
		echo 'DEPS:=$(addprefix $(DEPS_DIR),$(DEPS))'
		echo 'ifeq ($(DEBUG),yes)'
		echo 'COMPILE_FLAG = -g2'
		echo 'else'
		echo 'COMPILE_FLAG ='
		echo 'endif'
		echo 'all: $(DEPS) $(EXEC) '
		echo '$(DEPS_DIR)%.cpp.dep: %.cpp'
		echo '	@set -e; \'
		echo '	$(RM) -rf $@.tmp; \'
		echo '	gcc -E -MM $^ > $@.tmp; \'
		echo ' 	sed '\''s,\(.*\)\.o[ :]*,'\''$(TXTOBJS)'\''/\1.cpp.o:,g'\'' < $@.tmp > $@; \'
		echo '	$(RM) $@.tmp'
		echo '$(DEPS_DIR)%.c.dep: %.c'
		echo '	@set -e; \'
		echo '	$(RM) -rf $@.tmp; \'
		echo '	gcc -E -MM $^ > $@.tmp; \'
		echo ' 	sed '\''s,\(.*\)\.o[ :]*,'\''$(TXTOBJS)'\''/\1.c.o:,g'\'' < $@.tmp > $@; \'
		echo '	$(RM) $@.tmp'

		echo '$(DEPS_DIR)%.s.dep: %.s'
		echo '	@set -e; \'
		echo '	$(RM) -rf $@.tmp; \'
		echo '	echo $@ : $^ > $@.tmp; \'
		echo '	sed '\''s,\(.*\)\.s.dep[ :]*,\1.s.o:,g'\'' < $@.tmp > $@; \'
		echo ' 	sed '\''s/'\''$(TXTDEPS)/$(TXTOBJS)'\''/g'\'' < $@.tmp > $@; \'
		echo '	$(RM) $@.tmp'
		echo '$(DEPS_DIR)%.jpg.dep: %.jpg'
		echo '	@set -e; \'
		echo '	$(RM) -rf $@.tmp; \'
		echo '	echo $@ : $^ > $@.tmp; \'
		echo '	sed '\''s,\(.*\)\.jpg.dep[ :]*,\1.jpg.o:,g'\'' < $@.tmp > $@; \'
		echo ' 	sed '\''s/'\''$(TXTDEPS)/$(TXTOBJS)'\''/g'\'' < $@.tmp > $@; \'
		echo '	$(RM) $@.tmp'
		echo '-include $(DEPS)'
		echo '$(EXEC): $(OBJS)'
		echo '	$(CPP) $(FLAG) -o $@ $^ $(addprefix -l,$(LIBS))'
		echo '$(addprefix $(OBJS_DIR),%.s.o): %.s'
		echo '	$(AS) $< -o $@'
		echo '$(addprefix $(OBJS_DIR),%.c.o): %.c'
		echo '	$(CC) $(COMPILE_FLAG) -c $< -o $@'
		echo '$(addprefix $(OBJS_DIR),%.cpp.o): %.cpp'
		echo '	$(CPP) $(COMPILE_FLAG) -c $< -o $@'
		echo '$(addprefix $(OBJS_DIR),%.jpg.o): %.jpg'
		echo '	$(OBJCP) -I binary -O elf32-littlearm -B arm $< $@'
		echo '.PHONY: clean'
		echo 'clean:'
		echo '	$(RM) -rf $(addprefix $(OBJS_DIR),*.o) $(addprefix $(DEPS_DIR),*.dep) $(EXEC) '
	} > $1
}

USAGE()
{
	echo " "
	echo " the bash scripe used to create the work environment for program"
	echo " "
	echo "                                            	      by kevin"
	echo "Usage:"
	echo "      `basename $0` dir_name pro_name"
	echo " "
}

if [ -n "$1" ] && [ -n "$2" ]; then
	if [ -e "$PRODIR/$1" ]; then
		echo $PRODIR/$1 exist.
		exit
	else
		mkdir -p $PRODIR/$1/{bin,log,src}
		mkdir -p $PRODIR/$1/src/$2/{objs,deps}
		touch $PRODIR/$1/README
		CRETOPMAKEFILE $PRODIR/$1/Makefile $2
		CREMIDMAKEFILE $PRODIR/$1/src/Makefile
		CRESUBMAKEFILE $PRODIR/$1/src/$2/Makefile
	fi
else
	USAGE
	exit
fi
