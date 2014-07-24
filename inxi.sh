#!/bin/bash
LANG=C
CMDL_MAX=''
COLOR_SCHEME=''
CPU_SLEEP='0.3' 
DEV_DISK_ID=''
DEV_DISK_LABEL=''
DEV_DISK_MAPPER=''
DEV_DISK_UUID=''
DMIDECODE_DATA=''
FILTER_STRING='<filter>'
IRC_CLIENT=''
IRC_CLIENT_VERSION=''
LINE_MAX=''
LINE_MAX_CONSOLE='115'
LINE_MAX_IRC='105'
PS_COUNT=5
PS_THROTTLED=''
REPO_DATA=''
A_ALSA_DATA=''
A_AUDIO_DATA=''
A_CMDL=''
A_CPU_CORE_DATA=''
A_CPU_DATA=''
A_CPU_TYPE_PCNT_CCNT=''
A_DEBUG_BUFFER=''
A_GCC_VERSIONS=''
A_GFX_CARD_DATA=''
A_GLX_DATA=''
A_GRAPHIC_DRIVERS=''
A_HDD_DATA=''
A_INTERFACES_DATA=''
A_MACHINE_DATA=''
A_NETWORK_DATA=''
A_OPTICAL_DRIVE_DATA=''
A_PARTITION_DATA=''
A_PS_DATA=''
A_RAID_DATA=''
A_SENSORS_DATA=''
A_UNMOUNTED_PARTITION_DATA=''
A_X_DATA=''
B_ALLOW_UPDATE='true'
B_BSD='false'
B_COLOR_SCHEME_SET='false'
B_CONSOLE_IRC='false'
B_CPU_FLAGS_FULL='false'
B_DBUS_CLIENT='false'
B_DCOP='false'
B_DEBUG_FLOOD='false'
B_DMIDECODE_SET='false'
B_EXTRA_DATA='false'
B_EXTRA_EXTRA_DATA='false'
B_ID_SET='false'
B_HANDLE_CORRUPT_DATA='false'
B_LABEL_SET='false'
B_LOG_COLORS='false'
B_LOG_FULL_DATA='false'
B_MAPPER_SET='false'
B_OUTPUT_FILTER='false'
B_OVERRIDE_FILTER='false'
B_QDBUS='false'
B_PORTABLE='false'
B_ROOT='false'
B_RUN_COLOR_SELECTOR='false'
B_RUNNING_IN_SHELL='false'
if tty >/dev/null;then
	B_RUNNING_IN_SHELL='true'
fi
B_SCRIPT_UP='false'
B_SHOW_ADVANCED_NETWORK='false'
B_SHOW_AUDIO='false'
B_SHOW_BASIC_RAID='false'
B_SHOW_BASIC_CPU='false'
B_SHOW_BASIC_DISK='false'
B_SHOW_BASIC_OPTICAL='false'
B_SHOW_CPU='false'
B_SHOW_DISK_TOTAL='false'
B_SHOW_DISK='false'
B_SHOW_FULL_HDD='false'
B_SHOW_FULL_OPTICAL='false'
B_SHOW_GRAPHICS='false'
B_SHOW_HOST='true'
B_SHOW_INFO='false'
B_SHOW_IP='false'
B_SHOW_LABELS='false'
B_SHOW_MACHINE='false'
B_SHOW_NETWORK='false'
B_SHOW_PARTITIONS='false'
B_SHOW_PARTITIONS_FULL='false'
B_SHOW_PS_CPU_DATA='false'
B_SHOW_PS_MEM_DATA='false'
B_SHOW_RAID='false'
B_SHOW_RAID_R='false' 
B_SHOW_REPOS='false'
B_RUNNING_IN_X='false'
B_SHOW_SENSORS='false'
B_SHOW_SHORT_OUTPUT='false'
B_SHOW_SYSTEM='false'
B_SHOW_UNMOUNTED_PARTITIONS='false'
B_SHOW_UUIDS='false'
B_SHOW_X_DATA='false'
B_TESTING_1='false'
B_TESTING_2='false'
B_UPLOAD_DEBUG_DATA='false'
B_USB_NETWORKING='false'
# set to true here for debug logging from script start
B_USE_LOGGING='false'
B_UUID_SET='false'
B_XORG_LOG='false'

### Directory/file exist flags; test as [[ $(boolean) ]] not [[ $boolean ]]
B_ASOUND_DEVICE_FILE='false'
B_ASOUND_VERSION_FILE='false'
B_BASH_ARRAY='false'
B_CPUINFO_FILE='false'
B_LSB_FILE='false'
B_MDSTAT_FILE='false'
B_MEMINFO_FILE='false'
B_MODULES_FILE='false' #
B_MOUNTS_FILE='false'
B_OS_RELEASE_FILE='false' # new default distro id file? will this one work where lsb-release didn't?
B_PARTITIONS_FILE='false' #
B_PROC_DIR='false'
B_SCSI_FILE='false'

### File's used when present
FILE_ASOUND_DEVICE='/proc/asound/cards'
FILE_ASOUND_MODULES='/proc/asound/modules' # not used but maybe for -A?
FILE_ASOUND_VERSION='/proc/asound/version'
FILE_CPUINFO='/proc/cpuinfo'
FILE_LSB_RELEASE='/etc/lsb-release'
FILE_MDSTAT='/proc/mdstat'
FILE_MEMINFO='/proc/meminfo'
FILE_MODULES='/proc/modules'
FILE_MOUNTS='/proc/mounts'
FILE_OS_RELEASE='/etc/os-release'
FILE_PARTITIONS='/proc/partitions'
FILE_SCSI='/proc/scsi/scsi'
FILE_XORG_LOG='/var/log/Xorg.0.log' # if not found, search and replace with actual location

## app tested for and present, to avoid repeat tests
B_FILE_TESTED='false'
B_HDDTEMP_TESTED='false'
B_MODINFO_TESTED='false'
B_SUDO_TESTED='false'
FILE_PATH=''
HDDTEMP_PATH=''
MODINFO_PATH=''
SUDO_PATH=''

### Variable initializations: constants
DCOPOBJ="default"
DEBUG=0 # Set debug levels from 1-10 (8-10 trigger logging levels)
# Debug Buffer Index, index into a debug buffer storing debug messages until inxi is 'all up'
DEBUG_BUFFER_INDEX=0
## note: the debugger rerouting to /dev/null has been moved to the end of the get_parameters function
## so -@[number] debug levels can be set if there is a failure, otherwise you can't even see the errors

# Defaults to 2, make this 1 for normal, 0 for no colorcodes at all. Use following variables in config 
# files to change defaults for each type, or global
# Same as runtime parameter.
DEFAULT_COLOR_SCHEME=2
# Always leave these blank, these are only going to be set in inxi.conf files, that makes testing
# for user changes easier after sourcing the files
GLOBAL_COLOR_SCHEME=''
IRC_COLOR_SCHEME=''
IRC_CONS_COLOR_SCHEME=''
IRC_X_TERM_COLOR_SCHEME=''
CONSOLE_COLOR_SCHEME=''
VIRT_TERM_COLOR_SCHEME=''

# Default indentation level
INDENT=10

# logging eval variables, start and end function: Insert to LOGFS LOGFE when debug level >= 8
LOGFS_STRING='log_function_data fs $FUNCNAME "$( echo $@ )"'
LOGFE_STRING='log_function_data fe $FUNCNAME'
LOGFS=''
LOGFE=''
# uncomment for debugging from script start
# LOGFS=$LOGFS_STRING
# LOGFE=$LOGFE_STRING

# default to false, no konversation found, 1 is native konvi (qt3/KDE3) script mode, 2 is /cmd inxi start,
##	3 is Konversation > 1.2 (qt4/KDE4) 
KONVI=0
# NO_CPU_COUNT=0	# Wether or not the string "dual" or similar is found in cpuinfo output. If so, avoid dups.
# This is a variable that controls how many parameters inxi will parse in a /proc/<pid>/cmdline file before stopping.
PARAMETER_LIMIT=30
SCHEME=0 # set default scheme - do not change this, it's set dynamically
# this is set in user prefs file, to override dynamic temp1/temp2 determination of sensors output in case
# cpu runs colder than mobo
SENSORS_CPU_NO=''
# SHOW_IRC=1 to avoid showing the irc client version number, or SHOW_IRC=0 to disable client information completely.
SHOW_IRC=2
# Verbosity level defaults to 0, this can also be set with -v0, -v2, -v3, etc as a parameter.
VERBOSITY_LEVEL=0
# Supported number of verbosity levels, including 0
VERBOSITY_LEVELS=7

# Clear nullglob, because it creates unpredictable situations with IFS=$'\n' ARR=($VAR) IFS="$ORIGINAL_IFS"
# type constructs. Stuff like [rev a1] is now seen as a glob expansion pattern, and fails, and
# therefore results in nothing.
shopt -u nullglob
## info on bash built in: $IFS - http://tldp.org/LDP/abs/html/internalvariables.html
# Backup the current Internal Field Separator
ORIGINAL_IFS="$IFS"

# These two determine separators in single line output, to force irc clients not to break off sections
SEP1='~'
SEP2=' '
# these will assign a separator to non irc states. Important! Using ':' can trigger stupid emoticon
# behaviors in output on IRC, so do not use those.
SEP3_IRC=''
SEP3_CONSOLE=':'
SEP3='' # do not set, will be set dynamically

### Script names/paths - must be non root writable
SCRIPT_DATA_DIR="$HOME/.inxi"
ALTERNATE_FTP='' # for data uploads
LOG_FILE="$SCRIPT_DATA_DIR/inxi.log"
LOG_FILE_1="$SCRIPT_DATA_DIR/inxi.1.log"
LOG_FILE_2="$SCRIPT_DATA_DIR/inxi.2.log"
MAN_FILE_DOWNLOAD='http://inxi.googlecode.com/svn/trunk/inxi.1.gz'
MAN_FILE_LOCATION='/usr/share/man/man1'
SCRIPT_NAME='inxi'
SCRIPT_PATCH_NUMBER=''
SCRIPT_PATH='' #filled-in in Main
SCRIPT_VERSION_NUMBER=""	#filled-in in Main
SCRIPT_DOWNLOAD='http://inxi.googlecode.com/svn/trunk/'
SCRIPT_DOWNLOAD_BRANCH_1='http://inxi.googlecode.com/svn/branches/one/'
SCRIPT_DOWNLOAD_BRANCH_2='http://inxi.googlecode.com/svn/branches/two/'
SCRIPT_DOWNLOAD_BRANCH_3='http://inxi.googlecode.com/svn/branches/three/'
SCRIPT_DOWNLOAD_BRANCH_4='http://inxi.googlecode.com/svn/branches/four/'
SCRIPT_DOWNLOAD_DEV='http://smxi.org/test/'
# note, you can use any ip url here as long as it's the only line on the output page.
# Also the ip address must be the last thing on that line.
WAN_IP_URL='http://smxi.org/opt/ip.php'
KONVI_CFG="konversation/scripts/$SCRIPT_NAME.conf" # relative path to $(kde-config --path data)

### Script Localization
# Make sure every program speaks English.
LC_ALL="C"
export LC_ALL

### Output Colors
# A more elegant way to have a scheme that doesn't print color codes (neither ANSI nor mIRC) at all. See below.
unset EMPTY
#             DGREY   BLACK   RED     DRED    GREEN   DGREEN  YELLOW  DYELLOW
ANSI_COLORS="[1;30m [0;30m [1;31m [0;31m [1;32m [0;32m [1;33m [0;33m"
IRC_COLORS="  \x0314  \x0301  \x0304  \x0305  \x0309  \x0303  \x0308  \x0307"
#                          BLUE    DBLUE   MAGENTA DMAGENTA CYAN   DCYAN   WHITE   GREY    NORMAL
ANSI_COLORS="$ANSI_COLORS [1;34m [0;34m [1;35m [0;35m [1;36m [0;36m [1;37m [0;37m [0;37m"
IRC_COLORS=" $IRC_COLORS    \x0312 \x0302  \x0313  \x0306  \x0311  \x0310  \x0300  \x0315  \x03"

#ANSI_COLORS=($ANSI_COLORS); IRC_COLORS=($IRC_COLORS)
A_COLORS_AVAILABLE=( DGREY BLACK RED DRED GREEN DGREEN YELLOW DYELLOW BLUE DBLUE MAGENTA DMAGENTA CYAN DCYAN WHITE GREY NORMAL )

# See above for notes on EMPTY
## note: group 1: 0, 1 are null/normal
## Following: group 2: generic, light/dark or dark/light; group 3: dark on light; group 4 light on dark; 
# this is the count of the first two groups, starting at zero
SAFE_COLOR_COUNT=12
A_COLOR_SCHEMES=( 
EMPTY,EMPTY,EMPTY 
NORMAL,NORMAL,NORMAL 

BLUE,NORMAL,NORMAL
BLUE,RED,NORMAL 
CYAN,BLUE,NORMAL 
DCYAN,NORMAL,NORMAL
DCYAN,BLUE,NORMAL 
DGREEN,NORMAL,NORMAL 
DYELLOW,NORMAL,NORMAL 
GREEN,DGREEN,NORMAL 
GREEN,NORMAL,NORMAL 
MAGENTA,NORMAL,NORMAL
RED,NORMAL,NORMAL

BLACK,DGREY,NORMAL
DBLUE,DGREY,NORMAL 
DBLUE,DMAGENTA,NORMAL
DBLUE,DRED,NORMAL 
DBLUE,BLACK,NORMAL
DGREEN,DYELLOW,NORMAL 
DYELLOW,BLACK,NORMAL
DMAGENTA,BLACK,NORMAL
DCYAN,DBLUE,NORMAL

WHITE,GREY,NORMAL
GREY,WHITE,NORMAL
CYAN,GREY,NORMAL 
GREEN,WHITE,NORMAL 
GREEN,YELLOW,NORMAL 
YELLOW,WHITE,NORMAL 
MAGENTA,CYAN,NORMAL 
MAGENTA,YELLOW,NORMAL
RED,CYAN,NORMAL
RED,WHITE,NORMAL 
BLUE,WHITE,NORMAL
)

## Actual color variables
C1=''
C2=''
CN=''

### Distro Data
# In cases of derived distros where the version file of the base distro can also be found under /etc,
# the derived distro's version file should go first. (Such as with Sabayon / Gentoo)
DISTROS_DERIVED="antix-version aptosid-version kanotix-version knoppix-version mandrake-release pardus-release sabayon-release siduction-version sidux-version turbolinux-release zenwalk-version"
# debian_version excluded from DISTROS_PRIMARY so Debian can fall through to /etc/issue detection. Same goes for Ubuntu.
DISTROS_EXCLUDE_LIST="debian_version ubuntu_version"
DISTROS_PRIMARY="arch-release gentoo-release redhat-release slackware-version SuSE-release"
DISTROS_LSB_GOOD="mandrake-release mandriva-release mandrakelinux-release"
# this is being used both by core distros and derived distros now, eg, solusos uses it for solusos id, while
# debian, solusos base, uses it as well, so we have to know which it is.
DISTROS_OS_RELEASE_GOOD="arch-release SuSE-release"
## Distros with known problems
# DSL (Bash 2.05b: grep -m doesn't work; arrays won't work) --> unusable output
# Puppy Linux 4.1.2 (Bash 3.0: arrays won't work) --> works partially

### Bans Data
# Note that \<ltd\> bans only words, not parts of strings; in \<corp\> you can't use punctuation characters like . or ,
# we're saving about 10+% of the total script exec time by hand building the ban lists here, using hard quotes.
BAN_LIST_NORMAL='computing|computer|corporation|communications|electronics|electrical|electric|gmbh|group|industrial|international|revision|software|technologies|technology|ltd\.|\<ltd\>|inc\.|\<inc\>|intl\.|co\.|\<co\>|corp\.|\<corp\>|\(tm\)|\(r\)|®|\(rev ..\)'
BAN_LIST_CPU='@|cpu deca|dual core|dual-core|tri core|tri-core|quad core|quad-core|ennea|genuine|hepta|hexa|multi|octa|penta|processor|single|triple|[0-9\.]+ *[MmGg][Hh][Zz]'

SENSORS_GPU_SEARCH='intel|radeon|nouveau'

### USB networking search string data, because some brands can have other products than
### wifi/nic cards, they need further identifiers, with wildcards.
### putting the most common and likely first, then the less common, then some specifics
USB_NETWORK_SEARCH="Wi-Fi.*Adapter|Wireless.*Adapter|WLAN.*Adapter|Network.*Adapter|802\.11|Atheros|Atmel|D-Link.*Adapter|D-Link.*Wireless|Linksys|Netgea|Ralink|Realtek.*Network|Realtek.*Wireless|Realtek.*WLAN|Belkin.*Wireless|Belkin.*WLAN|Belkin.*Network"
USB_NETWORK_SEARCH="$USB_NETWORK_SEARCH|Actiontec.*Wireless|Actiontec.*Network|AirLink.*Wireless|Asus.*Network|Asus.*Wireless|Buffalo.*Wireless|Davicom|DWA-.*RangeBooster|DWA-.*Wireless|ENUWI-.*Wireless|LG.*Wi-Fi|Rosewill.*Wireless|RNX-.*Wireless|Samsung.*LinkStick|Samsung.*Wireless|Sony.*Wireless|TEW-.*Wireless|TP-Link.*Wireless|WG[0-9][0-9][0-9].*Wireless|WNA[0-9][0-9][0-9]|WNDA[0-9][0-9][0-9]|Zonet.*ZEW.*Wireless|54 Mbps" 
# then a few known hard to ID ones added 
# belkin=050d; d-link=07d1; netgear=0846; ralink=148f; realtek=0bda; 
USB_NETWORK_SEARCH="$USB_NETWORK_SEARCH|050d:935b|0bda:8189|0bda:8197"

# WARNING: In the main part below (search for 'KONVI')
# there's a check for Konversation-specific config files.
# Any one of these can override the above if inxi is run
# from Konversation!

########################################################################
#### MAIN: Where it all begins
########################################################################
main()
{
	eval $LOGFS
	
	local color_scheme=''
	
	# This function just initializes variables
	initialize_script_data

	# Check for dependencies BEFORE running ANYTHING else except above functions
	# Not all distro's have these depends installed by default. Don't want to run
	# this if the user is requesting to see this information in the first place
	if [[ $1 != '--recommends' ]];then
		check_script_depends
		check_script_suggested_apps
	fi

	### Only continue if depends ok
	SCRIPT_PATH=$( dirname $0 )
	SCRIPT_VERSION_NUMBER=$( grep -im 1 'version:' $SCRIPT_PATH/$SCRIPT_NAME | gawk '{print $3}' )
	SCRIPT_PATCH_NUMBER=$( grep -im 1 'Patch Number:' $SCRIPT_PATH/$SCRIPT_NAME | gawk '{print $4}' )
	
	### Source global config overrides
	if [[ -s /etc/$SCRIPT_NAME.conf ]];then
		source /etc/$SCRIPT_NAME.conf
	fi
	# Source user config variables override /etc/inxi.conf variables
	if [[ -s $HOME/.$SCRIPT_NAME/$SCRIPT_NAME.conf ]];then
		source $HOME/.$SCRIPT_NAME/$SCRIPT_NAME.conf
	fi

	## this needs to run before the KONVI stuff is set below
	## Konversation 1.2 apparently does not like the $PPID test in get_start_client
	## So far there is no known way to detect if qt4_konvi is the parent process
	## this method will infer qt4_konvi as parent
	get_start_client

	# note: this only works if it's run from inside konversation as a script builtin or something
	# only do this if inxi has been started as a konversation script, otherwise bypass this	
#	KONVI=3 ## for testing puroses
	if [[ $KONVI -eq 1 || $KONVI -eq 3 ]];then
		if [[ $KONVI -eq 1 ]]; then ## dcop Konversation (ie 1.x < 1.2(qt3))	
			DCPORT="$1"
			DCSERVER="$2"
			DCTARGET="$3"
			shift 3
		elif [[ $KONVI -eq 3 ]]; then ## dbus Konversation (> 1.2 (qt4))
			DCSERVER="$1" ##dbus testing
			DCTARGET="$2" ##dbus testing
			shift 2
		fi

		# The section below is on request of Argonel from the Konversation developer team:
		# it sources config files like $HOME/.kde/share/apps/konversation/scripts/inxi.conf
		IFS=":"
		for kde_config in $( kde-config --path data )
		do
			if [[ -r ${kde_config}${KONVI_CFG} ]];then
				source "${kde_config}${KONVI_CFG}"
				break
			fi
		done
		IFS="$ORIGINAL_IFS"
	fi

	## leave this for debugging dcop stuff if we get that working
	# 	print_screen_output "DCPORT: $DCPORT"
	# 	print_screen_output "DCSERVER: $DCSERVER"
	# 	print_screen_output "DCTARGET: $DCTARGET"
	
	# first init function must be set first for colors etc. Remember, no debugger
	# stuff works on this function unless you set the debugging flag manually.
	# Debugging flag -@ [number] will not work until get_parameters runs.
	
	# "$@" passes every parameter separately quoted, "$*" passes all parameters as one quoted parameter.
	# must be here to allow debugger and other flags to be set.
	get_parameters "$@"

	# If no colorscheme was set in the parameter handling routine, then set the default scheme
	if [[ $B_COLOR_SCHEME_SET != 'true' ]];then
		# This let's user pick their color scheme. For IRC, only shows the color schemes, no interactive
		# The override value only will be placed in user config files. /etc/inxi.conf can also override
		if [[ $B_RUN_COLOR_SELECTOR == 'true' ]];then 
			select_default_color_scheme
		else
			# set the default, then override as required
			color_scheme=$DEFAULT_COLOR_SCHEME
			if [[ -n $GLOBAL_COLOR_SCHEME ]];then
				color_scheme=$GLOBAL_COLOR_SCHEME
			else
				if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
					if [[ -n $CONSOLE_COLOR_SCHEME && -z $DISPLAY ]];then
						color_scheme=$CONSOLE_COLOR_SCHEME
					elif [[ -n $VIRT_TERM_COLOR_SCHEME ]];then
						color_scheme=$VIRT_TERM_COLOR_SCHEME
					fi
				else
					if [[ -n $IRC_X_TERM_COLOR_SCHEME && $B_CONSOLE_IRC == 'true' && -n $DISPLAY ]];then
						color_scheme=$IRC_X_TERM_COLOR_SCHEME
					elif [[ -n $IRC_CONS_COLOR_SCHEME && -z $DISPLAY ]];then
						color_scheme=$IRC_CONS_COLOR_SCHEME
					elif [[ -n $IRC_COLOR_SCHEME ]];then
						color_scheme=$IRC_COLOR_SCHEME
					fi
				fi
			fi
			set_color_scheme $color_scheme
		fi
	fi
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		LINE_MAX=$LINE_MAX_CONSOLE
		SEP3=$SEP3_CONSOLE
	else
		# too hard to read if no colors, so force that for users on irc
		if [[ $SCHEME == 0 ]];then
			SEP3=$SEP3_CONSOLE
		else
			SEP3=$SEP3_IRC
		fi
		LINE_MAX=$LINE_MAX_IRC
	fi

	# all the pre-start stuff is in place now
	B_SCRIPT_UP='true'
	script_debugger "Debugger: $SCRIPT_NAME is up and running..."
	
	# then create the output
	print_it_out

	## last steps
	if [[ $B_RUNNING_IN_SHELL == 'true' && $SCHEME -gt 0 ]];then
		echo -n "[0m"
	fi
	eval $LOGFE
	# weechat's executor plugin forced me to do this, and rightfully so, because else the exit code
	# from the last command is taken..
	exit 0
}

#### -------------------------------------------------------------------
#### basic tests: set script data, booleans, PATH
#### -------------------------------------------------------------------

# Set PATH data so we can access all programs as user. Set BAN lists.
# initialize some boleans, these directories are used throughout the script
# some apps are used for extended functions any directory used, should be
# checked here first.
# No args taken.
initialize_script_data()
{
	eval $LOGFS
	
	# now set the script BOOLEANS for files required to run features
	if [[ -d "/proc/" ]];then
		B_PROC_DIR='true'
	else
		error_handler 6
	fi
	
	initialize_script_paths
	
	# found a case of battery existing but having nothing in it on desktop mobo
	# not all laptops show the first, 
	if [[ -n $( ls /proc/acpi/battery 2>/dev/null ) ]];then
		B_PORTABLE='true'
	fi
	if [[ -e $FILE_CPUINFO ]]; then
		B_CPUINFO_FILE='true'
	fi

	if [[ -e $FILE_MEMINFO ]];then
		B_MEMINFO_FILE='true'
	fi

	if [[ -e $FILE_ASOUND_DEVICE ]];then
		B_ASOUND_DEVICE_FILE='true'
	fi

	if [[ -e $FILE_ASOUND_VERSION ]];then
		B_ASOUND_VERSION_FILE='true'
	fi

	if [[ -f $FILE_LSB_RELEASE ]];then
		B_LSB_FILE='true'
	fi
	
	if [[ -f $FILE_OS_RELEASE ]];then
		B_OS_RELEASE_FILE='true'
	fi

	if [[ -e $FILE_SCSI ]];then
		B_SCSI_FILE='true'
	fi

	if [[ -n $DISPLAY ]];then
		B_SHOW_X_DATA='true'
		B_RUNNING_IN_X='true'
	fi
	
	if [[ -e $FILE_MDSTAT ]];then
		B_MDSTAT_FILE='true'
	fi

	if [[ -e $FILE_MODULES ]];then
		B_MODULES_FILE='true'
	fi

	if [[ -e $FILE_MOUNTS ]];then
		B_MOUNTS_FILE='true'
	fi

	if [[ -e $FILE_PARTITIONS ]];then
		B_PARTITIONS_FILE='true'
	fi
	# default to the normal location, then search for it
	if [[ -e $FILE_XORG_LOG ]];then
		B_XORG_LOG='true'
	else
		# Detect location of the Xorg log file
		if [[ -n $( type -p xset ) ]]; then
			FILE_XORG_LOG=$( xset q 2>/dev/null | grep -i 'Log file' | gawk '{print $3}')
			if [[ -e $FILE_XORG_LOG ]];then
				B_XORG_LOG='true'
			fi
		fi
	fi
	# gfx output will require this flag
	if [[ $( whoami ) == 'root' ]];then
		B_ROOT='true'
	fi
	eval $LOGFE
}

initialize_script_paths()
{
	local path='' added_path='' b_path_found='' sys_path=''
	# Extra path variable to make execute failures less likely, merged below
	local extra_paths="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

	# Fallback paths put into $extra_paths; This might, among others, help on gentoo.
	# Now, create a difference of $PATH and $extra_paths and add that to $PATH:
	IFS=":"
	for path in $extra_paths
	do
		b_path_found='false'
		for sys_path in $PATH
		do
			if [[ $path == $sys_path ]];then
				b_path_found='true'
			fi
		done
		if [[ $b_path_found == 'false' ]];then
			added_path="$added_path:$path"
		fi
	done

	IFS="$ORIGINAL_IFS"
	PATH="${PATH}${added_path}"
	##echo "PATH='$PATH'"
	##/bin/sh -c 'echo "PATH in subshell=\"$PATH\""'
}

# No args taken.
check_script_suggested_apps()
{
	eval $LOGFS
	local bash_array_test=( "one" "two" )

	# check for array ability of bash, this is only good for the warning at this time
	# the boolean could be used later
	# bash version 2.05b is used in DSL
	# bash version 3.0 is used in Puppy Linux; it has a known array bug <reference to be placed here>
	# versions older than 3.1 don't handle arrays
	# distro's using below 2.05b are unknown, released in 2002
	if [[ ${bash_array_test[1]} -eq "two" ]];then
		B_BASH_ARRAY='true'
	else
		script_debugger "Suggestion: update to Bash v3.1 for optimal inxi output"
	fi
	# now setting qdbus/dcop for first run, some systems can have both by the way
	if [[ -n $( type -p qdbus ) ]];then
		B_QDBUS='true'
	fi
	if [[ -n $( type -p dcop ) ]];then
		B_DCOP='true'
	fi
	eval $LOGFE
}

# Determine if any of the absolutely necessary tools are absent
# No args taken.
check_script_depends()
{
	eval $LOGFS
	local app_name='' app_path=''
	# bc removed from deps for now
	local depends="df free gawk grep lspci ps readlink tr uname uptime wc"
	# no need to add xprop because it will just give N/A if not there, but if we expand use of xprop,
	# should add that here as a test, then use the B_SHOW_X_DATA flag to trigger the tests in de function
	local x_apps="xrandr xdpyinfo glxinfo" 

	if [[ $B_RUNNING_IN_X == 'true' ]];then
		for app_name in $x_apps
		do
			app_path=$( type -p $app_name )
			if [[ -z $app_path ]];then
				script_debugger "Resuming in non X mode: $app_name not found. For package install advice run: $SCRIPT_NAME --recommends"
				B_SHOW_X_DATA='false'
				break
			fi
		done
	fi

	app_name=''

	for app_name in $depends
	do
		app_path=$( type -p $app_name )
		if [[ -z $app_path ]];then
			error_handler 5 "$app_name"
		fi
	done
	eval $LOGFE
}

## note: this is now running inside each gawk sequence directly to avoid exiting gawk
## looping in bash through arrays, then re-entering gawk to clean up, then writing back to array
## in bash. For now I'll leave this here because there's still some interesting stuff to get re methods
# Enforce boilerplate and buzzword filters
# args: $1 - BAN_LIST_NORMAL/BAN_LIST_CPU; $2 - string to sanitize
sanitize_characters()
{
	eval $LOGFS
	# Cannot use strong quotes to unquote a string with pipes in it!
	# bash will interpret the |'s as usual and try to run a subshell!
	# Using weak quotes instead, or use '"..."'
	echo "$2" | gawk "
	BEGIN {
		IGNORECASE=1
	}
	{
		gsub(/${!1}/,\"\")
		gsub(/ [ ]+/,\" \")    ## ([ ]+) with (space)
		gsub(/^ +| +$/,\"\")   ## (pipe char) with (nothing)
		print                  ## prints (returns) cleaned input
	}"
	eval $LOGFE
}

# Set the colorscheme
# args: $1 = <scheme number>|<"none">
set_color_scheme()
{
	eval $LOGFS
	local i='' a_script_colors='' a_color_codes=''

	if [[ $1 -ge ${#A_COLOR_SCHEMES[@]} ]];then
		set -- 1
	fi
	# Set a global variable to allow checking for chosen scheme later
	SCHEME="$1"
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		a_color_codes=( $ANSI_COLORS )
	else
		a_color_codes=( $IRC_COLORS )
	fi
	for (( i=0; i < ${#A_COLORS_AVAILABLE[@]}; i++ ))
	do
		eval "${A_COLORS_AVAILABLE[i]}=\"${a_color_codes[i]}\""
	done
	IFS=","
	a_script_colors=( ${A_COLOR_SCHEMES[$1]} )
	IFS="$ORIGINAL_IFS"
	# then assign the colors globally
	C1="${!a_script_colors[0]}"
	C2="${!a_script_colors[1]}"
	CN="${!a_script_colors[2]}"
	# ((COLOR_SCHEME++)) ## note: why is this? ##
	eval $LOGFE
}

select_default_color_scheme()
{
	eval $LOGFS
	local spacer='  ' options='' user_selection='' config_variable=''
	local config_file="$HOME/.$SCRIPT_NAME/$SCRIPT_NAME.conf"
	local irc_clear="[0m" 
	local irc_gui='Unset' irc_console='Unset' irc_x_term='Unset'
	local console='Unset' virt_term='Unset' global='Unset' 
	
	if [[ -n $IRC_COLOR_SCHEME ]];then
		irc_gui="Set: $IRC_COLOR_SCHEME"
	fi
	if [[ -n $IRC_CONS_COLOR_SCHEME ]];then
		irc_console="Set: $IRC_CONS_COLOR_SCHEME"
	fi
	if [[ -n $IRC_X_TERM_COLOR_SCHEME ]];then
		irc_x_term="Set: $IRC_X_TERM_COLOR_SCHEME"
	fi
	if [[ -n $VIRT_TERM_COLOR_SCHEME ]];then
		virt_term="Set: $VIRT_TERM_COLOR_SCHEME"
	fi
	if [[ -n $CONSOLE_COLOR_SCHEME ]];then
		console="Set: $CONSOLE_COLOR_SCHEME"
	fi
	if [[ -n $GLOBAL_COLOR_SCHEME ]];then
		global="Set: $GLOBAL_COLOR_SCHEME"
	fi
	
	# don't want these printing in irc since they show literally
	if [[ $B_RUNNING_IN_SHELL != 'true' ]];then
		irc_clear=''
	fi
	# first make output neutral so it's just plain default for console client
	set_color_scheme "0"
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		print_screen_output "Welcome to $SCRIPT_NAME! Please select the default $COLOR_SELECTION color scheme."
		# print_screen_output "You will see this message only one time per user account, unless you set preferences in: /etc/$SCRIPT_NAME.conf"
		print_screen_output " "
	fi
	print_screen_output "Because there is no way to know your $COLOR_SELECTION foreground/background colors, you can"
	print_screen_output "set your color preferences from color scheme option list below. 0 is no colors, 1 neutral."
	print_screen_output "After these, there are 3 sets: 1-dark or light backgrounds; 2-light backgrounds; 3-dark backgrounds."
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		print_screen_output "Please note that this will set the $COLOR_SELECTION preferences only for user: $(whoami)"
	fi
	print_screen_output "------------------------------------------------------------------------------"
	for (( i=0; i < ${#A_COLOR_SCHEMES[@]}; i++ ))
	do
		if [[ $i -gt 9 ]];then
			spacer=' '
		fi
		# only offer the safe universal defaults
		case $COLOR_SELECTION in
			global|irc|irc-console|irc-virtual-terminal)
				if [[ $i -gt $SAFE_COLOR_COUNT ]];then
					break
				fi
				;;
		esac
		set_color_scheme $i
		print_screen_output "$irc_clear $i)$spacer${C1}Card:${C2} nVidia G86 [GeForce 8400 GS] ${C1}X.Org${C2} 1.7.7"
	done
	set_color_scheme 0
	
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		echo -n "[0m"
		print_screen_output "$irc_clear $i)${spacer}Remove all color settings. Restore $SCRIPT_NAME default."
		print_screen_output "$irc_clear $(($i+1)))${spacer}Continue, no changes or config file setting."
		print_screen_output "$irc_clear $(($i+2)))${spacer}Exit, use another terminal, or set manually."
		print_screen_output "------------------------------------------------------------------------------"
		print_screen_output "Simply type the number for the color scheme that looks best to your eyes for your $COLOR_SELECTION settings"
		print_screen_output "and hit ENTER. NOTE: You can bring this option list up by starting $SCRIPT_NAME with option: -c plus one of these numbers:"
		print_screen_output "94 (console, no X - $console); 95 (terminal, X - $virt_term); 96 (irc, gui, X - $irc_gui);"
		print_screen_output "97 (irc, X, in terminal - $irc_x_term); 98 (irc, no X - $irc_console); 99 (global - $global)"
		print_screen_output "Your selection(s) will be stored here: $config_file"
		print_screen_output "Global overrides all individual color schemes. Individual schemes remove the global setting."
		print_screen_output "------------------------------------------------------------------------------"
		read user_selection
		if [[ -n $( grep -Es '^([0-9]+)$' <<< "$user_selection" ) && $user_selection -lt $i ]];then
			case $COLOR_SELECTION in
				irc)
					config_variable='IRC_COLOR_SCHEME'
					;;
				irc-console)
					config_variable='IRC_CONS_COLOR_SCHEME'
					;;
				irc-virtual-terminal)
					config_variable='IRC_X_TERM_COLOR_SCHEME'
					;;
				console)
					config_variable='CONSOLE_COLOR_SCHEME'
					;;
				virtual-terminal)
					config_variable='VIRT_TERM_COLOR_SCHEME'
					;;
				global)
					config_variable='GLOBAL_COLOR_SCHEME'
					;;
			esac
			set_color_scheme $user_selection
			# make file/directory first if missing
			if [[ ! -f $config_file ]];then
				if [[ ! -d $HOME/.$SCRIPT_NAME ]];then
					mkdir $HOME/.$SCRIPT_NAME
				fi
				touch $config_file
			fi
			if [[ -z $( grep -s "$config_variable=" $config_file ) ]];then
				print_screen_output "Creating and updating config file for $COLOR_SELECTION color scheme now..."
				echo "$config_variable=$user_selection" >> $config_file
			else
				print_screen_output "Updating config file for $COLOR_SELECTION color scheme now..."
				sed -i "s/$config_variable=.*/$config_variable=$user_selection/" $config_file
			fi
			# file exists now so we can go on to cleanup
			case $COLOR_SELECTION in
				irc|irc-console|irc-virtual-terminal|console|virtual-terminal)
					sed -i '/GLOBAL_COLOR_SCHEME=/d' $config_file
					;;
				global)
					sed -i -e '/VIRT_TERM_COLOR_SCHEME=/d' -e '/CONSOLE_COLOR_SCHEME=/d' -e '/IRC_COLOR_SCHEME=/d' \
					-e '/IRC_CONS_COLOR_SCHEME=/d' -e '/IRC_X_TERM_COLOR_SCHEME=/d' $config_file
					;;
			esac
		elif [[ $user_selection == $i ]];then
			print_screen_output "Removing all color settings from config file now..."
			sed -i -e '/VIRT_TERM_COLOR_SCHEME=/d' -e '/GLOBAL_COLOR_SCHEME=/d' -e '/CONSOLE_COLOR_SCHEME=/d' \
			-e '/IRC_COLOR_SCHEME=/d' -e '/IRC_CONS_COLOR_SCHEME=/d' -e '/IRC_X_TERM_COLOR_SCHEME=/d' $config_file
			set_color_scheme $DEFAULT_COLOR_SCHEME
		elif [[ $user_selection == $(( $i+1 )) ]];then
			print_screen_output "Ok, continuing $SCRIPT_NAME unchanged. You can set the colors anytime by starting with: -c 95 to 99"
			if [[ -n $CONSOLE_COLOR_SCHEME && -z $DISPLAY ]];then
				set_color_scheme $CONSOLE_COLOR_SCHEME
			elif [[ -n $VIRT_TERM_COLOR_SCHEME ]];then
				set_color_scheme $VIRT_TERM_COLOR_SCHEME
			else
				set_color_scheme $DEFAULT_COLOR_SCHEME
			fi
		elif [[ $user_selection == $(( $i+2 )) ]];then
			set_color_scheme $DEFAULT_COLOR_SCHEME
			print_screen_output "Ok, exiting $SCRIPT_NAME now. You can set the colors later."
			exit 0
		else
			print_screen_output "Error - Invalid Selection. You entered this: $user_selection"
			print_screen_output " "
			select_default_color_scheme
		fi
	else
		print_screen_output "------------------------------------------------------------------------------"
		print_screen_output "After finding the scheme number you like, simply run this again in a terminal to set the configuration"
		print_screen_output "data file for your irc client. You can set color schemes for the following: start inxi with -c plus:"
		print_screen_output "94 (console, no X - $console); 95 (terminal, X - $virt_term); 96 (irc, gui, X - $irc_gui);"
		print_screen_output "97 (irc, X, in terminal - $irc_x_term); 98 (irc, no X - $irc_console); 99 (global - $global)"
		exit 0
	fi

	eval $LOGFE
}

########################################################################
#### UTILITY FUNCTIONS
########################################################################

#### -------------------------------------------------------------------
#### error handler, debugger, script updater
#### -------------------------------------------------------------------

# Error handling
# args: $1 - error number; $2 - optional, extra information
error_handler()
{
	eval $LOGFS
	local error_message=''

	# assemble the error message
	case $1 in
		2)	error_message="large flood danger, debug buffer full!"
			;;
		3)	error_message="unsupported color scheme number: $2"
			;;
		4)	error_message="unsupported verbosity level: $2"
			;;
		5)	error_message="dependency not met: $2 not found in path.\nFor distribution installation package names and missing apps information, run: $SCRIPT_NAME --recommends"
			;;
		6)	error_message="/proc not found! Quitting..."
			;;
		7)	error_message="One of the options you entered in your script parameters: $2\nis not supported.The option may require extra arguments to work.\nFor supported options (and their arguments), check the help menu: $SCRIPT_NAME -h"
			;;
		8)	error_message="the self-updater failed, wget exited with error: $2.\nYou probably need to be root.\nHint, to make for easy updates without being root, do: chown <user name> $SCRIPT_PATH/$SCRIPT_NAME"
			;;
		9)	error_message="unsupported debugging level: $2"
			;;
		10)
			error_message="the alt download url you provided: $2\nappears to be wrong, download aborted. Please note, the url\nneeds to end in /, without $SCRIPT_NAME, like: http://yoursite.com/downloads/"
			;;
		11)
			error_message="unsupported testing option argument: -! $2"
			;;
		12)
			error_message="the svn branch download url: $2\nappears to be empty currently. Make sure there is an actual svn branch version\nactive before you try this again. Check http://code.google.com/p/inxi\nto verify the branch status."
			;;
		13)
			error_message="The -t option requires the following extra arguments (no spaces between letters/numbers):\nc m cm [required], for example: -t cm8 OR -t cm OR -t c9\n(numbers: 1-20, > 5 throttled to 5 in irc clients) You entered: $2"
			;;
		14)
			error_message="failed to write correctly downloaded $SCRIPT_NAME to location $SCRIPT_PATH.\nThis usually means you don't have permission to write to that location, maybe you need to be root?\nThe operation failed with error: $2"
			;;
		15)
			error_message="failed set execute permissions on $SCRIPT_NAME at location $SCRIPT_PATH.\nThis usually means you don't have permission to set permissions on files there, maybe you need to be root?\nThe operation failed with error: $2"
			;;
		16)
			error_message="$SCRIPT_NAME downloaded but the file data is corrupted. Purged data and using current version."
			;;
		20)
			error_message="The option you selected has been deprecated. $2\nSee the -h (help) menu for currently supported options."
			;;
		*)	error_message="error unknown: $@"
			set -- 99
			;;
	esac
	# then print it and exit
	print_screen_output "Error $1: $error_message"
	eval $LOGFE
	exit $1
}

# prior to script up set, pack the data into an array
# then we'll print it out later.
# args: $1 - $@ debugging string text
script_debugger()
{
	eval $LOGFS
	if [[ $B_SCRIPT_UP == 'true' ]];then
		# only return if debugger is off and no pre start up errors have occured
		if [[ $DEBUG -eq 0 && $DEBUG_BUFFER_INDEX -eq 0 ]];then
			return 0
		# print out the stored debugging information if errors occured
		elif [[ $DEBUG_BUFFER_INDEX -gt 0 ]];then
			for (( DEBUG_BUFFER_INDEX=0; DEBUG_BUFFER_INDEX < ${#A_DEBUG_BUFFER[@]}; DEBUG_BUFFER_INDEX++ ))
			do
				print_screen_output "${A_DEBUG_BUFFER[$DEBUG_BUFFER_INDEX]}"
			done
			DEBUG_BUFFER_INDEX=0
		fi
		# or print out normal debugger messages if debugger is on
		if [[ $DEBUG -gt 0 ]];then
			print_screen_output "$1"
		fi
	else
		if [[ $B_DEBUG_FLOOD == 'true' && $DEBUG_BUFFER_INDEX -gt 10 ]];then
			error_handler 2
		# this case stores the data for later printout, will print out only
		# at B_SCRIPT_UP == 'true' if array index > 0
		else
			A_DEBUG_BUFFER[$DEBUG_BUFFER_INDEX]="$1"
			# increment count for next pre script up debugging error
			(( DEBUG_BUFFER_INDEX++ ))
		fi
	fi
	eval $LOGFE
}

# NOTE: no logging available until get_parameters is run, since that's what sets logging
# in order to trigger earlier logging manually set B_USE_LOGGING to true in top variables.
# $1 alone: logs data; $2 with or without $3 logs func start/end.
# $1 type (fs/fe/cat/raw) or logged data; [$2 is $FUNCNAME; [$3 - function args]]
log_function_data()
{
	if [ "$B_USE_LOGGING" == 'true' ];then
		local logged_data='' spacer='   ' line='----------------------------------------'
		case $1 in
			fs)
				logged_data="Function: $2 - Primary: Start"
				if [ -n "$3" ];then
					logged_data="$logged_data\n${spacer}Args: $3"
				fi
				spacer=''
				;;
			fe)
				logged_data="Function: $2 - Primary: End"
				spacer=''
				;;
			cat)
				if [[ $B_LOG_FULL_DATA == 'true' ]];then
					logged_data="\n$line\nFull file data: cat $2\n\n$( cat $2 )\n$line\n"
					spacer=''
				fi
				;;
			raw)
				if [[ $B_LOG_FULL_DATA == 'true' ]];then
					logged_data="\n$line\nRaw system data:\n\n$2\n$line\n"
					spacer=''
				fi
				;;
			*)
				logged_data="$1"
				;;
		esac
		# Create any required line breaks and strip out escape color code, either ansi (case 1)or irc (case 2).
		# This pattern doesn't work for irc colors, if we need that someone can figure it out
		if [[ -n $logged_data ]];then
			if [[ $B_LOG_COLORS != 'true' ]];then
				echo -e "${spacer}$logged_data" | sed -r 's/\x1b\[[0-9]{1,2}(;[0-9]{1,2}){0,2}m//g' >> $LOG_FILE
			else
				echo -e "${spacer}$logged_data" >> $LOG_FILE
			fi
		fi
	fi
}

# called in the initial -@ 10 script args setting so we can get logging as soon as possible
# will have max 3 files, inxi.log, inxi.1.log, inxi.2.log
create_rotate_logfiles()
{
	if [[ ! -d $SCRIPT_DATA_DIR ]];then
		mkdir $SCRIPT_DATA_DIR
	fi
	# do the rotation if logfile exists
	if [[ -f $LOG_FILE ]];then
		# copy if present second to third
		if [[ -f $LOG_FILE_1 ]];then
			mv -f $LOG_FILE_1 $LOG_FILE_2
		fi
		# then copy initial to second
		mv -f $LOG_FILE $LOG_FILE_1
	fi
	# now create the logfile
	touch $LOG_FILE
	# and echo the start data
	echo "=========================================================" >> $LOG_FILE
	echo "START $SCRIPT_NAME LOGGING:"                               >> $LOG_FILE
	echo "Script started: $( date +%Y-%m-%d-%H:%M:%S )"              >> $LOG_FILE
	echo "=========================================================" >> $LOG_FILE
}

# args: $1 - download url, not including file name; $2 - string to print out
# note that $1 must end in / to properly construct the url path
script_self_updater()
{
	eval $LOGFS
	local wget_error=0 file_contents='' wget_man_error=0 
	local man_file_path="$MAN_FILE_LOCATION/inxi.1.gz"
	
	if [[ $B_RUNNING_IN_SHELL != 'true' ]];then
		print_screen_output "Sorry, you can't run the $SCRIPT_NAME self updater option (-U) in an IRC client."
		exit 1
	fi

	print_screen_output "Starting $SCRIPT_NAME self updater."
	print_screen_output "Currently running $SCRIPT_NAME version number: $SCRIPT_VERSION_NUMBER"
	print_screen_output "Current version patch number: $SCRIPT_PATCH_NUMBER"
	print_screen_output "Updating $SCRIPT_NAME in $SCRIPT_PATH using $2 as download source..."

	file_contents="$( wget -q -O - $1$SCRIPT_NAME )" || wget_error=$?
	# then do the actual download
	if [[  $wget_error -eq 0 ]];then
		# make sure the whole file got downloaded and is in the variable
		if [[ -n $( grep '###\*\*EOF\*\*###' <<< "$file_contents" ) ]];then
			echo "$file_contents" > $SCRIPT_PATH/$SCRIPT_NAME || error_handler 14 "$?"
			chmod +x $SCRIPT_PATH/$SCRIPT_NAME || error_handler 15 "$?"
			SCRIPT_VERSION_NUMBER=$( grep -im 1 'version:' $SCRIPT_PATH/$SCRIPT_NAME | gawk '{print $3}' )
			SCRIPT_PATCH_NUMBER=$( grep -im 1 'Patch Number:' $SCRIPT_PATH/$SCRIPT_NAME | gawk '{print $4}' )
			print_screen_output "Successfully updated to $2 version: $SCRIPT_VERSION_NUMBER"
			print_screen_output "New $2 version patch number: $SCRIPT_PATCH_NUMBER"
			print_screen_output "To run the new version, just start $SCRIPT_NAME again."
			print_screen_output "----------------------------------------"
			print_screen_output "Starting download of man page file now."
			if [[ ! -d $MAN_FILE_LOCATION ]];then
				print_screen_output "The required man directory was not detected on your system, unable to continue: $MAN_FILE_LOCATION"
			else
				if [[ $B_ROOT == 'true' ]];then
					print_screen_output "Checking Man page download URL..."
					if [[ -f /usr/share/man/man8/inxi.8.gz ]];then
						print_screen_output "Updating man page location to man1."
						mv -f /usr/share/man/man8/inxi.8.gz /usr/share/man/man1/inxi.1.gz 
						if [[ -n $( type -p mandb ) ]];then
							exec $( type -p mandb ) -q 
						fi
					fi
					wget -q --spider $MAN_FILE_DOWNLOAD || wget_man_error=$?
					if [[ $wget_man_error -eq 0 ]];then
						print_screen_output "Man file download URL verified: $MAN_FILE_DOWNLOAD"
						print_screen_output "Downloading Man page file now."
						wget -q -O $man_file_path $MAN_FILE_DOWNLOAD || wget_man_error=$?
						if [[ $wget_man_error -gt 0 ]];then
							print_screen_output "Oh no! Something went wrong downloading the Man gz file at: $MAN_FILE_DOWNLOAD"
							print_screen_output "Check the error messages for what happened. Error: $wget_man_error"
						else
							print_screen_output "Download/install of man page successful. Check to make sure it works: man inxi"
						fi
					else
						print_screen_output "Man file download URL failed, unable to continue: $MAN_FILE_DOWNLOAD"
					fi
				else
					print_screen_output "Updating / Installing the Man page requires root user, writing to: $MAN_FILE_LOCATION"
					print_screen_output "If you want the man page, you'll have to run $SCRIPT_NAME -U as root."
				fi
			fi
			exit 0
		else
			error_handler 16
		fi
	# now run the error handlers on any wget failure
	else
		if [[ $2 == 'svn server' ]];then
			error_handler 8 "$wget_error"
		elif [[ $2 == 'alt server' ]];then
			error_handler 10 "$1"
		else
			error_handler 12 "$1"
		fi
	fi
	eval $LOGFS
}

# args: $1 - debug data type: sys|xorg|disk
debug_data_collector()
{
	local xiin_app='' xiin_data_file='' xiin_download='' error='' b_run_xiin='false'
	local debug_data_dir="inxi-$(tr ' ' '-' <<< $HOSTNAME | tr '[A-Z]' '[a-z]' )-$1-$(date +%Y%m%d)" 
	local completed_gz_file='' xiin_file='xiin.py' ftp_upload='ftp.techpatterns.com/incoming'
	local Line='-------------------------'
	
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		if [[ -n $ALTERNATE_FTP ]];then
			ftp_upload=$ALTERNATE_FTP
		fi
		echo "Starting debugging data collection type: $1"
		echo -n "Checking/creating required directories... "
		if [[ ! -d $SCRIPT_DATA_DIR ]];then
			mkdir $SCRIPT_DATA_DIR
		fi
		echo 'completed'
		cd $SCRIPT_DATA_DIR
		if [[ -d $debug_data_dir ]];then
			echo 'Deleting previous xiin data directory...'
			rm -rf $debug_data_dir
		fi
		mkdir $debug_data_dir
		if [[ -f $debug_data_dir.tar.gz ]];then
			echo 'Deleting previous tar.gz file...'
			rm -f $debug_data_dir.tar.gz
		fi
		
		echo 'Collecting system info: sensors, lsusb, lspci, lspci -v data, plus /proc data'
		lsusb &> $debug_data_dir/lsusb.txt
		lspci &> $debug_data_dir/lspci.txt
		lspci -n &> $debug_data_dir/lspci-n.txt
		lspci -v &> $debug_data_dir/lspci-v.txt
		ps aux &> $debug_data_dir/ps-aux.txt
		sensors &> $debug_data_dir/sensors.txt
		ls /usr/bin/gcc* &> $debug_data_dir/gcc-sys-versions.txt
		gcc --version &> $debug_data_dir/gcc-version.txt
		cat /etc/issue &> $debug_data_dir/etc-issue.txt
		cat $FILE_LSB_RELEASE &> $debug_data_dir/lsb-release.txt
		cat $FILE_OS_RELEASE &> $debug_data_dir/os-release.txt
		cat $FILE_ASOUND_DEVICE &> $debug_data_dir/proc-asound-device.txt
		cat $FILE_ASOUND_VERSION &> $debug_data_dir/proc-asound-version.txt
		cat $FILE_CPUINFO &> $debug_data_dir/proc-cpu-info.txt
		cat $FILE_MEMINFO &> $debug_data_dir/proc-meminfo.txt
		cat $FILE_MODULES &> $debug_data_dir/proc-modules.txt
		cat /proc/net/arp &> $debug_data_dir/proc-net-arp.txt 
		check_recommends &> $debug_data_dir/check-recommends.txt
		# first download and verify xiin
		if [[ $B_UPLOAD_DEBUG_DATA == 'true' || $1 == 'disk' || $1 == 'sys' || $1 == 'all' ]];then
			touch $debug_data_dir/xiin-error.txt
			echo "Downloading required tree traverse tool $xiin_file..."
			if [[ -f xiin && ! -f $xiin_file ]];then
				mv -f xiin $xiin_file
			fi
			# -Nc is creating really weird download anomolies, so using -O instead
			xiin_download="$( wget -q -O - http://inxi.googlecode.com/svn/branches/xiin/$xiin_file )"
			# if nothing got downloaded kick out error, otherwise we'll use an older version
			if [[ $? -gt 0 && ! -f $xiin_file ]];then
				echo -e "ERROR: Failed to download required file: $xiin_file\nMaybe the remote site is down or your networking is broken?"
				echo "Continuing with incomplete data collection."
				echo "$xiin_file download failed and no existing $xiin_file" >> $debug_data_dir/xiin-error.txt
			elif [[ -n $( grep -s '# EOF' <<< "$xiin_download" ) || -f $xiin_file ]];then
				if [[ -n $( grep -s '# EOF' <<< "$xiin_download" ) ]];then
					echo "Updating $xiin_file from remote location"
					echo "$xiin_download" > $xiin_file
				else
					echo "Using local $xiin_file due to download failure"
				fi
				b_run_xiin='true'
			else
				echo -e "ERROR: $xiin_file downloaded but the program file data is corrupted.\nContinuing with incomplete data collection."
				echo "$xiin_file downloaded but the program file data is corrupted." >> $debug_data_dir/xiin-error.txt
			fi
		fi
		# note, only bash 4> supports ;;& for case, so using if/then here
		if [[ $1 == 'disk' || $1 == 'sys' || $1 == 'all' ]];then
			xiin_data_file=$SCRIPT_DATA_DIR/$debug_data_dir/xiin-sys.txt
			echo 'Collecting networking data...'
			ifconfig &> $debug_data_dir/ifconfig.txt
			ip addr &> $debug_data_dir/ip-addr.txt
			if [[ $b_run_xiin == 'true' ]];then
				echo $Line
				echo "Running $xiin_file tool now on /sys..."
				echo "Using Python version:" && python --version
				python --version &> $debug_data_dir/python-version.txt
				python ./$xiin_file -d /sys -f $xiin_data_file
				if [[ $? -ne 0 ]];then
					error=$?
					echo -e "ERROR: $xiin_file exited with error $error - removing data file.\nContinuing with incomplete data collection."
					echo "Continuing with incomplete data collection."
					rm -f $xiin_data_file
					echo "$xiin_file data generation failed with python error $error" >> $debug_data_dir/xiin-error.txt
				fi
				echo $Line
			fi
		fi
		if [[ $1 == 'xorg' || $1 == 'all' ]];then
			if [[ $B_RUNNING_IN_X != 'true' ]];then
				echo 'Warning: only some of the data collection can occur if you are not in X'
				touch $debug_data_dir/warning-user-not-in-x
			fi
			if [[ $B_ROOT == 'true' ]];then
				echo 'Warning: only some of the data collection can occur if you are running as Root user'
				touch $debug_data_dir/warning-root-user
			fi
			echo 'Collecting Xorg log and xorg.conf files'
			if [[ -e $FILE_XORG_LOG ]];then
				cat $FILE_XORG_LOG &> $debug_data_dir/xorg-log-file.txt
			else
				touch $debug_data_dir/no-xorg-log-file
			fi
			if [[ -e /etc/X11/xorg.conf ]];then
				cp /etc/X11/xorg.conf $debug_data_dir
			else
				touch $debug_data_dir/no-xorg-conf-file
			fi
			if [[ -n $( ls /etc/X11/xorg.conf.d/ 2>/dev/null ) ]];then
				ls /etc/X11/xorg.conf.d &> $debug_data_dir/ls-etc-x11-xorg-conf-d.txt
				cp /etc/X11/xorg.conf.d $debug_data_dir
			else
				touch $debug_data_dir/no-xorg-conf-d-files
			fi
			echo 'Collecting X, xprop, glxinfo, xrandr, xdpyinfo data...'
			xprop -root &> $debug_data_dir/xprop_root.txt
			glxinfo &> $debug_data_dir/glxinfo.txt
			xdpyinfo &> $debug_data_dir/xdpyinfo.txt
			xrandr &> $debug_data_dir/xrandr.txt
			X -version &> $debug_data_dir/x-version.txt
			Xorg -version &> $debug_data_dir/xorg-version.txt
		fi
		if [[ $1 == 'disk' || $1 == 'all' ]];then
			echo 'Collecting dev, label, disk, uuid data, df...'
			ls -l /dev &> $debug_data_dir/dev-data.txt
			ls -l /dev/disk &> $debug_data_dir/dev-disk-data.txt
			ls -l /dev/disk/by-id &> $debug_data_dir/dev-disk-id-data.txt
			ls -l /dev/disk/by-label &> $debug_data_dir/dev-disk-label-data.txt
			ls -l /dev/disk/by-uuid &> $debug_data_dir/dev-disk-uuid-data.txt
			ls -l /dev/disk/by-path &> $debug_data_dir/dev-disk-path-data.txt
			ls -l /dev/mapper &> $debug_data_dir/dev-disk-mapper-data.txt
			readlink /dev/root &> $debug_data_dir/dev-root.txt
			df -h -T -P --exclude-type=aufs --exclude-type=squashfs --exclude-type=unionfs --exclude-type=devtmpfs --exclude-type=tmpfs --exclude-type=iso9660 --exclude-type=devfs --exclude-type=linprocfs --exclude-type=sysfs --exclude-type=fdescfs &> $debug_data_dir/df-h-T-excludes.txt
			swapon -s &> $debug_data_dir/swapon-s.txt
			df -P --exclude-type=aufs --exclude-type=squashfs --exclude-type=unionfs --exclude-type=devtmpfs --exclude-type=tmpfs --exclude-type=iso9660 &> $debug_data_dir/df-excludes.txt
			cat /proc/mdstat &> $debug_data_dir/proc-mdstat.txt
			cat $FILE_PARTITIONS &> $debug_data_dir/proc-partitions.txt
			cat $FILE_SCSI &> $debug_data_dir/proc-scsi.txt
			cat $FILE_MOUNTS &> $debug_data_dir/proc-mounts.txt
			cat /proc/sys/dev/cdrom/info &> $debug_data_dir/proc-cdrom-info.txt
			ls /proc/ide/ &> $debug_data_dir/proc-ide.txt
			cat /proc/ide/*/* &> $debug_data_dir/proc-ide-hdx-cat.txt
			cat /etc/fstab &> $debug_data_dir/etc-fstab.txt
			cat /etc/mtab &> $debug_data_dir/etc-mtab.txt
		fi
		echo 'Creating inxi output file now. This can take a few seconds...'
		$SCRIPT_NAME -FRploudxxx -c 0 -@ 8 > $debug_data_dir/inxi-FRploudxxx.txt
		cp $LOG_FILE $SCRIPT_DATA_DIR/$debug_data_dir
		if [[ -f $debug_data_dir.tar.gz ]];then
			echo "Found and removing previous tar.gz data file: $debug_data_dir.tar.gz"
			rm -f $debug_data_dir.tar.gz
		fi
		echo 'Creating tar.gz compressed file of this material now. Contents:'
		echo $Line
		tar -cvzf $debug_data_dir.tar.gz $debug_data_dir
		echo $Line
		echo 'Cleaning up leftovers...'
		rm -rf $debug_data_dir
		echo 'Testing gzip file integrity...'
		gzip -t $debug_data_dir.tar.gz
		if [[ $? -gt 0 ]];then
			echo 'Data in gz is corrupted, removing gzip file, try running data collector again.'
			rm -f $debug_data_dir.tar.gz
			echo "Data in gz is corrupted, removed gzip file" >> $debug_data_dir/gzip-error.txt
		else
			echo 'All done, you can find your data gzipped directory here:'
			completed_gz_file=$SCRIPT_DATA_DIR/$debug_data_dir.tar.gz
			echo $completed_gz_file
			if [[ $B_UPLOAD_DEBUG_DATA == 'true' ]];then
				echo $Line
				if [[ $b_run_xiin == 'true' ]];then
					echo "Running automatic upload of data to remote server $ftp_upload now..."
					python ./$xiin_file --version
					python ./$xiin_file -u $completed_gz_file $ftp_upload
					if [[ $? -gt 0 ]];then
						echo $Line
						echo "Error: looks like the ftp upload failed. Error number: $?"
						echo "The ftp upload failed. Error number: $?" >> $debug_data_dir/xiin-error.txt
					fi
				else
					echo 'Unable to run the automoatic ftp upload because of an error with the xiin download.'
					echo "Unable to run the automoatic ftp upload because of an error with the xiin download" >> $debug_data_dir/xiin-error.txt
				fi
			else
				echo 'You can upload this here using most file managers: ftp.techpatterns.com/incoming'
				echo 'then let a maintainer know it is uploaded.'
			fi
		fi
	else
		echo 'This feature only available in console or shell client! Exiting now.'
	fi
	exit 0
}

check_recommends()
{
	local Line='-----------------------------------------------------------------------------------------'
	local gawk_version='N/A' sed_version='N/A' sudo_version='N/A' python_version='N/A'
	
	if [[ $B_RUNNING_IN_SHELL != 'true' ]];then
		print_screen_output "Sorry, you can't run this option in an IRC client."
		exit 1
	fi
	
	initialize_script_paths
	
	echo "$SCRIPT_NAME will now begin checking for the programs it needs to operate. First a check of"
	echo "the main languages and tools $SCRIPT_NAME uses. Python is only for debugging data collection."
	echo $Line
	echo "Bash version: $( bash --version 2>&1 | awk 'BEGIN {IGNORECASE=1} /^GNU bash/ {print $4}' )"
	if [[ -n $( type -p gawk ) ]];then
		gawk_version=$( gawk --version 2>&1 | awk 'BEGIN {IGNORECASE=1} /^GNU Awk/ {print $3}' )
	fi
	if [[ -n $( type -p sed ) ]];then
		sed_version=$( sed --version 2>&1 | awk 'BEGIN {IGNORECASE=1} /^GNU sed version/ {print $4}' )
	fi
	if [[ -n $( type -p sudo ) ]];then
		sudo_version=$( sudo -V 2>&1 | awk 'BEGIN {IGNORECASE=1} /^Sudo version/ {print $3}' )
	fi
	if [[ -n $( type -p python ) ]];then
		python_version=$( python --version 2>&1 | awk 'BEGIN {IGNORECASE=1} /^Python/ {print $2}' )
	fi
	echo "Gawk version: $gawk_version"
	echo "Sed version: $sed_version"
	echo "Sudo version: $sudo_version"
	echo "Python version: $python_version"
	echo $Line
	echo "Test One: Required System Directories."
	echo "If one of these system directories is missing, $SCRIPT_NAME cannot operate:"
	echo 
	check_recommends_items 'required-dirs'
	echo "Test Two: Required Core Applications."
	echo "If one of these applications is missing, $SCRIPT_NAME cannot operate:"
	echo 
	check_recommends_items 'required-apps'
	echo 'Test Three: Script Recommends for Graphics Features. If you do not use X these do not matter.'
	echo "If one of these applications is missing, $SCRIPT_NAME will have incomplete output:"
	echo 
	check_recommends_items 'recommended-x-apps'
	echo 'Test Four: Script Recommends for Remaining Features.' 
	echo "If one of these applications is missing, $SCRIPT_NAME will have incomplete output:"
	echo 
	check_recommends_items 'recommended-apps'
	echo 'Test Five: System Directories for Various Information.' 
	echo "If one of these directories is missing, $SCRIPT_NAME will have incomplete output:"
	echo 
	check_recommends_items 'system-dirs'
	echo 'All tests completed.' 
}
# args: $1 - check item
check_recommends_items()
{
	local item='' item_list='' item_string='' missing_items='' missing_string=''
	local package='' application='' feature='' type='' starter='' finisher=''
	local package_deb='' package_pacman='' package_rpm='' 
	local print_string='' separator=''
	local required_dirs='/proc /sys'
	# package-owner: 1 - debian/ubuntu; 2 - arch; 3 - yum/rpm
	# pardus: pisi sf -q /usr/bin/package
	local required_apps='
	df:coreutils~coreutils~coreutils~:partition_data 
	free:procps~procps~procps~:system_memory 
	gawk:gawk~gawk~gawk~:core_tool
	grep:grep~grep~grep~:string_search 
	lspci:pciutils~pciutils~pciutils~:hardware_data 
	ps:procps~procps~procps~:process_data 
	readlink:coreutils~coreutils~coreutils~: 
	sed:sed~sed~sed~:string_replace 
	tr:coreutils~coreutils~coreutils~:character_replace 
	uname:uname~coreutils~coreutils~:kernel_data 
	uptime:procps~procps~procps~: 
	wc:coreutils~coreutils~coreutils~:word_character_count
	'
	local x_recommends='
	glxinfo:mesa-utils~mesa-demos~glx-utils~:-G_glx_info 
	xdpyinfo:X11-utils~xorg-xdpyinfo~xorg-x11-utils~:-G_multi_screen_resolution 
	xprop:X11-utils~xorg-xprop~x11-utils~:-S_desktop_data 
	xrandr:x11-xserver-utils~xrandr~x11-server-utils~:-G_single_screen_resolution
	'
	local recommended_apps='
	file:file~file~file~:-o_unmounted_file_system
	hddtemp:hddtemp~hddtemp~hddtemp~:-Dx_show_hdd_temp 
	ifconfig:net-tools~net-tools~net-tools~:-i_ip_lan-deprecated
	ip:iproute~iproute2~iproute~:-i_ip_lan
	sensors:lm-sensors~lm_sensors~lm-sensors~:-s_sensors_output
	lsusb:usbutils~usbutils~usbutils~:-A_usb_audio;-N_usb_networking 
	modinfo:module-init-tools~module-init-tools~module-init-tools~:-Ax,-Nx_module_version 
	runlevel:sysvinit~sysvinit~systemd~:-I_runlevel
	sudo:sudo~sudo~sudo~:-Dx_hddtemp-user;-o_file-user
	'
	local recommended_dirs='
	/sys/class/dmi/id:-M_system,_motherboard,_bios
	/dev:-l,-u,-o,-p,-P,-D_disk_partition_data
	/dev/disk/by-label:-l,-o,-p,-P_partition_labels
	/dev/disk/by-uuid:-u,-o,-p,-P_partition_uuid
	'
	
	case $1 in
		required-dirs)
			item_list=$required_dirs
			item_string='Required file system'
			missing_string='system directories'
			type='directories'
			;;
		required-apps)
			item_list=$required_apps
			item_string='Required application'
			missing_string='applications, and their corresponding packages,'
			type='applications'
			;;
		recommended-x-apps)
			item_list=$x_recommends
			item_string='Recommended X application'
			missing_string='applications, and their corresponding packages,'
			type='applications'
			;;
		recommended-apps)
			item_list=$recommended_apps
			item_string='Recommended application'
			missing_string='applications, and their corresponding packages,'
			type='applications'
			;;
		system-dirs)
			item_list=$recommended_dirs
			item_string='System directory'
			missing_string='system directories'
			type='directories'
			;;
	esac
	# great trick from: http://ideatrash.net/2011/01/bash-string-padding-with-sed.html
	# left pad: sed -e :a -e 's/^.\{1,80\}$/& /;ta'
	# right pad: sed -e :a -e 's/^.\{1,80\}$/ &/;ta'
	# center pad: sed -e :a -e 's/^.\{1,80\}$/ & /;ta'
	
	for item in $item_list
	do
		if [[ $( awk -F ":" '{print NF-1}' <<< $item ) -eq 0 ]];then
			application=$item
			package=''
			feature=''
			location=''
		elif [[ $( awk -F ":" '{print NF-1}' <<< $item ) -eq 1 ]];then
			application=$( cut -d ':' -f 1 <<< $item )
			package=''
			feature=$( cut -d ':' -f 2 <<< $item )
			location=''
		else
			application=$( cut -d ':' -f 1 <<< $item )
			package=$( cut -d ':' -f 2 <<< $item )
			location=$( type -p $application )
			if [[ $( awk -F ":" '{print NF-1}' <<< $item ) -eq 2 ]];then
				feature=$( cut -d ':' -f 3 <<< $item )
			else
				feature=''
			fi
		fi
		if [[ -n $feature ]];then
			print_string="$item_string: $application (info: $( sed 's/_/ /g' <<< $feature ))"
		else
			print_string="$item_string: $application"
		fi
		starter="$( sed -e :a -e 's/^.\{1,75\}$/&./;ta' <<< $print_string )"
		if [[ -z $( grep '^/' <<< $application ) && -n $location ]] || [[ -d $application ]];then
			if [[ -n $location ]];then
				finisher=" $location"
			else
				finisher=" Present"
			fi
		else
			finisher=" Missing"
			missing_items="$missing_items$separator$application:$package"
			separator=' '
		fi
		
		echo "$starter$finisher"
	done
	echo 
	if [[ -n $missing_items ]];then
		echo "The following $type are missing from your system:"
		for item in $missing_items
		do
			application=$( cut -d ':' -f 1 <<< $item )
			if [[ $type == 'applications' ]];then
				# echo '--------------------------------------------------------'
				echo
				package=$( cut -d ':' -f 2 <<< $item )
				package_deb=$( cut -d '~' -f 1 <<< $package )
				package_pacman=$( cut -d '~' -f 2 <<< $package )
				package_rpm=$( cut -d '~' -f 3 <<< $package )
				echo "Application: $application"
				echo "To add to your system, install the proper distribution package for your system:"
				echo "Debian/Ubuntu: $package_deb :: Arch Linux: $package_pacman :: Redhat/Fedora/Suse: $package_rpm"
			else
				echo "Directory: $application"
			fi
		done
		if [[ $item_string == 'System directory' ]];then
			echo "These directories are created by the kernel, so don't worry if they are not present."
		fi
	else
		echo "All the $( cut -d ' ' -f 1 <<< $item_string | sed -e 's/Re/re/' -e 's/Sy/sy/' ) $type are present."
	fi
	echo $Line
}

#### -------------------------------------------------------------------
#### print / output cleaners
#### -------------------------------------------------------------------

# inxi speaks through here. When run by Konversation script alias mode, uses DCOP
# for dcop to work, must use 'say' operator, AND colors must be evaluated by echo -e
# note: dcop does not seem able to handle \n so that's being stripped out and replaced with space.
print_screen_output()
{
	eval $LOGFS
	# the double quotes are needed to avoid losing whitespace in data when certain output types are used
	local print_data="$( echo -e "$1" )"

	# just using basic debugger stuff so you can tell which thing is printing out the data. This
	# should help debug kde 4 konvi issues when that is released into sid, we'll see. Turning off
	# the redundant debugger output which as far as I can tell does exactly nothing to help debugging.
	if [[ $DEBUG -gt 5 ]];then
		if [[ $KONVI -eq 1 ]];then
			# konvi doesn't seem to like \n characters, it just prints them literally
			# print_data="$( tr '\n' ' ' <<< "$print_data" )"
			# dcop "$DCPORT" "$DCOPOBJ" say "$DCSERVER" "$DCTARGET" "konvi='$KONVI' saying : '$print_data'"
			print_data="KP-$KONVI: $print_data"
		elif [[ $KONVI -eq 2 ]];then
			# echo "konvi='$KONVI' saying : '$print_data'"
			print_data="KP-$KONVI: $print_data"
		else
			# echo "printing out: '$print_data'"
			print_data="P: $print_data"
		fi
	fi

	if [[ $KONVI -eq 1 && $B_DCOP == 'true' ]]; then ## dcop Konversation (<= 1.1 (qt3))
		# konvi doesn't seem to like \n characters, it just prints them literally
		$print_data="$( tr '\n' ' ' <<< "$print_data" )"
		dcop "$DCPORT" "$DCOPOBJ" say "$DCSERVER" "$DCTARGET" "$print_data"

	elif [[ $KONVI -eq 3 && $B_QDBUS == 'true' ]]; then ## dbus Konversation (> 1.2 (qt4))
		qdbus org.kde.konversation /irc say "$DCSERVER" "$DCTARGET" "$print_data"

#	elif [[ $IRC_CLIENT == 'X-Chat' ]]; then
#		qdbus org.xchat.service print "$print_data\n"

	else
		# the -n is needed to avoid double spacing of output in terminal
		echo -ne "$print_data\n"
	fi
	eval $LOGFE
}

## this handles all verbose line construction with indentation/line starter
## args: $1 - null (, actually: " ") or line starter; $2 - line content
create_print_line()
{
	eval $LOGFS
	printf "${C1}%-${INDENT}s${C2} %s" "$1" "$2"
	eval $LOGFE
}

# this removes newline and pipes.
# args: $1 - string to clean
remove_erroneous_chars()
{
	eval $LOGFS
	## RS is input record separator
	## gsub is substitute;
	gawk '
	BEGIN {
		RS=""
	}
	{
		gsub(/\n$/,"")         ## (newline; end of string) with (nothing)
		gsub(/\n/," ");        ## (newline) with (space)
		gsub(/^ *| *$/, "")    ## (pipe char) with (nothing)
		gsub(/  +/, " ")       ## ( +) with (space)
		gsub(/ [ ]+/, " ")     ## ([ ]+) with (space)
		gsub(/^ +| +$/, "")    ## (pipe char) with (nothing)
		printf $0
	}' "$1"      ## prints (returns) cleaned input
	eval $LOGFE
}

#### -------------------------------------------------------------------
#### parameter handling, print usage functions.
#### -------------------------------------------------------------------

# Get the parameters. Note: standard options should be lower case, advanced or testing, upper
# args: $1 - full script startup args: $@
get_parameters()
{
	eval $LOGFS
	local opt='' wget_test='' update_flags='U!:' debug_data_type='' 
	local use_short='true' # this is needed to trigger short output, every v/d/F/line trigger sets this false

	# If distro maintainers want to not allow updates, turn off that option for users
	if [[ $B_ALLOW_UPDATE == 'false' ]];then
		update_flags=''
	fi
	if [[ $1 == '--version' ]];then
		print_version_info
		exit 0
	elif [[ $1 == '--help' ]];then
		show_options
		exit 0
	elif [[ $1 == '--recommends' ]];then
		check_recommends
		exit 0
	# the short form only runs if no args output args are used
	# no need to run through these if there are no args
	# reserved for future use: -g for extra Graphics; -m for extra Machine; -d for extra Disk
	fi
B_COLOR_SCHEME_SET='true'
B_SHOW_ADVANCED_NETWORK='true'
B_SHOW_AUDIO='true'
B_SHOW_CPU='true'
B_SHOW_DISK='true'
B_SHOW_GRAPHICS='true'
B_SHOW_INFO='true'
B_SHOW_MACHINE='true'
B_SHOW_NETWORK='true'
B_SHOW_PARTITIONS='true'
B_SHOW_RAID='true'
B_SHOW_SENSORS='true'
B_SHOW_SYSTEM='true'
use_short='false'
set_color_scheme "0"
}
## print out help menu, not including Testing or Debugger stuff because it's not needed
show_options()
{
	local color_scheme_count=$(( ${#A_COLOR_SCHEMES[@]} - 1 ))
	
	if [[ $B_RUNNING_IN_SHELL != 'true' ]];then
		print_screen_output "Sorry, you can't run the help option in an IRC client."
		exit 1
	fi
	print_screen_output "$SCRIPT_NAME supports the following options. You can combine them, or list them"
	print_screen_output "one by one: Examples: $SCRIPT_NAME -v4 -c6 OR $SCRIPT_NAME -bDc 6"
	print_screen_output " "
	print_screen_output "If you start $SCRIPT_NAME with no arguments, it will show the short form."
	print_screen_output "The following options if used without -F, -b, or -v will show just the complete line(s):"
	print_screen_output "A,C,D,G,I,M,N,P,S,f,i,n,o,p,l,u,r,s,t - you can use these alone or together to show"
	print_screen_output "just the line(s) you want to see."
	print_screen_output "If you use them with -v [level], -b or -F, it will show the full output for that line "
	print_screen_output "along with the output for the chosen verbosity level."
	print_screen_output "- - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	print_screen_output "Output Control Options:"
	print_screen_output "-A  Show Audio/sound card information."
	print_screen_output "-b  Shows basic output, short form. Like $SCRIPT_NAME -v 2, only minus hard disk names."
	print_screen_output "-c  Available color schemes. Scheme number is required. Color selectors run a color selector option"
	print_screen_output "    prior to $SCRIPT_NAME starting which lets you set the config file value for the selection."
	print_screen_output "    Supported color schemes: 0-$color_scheme_count Example: $SCRIPT_NAME -c 11"
	print_screen_output "    Color selectors for each type display (NOTE: irc and global only show safe color set):"
	print_screen_output "    94 - Console, out of X"
	print_screen_output "    95 - Terminal, running in X - like xTerm"
	print_screen_output "    96 - Gui IRC, running in X - like Xchat, Quassel, Konversation etc."
	print_screen_output "    97 - Console IRC running in X - like irssi in xTerm"
	print_screen_output "    98 - Console IRC not in  X"
	print_screen_output "    99 - Global - Overrides/removes all settings. Setting specific removes global."
	print_screen_output "-C  Show full CPU output, including per CPU clockspeed."
	print_screen_output "-d  Shows optical drive data. Same as -Dd. With -x, adds features line to output. -xx adds a few more features."
	print_screen_output "-D  Show full hard Disk info, not only model, ie: /dev/sda ST380817AS 80.0GB. See also -x and -xx."
	print_screen_output "-f  Show all cpu flags used, not just the short list. Not shown with -F to avoid spamming."
	print_screen_output "-F  Show Full output for $SCRIPT_NAME. Includes all Upper Case line letters, plus -s and -n."
	print_screen_output "    Does not show extra verbose options like -x -d -f -u -l -o -p -t -r unless you use that argument."
	print_screen_output "-G  Show Graphic card information (card, x type, resolution, glx renderer, version)."
	print_screen_output "-i  Show Wan IP address, and shows local interfaces (requires ifconfig network tool). Same as -Nni"
	print_screen_output "    Not shown with -F for user security reasons, you shouldn't paste your local/wan IP."
	print_screen_output "-I  Show Information: processes, uptime, memory, irc client (or shell type), inxi version."
	print_screen_output "-l  Show partition labels. Default: short partition -P. For full -p output, use: -pl (or -plu)."
	print_screen_output "-M  Show machine data. Motherboard, Bios, and if present, System Builder (Like Lenovo)."
	print_screen_output "    Older systems/kernels without the required /sys data can use dmidecode instead, run as root."
	print_screen_output "-n  Show Advanced Network card information. Same as -Nn. Shows interface, speed, mac id, state, etc."
	print_screen_output "-N  Show Network card information. With -x, shows PCI BusID, Port number."
	print_screen_output "-o  Show unmounted partition information (includes UUID and LABEL if available)."
	print_screen_output "    Shows file system type if you have file installed, if you are root OR if you have"
	print_screen_output "    added to /etc/sudoers (sudo v. 1.7 or newer): <username> ALL = NOPASSWD: /usr/bin/file (sample)"
	print_screen_output "-p  Show full partition information (-P plus all other detected partitions)."
	print_screen_output "-P  Show Partition information (shows what -v 4 would show, but without extra data)."
	print_screen_output "    Shows, if detected: / /boot /home /tmp /usr /var. Use -p to see all mounted partitions."
	print_screen_output "-r  Show distro repository data. Currently supported repo types: APT; PACMAN; PISI; YUM."
	print_screen_output "-R  Show RAID data. Shows RAID devices, states, levels, and components, and extra data with -x/-xx"
	print_screen_output "    If device is resyncing, shows resync progress line as well."
	print_screen_output "-s  Show sensors output (if sensors installed/configured): mobo/cpu/gpu temp; detected fan speeds."
	print_screen_output "    Gpu temp only for Fglrx/Nvidia drivers. Nvidia shows screen number for > 1 screens."
	print_screen_output "-S  Show System information: host name, kernel, desktop environment (if in X), distro"
	print_screen_output "-t  Show processes. Requires extra options: c (cpu) m (memory) cm (cpu+memory). If followed by numbers 1-20,"
	print_screen_output "    shows that number of processes for each type (default: $PS_COUNT; if in irc, max: 5): -t cm10"
	print_screen_output "    Make sure to have no space between letters and numbers (-t cm10 - right, -t cm 10 - wrong)."
	print_screen_output "-u  Show partition UUIDs. Default: short partition -P. For full -p output, use: -pu (or -plu)."
	print_screen_output "-v  Script verbosity levels. Verbosity level number is required. Should not be used with -b or -F"
	print_screen_output "    Supported levels: 0-${VERBOSITY_LEVELS} Example: $SCRIPT_NAME -v 4"
	print_screen_output "    0 - Short output, same as: $SCRIPT_NAME"
	print_screen_output "    1 - Basic verbose, -S + basic CPU + -G + basic Disk + -I."
	print_screen_output "    2 - Adds networking card (-N), Machine (-M) data, shows basic hard disk data (names only),"
	print_screen_output "        and, if present, basic raid (devices only, and if inactive, notes that). similar to: $SCRIPT_NAME -b"
	print_screen_output "    3 - Adds advanced CPU (-C), network (-n) data, and switches on -x advanced data option."
	print_screen_output "    4 - Adds partition size/filled data (-P) for (if present):/, /home, /var/, /boot"
	print_screen_output "        Shows full disk data (-D)."
	print_screen_output "    5 - Adds audio card (-A); sensors (-s), partition label (-l) and UUID (-u), short form of optical drives,"
	print_screen_output "        standard raid data (-R)."
	print_screen_output "    6 - Adds data types: full partition (-p), unmounted partition (-o), optical drive (-d), full raid; triggers -xx."
	print_screen_output "    7 - Adds network IP data (-i); triggers -xxx."
	print_screen_output "-x  Show extra data (only works with verbose or line output, not short form): "
	print_screen_output "    -C - bogomips on Cpu;"
	print_screen_output "    -d - Adds items to features line of optical drive; adds rev version to optical drive."
	print_screen_output "    -D - Hdd temp with disk data if you have hddtemp installed, if you are root OR if you have added to"
	print_screen_output "         /etc/sudoers (sudo v. 1.7 or newer): <username> ALL = NOPASSWD: /usr/sbin/hddtemp (sample)"
	print_screen_output "    -G - Direct rendering status for Graphics (in X)."
	print_screen_output "    -G - (for single gpu, nvidia driver) screen number gpu is running on."
	print_screen_output "    -i - Show IPv6 as well for LAN interface (IF) devices."
	print_screen_output "    -I - Show system GCC, default. With -xx, also show other installed GCC versions."
	print_screen_output "       - If running in console, not in IRC client, shows shell version number if detected."
	print_screen_output "    -N -A - Adds version/port(s)/driver version (if available) for Network/Audio;"
	print_screen_output "    -N -A -G - Network, audio, graphics, shows PCI Bus ID/Usb ID number of card;"
	print_screen_output "    -R - Shows component raid id. Adds second RAID Info line: raid level; report on drives (like 5/5);"
	print_screen_output "         blocks; chunk size; bitmap (if present). Resync line, shows blocks synced/total blocks."
	print_screen_output "    -S - Desktop toolkit if avaliable (GNOME/XFCE/KDE only); Kernel gcc version"
	print_screen_output "    -t - Adds memory use output to cpu (-xt c), and cpu use to memory (-xt m)."
	print_screen_output "-xx Show extra, extra data (only works with verbose or line output, not short form): "
	print_screen_output "    -A - Adds chip vendor:product ID for each audio device."
	print_screen_output "    -D - Adds disk serial number."
	print_screen_output "    -G - Adds chip vendor:product ID for each video card."
	print_screen_output "    -I - Adds other detected installed gcc versions to primary gcc output (if present)."
	print_screen_output "         Adds parent program (or tty) for shell info if not in IRC (like Konsole or Gterm)."
	print_screen_output "    -M - Adds chassis information, if any data for that is available."
	print_screen_output "    -N - Adds chip vendor:product ID for each nic."
	print_screen_output "    -R - Adds superblock (if present); algorythm, U data. Adds system info line (kernel support,"
	print_screen_output "         read ahead, raid events). Adds if present, unused device line. Resync line, shows progress bar."
	print_screen_output "    -S - Adds display manager (dm) to desktop output, if in X (like kdm, gdm3, lightdm)."
	print_screen_output "    -xx -@ <11-14> - Automatically uploads debugger data tar.gz file to ftp.techpatterns.com."
	print_screen_output "-xxx Show extra, extra, extra data (only works with verbose or line output, not short form): "
	print_screen_output "    -S - Adds panel/shell information to desktop output, if in X (like gnome-shell, cinnamon, mate-panel)."
	print_screen_output "-z  Adds security filters for IP addresses, Mac, and user home directory name. Default on for irc clients."
	print_screen_output "-Z  Absolute override for output filters. Useful for debugging networking issues in irc for example."
	print_screen_output " "
	print_screen_output "Additional Options:"
	print_screen_output "-h --help      This help menu."
	print_screen_output "-H             This help menu, plus developer options. Do not use dev options in normal operation!"
	print_screen_output "--recommends   Checks $SCRIPT_NAME application dependencies + recommends, and directories, then shows"
	print_screen_output "               what package(s) you need to install to add support for that feature."
	if [[ $B_ALLOW_UPDATE == 'true' ]];then
		print_screen_output "-U             Auto-update script. Will also install/update man page. Note: if you installed as root, you"
		print_screen_output "               must be root to update, otherwise user is fine. Man page installs require root user mode."
	fi
	print_screen_output "-V --version   $SCRIPT_NAME version information. Prints information then exits."
	print_screen_output " "
	print_screen_output "Debugging Options:"
	print_screen_output "-%  Overrides defective or corrupted data."
	print_screen_output "-@  Triggers debugger output. Requires debugging level 1-14 (8-10 - logging of data)."
	print_screen_output "    Less than 8 just triggers $SCRIPT_NAME debugger output on screen."
	print_screen_output "    1-7  - On screen debugger output"
	print_screen_output "    8    - Basic logging"
	print_screen_output "    9    - Full file/sys info logging"
	print_screen_output "    10   - Color logging."
	print_screen_output "    The following create a tar.gz file of system data, plus collecting the inxi output to file:"
	print_screen_output "    To automatically upload debugger data tar.gz file to ftp.techpatterns.com: inxi -xx@ <11-14>"
	print_screen_output "    For alternate ftp upload locations: Example: inxi -! ftp.yourserver.com/incoming -xx@ 14"
	print_screen_output "    11 - With data file of xiin read of /sys."
	print_screen_output "    12 - With xorg conf and log data, xrandr, xprop, xdpyinfo, glxinfo etc."
	print_screen_output "    13 - With data from dev, disks, partitions, etc., plus xiin data file."
	print_screen_output "    14 - Everything, full data collection."
	if [[ $1 == 'full' ]];then
		print_screen_output " "
		print_screen_output "Developer and Testing Options (Advanced):"
		print_screen_output "-! 1 - Sets testing flag B_TESTING_1='true' to trigger testing condition 1."
		print_screen_output "-! 2 - Sets testing flag B_TESTING_2='true' to trigger testing condition 2."
		print_screen_output "-! 3 - Sets flags B_TESTING_1='true' and B_TESTING_2='true'."
		print_screen_output "-! 10 - Triggers an update from the primary dev download server instead of svn."
		print_screen_output "-! 11 - Triggers an update from svn branch one - if present, of course."
		print_screen_output "-! 12 - Triggers an update from svn branch two - if present, of course."
		print_screen_output "-! 13 - Triggers an update from svn branch three - if present, of course."
		print_screen_output "-! 14 - Triggers an update from svn branch four - if present, of course."
		print_screen_output "-! <http://......> - Triggers an update from whatever server you list."
		print_screen_output "-! <ftp.......> - Changes debugging data ftp upload location to whatever you enter here."
		print_screen_output "   Only used together with -xx@ 11-14, and must be used in front of that."
		print_screen_output "   Example: inxi -! ftp.yourserver.com/incoming -xx@ 14"
		print_screen_output " "
	fi
	print_screen_output " "
}

## print out version information for -V/--version
print_version_info()
{
	# if not in PATH could be either . or directory name, no slash starting
	local script_path=$SCRIPT_PATH script_symbolic_start=''
	if [[ $script_path == '.' ]];then
		script_path=$( pwd )
	elif [[ -z $( grep '^/' <<< "$script_path" ) ]];then
		script_path="$( pwd )/$script_path"
	fi
	# handle if it's a symbolic link, rare, but can happen with script directories in irc clients
	# which would only matter if user starts inxi with -! 30 override in irc client
	if [[ -L $script_path/$SCRIPT_NAME ]];then
		script_symbolic_start=$script_path/$SCRIPT_NAME
		script_path=$( readlink $script_path/$SCRIPT_NAME )
		script_path=$( dirname $script_path )
	fi
	local last_modified=$( grep -m 1 '^####  Date:' $SCRIPT_PATH/$SCRIPT_NAME | gawk -F ': ' '{print $NF}' ) 
	local year_modified=$( gawk '{print $NF}' <<< "$last_modified" )
	
	print_screen_output "$SCRIPT_NAME $SCRIPT_VERSION_NUMBER-$SCRIPT_PATCH_NUMBER ($last_modified)"
	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		print_screen_output " "
		print_screen_output "Program Location: $script_path"
		if [[ -n $script_symbolic_start ]];then
			print_screen_output "Started via symbolic link: $script_symbolic_start"
		fi
		print_screen_output "Website: http://inxi.goooglecode.com - IRC: irc.oftc.net channel: #smxi"
		print_screen_output "Forums: http://techpatterns.com/forums/forum-33.html"
		print_screen_output " "
		print_screen_output "$SCRIPT_NAME - the universal, portable, system information tool for console and irc."
		print_screen_output "This program is a fork of Infobash 3.02:"
		print_screen_output "Copyright (C) 2005-2007  Michiel de Boer a.k.a. locsmif"
		print_screen_output "Subsequent changes and modifications (after Infobash 3.02):"
		print_screen_output "Copyright (C) 2008-$year_modified Scott Rogers, Harald Hope, aka trash80 & h2"
		print_screen_output " "
		print_screen_output "This program is free software; you can redistribute it and/or modify"
		print_screen_output "it under the terms of the GNU General Public License as published by"
		print_screen_output "the Free Software Foundation; either version 3 of the License, or"
		print_screen_output "(at your option) any later version. (http://www.gnu.org/licenses/gpl.html)"
	fi
}

########################################################################
#### MAIN FUNCTIONS
########################################################################

#### -------------------------------------------------------------------
#### initial startup stuff
#### -------------------------------------------------------------------

# Determine where inxi was run from, set IRC_CLIENT and IRC_CLIENT_VERSION
get_start_client()
{
	eval $LOGFS
	local irc_client_path='' irc_client_path_lower='' non_native_konvi='' i=''
	local b_non_native_app='false' pppid='' app_working_name='' file_data=''
	local b_qt4_konvi='false' ps_parent=''

	if [[ $B_RUNNING_IN_SHELL == 'true' ]];then
		IRC_CLIENT='Shell'
		unset IRC_CLIENT_VERSION
	elif [[ -n $PPID && -f /proc/$PPID/exe ]];then
		if [[ $B_OVERRIDE_FILTER != 'true' ]];then
			B_OUTPUT_FILTER='true'
		fi
		irc_client_path=$( readlink /proc/$PPID/exe )
		irc_client_path_lower=$( tr '[:upper:]' '[:lower:]' <<< $irc_client_path )
		app_working_name=$( basename $irc_client_path_lower )
		# handles the xchat/sh/bash/dash cases, and the konversation/perl cases, where clients
		# report themselves as perl or unknown shell. IE:  when konversation starts inxi
		# from inside itself, as a script, the parent is konversation/xchat, not perl/bash etc
		# note: perl can report as: perl5.10.0, so it needs wildcard handling
		case $app_working_name in
			bash|dash|sh|python*|perl*)	# We want to know who wrapped it into the shell or perl.
				pppid="$( ps -p $PPID -o ppid --no-headers | sed 's/ //g' )"
				if [[ -n $pppid && -f /proc/$pppid/exe ]];then
					irc_client_path="$( readlink /proc/$pppid/exe )"
					irc_client_path_lower="$( tr '[:upper:]' '[:lower:]' <<< $irc_client_path )"
					app_working_name=$( basename $irc_client_path_lower )
					b_non_native_app='true'
				fi
				;;
		esac

		# replacing loose detection with tight detection, bugs will be handled with app names
		# as they appear.
		case $app_working_name in
			# check for shell first
			bash|dash|sh)
				unset IRC_CLIENT_VERSION
				IRC_CLIENT="Shell wrapper"
				;;
			# now start on irc clients, alphabetically
			bitchx)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk '
				/Version/ {
					a=tolower($2)
					gsub(/[()]|bitchx-/,"",a)
					print a
					exit
				}
				$2 == "version" {
					a=tolower($3)
					sub(/bitchx-/,"",a)
					print a
					exit
				}' )"
				B_CONSOLE_IRC='true'
				IRC_CLIENT="BitchX"
				;;
			finch)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $2
				}' )"
				B_CONSOLE_IRC='true'
				IRC_CLIENT="Finch"
				;;
			gaim)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $2
				}' )"
				IRC_CLIENT="Gaim"
				;;
			hexchat)
				# the hexchat author decided to make --version/-v return a gtk dialogue box, lol...
				# so we need to read the actual config file for hexchat. Note that older hexchats
				# used xchat config file, so test first for default, then legacy. Because it's possible
				# for this file to be use edited, doing some extra checks here.
				if [[ -f ~/.config/hexchat/hexchat.conf ]];then
					file_data="$( cat ~/.config/hexchat/hexchat.conf )"
				elif [[ -f  ~/.config/hexchat/xchat.conf ]];then
					file_data="$( cat ~/.config/hexchat/xchat.conf )"
				fi
				if [[ -n $file_data ]];then
					IRC_CLIENT_VERSION=$( gawk '
					BEGIN {
						IGNORECASE=1
						FS="="
					}
					/^[[:space:]]*version/ {
						# get rid of the space if present
						gsub(/[[:space:]]*/, "", $2 )
						print $2
						exit # usually this is the first line, no point in continuing
					}' <<< "$file_data" )
					
					IRC_CLIENT_VERSION=" $IRC_CLIENT_VERSION"
				else
					IRC_CLIENT_VERSION=' N/A'
				fi
				IRC_CLIENT="HexChat"
				;;
			ircii)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $3
				}' )"
				B_CONSOLE_IRC='true'
				IRC_CLIENT="ircII"
				;;
			irssi-text|irssi)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $2
				}' )"
				B_CONSOLE_IRC='true'
				IRC_CLIENT="Irssi"
				;;
			konversation) ## konvi < 1.2 (qt4)
				# this is necessary to avoid the dcop errors from starting inxi as a /cmd started script
				if [[ $b_non_native_app == 'true' ]];then  ## true negative is confusing
					KONVI=2
				else # if native app
					KONVI=1
				fi
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk '
				/Konversation:/ {
					for ( i=2; i<=NF; i++ ) {
						if (i == NF) {
							print $i
						}
						else {
							printf $i" "
						}
					}
					exit
				}' )"

				T=($IRC_CLIENT_VERSION)
				if [[ ${T[0]} == *+* ]];then
					# < Sho_> locsmif: The version numbers of SVN versions look like this:
					#         "<version number of last release>+ #<build number", i.e. "1.0+ #3177" ...
					#         for releases we remove the + and build number, i.e. "1.0" or soon "1.0.1"
					IRC_CLIENT_VERSION=" CVS $IRC_CLIENT_VERSION"
					T2="${T[0]/+/}"
				else
					IRC_CLIENT_VERSION=" ${T[0]}"
					T2="${T[0]}"
				fi
				# Remove any dots except the first, and make sure there are no trailing zeroes,
				T2=$( echo "$T2" | gawk '{
					sub(/\./, " ")
					gsub(/\./, "")
					sub(/ /, ".")
					printf("%g\n", $0)
				}' )
				# Since Konversation 1.0, the DCOP interface has changed a bit: dcop "$DCPORT" Konversation ..etc
				# becomes : dcop "$DCPORT" default ... or dcop "$DCPORT" irc ..etc. So we check for versions smaller
				# than 1 and change the DCOP parameter/object accordingly.
				if [[ ${T2} -lt 1 ]];then
					DCOPOBJ="Konversation"
				fi
				IRC_CLIENT="Konversation"
				;;
			kopete)
				IRC_CLIENT_VERSION=" $( kopete -v | gawk '
				/Kopete:/ {
					print $2
					exit
				}' )"
				IRC_CLIENT="Kopete"
				;;
			kvirc)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v 2>&1 | gawk '{
					for ( i=2; i<=NF; i++) {
				 		if ( i == NF ) {
				 			print $i
				 		}
				 		else {
				 			printf $i" "
				 		}
				 	}
				 	exit
				 }' )"
				IRC_CLIENT="KVIrc"
				;;
			pidgin)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $2
				}' )"
				IRC_CLIENT="Pidgin"
				;;
			quassel*)
				# sample: quassel -v
				# Qt: 4.5.0
				# KDE: 4.2.65 (KDE 4.2.65 (KDE 4.3 >= 20090226))
				# Quassel IRC: v0.4.0 [+60] (git-22effe5)
				# note: early < 0.4.1 quassels do not have -v
				IRC_CLIENT_VERSION=" $( $irc_client_path -v 2>/dev/null | gawk -F ': ' '
				BEGIN {
					IGNORECASE=1
					clientVersion=""
				}
				/Quassel IRC/ {
					clientVersion = $2
				}
				END {
					# this handles pre 0.4.1 cases with no -v
					if ( clientVersion == "" ) {
						clientVersion = "(pre v0.4.1)"
					}
					print clientVersion
				}' )"
				# now handle primary, client, and core. quasselcore doesn't actually
				# handle scripts with exec, but it's here just to be complete
				case $app_working_name in
					quassel)
						IRC_CLIENT="Quassel [M]"
						;;
					quasselclient)
						IRC_CLIENT="Quassel"
						;;
					quasselcore)
						IRC_CLIENT="Quassel (core)"
						;;
				esac
				;;
			weechat-curses)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v ) "
				B_CONSOLE_IRC='true'
				IRC_CLIENT="Weechat"
				;;
			xchat-gnome)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $2
				}' )"
				IRC_CLIENT="X-Chat-Gnome"
				;;
			xchat)
				IRC_CLIENT_VERSION=" $( $irc_client_path -v | gawk 'NR == 1 {
					print $2
				}' )"
				IRC_CLIENT="X-Chat"
				;;
			# then do some perl type searches, do this last since it's a wildcard search
			perl*|ksirc|dsirc)
				unset IRC_CLIENT_VERSION
				# KSirc is one of the possibilities now. KSirc is a wrapper around dsirc, a perl client
				get_cmdline $PPID
				for (( i=0; i <= $CMDL_MAX; i++ ))
				do
					case ${A_CMDL[i]} in
						*dsirc*)
						IRC_CLIENT="KSirc"
						# Dynamic runpath detection is too complex with KSirc, because KSirc is started from
						# kdeinit. /proc/<pid of the grandparent of this process>/exe is a link to /usr/bin/kdeinit
						# with one parameter which contains parameters separated by spaces(??), first param being KSirc.
						# Then, KSirc runs dsirc as the perl irc script and wraps around it. When /exec is executed,
						# dsirc is the program that runs inxi, therefore that is the parent process that we see.
						# You can imagine how hosed I am if I try to make inxi find out dynamically with which path
						# KSirc was run by browsing up the process tree in /proc. That alone is straightjacket material.
						# (KSirc sucks anyway ;)
						IRC_CLIENT_VERSION=" $( ksirc -v | gawk '
						/KSirc:/ {
							print $2
							exit
						}' )"
						break
						;;
					esac
				done
				B_CONSOLE_IRC='true'
				set_perl_python_konvi "$app_working_name"
				;;
			python*)
				# B_CONSOLE_IRC='true' # are there even any python type console irc clients? check.
				set_perl_python_konvi "$app_working_name"
				;;
			# then unset, set unknown data
			*)	
				IRC_CLIENT="Unknown : ${irc_client_path##*/}"
				unset IRC_CLIENT_VERSION
				;;
		esac
		if [[ $SHOW_IRC -lt 2 ]];then
			unset IRC_CLIENT_VERSION
		fi
	else
		## lets look to see if qt4_konvi is the parent.  There is no direct way to tell, so lets infer it.
		## because $PPID does not work with qt4_konvi, the above case does not work
		if [[ $B_OVERRIDE_FILTER != 'true' ]];then
			B_OUTPUT_FILTER='true'
		fi
		b_qt4_konvi=$( is_this_qt4_konvi )
		if [[ $b_qt4_konvi == 'true' ]];then
			KONVI=3
			IRC_CLIENT='Konversation'
			IRC_CLIENT_VERSION=" $( konversation -v | gawk '
				/Konversation:/ {
					for ( i=2; i<=NF; i++ ) {
						if (i == NF) {
							print $i
						}
						else {
							printf $i" "
						}
					}
					exit
				}' )"
		else
			# this should handle certain cases where it's ssh or some other startup tool
			# that falls through all the other tests
			ps_parent=$(ps -p $PPID --no-headers 2>/dev/null | gawk '{print $NF}' )
			if [[ -n $ps_parent ]];then
				IRC_CLIENT=$ps_parent
			else
				IRC_CLIENT="PPID=\"$PPID\" - empty?"
			fi
			unset IRC_CLIENT_VERSION
		fi
	fi

	log_function_data "IRC_CLIENT: $IRC_CLIENT :: IRC_CLIENT_VERSION: $IRC_CLIENT_VERSION :: PPID: $PPID"
	eval $LOGFE
}
# args: $1 - app_working_name
set_perl_python_konvi()
{
	if [[ -z $IRC_CLIENT_VERSION ]];then
		# this is a hack to try to show konversation if inxi is running but started via /cmd
		if [[ -n $( ps aux | grep -i 'konversation' | grep -v 'grep' ) && $B_RUNNING_IN_X == 'true' ]];then
			IRC_CLIENT='Konversation'
			IRC_CLIENT_VERSION=" $( konversation --version 2>/dev/null | gawk '/^Konversation/ {print $2}' )"
			B_CONSOLE_IRC='false'
		else
			IRC_CLIENT="Unknown $1 client"
		fi
	fi
}

## try to infer the use of Konversation >= 1.2, which shows $PPID improperly
## no known method of finding Kovni >= 1.2 as parent process, so we look to see if it is running,
## and all other irc clients are not running.  
is_this_qt4_konvi()
{
	local konvi_qt4_client='' konvi_dbus_exist='' konvi_pid='' konvi_home_dir='' 
	local konvi='' konvi_qt4_ver='' b_is_qt4=''
	
	# fringe cases can throw error, always if untested app, use 2>/dev/null after testing if present
	if [[ $B_QDBUS == 'true' ]];then
		konvi_dbus_exist=$( qdbus 2>/dev/null | grep "org.kde.konversation" )
	fi
	# sabayon uses /usr/share/apps/konversation as path
	if [[ -n $konvi_dbus_exist ]] && [[ -e /usr/share/kde4/apps/konversation || -e  /usr/share/apps/konversation ]]; then
		konvi_pid=$( ps -A | grep -i 'konversation' )
		konvi_pid=$( echo $konvi_pid | gawk '{ print $1 }' ) 
		konvi_home_dir=$( readlink /proc/$konvi_pid/exe )
		konvi=$( echo $konvi_home_dir | sed "s/\// /g" )
		konvi=($konvi)

		if [[ ${konvi[2]} == 'konversation' ]];then	
			konvi_qt4_ver=$( konversation -v | grep -i 'konversation' )
			# note: we need to change this back to a single dot number, like 1.3, not 1.3.2
			konvi_qt4_client=$( echo "$konvi_qt4_ver" | gawk '{ print $2 }' | cut -d '.' -f 1,2 )

			if [[ $konvi_qt4_client > 1.1 ]]; then
				b_is_qt4='true'
			fi
		fi
	else
		konvi_qt4="qt3"
		b_is_qt4='false'
	fi
	log_function_data "b_is_qt4: $b_is_qt4"
	echo $b_is_qt4
	## for testing this module
	#qdbus org.kde.konversation /irc say $1 $2 "getpid_dir: $konvi_qt4  qt4_konvi: $konvi_qt4_ver   verNum: $konvi_qt4_ver_num  pid: $konvi_pid ppid: $PPID  konvi_home_dir: ${konvi[2]}"
}

# This needs some cleanup and comments, not quite understanding what is happening, although generally output is known
# Parse the null separated commandline under /proc/<pid passed in $1>/cmdline
# args: $1 - $PPID
get_cmdline()
{
	eval $LOGFS
	local i=0 ppid=$1

	if [[ ! -e /proc/$ppid/cmdline ]];then
		echo 0
		return
	fi
	##print_screen_output "Marker"
	##print_screen_output "\$ppid='$ppid' -=- $(< /proc/$ppid/cmdline)"
	unset A_CMDL
	## note: need to figure this one out, and ideally clean it up and make it readable
	while read -d $'\0' L && [[ $i -lt 32 ]]
	do
		A_CMDL[i++]="$L" ## note: make sure this is valid - What does L mean? ##
	done < /proc/$ppid/cmdline
	##print_screen_output "\$i='$i'"
	if [[ $i -eq 0 ]];then
		A_CMDL[0]=$(< /proc/$ppid/cmdline)
		if [[ -n ${A_CMDL[0]} ]];then
			i=1
		fi
	fi
	CMDL_MAX=$i
	log_function_data "CMDL_MAX: $CMDL_MAX"
	eval $LOGFE
}

#### -------------------------------------------------------------------
#### get data types
#### -------------------------------------------------------------------
## create array of sound cards installed on system, and if found, use asound data as well
get_audio_data()
{
	eval $LOGFS
	local i='' alsa_data='' audio_driver='' device_count='' temp_array=''

	IFS=$'\n'
	# this first step handles the drivers for cases where the second step fails to find one
	device_count=$( echo "$Lspci_v_Data" | grep -iEc '(multimedia audio controller|audio device)' )
	if [[ $device_count -eq 1 ]] && [[ $B_ASOUND_DEVICE_FILE == 'true' ]];then
		audio_driver=$( gawk -F ']: ' '
		BEGIN {
			IGNORECASE=1
		}
		# filtering out modems and usb devices like webcams, this might get a
		# usb audio card as well, this will take some trial and error
		$0 !~ /modem|usb|webcam/ {
			driver=gensub( /^(.+)( - )(.+)$/, "\\1", 1, $2 )
			gsub(/^ +| +$/,"",driver)
			if ( driver != "" ){
				print driver
			}
		}' $FILE_ASOUND_DEVICE ) 
		log_function_data 'cat' "$FILE_ASOUND_DEVICE"
	fi

	# this is to safeguard against line breaks from results > 1, which if inserted into following
	# array will create a false array entry. This is a hack, not a permanent solution.
	audio_driver=$( echo $audio_driver )
	# now we'll build the main audio data, card name, driver, and port. If no driver is found,
	# and if the first method above is not null, and one card is found, it will use that instead.
	A_AUDIO_DATA=( $( echo "$Lspci_v_Data" | gawk -F ': ' -v audioDriver="$audio_driver" '
	BEGIN {
		IGNORECASE=1
	}
	/multimedia audio controller|audio device/ {
		audioCard=gensub(/^[0-9a-f:\.]+ [^:]+: (.+)$/,"\\1","g",$0)
		# The doublequotes are necessary because of the pipes in the variable.
		gsub(/'"$BAN_LIST_NORMAL"'/, "", audioCard)
		gsub(/,/, " ", audioCard)
		gsub(/^ +| +$/, "", audioCard)
		gsub(/ [ \t]+/, " ", audioCard)
		aPciBusId[audioCard] = gensub(/(^[0-9a-f:\.]+) [^:]+: .+$/,"\\1","g",$0)
		cards[audioCard]++

		# loop until you get to the end of the data block
		while (getline && !/^$/) {
			gsub( /,/, "", $0 )
			if (/driver in use/) {
				drivers[audioCard] = drivers[audioCard] gensub( /(.*): (.*)/ ,"\\2", "g" ,$0 ) ""
			}
			else if (/kernel modules:/) {
				modules[audioCard] = modules[audioCard] gensub( /(.*): (.*)/ ,"\\2" ,"g" ,$0 ) ""
			}
			else if (/I\/O/) {
				portsTemp = gensub(/\t*I\/O ports at (.*) \[.*\]/,"\\1","g",$0)
				ports[audioCard] = ports[audioCard] portsTemp " "
			}
		}
	}

	END {
		j=0
		for (i in cards) {
			useDrivers=""
			useModules=""
			usePorts=""
			usePciBusId=""
			 
			if (cards[i]>1) {
				a[j]=cards[i]"x "i
				if (drivers[i] != "") {
					useDrivers=drivers[i]
				}
			}
			else {
				a[j]=i
				# little trick here to try to catch the driver if there is
				# only one card and it was null, from the first test of asound/cards
				if (drivers[i] != "") {
					useDrivers=drivers[i]
				}
				else if ( audioDriver != "" ) {
					useDrivers=audioDriver
				}
			}
			if (ports[i] != "") {
				usePorts = ports[i]
			}
			if (modules[i] != "" ) {
				useModules = modules[i]
			}
			if ( aPciBusId[i] != "" ) {
				usePciBusId = aPciBusId[i]
			}
			# create array primary item for master array
			sub( / $/, "", usePorts ) # clean off trailing whitespace
			print a[j] "," useDrivers "," usePorts "," useModules "," usePciBusId
			j++
		}
	}') )

	# in case of failure of first check do this instead
	if [[ ${#A_AUDIO_DATA[@]} -eq 0 ]] && [[ $B_ASOUND_DEVICE_FILE == 'true' ]];then
		A_AUDIO_DATA=( $( gawk -F ']: ' '
		BEGIN {
			IGNORECASE=1
		}
		$1 !~ /modem/ && $2 !~ /modem/ {
			card=gensub( /^(.+)( - )(.+)$/, "\\3", 1, $2 )
			driver=gensub( /^(.+)( - )(.+)$/, "\\1", 1, $2 )
			if ( card != "" ){
				print card","driver
			}
		}' $FILE_ASOUND_DEVICE ) )
	fi
	IFS="$ORIGINAL_IFS"
	get_audio_usb_data
	# handle cases where card detection fails, like in PS3, where lspci gives no output, or headless boxes..
	if [[ ${#A_AUDIO_DATA[@]} -eq 0 ]];then
		A_AUDIO_DATA[0]='Failed to Detect Sound Card!'
	fi
	temp_array=${A_AUDIO_DATA[@]}
	log_function_data "A_AUDIO_DATA: $temp_array"

	eval $LOGFE
}
# alsa usb detection by damentz

get_audio_usb_data()
{
	eval $LOGFS
	local usb_proc_file='' array_count='' usb_data='' usb_id='' lsusb_path='' lsusb_data=''
	local temp_array=''
	
	IFS=$'\n'
	lsusb_path=$( type -p lsusb )
	if [[ -n $lsusb_path ]];then
		lsusb_data=$( $lsusb_path 2>/dev/null )
	fi
	log_function_data 'raw' "usb_data:\n$lsusb_data"
	if [[ -n $lsusb_data ]];then
		# for every sound card symlink in /proc/asound - display information about it
		for usb_proc_file in /proc/asound/*
		do
			# If the file is a symlink, and contains an important usb exclusive file: continue
			if [[ -L $usb_proc_file && -e $usb_proc_file/usbid  ]]; then
				# find the contents of usbid in lsusb and print everything after the 7th word on the
				# corresponding line. Finally, strip out commas as they will change the driver :)
				usb_id=$( cat $usb_proc_file/usbid )
				usb_data=$( grep "$usb_id" <<< "$lsusb_data" )
				if [[ -n $usb_data && -n $usb_id ]];then
					usb_data=$( gawk '
					BEGIN {
						IGNORECASE=1
						string=""
						separator=""
					}
					{
						gsub( /,/, " ", $0 )
						gsub(/'"$BAN_LIST_NORMAL"'/, "", $0)
						gsub(/ [ \t]+/, " ", $0)
						for ( i=7; i<= NF; i++ ) {
							string = string separator $i
							separator = " "
						}
						if ( $2 != "" ){
							sub(/:/,"", $4)
							print string ",USB Audio,,," $2 "-" $4 "," $6
						}
					}' <<< "$usb_data" )
				fi
				# this method is interesting, it shouldn't work but it does
				#A_AUDIO_DATA=( "${A_AUDIO_DATA[@]}" "$usb_data,USB Audio,," )
				# but until we learn why the above worked, I'm using this one, which is safer
				if [[ -n $usb_data ]];then
					array_count=${#A_AUDIO_DATA[@]}
					A_AUDIO_DATA[$array_count]="$usb_data"
				fi
			fi
		done
	fi
	IFS="$ORIGINAL_IFS"
	temp_array=${A_AUDIO_DATA[@]}
	log_function_data "A_AUDIO_DATA: $temp_array"
	
	eval $LOGFE
}

get_audio_alsa_data()
{
	eval $LOGFS
	local alsa_data='' temp_array=''

	# now we'll get the alsa data if the file exists
	if [[ $B_ASOUND_VERSION_FILE == 'true' ]];then
		IFS=","
		A_ALSA_DATA=( $( 
		gawk '
			BEGIN {
				IGNORECASE=1
				alsa=""
				version=""
			}
			# some alsa strings have the build date in (...)
			# remove trailing . and remove possible second line if compiled by user
			$0 !~ /compile/ {
				gsub( /Driver | [(].*[)]|\.$/,"",$0 )
				gsub(/,/, " ", $0)
				gsub(/^ +| +$/, "", $0)
				gsub(/ [ \t]+/, " ", $0)
				sub(/Advanced Linux Sound Architecture/, "ALSA", $0)
				if ( $1 == "ALSA" ){
					alsa=$1
				}
				version=$NF
				print alsa "," version
			}' $FILE_ASOUND_VERSION 
		) )
		IFS="$ORIGINAL_IFS"
		log_function_data 'cat' "$FILE_ASOUND_VERSION"
	fi
	temp_array=${A_ALSA_DATA[@]}
	log_function_data "A_ALSA_DATA: $temp_array"
	eval $LOGFE
}

## create A_CPU_CORE_DATA, currently with two values: integer core count; core string text
## return value cpu core count string, this helps resolve the multi redundant lines of old style output
get_cpu_core_count()
{
	eval $LOGFS
	if [[ $B_CPUINFO_FILE == 'true' ]]; then
		# load the A_CPU_TYPE_PCNT_CCNT core data array
		get_cpu_ht_multicore_smp_data
		## Because of the upcoming release of cpus with core counts over 6, a count of cores is given after Deca (10)
		# count the number of processors given
		local cpu_physical_count=${A_CPU_TYPE_PCNT_CCNT[1]}
		local cpu_core_count=${A_CPU_TYPE_PCNT_CCNT[2]}
		local cpu_type=${A_CPU_TYPE_PCNT_CCNT[0]}

		# match the numberic value to an alpha value
		case $cpu_core_count in
			1) cpu_alpha_count='Single';;
			2) cpu_alpha_count='Dual';;
			3) cpu_alpha_count='Triple';;
			4) cpu_alpha_count='Quad';;
			5) cpu_alpha_count='Penta';;
			6) cpu_alpha_count='Hexa';;
			7) cpu_alpha_count='Hepta';;
			8) cpu_alpha_count='Octa';;
			9) cpu_alpha_count='Ennea';;
			10) cpu_alpha_count='Deca';;
			*) cpu_alpha_count='Multi';;
		esac
		# create array, core count integer; core count string
		# A_CPU_CORE_DATA=( "$cpu_core_count" "$cpu_alpha_count Core$cpu_type" )
		A_CPU_CORE_DATA=( "$cpu_physical_count" "$cpu_alpha_count" "$cpu_type" "$cpu_core_count" )
	fi
	temp_array=${A_CPU_CORE_DATA[@]}
	log_function_data "A_CPU_CORE_DATA: $temp_array"
	eval $LOGFE
}

## main cpu data collector
get_cpu_data()
{
	eval $LOGFS
	local i='' j='' cpu_array_nu='' a_cpu_working='' multi_cpu='' bits='' temp_array=''

	if [[ $B_CPUINFO_FILE == 'true' ]];then
		# stop script for a bit to let cpu slow down before parsing cpu /proc file
		sleep $CPU_SLEEP
		IFS=$'\n'
		A_CPU_DATA=( $( 
		gawk -F': ' '
		BEGIN {
			IGNORECASE=1
			# need to prime nr for arm cpus, which do not have processor number output in some cases
			nr = 0
			count = 0
			bArm = "false"
		}
		# TAKE STRONGER NOTE: \t+ does NOT always work, MUST be [ \t]+
		# TAKE NOTE: \t+ will work for $FILE_CPUINFO, but SOME ARBITRARY FILE used for TESTING might contain SPACES!
		# Therefore PATCH to use [ \t]+ when TESTING!
		/^processor[ \t]+:/ {
			gsub(/,/, " ", $NF)
			gsub(/^ +| +$/, "", $NF)
			if ( $NF ~ "^[0-9]+$" ) {
				nr = $NF
			}
			else {
				if ( $NF ~ "^ARM" ) {
					bArm = "true"
				}
				count += 1
				nr = count - 1
				cpu[nr, "model"] = $NF
			}
		}

		/^model name|^cpu\t+:/ {
			gsub(/'"$BAN_LIST_NORMAL"'/, "", $NF )
			gsub(/'"$BAN_LIST_CPU"'/, "", $NF )
			gsub(/,/, " ", $NF)
			gsub(/^ +| +$/, "", $NF)
			gsub(/ [ \t]+/, " ", $NF)
			cpu[nr, "model"] = $NF
		}

		/^cpu MHz|^clock\t+:/ {
			if (!min) {
				min = $NF
			}
			else {
				if ($NF < min) {
					min = $NF
				}
			}

			if ($NF > max) {
				max = $NF
			}
			gsub(/MHZ/,"",$NF) ## clears out for cell cpu
			gsub(/.00[0]+$/,".00",$NF) ## clears out excessive zeros
			cpu[nr, "speed"] = $NF
		}

		/^cache size/ {
			cpu[nr, "cache"] = $NF
		}

		/^flags|^features/ {
			cpu[nr, "flags"] = $NF
		}

		/^bogomips/ {
			cpu[nr, "bogomips"] = $NF
		}

		/vendor_id/ {
			gsub(/genuine|authentic/,"",$NF)
			cpu[nr, "vendor"] = tolower( $NF )
		}

		END {
			#if (!nr) { print ",,,"; exit } # <- should this be necessary or should bash handle that
			for ( i = 0; i <= nr; i++ ) {
				# note: assuming bogomips for arm at 1 x clock
				# http://en.wikipedia.org/wiki/BogoMips ARM could change so watch this
				# maybe add:  && bArm == "true" but I think most of the bogomips roughly equal cpu speed if not amd/intel
				if ( cpu[i, "bogomips"] != "" && cpu[i, "speed"] == "" ) {
					cpu[i, "speed"] = cpu[i, "bogomips"]
				}
				print cpu[i, "model"] "," cpu[i, "speed"] "," cpu[i, "cache"] "," cpu[i, "flags"] "," cpu[i, "bogomips"] ","  cpu[nr, "vendor"]
			}
			# this is / was used in inxi short output only, but when it is N/A, need to use the previous array
			# value, from above, the actual speed that is, for short output, key 0.
			if (!min) {
				print "N/A"
				exit
			}
			else {
				if (min != max) {
					printf("Min:%s%s Max:%s%s\n", min, "Mhz", max, "Mhz")
				}
				else {
					printf("%s %s\n", max, "Mhz")
				}
			}
		}
 		' $FILE_CPUINFO ) )
		log_function_data 'cat' "$FILE_CPUINFO"
	fi
	IFS="$ORIGINAL_IFS"
	temp_array=${A_CPU_DATA[@]}
	log_function_data "A_CPU_DATA: $temp_array"
# 	echo ta: ${temp_array[@]}
	eval $LOGFE
# 	echo getMainCpu: ${[@]}
}

## this is for counting processors and finding HT types
get_cpu_ht_multicore_smp_data()
{
	eval $LOGFS
	# in /proc/cpuinfo
	local temp_array=''

	if [[ $B_CPUINFO_FILE == 'true' ]]; then
		A_CPU_TYPE_PCNT_CCNT=( $(
		gawk '
		BEGIN {
			FS=": "
			IGNORECASE = 1
			num_of_cores = 0
			num_of_processors = 0
			num_of_cpus = 0
			cpu_core_count = 0
			core_id[0]
			processor_id[0]
			cpu_id[0]
			type = "-"
			iter = 0
			# needed to handle arm cpu, no processor number cases
			count = 0
			nr = 0
			bArm = "false"
		}
		# array of logical processors, both HT and physical
		/^processor/ {
			gsub(/,/, " ", $NF)
			gsub(/^ +| +$/, "", $NF)
			if ( $NF ~ "^[0-9]+$" ) {
				processor_id[iter] = $NF
			}
			else {
				if ( $NF ~ "^ARM" ) {
					bArm = "true"
				}
				count += 1
				nr = count - 1
				processor_id[iter] = nr
			}
			
		}
		# array of physical cpus ids
		/^physical/ {
			cpu_id[iter] = $NF
		}
		# array of core ids
		/^core id/ {
			core_id[iter] = $NF
			iter++
		}
		# this will be used to fix an intel glitch if needed, cause, intel
		# sometimes reports core id as the same number for each core, 0
		# so if cpu cores shows greater value than number of cores, use this
		/^cpu cores/ {
			cpu_core_count = $NF
		}
		END {
			## 	Look thru the array and filter same numbers.
			##	only unique numbers required
			## 	this is to get an accurate count
			##	we are only concerned with array length
			
			i = 0
			## count unique processors ##
			# note, this fails for intel cpus at times
			for ( i in processor_id ) {
				procHolder[processor_id[i]] = 1
			}
			for ( i in procHolder ) {
				num_of_processors++
			}
			
			i = 0
			## count unique physical cpus ##
			for ( i in cpu_id ) {
				cpuHolder[cpu_id[i]] = 1
			}
			for ( i in cpuHolder ) {				
				num_of_cpus++
			}
			
			i = 0		
			## count unique cores ##
			for ( i in core_id ) {
				coreHolder[core_id[i]] = 1
			}
			for ( i in coreHolder ) {				
				num_of_cores++
			}
			# final check, override the num of cores value if it clearly is wrong
			# and use the raw core count and synthesize the total instead of real count
			if ( ( num_of_cores == 1 ) && ( cpu_core_count * num_of_cpus > 1 ) ) {
				num_of_cores = cpu_core_count * num_of_cpus
			}
			
			####################################################################
			# 				algorithm
			# if > 1 processor && processor id (physical id) == core id then Hyperthreaded (HT)
			# if > 1 processor && processor id (physical id) != core id then Multi-Core Processors (MCP)
			# if > 1 processor && processor ids (physical id) > 1 then Multiple Processors (SMP)
			# if = 1 processor then single core/processor Uni-Processor (UP)
			if ( num_of_processors > 1 )
			{
				# non-multicore HT
				if ( num_of_processors == (num_of_cores * 2))
				{
					type = type "HT-"
				}
				# non-HT multi-core or HT multi-core
				if (( num_of_processors == num_of_cores) ||
					( num_of_cpus < num_of_cores))
				{
					type = type "MCP-"
				}
				# >1 cpu sockets active
				if ( num_of_cpus > 1 )
				{
					type = type "SMP-"
				}
			} else {
				type = type "UP-"
			}			
			
			print type " " num_of_cpus " " num_of_cores
		}
		' $FILE_CPUINFO ) )
	fi
	temp_array=${A_CPU_TYPE_PCNT_CCNT[@]}
	log_function_data "A_CPU_TYPE_PCNT_CCNT: $temp_array"
	eval $LOGFE
}

# Detect desktop environment in use, initial rough logic from: compiz-check
# http://forlong.blogage.de/entries/pages/Compiz-Check
get_desktop_environment()
{
	eval $LOGFS
	
	# set the default, this function only runs in X, if null, don't print data out
	local desktop_environment='' xprop_root='' ps_aux='' 
	local version='' version_data='' toolkit=''
	
	if [[ -n $( type -p xprop ) ]];then
		xprop_root="$( xprop -root 2>/dev/null )"
	fi

	# note that cinnamon split from gnome, and and can now be id'ed via xprop,
	# but it will still trigger the next gnome true case, so this needs to go before gnome test
	# eventually this needs to be better organized so all the xprop tests are in the same
	# section, but this is good enough for now.
	if [[ -n $xprop_root && -n $( grep -is '^_MUFFIN' <<< "$xprop_root" ) ]];then
		version=$( get_de_app_version 'cinnamon' '^cinnamon' '2' )
		# not certain cinn will always have version, so keep output right if not
		if [[ -n $version ]];then
			version="$version "
		fi
		if [[ $B_EXTRA_DATA == 'true' ]];then
			toolkit=$( get_de_gtk_data )
			if [[ -n $toolkit ]];then
				version="${version}(Gtk ${toolkit})"
			fi
		fi
		desktop_environment="Cinnamon"
	elif [[ -n $xprop_root && -n $( grep -is '^_MARCO' <<< "$xprop_root" ) ]];then
		version=$( get_de_app_version 'mate-about' '^MATE[[:space:]]DESKTOP' 'NF' )
		# not certain cinn/mate will always have version, so keep output right if not
		if [[ -n $version ]];then
			version="$version "
		fi
		if [[ $B_EXTRA_DATA == 'true' ]];then
			toolkit=$( get_de_gtk_data )
			if [[ -n $toolkit ]];then
				version="${version}(Gtk ${toolkit})"
			fi
		fi
		desktop_environment="MATE"
	# note, GNOME_DESKTOP_SESSION_ID is deprecated so we'll see how that works out
	# https://bugzilla.gnome.org/show_bug.cgi?id=542880
	elif [[ -n $GNOME_DESKTOP_SESSION_ID ]]; then
		version=$( get_de_app_version 'gnome-about' 'gnome' '3' )
		if [[ $B_EXTRA_DATA == 'true' ]];then
			toolkit=$( get_de_gtk_data )
			if [[ -n $toolkit ]];then
				version="$version (Gtk $toolkit)"
			fi
		fi
		desktop_environment="Gnome"
	# assume 5 will id the same, why not, no need to update in future
	elif [[ $KDE_SESSION_VERSION == '5' ]]; then
		version_data=$( kded5 --version 2>/dev/null )
		version=$( grep -si '^KDE Development Platform:' <<< "$version_data" | gawk '{print $4}' )
		if [[ -z $version ]];then
			version='5'
		fi
		if [[ $B_EXTRA_DATA == 'true' ]];then
			toolkit=$( grep -si '^Qt:' <<< "$version_data" | gawk '{print $2}' )
			if [[ -n $toolkit ]];then
				version="$version (Qt $toolkit)"
			fi
		fi
		desktop_environment="KDE"
	elif [[ $KDE_SESSION_VERSION == '4' ]]; then
		version_data=$( kded4 --version 2>/dev/null )
		version=$( grep -si '^KDE Development Platform:' <<< "$version_data" | gawk '{print $4}' )
		if [[ -z $version ]];then
			version='4'
		fi
		if [[ $B_EXTRA_DATA == 'true' ]];then
			toolkit=$( grep -si '^Qt:' <<< "$version_data" | gawk '{print $2}' )
			if [[ -n $toolkit ]];then
				version="$version (Qt $toolkit)"
			fi
		fi
		desktop_environment="KDE"
	# KDE_FULL_SESSION property is only available since KDE 3.5.5.
	# src: http://humanreadable.nfshost.com/files/startkde
	elif [[ $KDE_FULL_SESSION == 'true' ]]; then
		version_data=$( kded --version 2>/dev/null )
		version=$( grep -si '^KDE:' <<< "$version_data" | gawk '{print $2}' )
		# version=$( get_de_app_version 'kded' '^KDE:' '2' )
		if [[ -z $version ]];then
			version='3.5'
		fi
		if [[ $B_EXTRA_DATA == 'true' ]];then
			toolkit=$( grep -si '^Qt:' <<< "$version_data" | gawk '{print $2}' )
			if [[ -n $toolkit ]];then
				version="$version (Qt $toolkit)"
			fi
		fi
		desktop_environment="KDE"
	# now that the primary ones have been handled, next is to find the ones with unique
	# xprop detections possible
	else
		ps_aux="$( ps aux )"
		if [[ -n $xprop_root ]];then
			# String: "This is xfdesktop version 4.2.12"
			if [[ -n $( grep -Eis '\"xfce4\"' <<< "$xprop_root" ) ]];then
				version=$( get_de_app_version 'xfdesktop' 'xfdesktop[[:space:]]version' '5' )
				if [[ -z $version ]];then
					version='4'
				fi
				if [[ $B_EXTRA_DATA == 'true' ]];then
					toolkit=$( get_de_app_version 'xfdesktop' 'Built[[:space:]]with[[:space:]]GTK' '4' )
					if [[ -n $toolkit ]];then
						version="$version (Gtk $toolkit)"
					fi
				fi
				desktop_environment="Xfce"
			# when 5 is released, the string may need updating
			elif [[ -n $( grep -is '\"xfce5\"' <<< "$xprop_root" ) ]];then
				version=$( get_de_app_version 'xfdesktop' 'xfdesktop[[:space:]]version' '5' )
				if [[ -z $version ]];then
					version='5'
				fi
				if [[ $B_EXTRA_DATA == 'true' ]];then
					toolkit=$( get_de_app_version 'xfdesktop' 'Built[[:space:]]with[[:space:]]GTK' '4' )
					if [[ -n $toolkit ]];then
						version="$version (Gtk $toolkit)"
					fi
				fi
				desktop_environment="Xfce"
			elif [[ -n $( grep -is 'BLACKBOX_PID' <<< "$xprop_root" ) ]];then
				if [[ -n $( grep -is 'fluxbox' <<< "$ps_aux" | grep -v 'grep' ) ]];then
					version=$( get_de_app_version 'fluxbox' '^fluxbox' '2' )
					desktop_environment='Fluxbox'
				else
					desktop_environment='Blackbox'
				fi
			elif [[ -n $( grep -is 'OPENBOX_PID' <<< "$xprop_root" ) ]];then
				version=$( get_de_app_version 'openbox' '^openbox' '2' )
				if [[ -n $( grep -is 'lxde' <<< "$ps_aux" | grep -v 'grep' ) ]];then
					if [[ -n $version ]];then
						version="(Openbox $version)"
					fi
					desktop_environment='LXDE'
				elif [[ -n $( grep -is 'razor-desktop' <<< "$ps_aux" | grep -v 'grep' ) ]];then
					if [[ -n $version ]];then
						version="(Openbox $version)"
					fi
					desktop_environment='Razor-QT'
				else
					desktop_environment='Openbox'
				fi
			elif [[ -n $( grep -is 'ICEWM' <<< "$xprop_root" ) ]];then
				version=$( get_de_app_version 'icewm' '^icewm' '2' )
				desktop_environment='IceWM'
			elif [[ -n $( grep -is 'ENLIGHTENMENT' <<< "$xprop_root" ) ]];then
				# no -v or --version but version is in xprop -root
				# ENLIGHTENMENT_VERSION(STRING) = "Enlightenment 0.16.999.49898"
				version=$( grep -is 'ENLIGHTENMENT_VERSION' <<< "$xprop_root" | cut -d '"' -f 2 | gawk '{print $2}' )
				desktop_environment='Enlightenment'
			elif [[ -n $( grep -is '^I3_' <<< "$xprop_root" ) ]];then
				version=$( get_de_app_version 'i3' '^i3' '3' )
				desktop_environment='i3'
			elif [[ -n $( grep -is 'WINDOWMAKER' <<< "$xprop_root" ) ]];then
				version=$( get_de_app_version 'wmaker' '^Window[[:space:]]*Maker' 'NF' )
				if [[ -n $version ]];then
					version="$version "
				fi
				desktop_environment="WindowMaker"
			elif [[ -n $( grep -is '^_WM2' <<< "$xprop_root" ) ]];then
				# note; there isn't actually a wm2 version available but error handling should cover it and return null
				# maybe one day they will add it?
				version=$( get_de_app_version 'wm2' '^wm2' 'NF' )
				# not certain will always have version, so keep output right if not
				if [[ -n $version ]];then
					version="$version "
				fi
				desktop_environment="WM2"
			fi
		fi
		# a few manual hacks for things that don't id with xprop, these are just good guesses
		# note that gawk is going to exit after first occurance of search string, so no need for extra
		if [[ -z $desktop_environment ]];then
			if [[ -n $( grep -is 'fvwm-crystal'  <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'fvwm' '^fvwm' '2' )
				desktop_environment='FVWM-Crystal'
			elif [[ -n $( grep -is 'fvwm'  <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'fvwm' '^fvwm' '2' )
				desktop_environment='FVWM'
			elif [[ -n $( grep -is 'pekwm'  <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'pekwm' '^pekwm' '3' )
				desktop_environment='pekwm'
			elif [[ -n $( grep -is 'awesome' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'awesome' '^awesome' '2' )
				desktop_environment='Awesome'
			elif [[ -n $( grep -is 'scrotwm' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'scrotwm' '^welcome.*scrotwm' '4' )
				desktop_environment='Scrotwm' # no --version for this one
			elif [[ -n $( grep -Eis '([[:space:]]|/)twm' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				desktop_environment='Twm' # no --version for this one
			elif [[ -n $( grep -Eis '([[:space:]]|/)dwm' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'dwm' '^dwm' '1' )
				desktop_environment='dwm'
			elif [[ -n $( grep -is 'wmii2' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'wmii2' '^wmii2' '1' )
				desktop_environment='wmii2'
			# note: in debian at least, wmii is actuall wmii3
			elif [[ -n $( grep -is 'wmii' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'wmii' '^wmii' '1' )
				desktop_environment='wmii'
			elif [[ -n $( grep -Eis '([[:space:]]|/)jwm' <<< "$ps_aux" | grep -v 'grep' ) ]];then
				version=$( get_de_app_version 'jwm' '^jwm' '2' )
				desktop_environment='JWM'
			fi
		fi
	fi
	if [[ -n $version ]];then
		version=" $version"
	fi
	echo "$desktop_environment${version}"
	eval $LOGFE
}

# note: gawk doesn't support white spaces in search string, gave errors, so use [[:space:]] instead
# args: $1 - desktop/app command for --version; $2 - search string; $3 - gawk print number
get_de_app_version()
{
	local version_data='' version='' get_version='--version' 
	
	# mate-about -v = MATE Desktop Environment 1.4.0
	case $1 in
		dwm|jwm|mate-about|wmii|wmii2)
			get_version='-v'
			;;
	esac
	
	case $1 in
		# note, some wm/apps send version info to stderr instead of stdout
		dwm|ksh|scrotwm)
			version_data="$( $1 $get_version 2>&1 )"
			;;
		# quick debian/buntu hack until I find a universal way to get version for these
		csh|dash)
			if [[ -n $( type -p dpkg ) ]];then
				version_data="$( dpkg -l $1 2>/dev/null )"
			fi
			;;
		*)
			version_data="$( $1 $get_version 2>/dev/null )"
			;;
	esac
	
	if [[ -n $version_data ]];then
		version=$( gawk '
		BEGIN {
			IGNORECASE=1
		}
		/'$2'/ {
			# sample: dwm-5.8.2, ©.. etc, why no space? who knows. Also get rid of v in number string
			# xfce, and other, output has , in it, so dump all commas
			gsub(/(,|dwm-|wmii2-|wmii-|v|V)/, "",$'$3') 
			print $'$3'
			exit # quit after first match prints
		}' <<< "$version_data" )
	fi
	echo $version
}

get_desktop_extra_data()
{
	eval $LOGFS
	local de_data=$( ps -A | gawk '
	BEGIN {
		IGNORECASE=1
		desktops=""
		separator=""
	}
	/(gnome-shell|gnome-panel|kicker|lxpanel|mate-panel|plasma-desktop|xfce4-panel)$/ {
		# only one entry per type, can be multiple
		if ( desktops !~ $NF ) {
			desktops = desktops separator $NF
			separator = ","
		}
	}
	END {
		print desktops
	}
	' )
	echo $de_data
	
	eval $LOGFE
}

get_de_gtk_data()
{
	eval $LOGFS
	
	local toolkit=''
	
	# this is a hack, and has to be changed with every toolkit version change
	toolkit=$( pkg-config --modversion gtk+-4.0 2>/dev/null )
	if [[ -z $toolkit ]];then
		toolkit=$( pkg-config --modversion gtk+-3.0 2>/dev/null )
	fi
	if [[ -z $toolkit ]];then
		toolkit=$( pkg-config --modversion gtk+-2.0 2>/dev/null )
	fi
	echo $toolkit
	
	eval $LOGFE
}

# see which dm has started if any
get_display_manager()
{
	eval $LOGFS
	# ldm - LTSP display manager
	local dm_id_list='entranced.pid entrance/entranced.pid gdm.pid gdm3.pid kdm.pid ldm.pid lightdm.pid lxdm.pid mdm.pid nodm.pid slim.lock tint2.pid wdm.pid xdm.pid' 
	local dm_id='' dm='' separator=''
	# note we don't need to filter grep if we do it this way
	local ps_aux="$( ps aux )"
	local x_is_running=$( grep '/usr.*/X' <<< "$ps_aux" | grep -iv '/Xprt' )

	for dm_id in $dm_id_list
	do
		if [[ -e /var/run/$dm_id || -e /run/$dm_id ]];then
			# just on the off chance that two dms are running, good info to have in that case, if possible
			dm=$dm$separator$( basename $dm_id | cut -d '.' -f 1 )
			separator=','
		fi
	done
	# might add this in, but the rate of new dm's makes it more likely it's an unknown dm, so
	# we'll keep output to N/A
	if [[ -n $x_is_running && -z $dm ]];then
		if [[ -n $( grep 'startx$' <<< "$ps_aux" ) ]];then
			dm='(startx)'
		fi
	fi
	echo $dm

	log_function_data "display manager: $dm"

	eval $LOGFE
}

# for more on distro id, please reference this python thread: http://bugs.python.org/issue1322
## return distro name/id if found
get_distro_data()
{
	eval $LOGFS
	local i='' j='' distro='' distro_file='' a_distro_glob='' temp_array=''

	# get the wild carded array of release/version /etc files if present
	shopt -s nullglob
	cd /etc
	# note: always exceptions, so wild card after release/version: /etc/lsb-release-crunchbang
	# wait to handle since crunchbang file is one of the few in the world that uses this method
	a_distro_glob=(*[-_]{release,version})
	cd "$OLDPWD"
	shopt -u nullglob
	
	temp_array=${a_distro_glob[@]}
	log_function_data "A_GLX_DATA: $temp_array"

	if [[ ${#a_distro_glob[@]} -eq 1 ]];then
		distro_file="${a_distro_glob}"
	# use the file if it's in the known good lists
	elif [[ ${#a_distro_glob[@]} -gt 1 ]];then
		for i in $DISTROS_DERIVED $DISTROS_PRIMARY
		do
			# Only echo works with ${var[@]}, not print_screen_output() or script_debugger()
			# This is a known bug, search for the word "strange" inside comments
			# echo "i='$i' a_distro_glob[@]='${a_distro_glob[@]}'"
			if [[ " ${a_distro_glob[@]} " == *" $i "* ]];then
				# Now lets see if the distro file is in the known-good working-lsb-list
				# if so, use lsb-release, if not, then just use the found file
				# this is for only those distro's with self named release/version files
				# because Mint does not use such, it must be done as below 
				## this if statement requires the spaces and * as it is, else it won't work
				##
				if [[ " $DISTROS_LSB_GOOD " == *" ${i} "* ]] && [[ $B_LSB_FILE == 'true' ]];then
					distro_file='lsb-release'
				elif [[ " $DISTROS_OS_RELEASE_GOOD " == *" ${i} "* ]] && [[ $B_OS_RELEASE_FILE == 'true' ]];then
					distro_file='os-release'
				else
					distro_file="${i}"
				fi
				break
			fi
		done
	fi
	log_function_data "distro_file: $distro_file"
	# first test for the legacy antiX distro id file
	if [[ -e /etc/antiX ]];then
		distro="$( grep -Eoi 'antix.*\.iso' <<< $( remove_erroneous_chars '/etc/antiX' ) | sed 's/\.iso//' )"
	# this handles case where only one release/version file was found, and it's lsb-release. This would
	# never apply for ubuntu or debian, which will filter down to the following conditions. In general
	# if there's a specific distro release file available, that's to be preferred, but this is a good backup.
	elif [[ -n $distro_file && $B_LSB_FILE == 'true' && " $DISTROS_LSB_GOOD" == *" $distro_file "* ]];then
		distro=$( get_distro_lsb_os_release_data 'lsb-file' )
	elif [[ $distro_file == 'lsb-release' ]];then
		distro=$( get_distro_lsb_os_release_data 'lsb-file' )
	elif [[ $distro_file == 'os-release' ]];then
		distro=$( get_distro_lsb_os_release_data 'os-release-file' )
	# then if the distro id file was found and it's not in the exluded primary distro file list, read it
	elif [[ -n $distro_file && -s /etc/$distro_file && " $DISTROS_EXCLUDE_LIST " != *" $distro_file "* ]];then
		# new opensuse uses os-release, but older ones may have a similar syntax, so just use the first line
		if [[ $distro_file == 'SuSE-release' ]];then
			# leaving off extra data since all new suse have it, in os-release, this file has line breaks, like os-release
			# but in case we  want it, it's: CODENAME = Mantis  | VERSION = 12.2 
			# for now, just take first occurance, which should be the first line, which does not use a variable type format
			distro=$( grep -i -m 1 'suse' /etc/$distro_file )
		else
			distro=$( remove_erroneous_chars "/etc/$distro_file" )
		fi
	# otherwise try  the default debian/ubuntu /etc/issue file
	elif [[ -f /etc/issue ]];then
		# lsb gives more manageable and accurate output than issue, but mint should use issue for now
		# some bashism, boolean must be in parenthesis to work correctly, ie [[ $(boolean) ]] not [[ $boolean ]]
		if [[ $B_LSB_FILE == 'true' ]] && [[ -z $( grep -i 'mint' /etc/issue ) ]];then
			distro=$( get_distro_lsb_os_release_data 'lsb-file' )
		else
			distro=$( gawk '
			BEGIN {
				RS=""
			}
			{
				gsub(/\\[a-z]/, "")
				gsub(/,/, " ")
				gsub(/^ +| +$/, "")
				gsub(/ [ \t]+/, " ")
				print
			}' /etc/issue )
			
			# this handles an arch bug where /etc/arch-release is empty and /etc/issue is corrupted
			# only older arch installs that have not been updated should have this fallback required, new ones use
			# os-release
			if [[ -n $( grep -i 'arch linux' <<< $distro ) ]];then
				distro='Arch Linux'
			fi
		fi
	fi
	
	if [[ ${#distro} -gt 80 ]] && [[ $B_HANDLE_CORRUPT_DATA != 'true' ]];then
		distro="${RED}/etc/${distro_file} corrupted, use -% to override${NORMAL}"
	fi
	## note: would like to actually understand the method even if it's not used
	# : ${distro:=Unknown distro o_O}
	## test for /etc/lsb-release as a backup in case of failure, in cases where > one version/release file
	## were found but the above resulted in null distro value
	if [[ -z $distro ]] && [[ $B_LSB_FILE == 'true' ]];then
		distro=$( get_distro_lsb_os_release_data 'lsb-file' )
	fi
	if [[ -z $distro ]] && [[ $B_OS_RELEASE_FILE == 'true' ]];then
		distro=$( get_distro_lsb_os_release_data 'os-release-file' )
	fi
	# now some final null tries
	if [[ -z $distro ]];then
		# if the file was null but present, which can happen in some cases, then use the file name itself to 
		# set the distro value. Why say unknown if we have a pretty good idea, after all?
		if [[ -n $distro_file ]] && [[ " $DISTROS_DERIVED $DISTROS_PRIMARY " == *" $distro_file "* ]];then
			distro=$( sed -r -e 's/[-_]//' -e 's/(release|version)//' <<< $distro_file | sed -r 's/^([a-z])/\u\1/' )
		fi
		## finally, if all else has failed, give up
		if [[ -z $distro ]];then
			distro='unknown'
		fi
	fi
	# final step cleanup of unwanted information
	# opensuse has the x86 etc type string in names, not needed as redundant since -S already shows that
	distro=$( gawk '
	BEGIN {
		IGNORECASE=1
	}
	{
		sub(/ *\(*(x86_64|i486|i586|i686|686|586|486)\)*/, "", $0)
		print $0
	}' <<< $distro )
	echo "$distro"
	log_function_data "distro: $distro"
	eval $LOGFE
}

# args: $1 - lsb-file/lsb-app/os-release-file
get_distro_lsb_os_release_data()
{
	eval $LOGFS
	local distro=''
	
	case $1 in
		lsb-file)
			if [[ $B_LSB_FILE == 'true' ]];then
				distro=$( gawk -F '=' '
				BEGIN {
					IGNORECASE=1
				}
				# clean out unwanted characters
				{ 
					gsub(/\\|\"|[:\47]/,"", $0 )
					gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2 )
					gsub(/^[[:space:]]+|[[:space:]]+$/, "", $1 )
				}
				# note: adding the spacing directly to variable to make sure distro output is null if not found
				/^DISTRIB_ID/ {
					# this is needed because grep for "arch" is too loose to be safe
					if ( $2 == "arch" ) {
						distroId = "Arch Linux"
					}
					else if ( $2 != "n/a" ) {
						distroId = $2 " "
					}
				}
				/^DISTRIB_RELEASE/ {
					if ( $2 != "n/a" ) {
						distroRelease = $2 " "
					}
				}
				/^DISTRIB_CODENAME/ {
					if ( $2 != "n/a" ) {
						distroCodename = $2 " "
					}
				}
				# sometimes some distros cannot do their lsb-release files correctly, so here is
				# one last chance to get it right.
				/^DISTRIB_DESCRIPTION/ {
s					if ( $2 != "n/a" ) {
						distroDescription = $2
					}
				}
				END {
					fullString=""
					if ( distroId == "" && distroRelease == "" && distroCodename == "" && distroDescription != "" ){
						fullString = distroDescription
					}
					else {
						fullString = distroId distroRelease distroCodename
					}
					print fullString
				}
				' $FILE_LSB_RELEASE )
				log_function_data 'cat' "$FILE_LSB_RELEASE"
			fi
			;;
		lsb-app)
			# this is HORRIBLY slow, not using
			if [[  -n $( type -p lsb_release ) ]];then
				distro=$( echo "$( lsb_release -irc )" | gawk -F ':' '
				BEGIN { 
					IGNORECASE=1 
				}
				# clean out unwanted characters
				{ 
					gsub(/\\|\"|[:\47]/,"", $0 )
					gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2 )
					gsub(/^[[:space:]]+|[[:space:]]+$/, "", $1 )
				}
				/^Distributor ID/ {
					distroId = $2
				}
				/^Release/ {
					distroRelease = $2
				}
				/^Codename/ {
					distroCodename = $2
				}
				END {
					print distroId " " distroRelease " (" distroCodename ")"
				}' )
			fi
			;;
		os-release-file)
			if [[ $B_OS_RELEASE_FILE == 'true' ]];then
				distro=$( gawk -F '=' '
				BEGIN {
					IGNORECASE=1
					prettyName=""
					regularName=""
					versionName=""
					versionId=""
					distroName=""
				}
				# clean out unwanted characters
				{ 
					gsub(/\\|\"|[:\47]/,"", $0 )
					gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2 )
					gsub(/^[[:space:]]+|[[:space:]]+$/, "", $1 )
				}
				# note: adding the spacing directly to variable to make sure distro output is null if not found
				/^PRETTY_NAME/ {
					if ( $2 != "n/a" ) {
						prettyName = $2
					}
				}
				/^NAME/ {
					if ( $2 != "n/a" ) {
						regularName = $2
					}
				}
				/^VERSION/ {
					if ( $2 != "n/a" && $1 == "VERSION" ) {
						versionName = $2
					}
					else if ( $2 != "n/a" && $1 == "VERSION_ID" ) {
						versionId = $2
					}
				}
				END {
					if ( prettyName != "" ) {
						distroName = prettyName
					}
					else if ( regularName != "" ) {
						distroName = regularName
						if ( versionName != "" ) {
							distroName = distroName " " versionName
						}
						else if ( versionId != "" ) {
							distroName = distroName " " versionId
						}
						
					}
					print distroName
				}
				' $FILE_OS_RELEASE )
				log_function_data 'cat' "$FILE_OS_RELEASE"
			fi
			;;
	esac
	echo $distro
	log_function_data "distro: $distro"
	eval $LOGFE
}

get_dmidecode_data()
{
	eval $LOGFS
	
	local dmidecodePath=''

	if [[ $B_DMIDECODE_SET != 'true' ]];then
		dmidecodePath=$( type -p dmidecode 2>/dev/null )
		if [[ -n $dmidecodePath ]];then
			# note stripping out these lines: Handle 0x0016, DMI type 17, 27 bytes
			# but NOT deleting them, in case the dmidecode data is missing empty lines which will be
			# used to separate results. Then we remove the doubled empty lines to keep it clean and
			# strip out all the stuff we don't want to see in the results.
			DMIDECODE_DATA="$( $dmidecodePath 2>/dev/null \
			| gawk -F ':' '
			BEGIN {
				IGNORECASE=1
				cutExtraTab="false"
			}
			{
				if ( $2 != "" ) {
					twoHolder="true"
				}
				else {
					twoHolder="false"
				}
				if ( $0 ~ /^\tDMI type/ ) {
					sub(/^\tDMI type.*/, "", $0)
					cutExtraTab="true"
				}
				gsub(/'"$BAN_LIST_NORMAL"'/, "", $2)
				gsub(/,/, " ", $0)
				# clean out Handle line
				sub(/^Handle.*/,"", $0)
				sub(/^[[:space:]]*Inactive.*/,"",$0)
				# yes, there is a typo in a user data set, unknow
				# Base Board Version|Base Board Serial Number
				# Chassis Manufacturer|Chassis Version|Chassis Serial Number
				# System manufacturer|System Product Name|System Version
				# To Be Filled By O.E.M.
				sub(/^Base Board .*|^Chassis .*|.*O\.E\.M\..*|.*OEM.*|^Not .*|^System .*|.*unknow.*|.*N\/A.*|none|^To be filled.*/, "", $2) 
				gsub(/bios|acpi/, "", $2)
				sub(/http:\/\/www.abit.com.tw\//, "Abit", $2)
				
				# for double indented values replace with ~ so later can test for it, we are trusting that
				# indentation will be tabbed in this case
				# special case, dmidecode 2.2 has an extra tab and a DMI type line
				if ( cutExtraTab == "true" ) {
					sub(/^\t\t\t+/, "~", $1)
				}
				else {
					sub(/^\t\t+/, "~", $1)
				}
				
				gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2)
				gsub(/^[[:space:]]+|[[:space:]]+$/, "", $1)
				gsub(/ [ \t]+/, " ", $2)
				# reconstructing the line for processing so gawk can use -F : again
				if ( $1 != "" && twoHolder == "true" ) {
					print $1 ":" $2
				}
				else {
					print $0
				}
			}' \
			| sed '/^$/{
N
/^\n$/D
}' \
			)"
		fi
		B_DMIDECODE_SET='true'
		log_function_data "DMIDECODE_DATA: $DMIDECODE_DATA"
	fi

	eval $LOGFE
}
# get_dmidecode_data;echo "$DMIDECODE_DATA";exit
get_gcc_kernel_version()
{
	# note that we use gawk to get the last part because beta, alpha, git versions can be non-numeric
	local gccVersion=$( grep -Eio 'gcc[[:space:]]*version[[:space:]]*([^ \t]*)' /proc/version 2>/dev/null | gawk '{print $3}' )
	echo $gccVersion
}

get_gcc_system_version()
{
	eval $LOGFS
	local separator='' gcc_installed='' gcc_list='' gcc_others='' temp_array=''
	local gcc_version=$( 
	gcc --version 2>/dev/null | sed -r 's/\([^\)]*\)//g' | gawk '
	BEGIN {
		IGNORECASE=1
	}
	/^gcc/ {
		print $2
		exit
	}'
	)

	# can't use xargs -l basename because not all systems support thats
	if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
		gcc_others=$( ls /usr/bin/gcc-* 2>/dev/null )
		if [[ -n $gcc_others ]];then
			for item in $gcc_others
			do
				gcc_installed=$( basename $item | gawk -F '-' '
				$2 ~ /^[0-9\.]+$/ {
					print $2
				}' )
				if [[ -n $gcc_installed && -z $( grep "^$gcc_installed" <<< $gcc_version ) ]];then
					gcc_list=$gcc_list$separator$gcc_installed
					separator=','
				fi
			done
		fi
	fi
	if [[ -n $gcc_version ]];then
		A_GCC_VERSIONS=( "$gcc_version" $gcc_list )
	fi
	temp_array=${A_GCC_VERSIONS[@]}
	log_function_data "A_GCC_VERSIONS: $temp_array"
	eval $LOGFE
}
get_gpu_temp_data()
{
	local gpu_temp='' gpu_fan='' screens='' screen_nu='' gpu_temp_looper=''

	# we'll try for nvidia/ati, then add if more are shown
	if [[ -n $( type -p nvidia-settings ) ]];then
		# first get the number of screens
		screens=$( nvidia-settings -q screens | gawk '
		/:[0-9]\.[0-9]/ {
			screens=screens gensub(/(.*)(:[0-9]\.[0-9])(.*)/, "\\2", "1", $0) " "
		}
		END {
			print screens
		}
		' )
		# now we'll get the gpu temp for each screen discovered. The print out function
		# will handle removing screen data for single gpu systems
		for screen_nu in $screens
		do
			gpu_temp_looper=$( nvidia-settings -c $screen_nu -q GPUCoreTemp | gawk -F ': ' '
			BEGIN {
				IGNORECASE=1
				gpuTemp=""
				gpuTempWorking=""
			}
			/Attribute (.*)[0-9]+\.$/ {
				gsub(/\./, "", $2)
				if ( $2 ~ /^[0-9]+$/ ) {
					gpuTemp=gpuTemp $2 "C "
				}
			}
			END {
				print gpuTemp
			}'
			)
			screen_nu=$( cut -d ':' -f 2 <<< $screen_nu )
			gpu_temp="$gpu_temp$screen_nu:$gpu_temp_looper "
		done
	elif [[ -n $( type -p aticonfig ) ]];then
# 		gpu_temp=$( aticonfig --adapter=0 --od-gettemperature | gawk -F ': ' '
		gpu_temp=$( aticonfig --adapter=all --od-gettemperature | gawk -F ': ' '
		BEGIN {
			IGNORECASE=1
			gpuTemp=""
			gpuTempWorking=""
		}
		/Sensor (.*)[0-9\.]+ / {
			gpuTempWorking=gensub(/(.*) ([0-9\.]+) (.*)/, "\\2", "1", $2)
			if ( gpuTempWorking ~ /^[0-9\.]+$/ ) {
				gpuTemp=gpuTemp gpuTempWorking "C "
			}
		}
		END {
			print gpuTemp
		}'
		)
	# this handles some newer cases of free driver temp readouts, will require modifications as
	# more user data appears.
	elif [[ -n $Sensors_Data ]];then
		gpu_temp=$( 
		gawk '
		BEGIN {
			IGNORECASE=1
			gpuTemp=""
			separator=""
		}
		/^('"$SENSORS_GPU_SEARCH"')-pci/ {
			while ( getline && !/^$/  ) {
				if ( /^temp/ ) {
					sub(/^[[:alnum:]]*.*:/, "", $0 ) # clear out everything to the :
					gsub(/[\+ \t°]/, "", $1) # ° is a special case, like a space for gawk
					gpuTemp=gpuTemp separator $1
					separator=","
				}	
			}
		}
		END {
			print gpuTemp
		}' <<< "$Sensors_Data"
		)
	fi
	
	if [[ -n $gpu_temp ]];then
		echo $gpu_temp
	fi
}

## for possible future data, not currently used
get_graphics_agp_data()
{
	eval $LOGFS
	local agp_module=''

	if [[ $B_MODULES_FILE == 'true' ]];then
		## not used currently
		agp_module=$( gawk '
		/agp/ && !/agpgart/ && $3 > 0 {
			print(gensub(/(.*)_agp.*/,"\\1","g",$1))
		}' $FILE_MODULES )
		log_function_data 'cat' "$FILE_MODULES"
	fi
	log_function_data "agp_module: $agp_module"
	eval $LOGFE
}

## create array of gfx cards installed on system
get_graphics_card_data()
{
	eval $LOGFS
	local i='' temp_array=''

	IFS=$'\n'
	A_GFX_CARD_DATA=( $( gawk -F': ' '
	BEGIN {
		IGNORECASE=1
		busId=""
	}
	/vga compatible controller/ {
		gsub(/'"$BAN_LIST_NORMAL"'/, "", $NF)
		gsub(/,/, " ", $NF)
		gsub(/^ +| +$/, "", $NF)
		gsub(/ [ \t]+/, " ", $NF)
		busId=gensub(/^([0-9a-f:\.]+) (.+)$/,"\\1","",$1)
		print $NF "," busId
	}' <<< "$Lspci_v_Data" ) )
	IFS="$ORIGINAL_IFS"
# 	for (( i=0; i < ${#A_GFX_CARD_DATA[@]}; i++ ))
# 	do
# 		A_GFX_CARD_DATA[i]=$( sanitize_characters BAN_LIST_NORMAL "${A_GFX_CARD_DATA[i]}" )
# 	done

	# GFXMEM is UNUSED at the moment, because it shows AGP aperture size, which is not necessarily equal to GFX memory..
	# GFXMEM="size=[$(echo "$Lspci_v_Data" | gawk '/VGA/{while (!/^$/) {getline;if (/size=[0-9][0-9]*M/) {size2=gensub(/.*\[size=([0-9]+)M\].*/,"\\1","g",$0);if (size<size2){size=size2}}}}END{print size2}')M]"
	temp_array=${A_GFX_CARD_DATA[@]}
	log_function_data "A_GFX_CARD_DATA: $temp_array"
	eval $LOGFE
}

get_graphics_driver()
{
	eval $LOGFS
	
	# list is from sgfxi plus non-free drivers
	local driver_list='apm|ark|ati|chips|cirrus|cyrix|fbdev|fglrx|glint|i128|i740|intel|i810|imstt|mach64|mga|neomagic|nsc|nv|nvidia|openchrome|nouveau|radeon|radeonhd|rendition|s3|s3virge|savage|siliconmotion|sis|sisusb|tdfx|tga|trident|tseng|unichrome|vboxvideo|vesa|vga|via|voodoo|vmware|v4l'
	local driver='' driver_string='' xorg_log_data='' status='' temp_array=''

	if [[ $B_XORG_LOG == 'true' ]];then
		A_GRAPHIC_DRIVERS=( $(
		gawk '
		BEGIN {
			driver=""
		}
		/[[:space:]]Loading.*('"$driver_list"')_drv.so$/ {
			driver=gensub(/.*[[:space:]]Loading.*('"$driver_list"')_drv.so/, "\\1", 1, $0 )
			# we get all the actually loaded drivers first, we will use this to compare the
			# failed/unloaded, which have not always actually been truly loaded
 			aDrivers[driver]="loaded" 
		}
		/Unloading[[:space:]].*('"$driver_list"')(|_drv.so)$/ {
			driver=gensub(/(.*)Unloading[[:space:]].*('"$driver_list"')(|_drv.so)$/, "\\2", 1, $0 )
			# we need to make sure that the driver has already been truly loaded, not just discussed
			if ( driver in aDrivers ) {
				aDrivers[driver]="unloaded"
			}
		}
		/Failed.*('"$driver_list"')_drv.so|Failed.*\"('"$driver_list"')\"/ {
 			driver=gensub(/(.*)Failed.*('"$driver_list"')_drv.so/, "\\2", 1, $0 )
			if ( driver == $0 ) {
				driver=gensub(/(.*)Failed.*\"('"$driver_list"')\".*|fred/, "\\2", 1, $0 )
			}
			# we need to make sure that the driver has already been truly loaded, not just discussed
			if ( driver != $0 && driver in aDrivers ) {
				aDrivers[driver]="failed"
			}
		}
		END {
			for ( driver in aDrivers ) {
				print driver "," aDrivers[driver]
			}
		}' < $FILE_XORG_LOG
		) )
	fi
	temp_array=${A_GRAPHIC_DRIVERS[@]}
	log_function_data "A_GRAPHIC_DRIVERS: $temp_array"
	
	eval $LOGFE
}

## create array of glx data
get_graphics_glx_data()
{
	eval $LOGFS
	local temp_array=''
	if [[ $B_SHOW_X_DATA == 'true' && $B_ROOT != 'true' ]];then
		IFS=$'\n'
		A_GLX_DATA=( $( glxinfo | gawk -F ': ' '
		# note: function declarations go before BEGIN? It appears so, confirm.
		# the real question here though is why this function is even here, seems
		# just to be a complicated way to pack/print a variable, but maybe the
		# original idea was to handle > 1 cases of detections I guess
		function join( arr, sep ) {
			s=""
			i=flag=0
			for ( i in arr ) {
				if ( flag++ ) {
					s = s sep
				}
				s = s i
			}
			return s
		}

		BEGIN {
			IGNORECASE=1
		}
		/opengl renderer/ {
			gsub(/'"$BAN_LIST_NORMAL"'/, "", $2)
			gsub(/ [ \t]+/, " ", $2) # get rid of the created white spaces
			gsub(/^ +| +$/, "", $2)
			if ( $2 ~ /mesa/ ) {
				# Allow all mesas
# 				if ( $2 ~ / r[3-9][0-9][0-9] / ) {
					a[$2]
					# this counter failed in one case, a bug, and is not needed now
# 					f++
# 				}
				next
			}
			
			$2 && a[$2]
		}
		# dropping all conditions from this test to just show full mesa information
		# there is a user case where not f and mesa apply, atom mobo
		# /opengl version/ && ( f || $2 !~ /mesa/ ) {
		/opengl version/ {
			# fglrx started appearing with this extra string, does not appear to communicate anything of value
			sub(/Compatibility Profile Context/, "- CPC", $2 )
			gsub(/ [ \t]+/, " ", $2) # get rid of the created white spaces
			gsub(/^ +| +$/, "", $2)
			$2 && b[$2]
		}
		/direct rendering/ {
			$2 && c[$2]
		}
		END {
			printf( "%s\n%s\n%s\n", join( a, ", " ), join( b, ", " ), join( c, ", " ) )
		}' ) )
		IFS="$ORIGINAL_IFS"

		# GLXR=$(glxinfo | gawk -F ': ' 'BEGIN {IGNORECASE=1} /opengl renderer/ && $2 !~ /mesa/ {seen[$2]++} END {for (i in seen) {printf("%s ",i)}}')
		#    GLXV=$(glxinfo | gawk -F ': ' 'BEGIN {IGNORECASE=1} /opengl version/ && $2 !~ /mesa/ {seen[$2]++} END {for (i in seen) {printf("%s ",i)}}')
	fi
	temp_array=${A_GLX_DATA[@]}
	log_function_data "A_GLX_DATA: $temp_array"
	eval $LOGFE
}

## return screen resolution / tty resolution
get_graphics_res_data()
{
	eval $LOGFS
	local screen_resolution='' xdpy_data='' screens_count=0

	if [[ $B_SHOW_X_DATA == 'true' && $B_ROOT != 'true' ]];then
		# Added the two ?'s , because the resolution is now reported without spaces around the 'x', as in
		# 1400x1050 instead of 1400 x 1050. Change as of X.org version 1.3.0
		xdpy_data="$( xdpyinfo )"
		xdpy_count=$( grep -c 'dimensions' <<< "$xdpy_data" )
		# we get a bit more info from xrandr than xdpyinfo, but xrandr fails to handle
		# multiple screens from different video cards
		if [[ $xdpy_count -eq 1 ]];then
			screen_resolution=$( xrandr | gawk '
			/\*/ {
				res[++m] = gensub(/^.* ([0-9]+) ?x ?([0-9]+)[_ ].* ([0-9\.]+)\*.*$/,"\\1x\\2@\\3hz","g",$0)
			}
			END {
				for (n in res) {
					if (res[n] ~ /^[[:digit:]]+x[[:digit:]]+/) {
						line = line ? line ", " res[n] : res[n]
					}
				}
				if (line) {
					print(line)
				}
			}' )
		fi
		if [[ -z $screen_resolution || $xdpy_count -gt 1 ]];then
			screen_resolution=$( gawk '
			BEGIN {
				IGNORECASE=1
				screens = ""
				separator = ""
			}
			/dimensions/ {
				screens = screens separator # first time, this is null, next, has comma last
				screens = screens $2 # then tack on the new value for nice comma list
				separator = ", "
			}
			END {
				print screens
			}' <<< "$xdpy_data" )
		fi
	else
		screen_resolution=$( stty -F $( readlink /proc/$PPID/fd/0 ) size | gawk '{
			print $2"x"$1
		}' )
	fi
	echo "$screen_resolution"
	log_function_data "screen_resolution: $screen_resolution"
	eval $LOGFE
}

## create array of x vendor/version data
get_graphics_x_data()
{
	eval $LOGFS
	local x_vendor='' x_version='' temp_array='' xdpy_info='' a_x_working=''

	if [[ $B_SHOW_X_DATA == 'true' && $B_ROOT != 'true' ]];then
		# X vendor and version detection.
		# new method added since radeon and X.org and the disappearance of <X server name> version : ...etc
		# Later on, the normal textual version string returned, e.g. like: X.Org version: 6.8.2
		# A failover mechanism is in place. (if $x_version is empty, the release number is parsed instead)
		# xdpy_info="$( xdpyinfo )"
		IFS=","
		a_x_working=( $( xdpyinfo | gawk -F': +' '
		BEGIN {
			IGNORECASE=1
			vendorString=""
			version=""
			vendorRelease=""
		}
		/vendor string/ {
			gsub(/the|inc|foundation|project|corporation/, "", $2)
			gsub(/,/, " ", $2)
			gsub(/^ +| +$/, "", $2)
			gsub(/ [ \t]+/, " ", $2)
			vendorString = $2
		}
		/version:/ {
			version = $NF
		}
		/vendor release number/ {
			gsub(/0+$/, "", $2)
			gsub(/0+/, ".", $2)
			vendorRelease = $2
		}
		END {
			print vendorString "," version "," vendorRelease
		}' ) )
		x_vendor=${a_x_working[0]}
		x_version=${a_x_working[1]}

		# this gives better output than the failure last case, which would only show:
		# for example: X.org: 1.9 instead of: X.org: 1.9.0
		if [[ -z $x_version ]];then
			x_version=$( get_graphics_x_version )
		fi
		if [[ -z $x_version ]];then
			x_version=${a_x_working[2]}
		fi
		
		# some distros, like fedora, report themselves as the xorg vendor, so quick check
		# here to make sure the vendor string includes Xorg in string
		if [[ -z $( grep -E '(X|xorg|x\.org)' <<< $x_vendor ) ]];then
			x_vendor="$x_vendor X.org"
		fi
		IFS="$ORIGINAL_IFS"
		A_X_DATA[0]="$x_vendor"
		A_X_DATA[1]="$x_version"
	else
		x_version=$( get_graphics_x_version )
		if [[ -n $x_version ]];then
			x_vendor='X.org'
			A_X_DATA[0]="$x_vendor"
			A_X_DATA[1]="$x_version"
		fi
	fi
	temp_array=${A_X_DATA[@]}
	log_function_data "A_X_DATA: $temp_array"
	eval $LOGFE
}

# if other tests fail, try this one, this works for root, out of X also
get_graphics_x_version()
{
	eval $LOGFS
	local x_version='' x_data=''
	# note that some users can have /usr/bin/Xorg but not /usr/bin/X
	if [[ -n $( type -p X ) ]];then
		# note: MUST be this syntax: X -version 2>&1
		# otherwise X -version overrides everything and this comes out null.
		# two knowns id strings: X.Org X Server 1.7.5 AND X Window System Version 1.7.5
		#X -version 2>&1 | gawk '/^X Window System Version/ { print $5 }'
		x_data="$( X -version 2>&1 )"
	elif [[ -n $( type -p Xorg ) ]];then
		x_data="$( Xorg -version 2>&1)"
	fi
	if [[ -n $x_data ]];then
		x_version=$( 
		gawk '
		BEGIN {
			IGNORECASE=1
		}
		/^x.org x server/ {
			print $4
			exit
		}
		/^X Window System Version/ {
			print $5
			exit
		}' <<< "$x_data"
		)
	fi
	echo $x_version
	log_function_data " x_version: $x_version"
	eval $LOGFE
}

# this gets just the raw data, total space/percent used and disk/name/per disk capacity
get_hdd_data_basic()
{
	eval $LOGFS
	local hdd_used='' temp_array=''
	local hdd_data="$( df -P --exclude-type=aufs --exclude-type=squashfs --exclude-type=unionfs --exclude-type=devtmpfs --exclude-type=tmpfs --exclude-type=iso9660 )"
	log_function_data 'raw' "hdd_data:\n$hdd_data"
	
	hdd_used=$( echo "$hdd_data" | gawk '
	# also handles odd dm-1 type, from lvm
	/^\/dev\/(mapper\/|[hsv]d[a-z][0-9]+|dm[-]?[0-9]+)/ {
		# this handles the case where the first item is too long
		# and makes df wrap output to next line, so here we advance
		# it to the next line for that single case. Using df -P should
		# make this unneeded but leave it in just in case
		if ( NF < 5 && $0 !~ /.*%/ ) {
			getline
		}
		# if the first item caused a wrap, use one less than standard
		# testing for the field with % in it, ie: 34%, then go down from there
		# this also protects against cases where the mount point has a space in the
		# file name, thus breaking going down from $NF directly.
		if ( $4 ~ /.*%/ ) {
			used += $2
		}
		# otherwise use standard
		else if ( $5 ~ /.*%/ ) {
			used += $3
		}
		# and if this is not detected, give up, we need user data to debug
		else {
			next
		}
	}
	END {
		print used
	}' )

	if [[ -z $hdd_used ]];then
		hdd_used='na'
	fi
	log_function_data "hdd_used: $hdd_used"
	# create the initial array strings:
	# disk-dev, capacity, name, usb or not
	# final item is the total of the disk
	IFS=$'\n'

	if [[ $B_PARTITIONS_FILE == 'true' ]];then
		A_HDD_DATA=( $(
		gawk -v hddused="$hdd_used" '
		/[hsv]d[a-z]$/ {
			driveSize = $(NF - 1)*1024/1000**3
			gsub(/,/, " ", driveSize)
			gsub(/^ +| +$/, "", driveSize)
			printf( $NF",%.1fGB,,\n", driveSize )
		}
		# See http://lanana.org/docs/device-list/devices-2.6+.txt for major numbers used below
		# $1 ~ /^(3|22|33|8)$/ && $2 % 16 == 0  {
		#	size += $3
		# }
		# special case from this data: 8     0  156290904 sda
		# note: vm has 252 known starter
		$1 ~ /^(3|8|22|33|252)$/ && $NF ~ /[hsv]d[a-z]$/ && ( $2 % 16 == 0 || $2 % 16 == 8 ) {
			size += $3
		}

		END {
			size = size*1024/1000**3                   # calculate size in GB size
			workingUsed = hddused*1024/1000**3         # calculate workingUsed in GB used
			# this handles a special case with livecds where no hdd_used is detected
			if ( size > 0 && hddused == "na" ) {
				size = sprintf( "%.1f", size )
				print size "GB,-"
			}
			else if ( size > 0 && workingUsed > 0 ) {
				diskUsed = workingUsed*100/size  # calculate used percentage
				diskUsed = sprintf( "%.1f", diskUsed )
				size = sprintf( "%.1f", size )
				print size "GB," diskUsed "% used"
			}
			else {
				print "NA,-" # print an empty array, this will be further handled in the print out function
			}
		}' $FILE_PARTITIONS 
		) )

		log_function_data 'cat' "$FILE_PARTITIONS"
	fi
	IFS="$ORIGINAL_IFS"
	temp_array=${A_HDD_DATA[@]}
	log_function_data "A_HDD_DATA: $temp_array"
	eval $LOGFE
}

## fills out the A_HDD_DATA array with disk names
get_hard_drive_data_advanced()
{
	eval $LOGFS
	local a_temp_working='' a_temp_scsi='' temp_holder='' temp_name='' i='' j=''
	local sd_ls_by_id='' ls_disk_by_id='' usb_exists='' temp_array=''

	## check for all ide type drives, non libata, only do it if hdx is in array
	## this is now being updated for new /sys type paths, this may handle that ok too
	if [[ -n $( grep -E 'hd[a-z]' <<< ${A_HDD_DATA[@]} ) ]];then
		# remember, we're using the last array item to store the total size of disks
		for (( i=0; i < ${#A_HDD_DATA[@]} - 1; i++ ))
		do
			IFS=","
			a_temp_working=( ${A_HDD_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			if [[ -n $( grep -E '^hd[a-z]' <<< ${a_temp_working[0]} ) ]];then
				if [[ -e /proc/ide/${a_temp_working[0]}/model ]];then
					a_temp_working[2]="$( remove_erroneous_chars /proc/ide/${a_temp_working[0]}/model )"
				else
					a_temp_working[2]="Name n/a"
				fi
				# these loops are to easily extend the cpu array created in the gawk script above with more fields per cpu.
				for (( j=0; j < ${#a_temp_working[@]}; j++ ))
				do
					if [[ $j -gt 0 ]];then
						A_HDD_DATA[i]="${A_HDD_DATA[i]},${a_temp_working[$j]}"
					else
						A_HDD_DATA[i]="${a_temp_working[$j]}"
					fi
				done
			fi
		done
	fi

	## then handle libata names
	# first get the ata device names, put them into an array
	IFS=$'\n'
	if [[ $B_SCSI_FILE == 'true' ]]; then
		a_temp_scsi=( $( gawk  '
		BEGIN {
			IGNORECASE=1
		}
		/host/ {
			getline a[$0]
			getline b[$0]
		}
		END {
			for (i in a) {
				if (b[i] ~ / *type: *direct-access.*/) {
					#c=gensub(/^ *vendor: (.+) +model: (.+) +rev: (.+)$/,"\\1 \\2 \\3","g",a[i])
					#c=gensub( /^ *vendor: (.+) +model: (.+) +rev:.*$/,"\\1 \\2","g",a[i] )
					# the vendor: string is useless, and is a bug, ATA is not a vendor for example
					c=gensub( /^ *vendor: (.+) +model: (.+) +rev:.*$/, "\\2", "g", a[i] )
					gsub(/,/, " ", c)
					gsub(/^ +| +$/, "", c)
					gsub(/ [ \t]+/, " ", c)
					#print a[i]
					# we actually want this data, so leaving this off for now
# 					if (c ~ /\<flash\>|\<pendrive\>|memory stick|memory card/) {
# 						continue
# 					}
					print c
				}
			}
		}' $FILE_SCSI ) )
		log_function_data 'cat' "$FILE_SCSI"
	fi
	IFS="$ORIGINAL_IFS"

	## then we'll loop through that array looking for matches.
	if [[ -n $( grep -E 'sd[a-z]' <<< ${A_HDD_DATA[@]} ) ]];then
		# first pack the main ls variable so we don't have to keep using ls /dev...
		# not all systems have /dev/disk/by-id
		ls_disk_by_id="$( ls -l /dev/disk/by-id 2>/dev/null )"
		for (( i=0; i < ${#A_HDD_DATA[@]} - 1; i++ ))
		do
			if [[ -n $( grep -E '^sd[a-z]' <<< ${A_HDD_DATA[$i]} ) ]];then
				IFS=","
				a_temp_working=( ${A_HDD_DATA[$i]} )
				IFS="$ORIGINAL_IFS"
				# /sys/block/[sda,hda]/device/model
				# this is handles the new /sys data types first
				if [[ -e /sys/block/${a_temp_working[0]}/device/model ]];then
					temp_name="$( remove_erroneous_chars /sys/block/${a_temp_working[0]}/device/model )"
					temp_name=$( tr ' ' '_' <<< $temp_name | cut -d '-' -f 1 )
				elif [[ ${#a_temp_scsi[@]} -gt 0 ]];then
					for (( j=0; j < ${#a_temp_scsi[@]}; j++ ))
					do
						## ok, ok, it's incomprehensible, search /dev/disk/by-id for a line that contains the
						# discovered disk name AND ends with the correct identifier, sdx
						# get rid of whitespace for some drive names and ids, and extra data after - in name
						temp_name=$( tr ' ' '_' <<< ${a_temp_scsi[$j]} | cut -d '-' -f 1 )
						sd_ls_by_id=$( grep -Em1 ".*$temp_name.*${a_temp_working[0]}$" <<< "$ls_disk_by_id" )

						if [[ -n $sd_ls_by_id ]];then
							temp_name=${a_temp_scsi[$j]}
							break
						else
							# test to see if we can get a better name output when null
							if [[ -n $temp_name ]];then
								temp_name=$temp_name
							fi
						fi
					done
				fi
				
				if [[ -z $temp_name ]];then
					temp_name="Name n/a"
				else 
					usb_exists=$( grep -Em1 "usb-.*$temp_name.*${a_temp_working[0]}$" <<< "$ls_disk_by_id" )
					if [[ -n $usb_exists ]];then
						a_temp_working[3]='USB'
					fi
				fi
				a_temp_working[2]=$temp_name
				# these loops are to easily extend the cpu array created in the gawk script above with more fields per cpu.
				for (( j=0; j < ${#a_temp_working[@]}; j++ ))
				do
					if [[ $j -gt 0 ]];then
						A_HDD_DATA[i]="${A_HDD_DATA[i]},${a_temp_working[$j]}"
					else
						A_HDD_DATA[i]="${a_temp_working[$j]}"
					fi
				done
			fi
		done
		unset ls_disk_by_id # and then let's dump the data we don't need
	fi
	temp_array=${A_HDD_DATA[@]}
	log_function_data "A_HDD_DATA: $temp_array"
	eval $LOGFE
}

# args: $1 - which drive to get serial number of
get_hdd_serial_number()
{
	eval $LOGFS
	
	local hdd_serial=''
	
	get_partition_dev_data 'id'
	
	# lrwxrwxrwx 1 root root  9 Apr 26 09:32 scsi-SATA_ST3160827AS_5MT2HMH6 -> ../../sdc
	# exit on the first instance
	hdd_serial=$( gawk '
	/'$1'$/ {
		serial=gensub( /^(.+)_([^_]+)$/, "\\2", 1, $9 )
		print serial
		exit
	}' <<< "$DEV_DISK_ID"
	)
	
	echo $hdd_serial
	log_function_data "hdd serial: $hdd_serial"
	eval $LOGFE
}

# a few notes, normally hddtemp requires root, but you can set user rights in /etc/sudoers.
# args: $1 - /dev/<disk> to be tested for
get_hdd_temp_data()
{
	eval $LOGFS
	local hdd_temp='' sudo_command='' 

	if [[ $B_HDDTEMP_TESTED != 'true' ]];then
		B_HDDTEMP_TESTED='true'
		HDDTEMP_PATH=$( type -p hddtemp )
	fi
	if [[ $B_SUDO_TESTED != 'true' ]];then
		B_SUDO_TESTED='true'
		SUDO_PATH=$( type -p sudo )
	fi
	
	if [[ -n $HDDTEMP_PATH && -n $1 ]];then
		# only use sudo if not root, -n option requires sudo -V 1.7 or greater. sudo will just error out
		# which is the safest course here for now, otherwise that interactive sudo password thing is too annoying
		# important: -n makes it non interactive, no prompt for password
		if [[ $B_ROOT != 'true' && -n $SUDO_PATH ]];then
			sudo_command='sudo -n '
		fi
		# this will fail if regular user and no sudo present, but that's fine, it will just return null
		hdd_temp=$( eval $sudo_command $HDDTEMP_PATH -nq -u C $1 )
		if [[ -n $hdd_temp && -n $( grep -E '^([0-9\.]+)$' <<< $hdd_temp ) ]];then
			echo $hdd_temp
		fi
	fi
	eval $LOGFE
}

# args: $1 - v/n 
get_lspci_data()
{
	eval $LOGFS
	local lspci_data="$( lspci -$1 | gawk '{
		gsub(/\(prog-if[^)]*\)/,"")
		sub(/^0000:/, "", $0) # seen case where the 0000: is prepended, rare, but happens
		print
	}' )"
	
	echo "$lspci_data"
	log_function_data 'raw' "lspci_data $1:\n$lspci_data"
	eval $LOGFE
}

# args: $1 - busid
get_lspci_vendor_product()
{
	eval $LOGFS
	
	local vendor_product=''
	
	vendor_product=$( gawk '
	/^'$1'/ {
		if ( $3 != "" ) {
			print $3
		}
	}' <<< "$Lspci_n_Data" )
	
	echo $vendor_product
	
	eval $LOGFE
}

get_machine_data()
{
	eval $LOGFS
	local temp_array='' separator='' id_file='' file_data='' array_string=''
	local id_dir='/sys/class/dmi/id/' dmi_name='' dmi_data='' 
	local machine_files="
	sys_vendor product_name product_version product_serial product_uuid 
	board_vendor board_name board_version board_serial 
	bios_vendor bios_version bios_date 
	"
	local dmi_names="
	system-manufacturer system-product-name system-version system-serial-number system-uuid 
	baseboard-manufacturer baseboard-product-name baseboard-version baseboard-serial-number 
	bios-vendor bios-version bios-release-date 
	"
	if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
		machine_files="$machine_files
		chassis_vendor chassis_type chassis_version chassis_serial
		"
		dmi_names="$dmi_names
		chassis-manufacturer chassis-type chassis-version chassis-serial-number
		"
	fi
	if [[ -d $id_dir ]];then
		for id_file in $machine_files
		do
			file_data=''
			if [[ -r $id_dir$id_file ]];then
				file_data=$( gawk '
				BEGIN {
					IGNORECASE=1
				}
				{
					gsub(/'"$BAN_LIST_NORMAL"'/, "", $0)
					gsub(/,/, " ", $0)
					# yes, there is a typo in a user data set, unknow
					# Base Board Version|Base Board Serial Number
					# Chassis Manufacturer|Chassis Version|Chassis Serial Number
					# System manufacturer|System Product Name|System Version
					# To Be Filled By O.E.M.
					sub(/^Base Board .*|^Chassis .*|.*O\.E\.M\..*|.*OEM.*|^Not .*|^System .*|.*unknow.*|.*N\/A.*|none|^To be filled.*/, "", $0) 
					gsub(/bios|acpi/, "", $0)
					sub(/http:\/\/www.abit.com.tw\//, "Abit", $0)
					gsub(/^ +| +$/, "", $0)
					gsub(/ [ \t]+/, " ", $0)
					print $0
				}' < $id_dir$id_file
				)
			fi
			array_string="$array_string$separator$file_data"
			separator=','
		done
	else
		get_dmidecode_data
		if [[ -n $DMIDECODE_DATA ]];then
			if [[ $B_ROOT == 'true' ]];then
				# this handles very old systems, like Lenny 2.6.26, with dmidecode, but no data
				if [[ -n $( grep -i 'no smbios or dmi' <<< "$DMIDECODE_DATA" ) ]];then
					array_string='dmidecode-no-smbios-dmi-data'
				# please note: only dmidecode version 2.11 or newer supports consistently the -s flag
				else
					for dmi_name in $dmi_names
					do
			# 			echo "$dmi_name" >&2
						dmi_data=''
						dmi_data=$( dmidecode -s $dmi_name | gawk '
							BEGIN {
								IGNORECASE=1
							}
							{
								gsub(/'"$BAN_LIST_NORMAL"'/, "", $0)
								gsub(/,/, " ", $0)
								# yes, there is a typo in a user data set, unknow
								# Base Board Version|Base Board Serial Number
								# Chassis Manufacturer|Chassis Version|Chassis Serial Number
								# System manufacturer|System Product Name|System Version
								# To Be Filled By O.E.M.
								sub(/^Base Board .*|^Chassis .*|.*O\.E\.M\..*|.*OEM.*|^Not .*|^System .*|.*unknow.*|.*N\/A.*|none|^To be filled.*/, "", $0) 
								gsub(/bios|acpi/, "", $0)
								sub(/http:\/\/www.abit.com.tw\//, "Abit", $0)
								gsub(/^ +| +$/, "", $0)
								gsub(/ [ \t]+/, " ", $0)
								print $0
							}' )
						array_string="$array_string$separator$dmi_data"
						separator=','
					done
				fi
			else
				array_string='dmidecode-non-root-user'
			fi
		fi
	fi
	IFS=','
	A_MACHINE_DATA=( $array_string )
	IFS="$ORIGINAL_IFS"
	temp_array=${A_MACHINE_DATA[@]}
	# echo ${temp_array[@]}
	log_function_data "A_MACHINE_DATA: $temp_array"
	eval $LOGFE
}

## return memory used/installed
get_memory_data()
{
	eval $LOGFS
	local memory=''
	if [[ $B_MEMINFO_FILE == 'true' ]];then
		memory=$( gawk '
		/^MemTotal:/ {
			tot = $2
		}
		/^(MemFree|Buffers|Cached):/ {
			notused+=$2
		}
		END {
			used = tot-notused
			printf("%.1f/%.1fMB\n", used/1024, tot/1024)
		}' $FILE_MEMINFO )
		log_function_data 'cat' "$FILE_MEMINFO"
	fi
	echo "$memory"
	log_function_data "memory: $memory"
	eval $LOGFE
}

# process and return module version data
get_module_version_number()
{
	eval $LOGFS
	local module_version=''
	
	if [[ $B_MODINFO_TESTED != 'true' ]];then
		B_MODINFO_TESTED='true'
		MODINFO_PATH=$( type -p modinfo )
	fi

	if [[ -n $MODINFO_PATH ]];then
		module_version=$( $MODINFO_PATH $1 2>/dev/null | gawk '
		BEGIN {
			IGNORECASE=1
		}
		/^version/ {
			gsub(/,/, " ", $2)
			gsub(/^ +| +$/, "", $2)
			gsub(/ [ \t]+/, " ", $2)
			print $2
		}
		' )
	fi

	echo "$module_version"
	log_function_data "module_version: $module_version"
	eval $LOGFE
}

## create array of network cards
get_networking_data()
{
	eval $LOGFS
	
	local B_USB_NETWORKING='false' temp_array=''
	
	IFS=$'\n'
	A_NETWORK_DATA=( $( 
	echo "$Lspci_v_Data" | gawk '
	BEGIN {
		IGNORECASE=1
		counter=0 # required to handle cases of > 1 instance of the same chipset
	}
	/^[0-9a-f:\.]+ (ethernet|network) (controller|bridge)/ || /^[0-9a-f:\.]+ [^:]+: .*(ethernet|network).*$/ {
		nic=gensub(/^[0-9a-f:\.]+ [^:]+: (.+)$/,"\\1","g",$0)
		gsub(/realtek semiconductor/, "Realtek", nic)
		gsub(/davicom semiconductor/, "Davicom", nic)
		# The doublequotes are necessary because of the pipes in the variable.
		gsub(/'"$BAN_LIST_NORMAL"'/, "", nic)
		gsub(/,/, " ", nic)
		gsub(/^ +| +$/, "", nic)
		gsub(/ [ \t]+/, " ", nic)
		# construct a unique string ending for each chipset detected, this allows for
		# multiple instances of the same exact chipsets, ie, dual gigabit 
		nic = nic "~~" counter++
		aPciBusId[nic] = gensub(/(^[0-9a-f:\.]+) [^:]+: .+$/,"\\1","g",$0)
		# I do not understand why incrementing a string index makes sense? 
		eth[nic]++ 
		while ( getline && !/^$/ ) {
			gsub(/,/, "", $0)
			if ( /I\/O/ ) {
				ports[nic] = ports[nic] $4 " "
			}
			if ( /driver in use/ ) {
				drivers[nic] = drivers[nic] gensub( /(.*): (.*)/ ,"\\2" ,"g" ,$0 ) ""
			}
			else if ( /kernel modules/ ) {
				modules[nic] = modules[nic] gensub( /(.*): (.*)/ ,"\\2" ,"g" ,$0 ) ""
			}
		}
	}

	END {
		j=0
		for (i in eth) {
			useDrivers=""
			usePorts=""
			useModules=""
			usePciBusId=""

			if ( eth[i] > 1 ) {
				a[j] = eth[i] "x " i
			}
			else {
				a[j] = i
			}	
			## note: this loses the plural ports case, is it needed anyway?
			if ( ports[i] != "" ) {
				usePorts = ports[i]
			}
			if ( drivers[i] != "" ) {
				useDrivers = drivers[i]
			}
			if ( modules[i] != "" ) {
				useModules = modules[i]
			}
			if ( aPciBusId[i] != "" ) {
				usePciBusId = aPciBusId[i]
			}
			# create array primary item for master array
			# and strip out the counter again, this handled dual cards with same chipset
			sub( /~~[0-9]+$/, "", a[j] )
			sub( / $/, "", usePorts ) # clean off trailing whitespace
			print a[j] "," useDrivers "," usePorts "," useModules, "," usePciBusId
			j++
		}
	}'
	) )
	IFS="$ORIGINAL_IFS"
	get_networking_usb_data
	if [[ $B_SHOW_ADVANCED_NETWORK == 'true' || $B_USB_NETWORKING == 'true' ]];then
		get_network_advanced_data
	fi
	temp_array=${A_NETWORK_DATA[@]}
	log_function_data "A_NETWORK_DATA: $temp_array"
	
	eval $LOGFE
}

get_network_advanced_data()
{
	eval $LOGFS
	local a_network_adv_working='' if_path='' working_path='' working_uevent_path='' dir_path=''
	local if_id='' speed='' duplex='' mac_id='' oper_state=''  vendor_product=''
	local usb_data='' usb_vendor='' usb_product='' product_path='' driver_test=''
	
	for (( i=0; i < ${#A_NETWORK_DATA[@]}; i++ ))
	do
		IFS=","
		a_network_adv_working=( ${A_NETWORK_DATA[i]} )
		# reset these every go round
		driver_test=''
		if_id='' 
		speed='' 
		duplex='' 
		mac_id='' 
		oper_state=''
		usb_data=''
		vendor_product=''
		if [[ -z $( grep '^usb-' <<< ${a_network_adv_working[4]} ) ]];then
			# note although this may exist technically don't use it, it's a virtual path
			# and causes weird cat errors when there's a missing file as well as a virtual path
			# /sys/bus/pci/devices/0000:02:02.0/net/eth1
			# real paths are: /sys/devices/pci0000:00/0000:00:1e/0/0000:02:02.0/net/eth1/uevent
			# and on older debian kernels: /sys/devices/pci0000:00/0000:02:02.0/net:eth1/uevent
			# but broadcom shows this sometimes:
			# /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/ssb0:0/uevent:['DRIVER=b43', 'MODALIAS=ssb:v4243id0812rev0D']:
			working_path="/sys/bus/pci/devices/0000:${a_network_adv_working[4]}"
			# now we want the real one, that xiin also displays, without symbolic links.
			if [[ -e $working_path ]];then
				working_path=$( readlink -f $working_path 2>/dev/null )
				# sometimes there is another directory between the path and /net
				if [[ ! -e $working_path/net ]];then
					# using find here, probably will need to also use it in usb part since the grep
					# method seems to not be working now. Slice off the rest, which leaves the basic path
					working_path=$( find $working_path/*/net/*/uevent 2>/dev/null | \
					sed 's|/net.*||' )
				fi
			fi
			# working_path=$( ls /sys/devices/pci*/*/0000:${a_network_adv_working[4]}/net/*/uevent  )
		else
			# now we'll use the actual vendor:product string instead
			usb_data=${a_network_adv_working[10]}
			usb_vendor=$( cut -d ':' -f 1 <<< $usb_data )
			usb_product=$( cut -d ':' -f 2 <<< $usb_data )
			# this grep returns the path plus the contents of the file, with a colon separator, so slice that off
			# /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/idVendor
			working_path=$( grep -s "$usb_vendor" /sys/devices/pci*/*/usb*/*/*/idVendor | \
			sed -e "s/idVendor:$usb_vendor//"  -e '/driver/d' )
			# try an alternate path if first one doesn't work
			# /sys/devices/pci0000:00/0000:00:0b.1/usb1/1-1/idVendor
			if [[ -z $working_path ]];then
				working_path=$( grep -s "$usb_vendor" /sys/devices/pci*/*/usb*/*/idVendor | \
				sed -e "s/idVendor:$usb_vendor//"  -e '/driver/d' )
				product_path=$( grep -s "$usb_product" /sys/devices/pci*/*/usb*/*/idProduct | \
				sed -e "s/idProduct:$usb_product//" -e '/driver/d' )
			else
				product_path=$( grep -s "$usb_product" /sys/devices/pci*/*/usb*/*/*/idProduct | \
				sed -e "s/idProduct:$usb_product//" -e '/driver/d' )
			fi
			
			# make sure it's the right product/vendor match here, it will almost always be but let's be sure
			if [[ -n $working_path && -n $product_path ]] && [[ $working_path == $product_path ]];then
			#if [[ -n $working_path ]];then
				# now ls that directory and get the numeric starting sub directory and that should be the full path
				# to the /net directory part
				dir_path=$( ls ${working_path} 2>/dev/null | grep -sE '^[0-9]' )
				working_uevent_path="${working_path}${dir_path}"
			fi
		fi
		# /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/uevent grep for DRIVER=
		# /sys/devices/pci0000:00/0000:00:0b.1/usb1/1-1/1-1:1.0/uevent
		if [[ -n $usb_data ]];then
			driver_test=$( grep -si 'DRIVER=' $working_uevent_path/uevent | cut -d '=' -f 2 )
			if [[ -n $driver_test ]];then
				a_network_adv_working[1]=$driver_test
			fi
		fi
		log_function_data "PRE: working_path: $working_path\nworking_uevent_path: $working_uevent_path"
		
		# this applies in two different cases, one, default, standard, two, for usb, this is actually
		# the short path, minus the last longer numeric directory name, ie: 
		# from debian squeeze 2.6.32-5-686: 
		# /sys/devices/pci0000:00/0000:00:0b.1/usb1/1-1/net/wlan0/address
		if [[ -e $working_path/net ]];then
			if_path=$( ls $working_path/net 2>/dev/null )
			if_id=$if_path
			working_path=$working_path/net/$if_path
		# this is the normal usb detection if the first one didn't work
		elif [[ -n $usb_data && -e $working_uevent_path/net ]];then
			if_path=$( ls $working_uevent_path/net 2>/dev/null )
			if_id=$if_path
			working_path=$working_uevent_path/net/$if_path
		# 2.6.32 debian lenny kernel shows not: /net/eth0 but /net:eth0
		else
			if_path=$( ls $working_path 2>/dev/null | grep 'net:' )
			if_id=$( cut -d ':' -f 2 <<< "$if_path" )
			working_path=$working_path/$if_path
		fi
		log_function_data "POST: working_path: $working_path\nif_path: $if_path - if_id: $if_id"
		
		if [[ -n $if_path ]];then
			if [[ -r $working_path/speed ]];then
				speed=$( cat $working_path/speed 2>/dev/null )
			fi
			if [[ -r $working_path/duplex ]];then
				duplex=$( cat $working_path/duplex 2>/dev/null )
			fi
			if [[ -r $working_path/address ]];then
				mac_id=$( cat $working_path/address 2>/dev/null )
			fi
			if [[ -r $working_path/operstate ]];then
				oper_state=$( cat $working_path/operstate 2>/dev/null )
			fi
		fi
		
		if [[ -n ${a_network_adv_working[10]} ]];then
			vendor_product=${a_network_adv_working[10]}
		fi
		A_NETWORK_DATA[i]=${a_network_adv_working[0]}","${a_network_adv_working[1]}","${a_network_adv_working[2]}","${a_network_adv_working[3]}","${a_network_adv_working[4]}","$if_id","$oper_state","$speed","$duplex","$mac_id","$vendor_product
		IFS="$ORIGINAL_IFS"
	done

	eval $LOGFE
}

get_networking_usb_data()
{
	eval $LOGFS
	local lsusb_path='' lsusb_data='' a_usb='' array_count=''
	
	# now we'll check for usb wifi, a work in progress
	# USB_NETWORK_SEARCH
	# alsa usb detection by damentz
	# for every sound card symlink in /proc/asound - display information about it
	lsusb_path=$( type -p lsusb )
	# if lsusb exists, the file is a symlink, and contains an important usb exclusive file: continue
	if [[ -n $lsusb_path ]]; then
		# send error messages of lsusb to /dev/null as it will display a bunch if not a super user
		lsusb_data="$( $lsusb_path 2>/dev/null )"
		# also, find the contents of usbid in lsusb and print everything after the 7th word on the
		# corresponding line. Finally, strip out commas as they will change the driver :)
		if [[ -n $lsusb_data ]];then
			IFS=$'\n'
			a_usb=( $( 
			gawk '
			BEGIN {
				IGNORECASE=1
				string=""
				separator=""
			}
			/'"$USB_NETWORK_SEARCH"'/ && !/bluetooth| hub|keyboard|mouse|printer| ps2|reader|scan|storage/ {
				string=""
				gsub( /,/, " ", $0 )
				gsub(/'"$BAN_LIST_NORMAL"'/, "", $0)
				gsub(/ [ \t]+/, " ", $0)
				sub(/realtek semiconductor/, "Realtek", $0)
				sub(/davicom semiconductor/, "Davicom", $0)
				sub(/Belkin Components/, "Belkin", $0)
				
				for ( i=7; i<= NF; i++ ) {
					string = string separator $i
					separator = " "
				}
				if ( $2 != "" ){
					sub(/:/, "", $4 )
					print string ",,,,usb-" $2 "-" $4 ",,,,,," $6
				}
			}' <<< "$lsusb_data" 
			) )
			IFS="$ORIGINAL_IFS"
			if [[ ${#a_usb[@]} -gt 0 ]];then
				array_count=${#A_NETWORK_DATA[@]}
				for (( i=0; i < ${#a_usb[@]}; i++ ))
				do
					A_NETWORK_DATA[$array_count]=${a_usb[i]}
					((array_count++))
				done
				# need this to get the driver data for -N regular output, but no need
				# to run the advanced stuff unless required
				B_USB_NETWORKING='true'
			fi
		fi
	fi
# 	echo $B_USB_NETWORKING
	eval $LOGFE
}

get_networking_wan_ip_data()
{
	eval $LOGFS
	local ip=''

	# get ip using wget redirect to stdout. This is a clean, text only IP output url,
	# single line only, ending in the ip address. May have to modify this in the future
	# to handle ipv4 and ipv6 addresses but should not be necessary.
	# awk has bad regex handling so checking it with grep -E instead
	# ip=$( echo  2001:0db8:85a3:0000:0000:8a2e:0370:7334 | gawk  --re-interval '
	# ip=$( wget -q -O - $WAN_IP_URL | gawk  --re-interval '
	ip=$( wget -q -O - $WAN_IP_URL | gawk  --re-interval '
	{
		#gsub("\n","",$2")
		print $NF
	}' )
	# validate the data
	if [[ -z $ip ]];then
		ip='None Detected!'
	elif [[ -z $( grep -Es \
	'^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|[[:alnum:]]{0,4}:[[:alnum:]]{0,4}:[[:alnum:]]{0,4}:[[:alnum:]]{0,4}:[[:alnum:]]{0,4}:[[:alnum:]]{0,4}:[[:alnum:]]{0,4}:[[:alnum:]]{0,4})$' <<< $ip ) ]];then
		ip='IP Source Corrupt!'
	fi
	echo "$ip"
	log_function_data "ip: $ip"
	eval $LOGFE
}

get_networking_local_ip_data()
{
	eval $LOGFS
	
	local ip_tool_command=$( type -p ip )
	local temp_array='' ip_tool='ip' ip_tool_data=''
	# the chances for all new systems to have ip by default are far higher than
	# the deprecated ifconfig. Only try for ifconfig if ip is not present in system
	if [[ -z $ip_tool_command ]];then
		ip_tool_command=$( type -p ifconfig )
		ip_tool='ifconfig'
	else
		ip_tool_command="$ip_tool_command addr"
	fi
	if [[ -n "$ip_tool_command" ]];then
		if [[ $ip_tool == 'ifconfig' ]];then
			ip_tool_data="$( $ip_tool_command )"
		# note, ip addr does not have proper record separation, so creating new lines explicitly here at start
		# of each IF record item. Also getting rid of the unneeded numeric line starters, now it can be parsed 
		# like ifconfig more or less
		elif [[ $ip_tool == 'ip' ]];then
			ip_tool_data="$( eval ${ip_tool_command} | sed 's/^[0-9]\+:[[:space:]]\+/\n/' )"
		fi
	fi
	if [[ -z $ip_tool_command ]];then
		A_INTERFACES_DATA=( "Interfaces program 'ip' missing. Please check: $SCRIPT_NAME --recommends" )
	elif [[ -n "$ip_tool_data" ]];then
		IFS=$'\n' # $ip_tool_command
		A_INTERFACES_DATA=( $( 
		gawk -v ipTool=$ip_tool '
		BEGIN {
			IGNORECASE=1
			interface=""
			ifIp=""
			ifIpV6=""
			ifMask=""
		}
		# skip past the lo item
		/^lo/ {
			while (getline && !/^$/ ) {
				# do nothing, just get past this entry item
			}
		}
		/^[a-zA-Z]+[0-9]/ {
			# not clear on why inet is coming through, but this gets rid of it
			# as first line item.
			gsub(/,/, " ", $0)
			gsub(/^ +| +$/, "", $0)
			gsub(/ [ \t]+/, " ", $0)
			interface = $1
			# prep this this for ip addr: eth0: 
			sub(/:/, "", interface)
			ifIp=""
			ifIpV6=""
			ifMask=""
			aInterfaces[interface]++

			while (getline && !/^$/ ) {
				if ( ipTool == "ifconfig" ) {
					if (/inet addr:/) {
						ifIp = gensub( /addr:([0-9\.]+)/, "\\1", "g", $2 )
						if (/mask:/) {
							ifMask = gensub( /mask:([0-9\.]+)/, "\\1", "g", $NF )
						}
					}
					if (/inet6 addr:/) {
						ifIpV6 = $3
					}
				}
				else if ( ipTool == "ip" ) {
					if ( $1 == "inet" ) {
						ifIp = $2
					}
					if ( $1 == "inet6" ) {
						ifIpV6 = $2
					}
				}
			}
			# slice off the digits that are sometimes tacked to the end of the address, 
			# like: /64 or /24
			sub(/\/[0-9]+/, "", ifIp)
			sub(/\/[0-9]+/, "", ifIpV6)
			ipAddresses[interface] = ifIp "," ifMask "," ifIpV6
		}
		END {
			j=0
			for (i in aInterfaces) {
				ifData = ""
				a[j] = i
				if (ipAddresses[i] != "") {
					ifData = ipAddresses[i]
				}
				# create array primary item for master array
				# tested needed to avoid bad data from above, if null it is garbage
				# this is the easiest way to handle junk I found, improve if you want
				if ( ifData != "" ) {
					print a[j] "," ifData
				}
				j++
			}
		}' <<< "$ip_tool_data"
		) )
		IFS="$ORIGINAL_IFS"
	else
		A_INTERFACES_DATA=( "Interfaces program $ip_tool present but created no data. " )
	fi
	temp_array=${A_INTERFACES_DATA[@]}
	log_function_data "A_INTERFACES_DATA: $temp_array"
	eval $LOGFE
}
# get_networking_local_ip_data;exit

# get_networking_local_ip_data;exit
get_optical_drive_data()
{
	eval $LOGFS
	
	local temp_array='' sys_uevent_path='' proc_cdrom='' link_list=''
	local separator='' linked='' disk='' item_string='' proc_info_string='' 
	local dev_disks_links="$( ls /dev/dvd* /dev/cd* /dev/scd* 2>/dev/null  )"
	# get the actual disk dev location, first try default which is easier to run, need to preserve line breaks
	local dev_disks_real="$( echo "$dev_disks_links" | xargs -l readlink 2>/dev/null | sort -u )"
	# Some systems don't support xargs -l so we need to do it manually
	if [[ -z $dev_disks_real ]];then
		for linked in $dev_disks_links
		do
			disk=$( readlink $linked 2>/dev/null )
			if [[ -n $disk ]];then
				disk=$( basename $disk ) # puppy shows this as /dev/sr0, not sr0
				if [[ -z $dev_disks_real || -z $( grep $disk <<< $dev_disks_real ) ]];then
					# need line break IFS for below, no white space
					dev_disks_real="$dev_disks_real$separator$disk"
					separator=$'\n'
				fi
			fi
		done
		dev_disks_real="$( sort -u <<< "$dev_disks_real" )"
		linked=''
		disk=''
		separator=''
	fi

	# A_OPTICAL_DRIVE_DATA indexes: not going to use all these, but it's just as easy to build the full
	# data array and use what we need from it as to update it later to add features or items
	# 0 - true dev path, ie, sr0, hdc
	# 1 - dev links to true path
	# 2 - device vendor - for hdx drives, vendor model are one string from proc
	# 3 - device model
	# 4 - device rev version
	# 5 - speed
	# 6 - multisession support
	# 7 - MCN support
	# 8 - audio read
	# 9 - cdr
	# 10 - cdrw
	# 11 - dvd read
	# 12 - dvdr
	# 13 - dvdram
	# 14 - state

	if [[ -n $dev_disks_real ]];then
		if [[ $B_SHOW_FULL_OPTICAL == 'true' ]];then
			proc_cdrom="$( cat /proc/sys/dev/cdrom/info 2>/dev/null )"
		fi
		IFS=$'\n'
		A_OPTICAL_DRIVE_DATA=( $(
		for disk in $dev_disks_real
		do
			for linked in $dev_disks_links 
			do
				if [[ -n $( readlink $linked | grep $disk ) ]];then
					linked=$( basename $linked )
					link_list="$link_list$separator$linked"
					separator='~'
				fi
			done
			item_string="$disk,$link_list"
			link_list=''
			linked=''
			separator=''
			vendor=''
			model=''
			proc_info_string=''
			rev_number=''
			state=""
			sys_path=''
			# this is only for new sd type paths in /sys, otherwise we'll use /proc/ide
			if [[ -z $( grep '^hd' <<< $disk ) ]];then
				sys_path=$( ls /sys/devices/pci*/*/host*/target*/*/block/$disk/uevent 2>/dev/null | sed "s|/block/$disk/uevent||" )
				# no need to test for errors yet, probably other user systems will require some alternate paths though
				if [[ -n $sys_path ]];then
					vendor=$( cat $sys_path/vendor 2>/dev/null )
					model=$( cat $sys_path/model 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/,//g' )
					state=$( cat $sys_path/state 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/,//g' )
					rev_number=$( cat $sys_path/rev 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/,//g' )
				fi
			elif [[ -e /proc/ide/$disk/model ]];then
				vendor=$( cat /proc/ide/$disk/model 2>/dev/null )
			fi
			if [[ -n $vendor ]];then
				vendor=$( gawk '
				BEGIN {
					IGNORECASE=1
				}
				{
					gsub(/'"$BAN_LIST_NORMAL"'/, "", $0)
					sub(/TSSTcorp/, "TSST ", $0) # seen more than one of these weird ones
					gsub(/,/, " ", $0)
					gsub(/^[[:space:]]*|[[:space:]]*$/, "", $0)
					gsub(/ [[:space:]]+/, " ", $0)
					print $0
				}'	<<< $vendor
				)
			fi
			# this needs to run no matter if there's proc data or not to create the array comma list
			if [[ $B_SHOW_FULL_OPTICAL == 'true' ]];then
				proc_info_string=$( gawk -v diskId=$disk '
				BEGIN {
					IGNORECASE=1
					position=""
					speed=""
					multisession=""
					mcn=""
					audio=""
					cdr=""
					cdrw=""
					dvd=""
					dvdr=""
					dvdram=""
				}
				# first get the position of the device name from top field
				# we will use this to get all the other data for that column
				/drive name:/ {
					for ( position=3; position <= NF; position++ ) {
						if ( $position == diskId ) {
							break
						}
					}
				}
				/drive speed:/ {
					speed = $position
				}
				/Can read multisession:/ {
					multisession=$( position + 1 )
				}
				/Can read MCN:/ {
					mcn=$( position + 1 )
				}
				/Can play audio:/ {
					audio=$( position + 1 )
				}
				/Can write CD-R:/ {
					cdr=$( position + 1 )
				}
				/Can write CD-RW:/ {
					cdrw=$( position + 1 )
				}
				/Can read DVD:/ {
					dvd=$( position + 1 )
				}
				/Can write DVD-R:/ {
					dvdr=$( position + 1 )
				}
				/Can write DVD-RAM:/ {
					dvdram=$( position + 1 )
				}
				END {
					print speed "," multisession "," mcn "," audio "," cdr "," cdrw "," dvd "," dvdr "," dvdram
				}
				' <<< "$proc_cdrom"
				)
			fi
			item_string="$item_string,$vendor,$model,$rev_number,$proc_info_string,$state"
			echo $item_string
		done
		) )
		IFS="$ORIGINAL_IFS"
	fi
	temp_array=${A_OPTICAL_DRIVE_DATA[@]}
	log_function_data "A_OPTICAL_DRIVE_DATA: $temp_array"
	eval $LOGFE
}

get_partition_data()
{
	eval $LOGFS
	
	local a_partition_working='' dev_item='' temp_array='' dev_working_item=''
	#local excluded_file_types='--exclude-type=aufs --exclude-type=tmpfs --exclude-type=iso9660'
	# df doesn't seem to work in script with variables like at the command line
	# added devfs linprocfs sysfs fdescfs which show on debian kfreebsd kernel output
	local main_partition_data="$( df -h -T -P --exclude-type=aufs --exclude-type=squashfs --exclude-type=unionfs --exclude-type=devtmpfs --exclude-type=tmpfs --exclude-type=iso9660 --exclude-type=devfs --exclude-type=linprocfs --exclude-type=sysfs --exclude-type=fdescfs )"
	local swap_data="$( swapon -s )"
	# set dev disk label/mapper/uuid data globals
	get_partition_dev_data 'label'
	get_partition_dev_data 'mapper'
	get_partition_dev_data 'uuid'
	
	log_function_data 'raw' "main_partition_data:\n$main_partition_data\n\nswap_data:\n$swap_data"
	
	# new kernels/df have rootfs and / repeated, creating two entries for the same partition
	# so check for two string endings of / then slice out the rootfs one, I could check for it
	# before slicing it out, but doing that would require the same action twice re code execution
	if [[ $( grep -cs '[[:space:]]/$' <<< "$main_partition_data" ) -gt 1 ]];then
		main_partition_data="$( grep -vs '^rootfs' <<< "$main_partition_data" )"
	fi
	log_function_data 'raw' "main_partition_data_post_rootfs:\n$main_partition_data\n\nswap_data:\n$swap_data"
	IFS=$'\n'
	# sample line: /dev/sda2     ext3     15G  8.9G  4.9G  65% /home
	# $NF = partition name; $(NF - 4) = partition size; $(NF - 3) = used, in gB; $(NF - 1) = percent used
	## note: by subtracting from the last field number NF, we avoid a subtle issue with LVM df output, where if
	## the first field is too long, it will occupy its own line, this way we are getting only the needed data
	A_PARTITION_DATA=( $( echo "$main_partition_data" | gawk '
	BEGIN {
		IGNORECASE=1
	}
	# this has to be nulled for every iteration so it does not retain value from last iteration
	devBase=""
	# this is required because below we are subtracting from NF, so it has to be > 5
	# the real issue is long file system names that force the wrap of df output: //fileserver/main
	# but we still need to handle more dynamically long space containing file names, but later.
	# Using df -P should fix this, ie, no wrapping of line lines, but leaving this for now
	( NF < 6 ) && ( $0 !~ /[0-9]+%/ ) {
		# set the dev location here for cases of wrapped output
		if ( NF == 1 ){
			devBase=gensub( /^(\/dev\/)(.+)$/, "\\2", 1, $1 )
		}
		getline
	}
	# next set devBase if it didn not get set above here
	( $1 ~ /^\/dev\// ) && ( devBase == "" ) {
		devBase=gensub( /^(\/dev\/)(.+)$/, "\\2", 1, $1 )
	}
	# this handles yet another fredforfaen special case where a mounted drive
	# has the search string in its name
	$NF ~ /^\/$|^\/boot$|^\/var$|^\/home$|^\/tmp$|^\/usr$/ {
		print $NF "," $(NF - 4) "," $(NF - 3) "," $(NF - 1) ",main," $(NF - 5) "," devBase 
	}
	# skip all these, including the first, header line. Use the --exclude-type
	# to handle new filesystems types we do not want listed here
	$NF !~ /^\/$|^\/boot$|^\/var$|^\/home$|^\/tmp$|^\/usr$|^filesystem/ {
		# this is to avoid file systems with spaces in their names, that will make
		# the test show the wrong data in each of the fields, if no x%, then do not use
		# using 3 cases, first default, standard, 2nd, 3rd, handles one and two spaces in name
		if ( $(NF - 1) ~ /[0-9]+%/ ) {
			print $NF "," $(NF - 4) "," $(NF - 3) "," $(NF - 1) ",secondary," $(NF - 5) "," devBase 
		}
		# these two cases construct the space containing name
		else if ( $(NF - 2) ~ /[0-9]+%/ ) {
			print $(NF - 1) " " $NF "," $(NF - 5) "," $(NF - 4) "," $(NF - 2) ",secondary," $(NF - 6) "," devBase
		}
		else if ( $(NF - 3) ~ /[0-9]+%/ ) {
			print $(NF - 2) " " $(NF - 1) " " $NF "," $(NF - 6) "," $(NF - 5) "," $(NF - 3) ",secondary," $(NF - 7) "," devBase 
		}
	}
	' )
	
	# now add the swap partition data, don't want to show swap files, just partitions,
	# though this can include /dev/ramzswap0. Note: you can also use /proc/swaps for this
	# data, it's the same exact output as swapon -s
	$( echo "$swap_data" | gawk '
	BEGIN {
		swapCounter = 1
	}
	/^\/dev/ {
		size = sprintf( "%.2f", $3*1024/1000**3 )
		devBase = gensub( /^(\/dev\/)(.+)$/, "\\2", 1, $1 )
		used = sprintf( "%.2f", $4*1024/1000**3 )
		percentUsed = sprintf( "%.0f", ( $4/$3 )*100 )
		print "swap-" swapCounter "," size "GB," used "GB," percentUsed "%,main," "swap," devBase
		swapCounter = ++swapCounter
	}' ) )
	IFS="$ORIGINAL_IFS"
	
	temp_array=${A_PARTITION_DATA[@]}
	log_function_data "1: A_PARTITION_DATA:\n$temp_array"
	
	# now we'll handle some fringe cases where irregular df -hT output shows /dev/disk/.. instead of 
	# /dev/h|sdxy type data for column 1, . A_PARTITION_DATA[6]
	# Here we just search for the uuid/label and then grab the end of the line to get the right dev item.
	for (( i=0; i < ${#A_PARTITION_DATA[@]}; i++ ))
	do
		IFS=","
		a_partition_working=( ${A_PARTITION_DATA[i]} )
		IFS="$ORIGINAL_IFS"
		dev_item='' # reset each loop
		
		# note: for swap this will already be set
		if [[ -n $( grep -E '(by-uuid|by-label)' <<< ${a_partition_working[6]} ) ]];then
			dev_working_item=$( basename ${a_partition_working[6]} )
			if [[ -n $DEV_DISK_UUID ]];then
				dev_item=$( echo "$DEV_DISK_UUID" | gawk '
					$0 ~ /[ /t]'$dev_working_item'[ /t]/ {
						item=gensub( /..\/..\/(.+)/, "\\1", 1, $NF )
						print item
					}' )
			fi
			# if we didn't find anything for uuid try label
			if [[ -z $dev_item && -n $DEV_DISK_LABEL ]];then
				dev_item=$( echo "$DEV_DISK_LABEL" | gawk '
					$0 ~ /[ /t]'$dev_working_item'[ /t]/ {
						item=gensub( /..\/..\/(.+)/, "\\1", 1, $NF )
						print item
					}' )
			fi
		elif [[ -n $( grep 'mapper/' <<< ${a_partition_working[6]} ) ]];then
			# get the mapper actual dev item
			dev_item=$( get_dev_processed_item "${a_partition_working[6]}" )
		fi
		
		if [[ -n $dev_item ]];then
			# assemble everything we could get for dev/h/dx, label, and uuid
			IFS=","
			A_PARTITION_DATA[i]=${a_partition_working[0]}","${a_partition_working[1]}","${a_partition_working[2]}","${a_partition_working[3]}","${a_partition_working[4]}","${a_partition_working[5]}","$dev_item
			IFS="$ORIGINAL_IFS"
		fi
	done
	temp_array=${A_PARTITION_DATA[@]}
	log_function_data "2: A_PARTITION_DATA:\n$temp_array"
	if [[ $B_SHOW_LABELS == 'true' || $B_SHOW_UUIDS == 'true' ]];then
		get_partition_data_advanced
	fi
	eval $LOGFE
}

# first get the locations of the mount points for label/uuid detection
get_partition_data_advanced()
{
	eval $LOGFS
	local a_partition_working='' dev_partition_data=''
	local dev_item='' dev_label='' dev_uuid='' temp_array=''
	local mount_point=''
	# set dev disk label/mapper/uuid data globals
	get_partition_dev_data 'label'
	get_partition_dev_data 'mapper'
	get_partition_dev_data 'uuid'

	if [[ $B_MOUNTS_FILE == 'true' ]];then
		for (( i=0; i < ${#A_PARTITION_DATA[@]}; i++ ))
		do
			IFS=","
			a_partition_working=( ${A_PARTITION_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			
			# note: for swap this will already be set
			if [[ -z ${a_partition_working[6]} ]];then
				mount_point=$( sed 's|/|\\/|g'  <<< ${a_partition_working[0]} )
				#echo mount_point $mount_point
				dev_partition_data=$( gawk '
				BEGIN {
					IGNORECASE = 1
					partition = ""
					partTemp = ""
				}
				# trying to handle space in name
# 				gsub( /\\040/, " ", $0 )
				/[ \t]'$mount_point'[ \t]/ && $1 != "rootfs" {
					# initialize the variables
					label = ""
					uuid = ""

					# slice out the /dev
					partition=gensub( /^(\/dev\/)(.+)$/, "\\2", 1, $1 )
					# label and uuid can occur for root, set partition to null now
					if ( partition ~ /by-label/ ) {
						label=gensub( /^(\/dev\/disk\/by-label\/)(.+)$/, "\\2", 1, $1 )
						partition = ""
					}
					if ( partition ~ /by-uuid/ ) {
						uuid=gensub( /^(\/dev\/disk\/by-uuid\/)(.+)$/, "\\2", 1, $1 )
						partition = ""
					}

					# handle /dev/root for / id
					if ( partition == "root" ) {
						# if this works, great, otherwise, just set this to null values
						partTemp="'$( readlink /dev/root 2>/dev/null )'"
						if ( partTemp != "" ) {
							if ( partTemp ~ /[hsv]d[a-z][0-9]{1,2}/ ) {
								partition=gensub( /^(\/dev\/)(.+)$/, "\\2", 1, partTemp )
							}
							else if ( partTemp ~ /by-uuid/ ) {
								uuid=gensub( /^(\/dev\/disk\/by-uuid\/)(.+)$/, "\\2", 1, partTemp )
								partition="" # set null to let real location get discovered
							}
							else if ( partTemp ~ /by-label/ ) {
								label=gensub( /^(\/dev\/disk\/by-label\/)(.+)$/, "\\2", 1, partTemp )
								partition="" # set null to let real location get discovered
							}
						}
						else {
							partition = ""
							label = ""
							uuid = ""
						}
					}
					print partition "," label "," uuid
				}'	$FILE_MOUNTS )

				# assemble everything we could get for dev/h/dx, label, and uuid
				IFS=","
				A_PARTITION_DATA[i]=${a_partition_working[0]}","${a_partition_working[1]}","${a_partition_working[2]}","${a_partition_working[3]}","${a_partition_working[4]}","${a_partition_working[5]}","$dev_partition_data
				IFS="$ORIGINAL_IFS"
			fi
			## now we're ready to proceed filling in the data
			IFS=","
			a_partition_working=( ${A_PARTITION_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			# get the mapper actual dev item first, in case it's mapped
			dev_item=$( get_dev_processed_item "${a_partition_working[6]}" )
			dev_item=$( basename $dev_item ) ## needed to avoid error in case name still has / in it
			dev_label=${a_partition_working[7]}
			dev_uuid=${a_partition_working[8]}
			
			# then if dev data/uuid is incomplete, try to get missing piece
			# it's more likely we'll get a uuid than a label. But this should get the
			# dev item set no matter what, so then we can get the rest of any missing data
			# first we'll get the dev_item if it's missing
			if [[ -z $dev_item ]];then
				if [[ -n $DEV_DISK_UUID && -n $dev_uuid ]];then
					dev_item=$( echo "$DEV_DISK_UUID" | gawk '
						$0 ~ /[ \t]'$dev_uuid'[ \t]/ {
							item=gensub( /..\/..\/(.+)/, "\\1", 1, $NF )
							print item
						}' )
				elif [[ -n $DEV_DISK_LABEL && -n $dev_label ]];then
					dev_item=$( echo "$DEV_DISK_LABEL" | gawk '
						# first we need to change space x20 in by-label back to a real space
						#gsub( /x20/, " ", $0 )
						# then we can see if the string is there
						$0 ~ /[ \t]'$dev_label'[ \t]/ {
							item=gensub( /..\/..\/(.+)/, "\\1", 1, $NF )
							print item
						}' )
				fi
			fi
			# this can trigger all kinds of weird errors if it is a non /dev path, like: remote:/machine/name
			if [[ -n $dev_item && -z $( grep -E '(^//|:/)' <<< $dev_item ) ]];then
				if [[ -n $DEV_DISK_UUID && -z $dev_uuid ]];then
					dev_uuid=$( echo "$DEV_DISK_UUID" | gawk  '
					/'$dev_item'$/ {
						print $(NF - 2)
					}' )
				fi
				if [[ -n $DEV_DISK_LABEL && -z $dev_label ]];then
					dev_label=$( echo "$DEV_DISK_LABEL" | gawk '
					/'$dev_item'$/ {
						print $(NF - 2)
					}' )
				fi
			fi

			# assemble everything we could get for dev/h/dx, label, and uuid
			IFS=","
			A_PARTITION_DATA[i]=${a_partition_working[0]}","${a_partition_working[1]}","${a_partition_working[2]}","${a_partition_working[3]}","${a_partition_working[4]}","${a_partition_working[5]}","$dev_item","$dev_label","$dev_uuid
			IFS="$ORIGINAL_IFS"
		done
		log_function_data 'cat' "$FILE_MOUNTS"
	fi
	temp_array=${A_PARTITION_DATA[@]}
	log_function_data "3-advanced: A_PARTITION_DATA:\n$temp_array"
	eval $LOGFE
}

# args: $1 - uuid/label/id/mapper
get_partition_dev_data()
{
	eval $LOGFS
	
	# only run these tests once per directory to avoid excessive queries to fs
	case $1 in
		id)
			if [[ $B_ID_SET != 'true' ]];then
				if [[ -d /dev/disk/by-id ]];then
					DEV_DISK_ID="$( ls -l /dev/disk/by-id )"
				fi
				B_ID_SET='true'
			fi
			;;
		label)
			if [[ $B_LABEL_SET != 'true' ]];then
				if [[ -d /dev/disk/by-label ]];then
					DEV_DISK_LABEL="$( ls -l /dev/disk/by-label )"
				fi
				B_LABEL_SET='true'
			fi
			;;
		mapper)
			if [[ $B_MAPPER_SET != 'true' ]];then
				if [[ -d /dev/mapper ]];then
					DEV_DISK_MAPPER="$( ls -l /dev/mapper )"
				fi
				B_MAPPER_SET='true'
			fi
			;;
		uuid)
			if [[ $B_UUID_SET != 'true' ]];then
				if [[ -d /dev/disk/by-uuid ]];then
					DEV_DISK_UUID="$( ls -l /dev/disk/by-uuid )"
				fi
				B_UUID_SET='true'
			fi
			;;
		
	esac
	log_function_data 'raw' "DEV_DISK_LABEL:\n$DEV_DISK_LABEL\n\nDEV_DISK_UUID:\n$DEV_DISK_UUID\n\nDEV_DISK_ID:\n$DEV_DISK_ID\n\nDEV_DISK_MAPPER:\n$DEV_DISK_MAPPER"
	# debugging section, uncomment to insert user data
# 	DEV_DISK_LABEL='
#
# '
# DEV_DISK_UUID='
#
# '
# DEV_DISK_MAPPER='
#
# '
	eval $LOGFE
}

# args: $1 - dev item, check for mapper, then get actual dev item if mapped
# eg: lrwxrwxrwx 1 root root       7 Sep 26 15:10 truecrypt1 -> ../dm-2 
get_dev_processed_item()
{
	eval $LOGFS
	
	local dev_item=$1 dev_return=''
	
	if [[ -n $DEV_DISK_MAPPER && -n $( grep -is 'mapper/' <<< $dev_item ) ]];then
		dev_return=$( echo "$DEV_DISK_MAPPER" | gawk '
		$( NF - 2 ) ~ /^'$( basename $dev_item )'$/ {
			item=gensub( /..\/(.+)/, "\\1", 1, $NF )
			print item
		}' )
	fi
	if [[ -z $dev_return ]];then
		dev_return=$dev_item
	fi
	
	echo $dev_return

	eval $LOGFE
}

get_patch_version_string()
{
	local script_patch_number=$( sed 's/^[0]\+//' <<< $SCRIPT_PATCH_NUMBER )
	
	if [[ -n $script_patch_number ]];then
		script_patch_number="-$script_patch_number"
	fi
	echo $script_patch_number
}

# args: $1 - type cpu/mem 
get_ps_data()
{
	eval $LOGFS
	local array_length='' reorder_temp='' i=0 head_tail='' sort_type=''
	
	# bummer, have to make it more complex here because of reverse sort
	# orders in output, pesky lack of support of +rss in old systems
	case $1 in
		mem)
			head_tail='head'
			sort_type='-rss'
			;;
		cpu)
			head_tail='tail'
			sort_type='%cpu'
			;;
	esac
	
	# throttle potential irc abuse
	if [[ $B_RUNNING_IN_SHELL != 'true' && $PS_COUNT -gt 5 ]];then
		PS_THROTTLED=$PS_COUNT
		PS_COUNT=5
	fi

	IFS=$'\n'
	# note that inxi can use a lot of cpu, and can actually show up here as the script runs
	A_PS_DATA=( $( ps aux --sort $sort_type | grep -Ev "($SCRIPT_NAME|%CPU|[[:space:]]ps[[:space:]])" | $head_tail -n $PS_COUNT | gawk '
	BEGIN {
		IGNORECASE=1
		appName=""
		appPath=""
		appStarterName=""
		appStarterPath=""
		cpu=""
		mem=""
		pid=""
		user=""
		rss=""
	}
	{
		cpu=$3
		mem=$4
		pid=$2
		user=$1
		rss=sprintf( "%.2f", $6/1024 )
		# have to get rid of [,],(,) eg: [lockd] which break the printout function compare in bash
		gsub(/\[|\]|\(|\)/,"~", $0 )
		if ( $12 ~ /^\// ){
			appStarterPath=$11
			appPath=$12
		}
		else {
			appStarterPath=$11
			appPath=$11
		}
		appStarterName=gensub( /(\/.*\/)(.*)/, "\\2", "1", appStarterPath )
		appName=gensub( /(\/.*\/)(.*)/, "\\2", "1", appPath )
		print appName "," appPath "," appStarterName "," appStarterPath "," cpu "," mem "," pid "," rss "," user
	}
	' ) )
	# make the array ordered highest to lowest so output looks the way we expect it to
	# this isn't necessary for -rss, and we can't make %cpu ordered the other way, so
	# need to reverse it here. -rss is used because on older systems +rss is not supported
	if [[ $1 == 'cpu' ]];then
		array_length=${#A_PS_DATA[@]}; 
		while (( $i < $array_length/2 ))
		do 
			reorder_temp=${A_PS_DATA[i]}f
			A_PS_DATA[i]=${A_PS_DATA[$array_length-$i-1]}
			A_PS_DATA[$array_length-$i-1]=$reorder_temp
			(( i++ ))
		done 
	fi

	IFS="$ORIGINAL_IFS"
	
# 	echo ${A_PS_DATA[@]}
	eval $LOGFE
}

# mdstat syntax information: http://www-01.ibm.com/support/docview.wss?uid=isg3T1011259
# note that this does NOT use either Disk or Partition information for now, ie, there
# is no connection between the data types, but the output should still be consistent
get_raid_data()
{
	eval $LOGFS
	
	local mdstat=''
		
	if [[ $B_MDSTAT_FILE ]];then
	 	mdstat="$( cat $FILE_MDSTAT 2>/dev/null )"
	fi
	
	if [[ -n $mdstat ]];then
		# need to make sure there's always a newline in front of each record type, and
		# also correct possible weird formats for the output from older kernels etc.
		mdstat="$( sed -e 's/^md/\nmd/' -e 's/^unused[[:space:]]/\nunused /' \
		-e 's/read_ahead/\nread_ahead/' -e 's/^resync=/\nresync=/' -e 's/^Event/\nEvent/' \
		-e 's/^[[:space:]]*$//' -e 's/[[:space:]]read_ahead/\nread_ahead/'  <<< "$mdstat" )"
		# some fringe cases do not end as expected, so need to add newlines plus EOF to make sure while loop doesn't spin
		mdstat=$( echo -e "$mdstat\n\nEOF" )

		IFS=$'\n'
		A_RAID_DATA=( $(
		gawk '
		BEGIN {
			IGNORECASE=1
			RS="\n"
		}
		
		/^personalities/ {
			KernelRaidSupport = gensub(/personalities[[:space:]]*:[[:space:]]*(.*)/, "\\1", 1, $0)
			# clean off the brackets
			gsub(/[\[\]]/,"",KernelRaidSupport)
			print "KernelRaidSupport," KernelRaidSupport
		}
		/^read_ahead/ {
			ReadAhead=gensub(/read_ahead (.*)/, "\\1", 1 )
			print "ReadAhead," ReadAhead
		}
		/^Event:/ {
			print "raidEvent," $NF
		}
		# print logic will search for this value and use it to print out the unused devices data
		/^unused devices/ {
			unusedDevices = gensub(/^unused devices:[[:space:]][<]?([^>]*)[>]?.*/, "\\1", 1, $0)
			print "UnusedDevices," unusedDevices
		}
		
		/^md/ {
			# reset for each record loop through
			deviceState = ""
			bitmapValues = ""
			blocks = ""
			chunkSize = ""
			components = ""
			device = ""
			deviceReport = ""
			finishTime = ""
			recoverSpeed = ""
			recoveryProgressBar = ""
			recoveryPercent = ""
			raidLevel = ""
			sectorsRecovered = ""
			separator = ""
			superBlock = ""
			uData = ""
			
			while ( !/^[[:space:]]*$/  ) {
				gsub(/,/, " ", $0 )
				gsub(/[[:space:]]+/, " ", $0 )
				if ( $0 ~ /^md/ ) {
					device = gensub(/(md.*)[[:space:]]?:/, "\\1", "1", $1 )
				}
				if ( $0 ~ /raid[0-9]+/ ) {
					raidLevel = gensub(/(.*)raid([0-9]+)(.*)/, "\\2", "g", $0 )
				}
				if ( $0 ~ /(active \(auto-read-only\)|active|inactive)/ ) {
					deviceState = gensub(/(.*) (active \(auto-read-only\)|active|inactive) (.*)/, "\\2", "1", $0 )
				}
				# gawk will not return all the components using gensub, only last one
				separator = ""
				for ( i=3; i<=NF; i++ ) {
					if ( $i ~ /[hs]d[a-z][0-9]*(\[[0-9]+\])?(\([SF]\))?/ ) {
						components = components separator $i
						separator=" "
					}
				}
				if ( $0 ~ /blocks/ ) {
					blocks = gensub(/(.*[[:space:]]+)?([0-9]+)[[:space:]]blocks.*/, "\\2", "1", $0)
				}
				if ( $0 ~ /super[[:space:]][0-9\.]+/ ) {
					superBlock = gensub(/.*[[:space:]]super[[:space:]]([0-9\.]+)[[:space:]].*/, "\\1", "1", $0)
				}
				if ( $0 ~ /algorithm[[:space:]][0-9\.]+/ ) {
					algorithm = gensub(/.*[[:space:]]algorithm[[:space:]]([0-9\.]+)[[:space:]].*/, "\\1", "1", $0)
				}
				if ( $0 ~ /\[[0-9]+\/[0-9]+\]/ ) {
					deviceReport = gensub(/.*[[:space:]]\[([0-9]+\/[0-9]+)\][[:space:]].*/, "\\1", "1", $0)
					uData = gensub(/.*[[:space:]]\[([U_]+)\]/, "\\1", "1", $0)
				}
				# need to avoid this:  bitmap: 0/10 pages [0KB], 16384KB chunk
				# while currently all the normal chunks are marked with k, not kb, this can change in the future
				if ( $0 ~ /[0-9]+[k] chunk/ && $0 !~ /bitmap/ ) {
					chunkSize = gensub(/(.*) ([0-9]+[k]) chunk.*/, "\\2", "1", $0)
				}
				if ( $0 ~ /^resync=/ ) {
					sub(/resync=/,"")
					print "resyncStatus," $0
				}
				if ( $0 ~ /\[[=]*>[\.]*\].*(resync|recovery)/ ) {
					recoveryProgressBar = gensub(/.*(\[[=]*>[\.]*\]).*/, "\\1",1,$0)
				}
				if ( $0 ~ / (resync|recovery)[[:space:]]*=/ ) {
					recoveryPercent = gensub(/.* (resync|recovery)[[:space:]]*=[[:space:]]*([0-9\.]+%).*/, "\\1~\\2", 1 )
					if ( $0 ~ /[[:space:]]\([0-9]+\/[0-9]+\)/ ) {
						sectorsRecovered = gensub(/.* \(([0-9]+\/[0-9]+)\).*/, "\\1", 1, $0 )
					}
					if ( $0 ~ /finish[[:space:]]*=/ ) {
						finishTime = gensub(/.* finish[[:space:]]*=[[:space:]]*([[0-9\.]+)([a-z]+) .*/, "\\1 \\2", 1, $0 )
					}
					if ( $0 ~ /speed[[:space:]]*=/ ) {
						recoverSpeed = gensub(/.* speed[[:space:]]*=[[:space:]]*([[0-9\.]+)([a-z]+\/[a-z]+)/, "\\1 \\2", 1, $0 )
					}
				}
				if ( $0 ~ /bitmap/ ) {
					bitmapValues = gensub(/(.*[[:space:]])?bitmap:(.*)/, "\\2", 1, $0 )
				}
				
				getline
			}
			raidString = device "," deviceState "," raidLevel "," components "," deviceReport "," uData 
			raidString = raidString "," blocks "," superBlock "," algorithm "," chunkSize "," bitmapValues
			raidString = raidString "," recoveryProgressBar "," recoveryPercent "," sectorsRecovered "," finishTime "," recoverSpeed
			
			print raidString
		}
		' <<< "$mdstat"
		) )
		IFS="$ORIGINAL_IFS"
		temp_array=${A_RAID_DATA[@]}
		log_function_data "A_RAID_DATA: $temp_array"
# 		echo -e "A_RAID_DATA:\n${A_RAID_DATA[@]}"
	fi
	
	eval $LOGFE
}

# Repos will be added as we get distro package manager data to create the repo data. 
# This method will output the file name also, which is useful to create output that's 
# neat and readable. Each line of the total number contains the following sections,
# separated by a : for splitting in the print function
# part one, repo type/string : part two, file name, if present, of info : part 3, repo data
get_repo_data()
{
	eval $LOGFS
	local repo_file='' repo_data_working='' repo_data_working2='' repo_line='' 
	local apt_file='/etc/apt/sources.list' yum_repo_dir='/etc/yum.repos.d/' yum_conf='/etc/yum.conf'
	local pacman_conf='/etc/pacman.conf' pacman_repo_dir='/etc/pacman.d/' pisi_dir='/etc/pisi/'
	
	# apt - debian, buntus, also sometimes some yum/rpm repos may create apt repos here as well
	if [[ -f $apt_file || -d $apt_file.d ]];then
		REPO_DATA="$( grep -Esv '(^[[:space:]]*$|^[[:space:]]*#)' $apt_file $apt_file.d/*.list | sed -r 's/^(.*)/apt sources:\1/' )"
	fi
	# yum - fedora, redhat, centos, etc. Note that rpmforge also may create apt sources
	# in /etc/apt/sources.list.d/. Therefore rather than trying to assume what package manager is
	# actually running, inxi will merely note the existence of each repo type for apt/yum. 
	# Also, in rpm, you can install apt-rpm for the apt-get command, so it's not good to check for
	# only the commands in terms of selecting which repos to show.
	if [[ -d $yum_repo_dir || -f $yum_conf ]];then
		# older redhats put their yum data in /etc/yum.conf
		for repo_file in $( ls $yum_repo_dir*.repo $yum_conf 2>/dev/null )
		do
			repo_data_working="$( gawk -v repoFile=$repo_file '
			# construct the string for the print function to work with, file name: data
			function print_line( fileName, repoId, repoUrl ){
				print "yum repos:" fileName ":" repoId repoUrl
			}
			BEGIN {
				FS="\n"
				IGNORECASE=1
				enabledStatus=""
				repoTitle=""
				urlData=""
			}
			# this is a hack, assuming that each item has these fields listed, we collect the 3
			# items one by one, then when the url/enabled fields are set, we print it out and
			# reset the data. Not elegant but it works. Note that if enabled was not present
			# we assume it is enabled then, and print the line, reset the variables. This will
			# miss the last item, so it is printed if found in END
			/^\[.+\]/ {
				if ( urlData != "" && repoTitle != "" ){
					print_line( repoFile, repoTitle, urlData )
					enabledStatus=""
					urlData=""
					repoTitle=""
				}
				gsub( /\[|\]/, "", $1 ) # strip out the brackets
				repoTitle = $1 " ~ "
			}
			/^(mirrorlist|baseurl)/ {
				sub( /(mirrorlist|baseurl)[[:space:]]*=[[:space:]]*/, "", $1 ) # strip out the field starter
				urlData = $1
			}
			# note: enabled = 1. enabled = 0 means disabled
			/^enabled[[:space:]]*=/ {
				enabledStatus = $1
			}
			# print out the line if all 3 values are found, otherwise if a new
			# repoTitle is hit above, it will print out the line there instead
			{ 
				if ( urlData != "" && enabledStatus != "" && repoTitle != "" ){
					if ( enabledStatus !~ /enabled[[:space:]]*=[[:space:]]*0/ ){
						print_line( repoFile, repoTitle, urlData )
					}
					enabledStatus=""
					urlData=""
					repoTitle=""
				}
			}
			END {
				# print the last one if there is data for it
				if ( urlData != ""  && repoTitle != "" ){
					print_line( repoFile, repoTitle, urlData )
				}
			}
			' $repo_file )"
			
			# then load the global for each file as it gets filled
			if [[ -n $repo_data_working ]];then
				if [[ -z $REPO_DATA ]];then
					REPO_DATA="$repo_data_working"
				else
					REPO_DATA="$REPO_DATA
$repo_data_working"
				fi
				repo_data_working=''
			fi
		done
	# pacman - archlinux, going to assume that pisi and arch/pacman don't have the above issue with apt/yum
	# pisi - pardus
	elif [[ -d $pisi_dir && -n $( type -p pisi ) ]];then
		REPO_DATA="$( pisi list-repo )"
		# now we need to create the structure: repo info: repo path
		# we do that by looping through the lines of the output and then
		# putting it back into the <data>:<url> format print repos expects to see
		# note this structure in the data, so store first line and make start of line
		# then when it's an http line, add it, and create the full line collection.
# Pardus-2009.1 [Aktiv]
# 	http://packages.pardus.org.tr/pardus-2009.1/pisi-index.xml.bz2
# Contrib [Aktiv]
# 	http://packages.pardus.org.tr/contrib-2009/pisi-index.xml.bz2
		while read repo_line
		do
			repo_line=$( gawk '
			{
				# need to dump leading/trailing spaces and clear out color codes for irc output
				sub(/^[[:space:]]+|[[:space:]]+$/,"",$0)
# 				gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/,"",$0) # leaving this pattern in case need it
				gsub(/\[([0-9];)?[0-9]+m/,"",$0)
				print $0
			}' <<< $repo_line )
			if [[ -n $( grep '://' <<< $repo_line ) ]];then
				repo_data_working="$repo_data_working:$repo_line\n"
			else
				repo_data_working="${repo_data_working}pisi repo:$repo_line"
			fi
		done <<< "$REPO_DATA"
		# echo and execute the line breaks inserted
		REPO_DATA="$( echo -e $repo_data_working )"
	elif [[ -f $pacman_conf ]];then
		# get list of mirror include files, trim white space off ends
		repo_data_working="$( gawk '
		BEGIN {
			FS="="
			IGNORECASE=1
		}
		/^[[:space:]]*Include/ {
			sub(/^[[:space:]]+|[[:space:]]+$/,"",$2)
			print $2
		}
		' $pacman_conf )"
		# sort into unique paths only, to be used to search for server = data
		repo_data_working=$( sort -bu <<< "$repo_data_working" | uniq ) 
		repo_data_working="$repo_data_working $pacman_conf"
		for repo_file in $repo_data_working 
		do
			if [[ -f $repo_file ]];then
				# inserting a new line after each found / processed match
				repo_data_working2="$repo_data_working2$( gawk -v repoFile=$repo_file '
				BEGIN {
					FS="="
					IGNORECASE=1
				}
				/^[[:space:]]*Server/ {
					sub(/^[[:space:]]+|[[:space:]]+$/,"",$2)
					print "pacman repo servers:" repoFile ":" $2 "\\n"
				}
				' $repo_file )"
			else
				echo "Error: file listed in $pacman_conf does not exist - $repo_file"
			fi
		done
		# execute line breaks
		REPO_DATA="$( echo -e $repo_data_working2 )"
	fi
	eval $LOGFE
}

get_runlevel_data()
{
	eval $LOGFS
	local runlvl=''
	local runlevel_path=$( type -p runlevel )
	if [[ -n $runlevel_path ]];then
		runlvl="$( $runlevel_path | gawk '{ print $2 }' )"
	fi
	echo $runlvl
	eval $LOGFE
}

get_sensors_data()
{
	eval $LOGFS
	
	
	local temp_array=''
		
	IFS=$'\n'
	if [[ -n $Sensors_Data ]];then
		# note: non-configured sensors gives error message, which we need to redirect to stdout
		# also, -F ':' no space, since some cases have the data starting right after,like - :1287
		A_SENSORS_DATA=( $( 
  		gawk -F ':' -v userCpuNo="$SENSORS_CPU_NO" '
		BEGIN {
			IGNORECASE=1
			core0Temp="" # only if all else fails...
			cpuTemp=""
			cpuTempReal=""
			fanWorking=""
			indexCountaFanMain=0
			indexCountaFanDefault=0
			i=""
			j=""
			moboTemp=""
			moboTempReal=""
			psuTemp=""
			separator=""
			sysFanString=""
			temp1=""
			temp2=""
			tempFanType="" # set to 1 or 2
			tempUnit=""
			tempWorking=""
			tempWorkingUnit=""
		}
		# new data arriving: gpu temp in sensors, have to skip that
		/^('"$SENSORS_GPU_SEARCH"')-pci/ {
			while ( getline && !/^$/ ) {
				# do nothing, just skip it
			}
		}
		# dumping the extra + signs after testing for them,  nobody has negative temps.
		# also, note gawk treats ° as a space, so we have to get the C/F data
		# there are some guesses here, but with more sensors samples it will get closer.
		# note: using arrays starting at 1 for all fan arrays to make it easier overall
		# more validation because gensub if fails to get match returns full string, so
		# we have to be sure we are working with the actual real string before assiging
		# data to real variables and arrays. Extracting C/F degree unit as well to use
		# when constructing temp items for array. 
		# note that because of charset issues, no tempUnit="°" tempWorkingUnit degree sign 
		# used, but it is required in testing regex to avoid error.
		/^(M\/B|MB|SIO|SYS)(.*)\+([0-9]+)(.*)[ \t°](C|F)/ && $2 ~ /^[ \t]*\+([0-9]+)/ {
			moboTemp=gensub( /[ \t]+\+([0-9\.]*)(.*)/, "\\1", 1, $2 )
			tempWorkingUnit=gensub( /[ \t]+\+([0-9\.]+)[ \t°]+([CF])(.*)/, "\\2", 1, $2 )
			if ( tempWorkingUnit ~ /^C|F$/ && tempUnit == "" ){
				tempUnit=tempWorkingUnit
			}
		}
		/^CPU(.*)\+([0-9]+)(.*)[ \t°](C|F)/ && $2 ~ /^[ \t]*\+([0-9]+)/ {
			cpuTemp=gensub( /[ \t]+\+([0-9\.]+)(.*)/, "\\1", 1, $2 )
			tempWorkingUnit=gensub( /[ \t]+\+([0-9\.]+)[ \t°]+([CF])(.*)/, "\\2", 1, $2 )
			if ( tempWorkingUnit ~ /^C|F$/ && tempUnit == "" ){
				tempUnit=tempWorkingUnit
			}
		}
		/^(P\/S|Power)(.*)\+([0-9]+)(.*)[ \t°](C|F)/ && $2 ~ /^[ \t]*\+([0-9]+)/ {
			psuTemp=gensub( /[ \t]+\+([0-9\.]+)(.*)/, "\\1", 1, $2 )
			tempWorkingUnit=gensub( /[ \t]+\+([0-9\.]+)[ \t°]+([CF])(.*)/, "\\2", 1, $2 )
			if ( tempWorkingUnit ~ /^C|F$/ && tempUnit == "" ){
				tempUnit=tempWorkingUnit
			}
		}
		$1 ~ /^temp1$/ && $2 ~ /^[ \t]*\+([0-9]+)/ {
			tempWorking=gensub( /[ \t]+\+([0-9\.]+)(.*)/, "\\1", 1, $2 )
			if ( temp1 == "" || tempWorking > 0 ) {
				temp1=tempWorking
			}
			tempWorkingUnit=gensub( /[ \t]+\+([0-9\.]+)[ \t°]+([CF])(.*)/, "\\2", 1, $2 )
			if ( tempWorkingUnit ~ /^C|F$/ && tempUnit == "" ){
				tempUnit=tempWorkingUnit
			}
		}
		$1 ~ /^temp2$/ && $2 ~ /^[ \t]*\+([0-9]+)/ {
			tempWorking=gensub( /[ \t]+\+([0-9\.]+)(.*)/, "\\1", 1, $2 )
			if ( temp2 == "" || tempWorking > 0 ) {
				temp2=tempWorking
			}
			tempWorkingUnit=gensub( /[ \t]+\+([0-9\.]+)[ \t°]+([CF])(.*)/, "\\2", 1, $2 )
			if ( tempWorkingUnit ~ /^C|F$/ && tempUnit == "" ){
				tempUnit=tempWorkingUnit
			}
		}
		
		# final fallback if all else fails, funtoo user showed sensors putting
		# temp on wrapped second line, not handled
		/^(core0|core 0)(.*)\+([0-9]+)(.*)[ \t°](C|F)/ && $2 ~ /^[ \t]*\+([0-9]+)/ {
			tempWorking=gensub( /[ \t]+\+([0-9\.]+)(.*)/, "\\1", 1, $2 )
			if ( core0Temp == "" || tempWorking > 0 ) {
				core0Temp=tempWorking
			}
			tempWorkingUnit=gensub( /[ \t]+\+([0-9\.]+)[ \t°]+([CF])(.*)/, "\\2", 1, $2 )
			if ( tempWorkingUnit ~ /^C|F$/ && tempUnit == "" ){
				tempUnit=tempWorkingUnit
			}
		}
		
		# note: can be cpu fan:, cpu fan speed:, etc. Some cases have no space before
		# $2 starts (like so :1234 RPM), so skip that space test in regex
		/^CPU(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			aFanMain[1]=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
		}
		/^(M\/B|MB|SYS)(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			aFanMain[2]=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
		}
		/(Power|P\/S|POWER)(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			aFanMain[3]=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
		}
		# note that the counters are dynamically set for fan numbers here
		# otherwise you could overwrite eg aux fan2 with case fan2 in theory
		# note: cpu/mobo/ps are 1/2/3
		# NOTE: test: ! i in array does NOT work, this appears to be an awk/gawk bug
		/^(AUX(1)? |CASE(1)? |CHASSIS(1)? )(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			for ( i = 4; i < 7; i++ ){
				if ( i in aFanMain ){
					##
				}
				else {
					aFanMain[i]=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
					break
				}
			}
		}
		/^(AUX([2-9]) |CASE([2-9]) |CHASSIS([2-9]) )(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			for ( i = 5; i < 30; i++ ){
				if ( i in aFanMain ) {
					##
				}
				else {
					sysFanNu = i
					aFanMain[i]=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
					break
				}
			}
		}
		# in rare cases syntax is like: fan1: xxx RPM
		/^(FAN(1)?[ \t:])(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			aFanDefault[1]=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
		}
		/^FAN([2-9]|1[0-9])(.*)[ \t]*([0-9]+)[ \t]RPM/ {
			fanWorking=gensub( /[ \t]*([0-9]+)[ \t]+(.*)/, "\\1", 1, $2 )
			sysFanNu=gensub( /fan([0-9]+)/, "\\1", 1, $1 )
			if ( sysFanNu ~ /^([0-9]+)$/ ) {
				# add to array if array index does not exist OR if number is > existing number
				if ( sysFanNu in aFanDefault ) {
					if ( fanWorking >= aFanDefault[sysFanNu] ) {
						aFanDefault[sysFanNu]=fanWorking
					}
				}
				else {
					aFanDefault[sysFanNu]=fanWorking
				}
			}
		}
		
		END {
			# first we need to handle the case where we have to determine which temp/fan to use for cpu and mobo:
			# note, for rare cases of weird cool cpus, user can override in their prefs and force the assignment
			if ( temp1 != "" && temp2 != "" ){
				if ( userCpuNo != "" && userCpuNo ~ /(1|2)/ ) {
					tempFanType=userCpuNo
				}
				else {
					# first some fringe cases with cooler cpu than mobo: assume which is cpu temp based on fan speed
					# but only if other fan speed is 0
					if ( temp1 >= temp2 && 1 in aFanDefault && 2 in aFanDefault && aFanDefault[1] == 0 && aFanDefault[2] > 0 ) {
						tempFanType=2
					}
					else if ( temp2 >= temp1 && 1 in aFanDefault && 2 in aFanDefault && aFanDefault[2] == 0 && aFanDefault[1] > 0 ) {
						tempFanType=1
					}
					# then handle the standard case if these fringe cases are false
					else if ( temp1 >= temp2 ) {
						tempFanType=1
					}
					else {
						tempFanType=2
					}
				}
			}
			# need a case for no temps at all reported, like with old intels
			else if ( temp2 == "" && cpuTemp == "" ){
				if ( temp1 == "" && moboTemp == "" ){
					tempFanType=1
				}
				else if ( temp1 != "" && moboTemp == "" ){
					tempFanType=1
				}
				else if ( temp1 != "" && moboTemp != "" ){
					tempFanType=1
				}
			}
			
			# then get the real cpu temp, best guess is hottest is real
			if ( cpuTemp != "" ){
				cpuTempReal=cpuTemp
			}
			else if ( tempFanType != "" ){
				if ( tempFanType == 1 ){
					cpuTempReal=temp1
				}
				else {
					cpuTempReal=temp2
				}
			}
			else {
				cpuTempReal=temp1
			}
			# if all else fails, use core0 temp if it is present and cpu is null
			if ( cpuTempReal == "" && core0Temp != "" ) {
				cpuTempReal=core0Temp
			}

			# then the real mobo temp
			if ( moboTemp != "" ){
				moboTempReal=moboTemp
			}
			else if ( tempFanType != "" ){
				if ( tempFanType == 1 ) {
					moboTempReal=temp2
				}
				else {
					moboTempReal=temp1
				}
			}
			else {
				moboTempReal=temp2
			}
			# then set the cpu fan speed
			if ( aFanMain[1] == "" ) {
				# note, you cannot test for aFanDefault[1] or [2] != "" 
				# because that creates an array item in gawk just by the test itself
				if ( tempFanType == 1 && 1 in aFanDefault ) {
					aFanMain[1]=aFanDefault[1]
					aFanDefault[1]=""
				}
				else if ( tempFanType == 2 && 2 in aFanDefault ) {
					aFanMain[1]=aFanDefault[2]
					aFanDefault[2]=""
				}
			}

			# then we need to get the actual numeric max array count for both fan arrays
			for (i = 0; i <= 29; i++) {
				if ( i in aFanMain && i > indexCountaFanMain ) {
					indexCountaFanMain=i
				}
			}
			for (i = 0; i <= 14; i++) {
				if ( i in aFanDefault && i > indexCountaFanDefault ) {
					indexCountaFanDefault=i
				}
			}
			
			# clear out any duplicates. Primary fan real trumps fan working always if same speed
			for (i = 1; i <= indexCountaFanMain; i++) {
				if ( i in aFanMain && aFanMain[i] != "" && aFanMain[i] != 0 ) {
					for (j = 1; j <= indexCountaFanDefault; j++) {
						if ( j in aFanDefault && aFanMain[i] == aFanDefault[j] ) {
							aFanDefault[j] = ""
						}
					}
				}
			}

			# now see if you can find the fast little mobo fan, > 5000 rpm and put it as mobo
			# note that gawk is returning true for some test cases when aFanDefault[j] < 5000
			# which has to be a gawk bug, unless there is something really weird with arrays
			# note: 500 > aFanDefault[j] < 1000 is the exact trigger, and if you manually 
			# assign that value below, the > 5000 test works again, and a print of the value
			# shows the proper value, so the corruption might be internal in awk. 
			# Note: gensub is the culprit I think, assigning type string for range 501-1000 but 
			# type integer for all others, this triggers true for >
			for (j = 1; j <= indexCountaFanDefault; j++) {
				if ( j in aFanDefault && int( aFanDefault[j] ) > 5000 && aFanMain[2] == "" ) {
					aFanMain[2] = aFanDefault[j]
					aFanDefault[j] = ""
					# then add one if required for output
					if ( indexCountaFanMain < 2 ) {
						indexCountaFanMain = 2
					}
				}
			}

			# then construct the sys_fan string for echo, note that iteration 1
			# makes: fanDefaultString separator null, ie, no space or ,
			for (j = 1; j <= indexCountaFanDefault; j++) {
				fanDefaultString = fanDefaultString separator aFanDefault[j]
				separator=","
			}
			separator="" # reset to null for next loop
			# then construct the sys_fan string for echo
			for (j = 1; j <= indexCountaFanMain; j++) {
				fanMainString = fanMainString separator aFanMain[j]
				separator=","
			}
			
			# and then build the temps:
			if ( moboTempReal != "" ) {
				moboTempReal = moboTempReal tempUnit
			}
			if ( cpuTempReal != "" ) {
				cpuTempReal = cpuTempReal tempUnit
			}
			
			# if they are ALL null, print error message. psFan is not used in output currently
			if ( cpuTempReal == "" && moboTempReal == "" && aFanMain[1] == "" && aFanMain[2] == "" && aFanMain[3] == "" && fanDefaultString == "" ) {
				print "No active sensors found. Have you configured your sensors yet?"
			}
			else {
				# then build array arrays: 
				print cpuTempReal "," moboTempReal "," psuTemp
				# this is for output, a null print line does NOT create a new array index in bash
				if ( fanMainString == "" ) {
					fanMainString=","
				}
				print fanMainString
				print fanDefaultString
			}
		}' <<< "$Sensors_Data"
		) )
	fi
	
	IFS="$ORIGINAL_IFS"
	temp_array=${A_SENSORS_DATA[@]}
	log_function_data "A_SENSORS_DATA: $temp_array"
# 	echo "A_SENSORS_DATA: ${A_SENSORS_DATA[@]}"
	eval $LOGFE
}

get_sensors_output()
{
	local sensors_path=$( type -p sensors ) sensors_data=''
	
	if [[ -n $sensors_path ]];then
		sensors_data="$( $sensors_path 2>/dev/null )"
		if [[ -n "$sensors_data" ]];then
			# make sure the file ends in newlines then characters, the newlines are lost in the echo unless
			# the data ends in some characters
			sensors_data="$sensors_data\n\n###" 
		fi
	fi
	echo -e "$sensors_data"
}

get_shell_data()
{
	eval $LOGFS

	local shell_type="$( ps -p $PPID -o comm= 2>/dev/null )"
	local shell_version='' 
	
	if [[ $B_EXTRA_DATA == 'true' && -n $shell_type ]];then
		case $shell_type in
			bash)
				shell_version=$( get_de_app_version "$shell_type" "^GNU[[:space:]]bash,[[:space:]]version" "4" | sed -r 's/(\(.*|-release|-version)//' )
				;;
			# csh/dash use dpkg package version data, debian/buntu only
			csh)
				shell_version=$( get_de_app_version "$shell_type" "$shell_type" "3" )
				;;
			dash)
				shell_version=$( get_de_app_version "$shell_type" "$shell_type" "3" )
				;;
			ksh)
				shell_version=$( get_de_app_version "$shell_type" "version" "5" )
				;;
			tcsh)
				shell_version=$( get_de_app_version "$shell_type" "^tcsh" "2" )
				;;
			zsh)
				shell_version=$( get_de_app_version "$shell_type" "^zsh" "2" )
				;;
		esac
	fi
	if [[ -n $shell_version ]];then
		shell_type="$shell_type $shell_version"
	fi
	echo $shell_type
	
	eval $LOGFS
}

get_shell_parent()
{
	eval $LOGFS
	local shell_parent='' script_parent=''
	
	script_parent=$( ps -fp $PPID --no-headers 2>/dev/null | gawk '/'"$PPID"'/ { print $3 }' )
	shell_parent=$( ps -p $script_parent --no-headers 2>/dev/null | gawk '/'"$script_parent"'/ { print $NF}' )
	# no idea why have to do script_parent action twice in su case, but you do, oh well.
	if [[ $shell_parent == 'su' ]];then
		script_parent=$( ps -fp $script_parent --no-headers 2>/dev/null | gawk '/'"$script_parent"'/ { print $3 }' )
		script_parent=$( ps -fp $script_parent --no-headers 2>/dev/null | gawk '/'"$script_parent"'/ { print $3 }' )
		shell_parent=$( ps -p $script_parent --no-headers 2>/dev/null | gawk '/'"$script_parent"'/ { print $NF}' )
	fi
	echo $shell_parent
	
	eval $LOGFE
}

get_tty_console_irc()
{
	eval $LOGFS
	local tty_number=''
	if [[ -n ${IRC_CLIENT} ]];then
		tty_number=$( ps aux | gawk '
			BEGIN {
				IGNORECASE=1
			}
			/'${IRC_CLIENT}'/ {
				gsub(/[^0-9]/, "", $7)
				print $7
			}' )
	fi
	log_function_data "tty_number: $tty_number"
	echo $tty_number
	eval $LOGFE
}

get_tty_number()
{
	eval $LOGFS
	
	local tty_number=$( basename "$( tty 2>/dev/null )" | sed 's/[^0-9]*//g' )
	
	echo $tty_number
	
	eval $LOGFE
}

get_unmounted_partition_data()
{
	eval $LOGFS
	local a_unmounted_working='' mounted_partitions='' separator='' unmounted_fs=''
	local dev_working='' uuid_working='' label_working=''
	
	if [[ $B_PARTITIONS_FILE == 'true' ]];then
		# set dev disk label/uuid data globals
		get_partition_dev_data 'label'
		get_partition_dev_data 'uuid'
		
		# create list for slicing out the mounted partitions
		for (( i=0; i < ${#A_PARTITION_DATA[@]}; i++ ))
		do
			IFS=","
			a_unmounted_working=( ${A_PARTITION_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			if [[ -n ${a_unmounted_working[6]} ]];then
				mounted_partitions="$mounted_partitions$separator${a_unmounted_working[6]}"
				separator='|'
			fi
		done
	
		A_UNMOUNTED_PARTITION_DATA=( $( grep -Ev '('$mounted_partitions')$' $FILE_PARTITIONS | gawk '
		BEGIN {
			IGNORECASE=1
		}
		# note that size 1 means it is a logical extended partition container
		# lvm might have dm-1 type syntax
		# need to exclude loop type file systems, squashfs for example
		/[a-z][0-9]+$|dm-[0-9]+$/ && $3 != 1 && $NF !~ /loop/ {
			size = sprintf( "%.2f", $3*1024/1000**3 )
			print $4 "," size "G"
		}' ) )

		for (( i=0; i < ${#A_UNMOUNTED_PARTITION_DATA[@]}; i++ ))
		do
			IFS=","
			a_unmounted_working=( ${A_UNMOUNTED_PARTITION_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			
			label_working=$( grep -E "${a_unmounted_working[0]}$" <<< "$DEV_DISK_LABEL"  | gawk '{
				print $(NF - 2)
			}' )
			uuid_working=$( grep -E "${a_unmounted_working[0]}$" <<< "$DEV_DISK_UUID"  | gawk '{
				print $(NF - 2)
			}' )
			unmounted_fs=$( get_unmounted_partition_filesystem "/dev/${a_unmounted_working[0]}" )
			
			IFS=","
			A_UNMOUNTED_PARTITION_DATA[i]=${a_unmounted_working[0]}","${a_unmounted_working[1]}","$label_working","$uuid_working","$unmounted_fs
			IFS="$ORIGINAL_IFS"
		done
	fi
#	echo "${A_PARTITION_DATA[@]}"
# 	echo "${A_UNMOUNTED_PARTITION_DATA[@]}"
	eval $LOGFE
}

# a few notes, normally file -s requires root, but you can set user rights in /etc/sudoers.
# list of file systems: http://en.wikipedia.org/wiki/List_of_file_systems
# args: $1 - /dev/<disk><part> to be tested for
get_unmounted_partition_filesystem()
{
	eval $LOGFS
	local partition_filesystem='' sudo_command=''
	
	if [[ $B_FILE_TESTED != 'true' ]];then
		B_FILE_TESTED='true'
		FILE_PATH=$( type -p file )
	fi
	
	if [[ $B_SUDO_TESTED != 'true' ]];then
		B_SUDO_TESTED='true'
		SUDO_PATH=$( type -p sudo )
	fi
	
	if [[ -n $FILE_PATH && -n $1 ]];then
		# only use sudo if not root, -n option requires sudo -V 1.7 or greater. sudo will just error out
		# which is the safest course here for now, otherwise that interactive sudo password thing is too annoying
		# important: -n makes it non interactive, no prompt for password
		if [[ $B_ROOT != 'true' && -n $SUDO_PATH ]];then
			sudo_command='sudo -n '
		fi
		# this will fail if regular user and no sudo present, but that's fine, it will just return null
		# note the hack that simply slices out the first line if > 1 items found in string
		# also, if grub/lilo is on partition boot sector, no file system data is available
		partition_filesystem=$( eval $sudo_command $FILE_PATH -s $1 | grep -Eio '(ext2|ext3|ext4|ext5|ext[[:space:]]|ntfs|fat32|fat16|fat[[:space:]]\(.*\)|vfat|fatx|tfat|swap|btrfs|ffs[[:space:]]|hfs\+|hfs[[:space:]]plus|hfs[[:space:]]extended[[:space:]]version[[:space:]][1-9]|hfsj|hfs[[:space:]]|jfs[[:space:]]|nss[[:space:]]|reiserfs|reiser4|ufs2|ufs[[:space:]]|xfs[[:space:]]|zfs[[:space:]])' | grep -Em 1 '.*' )
		if [[ -n $partition_filesystem ]];then
			echo $partition_filesystem
		fi
	fi
	eval $LOGFE
}

## return uptime string
get_uptime()
{
	eval $LOGFS
	## note: removing gsub(/ /,"",a); to get get space back in there, goes right before print a
	local uptime_value="$( uptime | gawk '{
		a = gensub(/^.*up *([^,]*).*$/,"\\1","g",$0)
		print a
	}' )"
	echo "$uptime_value"
	log_function_data "uptime_value: $uptime_value"
	eval $LOGFE
}

#### -------------------------------------------------------------------
#### special data handling for specific options and conditions
#### -------------------------------------------------------------------

# args: $1 - string to strip color code characters out of
# returns count of string length minus colors
calculate_line_length()
{
	local string="$1"
	# ansi: [1;34m irc: \x0312
	string=$( sed -e "s/\x1b\[[0-9]\{1,2\}\(;[0-9]\{1,2\}\)\{0,2\}m//g" -e "s/\\\x0[0-9]\{1,3\}//g" <<< $string )
	count=$( wc -c <<< $string )
	echo $count
}

## multiply the core count by the data to be calculated, bmips, cache
# args: $1 - string to handle; $2 - cpu count
calculate_multicore_data()
{
	eval $LOGFS
	local string_number=$1 string_data=''

	if [[ -n $( grep -Ei '( mb| kb)' <<< $1 ) ]];then
		string_data=" $( gawk '{print $2}' <<< $1 )" # add a space for output
		string_number=$( gawk '{print $1}' <<< $1 )
	fi
	# handle weird error cases where it's not a number
	if [[ -n $( grep -E '^[0-9\.,]+$' <<< $string_number ) ]];then
		string_number=$( echo $string_number $2 | gawk '{
			total = $1*$2
			print total
		}' )
	elif [[ $string_number == '' ]];then
		string_number='Not Available'
	else
		# I believe that the above returns 'unknown' by default so no need for extra text
		string_number="$string_number "
	fi
	echo "$string_number$string_data"
	log_function_data "string_numberstring_data: $string_number$string_data"
	eval $LOGFE
}

# prints out shortened list of flags, the main ones of interest
# args: $1 - string of cpu flags to process
process_cpu_flags()
{
	eval $LOGFS
	# must have a space after last item in list for RS=" "
	local cpu_flags_working="$1 "
	
	# nx = AMD stack protection extensions
	# lm = Intel 64bit extensions
	# sse, sse2, pni = sse1,2,3,4,5 gfx extensions
	# svm = AMD pacifica virtualization extensions
	# vmx = Intel IVT (vanderpool) virtualization extensions
	cpu_flags=$( 
	echo "$cpu_flags_working" | gawk '
	BEGIN {
		RS=" "
		count = 0
		i = 1 # start at one because of for increment issue
		flag_string = ""
	}
	/^(lm|nx|pae|pni|svm|vmx|(sss|ss)e([2-9])?([a-z])?(_[0-9])?)$/ {
		if ( $0 == "pni" ){
			a_flags[i] = "sse3"
		}
		else {
			a_flags[i] = $0
		}
		i++
	}
	END {
		count = asort( a_flags )
		# note: why does gawk increment before the loop and not after? weird.
		for ( i=0; i <= count; i++ ){
			if ( flag_string == "" ) {
				flag_string = a_flags[i] 
			}
			else {
				flag_string = flag_string " " a_flags[i]
			}
		}
		print flag_string
	}' 
	)

	#grep -oE '\<(nx|lm|sse[0-9]?|pni|svm|vmx)\>' | tr '\n' ' '))
	if [[ -z $cpu_flags ]];then
		cpu_flags="-"
	fi
	echo "$cpu_flags"
	log_function_data "cpu_flags: $cpu_flags"
	eval $LOGFE
}

#### -------------------------------------------------------------------
#### print and processing of output data
#### -------------------------------------------------------------------

#### MASTER PRINT FUNCTION - triggers all line item print functions
## main function to print out, master for all sub print functions.
print_it_out()
{
	eval $LOGFS
	# note that print_it_out passes local variable values on to its children,
	# and in some cases, their children, with Lspci_v_Data
	local Lspci_v_Data='' Lspci_n_Data='' # only for verbose

	if [[ $B_SHOW_SHORT_OUTPUT == 'true' ]];then
		print_short_data
	else
		Lspci_v_Data="$( get_lspci_data 'v' )"
		if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
			Lspci_n_Data="$( get_lspci_data 'n' )"
		fi
		if [[ $B_SHOW_SYSTEM == 'true' ]];then
			print_system_data
		fi
		if [[ $B_SHOW_MACHINE == 'true' ]];then
			print_machine_data
		fi
		if [[ $B_SHOW_BASIC_CPU == 'true' || $B_SHOW_CPU == 'true' ]];then
			print_cpu_data
		fi
		if [[ $B_SHOW_GRAPHICS == 'true' ]];then
			print_gfx_data
		fi
		if [[ $B_SHOW_AUDIO == 'true' ]];then
			print_audio_data
		fi
		if [[ $B_SHOW_NETWORK == 'true' ]];then
			print_networking_data
		fi
		if [[ $B_SHOW_DISK_TOTAL == 'true' || $B_SHOW_BASIC_DISK == 'true' || $B_SHOW_DISK == 'true' ]];then
			print_hard_disk_data
		fi
		if [[ $B_SHOW_PARTITIONS == 'true' ]];then
			print_partition_data
		fi
		if [[ $B_SHOW_RAID == 'true' || $B_SHOW_BASIC_RAID == 'true' ]];then
			print_raid_data
		fi
		if [[ $B_SHOW_UNMOUNTED_PARTITIONS == 'true' ]];then
			print_unmounted_partition_data
		fi
		if [[ $B_SHOW_SENSORS == 'true' ]];then
			print_sensors_data
		fi
		if [[ $B_SHOW_REPOS == 'true' ]];then
			print_repo_data
		fi
		if [[ $B_SHOW_PS_CPU_DATA == 'true' || $B_SHOW_PS_MEM_DATA == 'true' ]];then
			print_ps_data
		fi
		if [[ $B_SHOW_INFO == 'true' ]];then
			print_info_data
		fi
	fi
	eval $LOGFE
}

#### SHORT OUTPUT PRINT FUNCTION, ie, verbosity 0
# all the get data stuff is loaded here to keep execution time down for single line print commands
# these will also be loaded in each relevant print function for long output
print_short_data()
{
	eval $LOGFS
	local current_kernel=$( uname -rm ) # | gawk '{print $1,$3,$(NF-1)}' )
	local processes="$(( $( ps aux | wc -l ) - 1 ))"
	local short_data='' i='' b_background_black='false'
	local memory=$( get_memory_data )
	local up_time="$( get_uptime )"

	# set A_CPU_CORE_DATA
	get_cpu_core_count
	local cpc_plural='' cpu_count_print='' model_plural=''
	local cpu_physical_count=${A_CPU_CORE_DATA[0]}
	local cpu_core_count=${A_CPU_CORE_DATA[3]}
	local cpu_core_alpha=${A_CPU_CORE_DATA[1]}
	local cpu_type=${A_CPU_CORE_DATA[2]}

	if [[ $cpu_physical_count -gt 1 ]];then
		cpc_plural='(s)'
		model_plural='s'
		cpu_count_print="$cpu_physical_count "
	fi

	local cpu_data_string="${cpu_count_print}${cpu_core_alpha} core"
# 	local cpu_core_count=${A_CPU_CORE_DATA[0]}

	# load A_HDD_DATA
	get_hdd_data_basic
	## note: if hdd_model is declared prior to use, whatever string you want inserted will
	## be inserted first. In this case, it's desirable to print out (x) before each disk found.
	local a_hdd_data_count=$(( ${#A_HDD_DATA[@]} - 1 ))
	IFS=","
	local a_hdd_basic_working=( ${A_HDD_DATA[$a_hdd_data_count]} )
	IFS="$ORIGINAL_IFS"
	local hdd_capacity=${a_hdd_basic_working[0]}
	local hdd_used=${a_hdd_basic_working[1]}

	# load A_CPU_DATA
	get_cpu_data

	IFS=","
	local a_cpu_working=(${A_CPU_DATA[0]})
	IFS="$ORIGINAL_IFS"
	local cpu_model="${a_cpu_working[0]}"
	## assemble data for output
	local cpu_clock="${a_cpu_working[1]}" # old CPU3
	# this gets that weird min/max final array item, which almost never contains any data of use
	local min_max_clock_nu=$(( ${#A_CPU_DATA[@]} - 1 ))
	local min_max_clock=${A_CPU_DATA[$min_max_clock_nu]}
	# this handles the case of for example ARM cpus, which will not have data for
	# min/max, since they don't have speed. Since that sets a flag, not found, just
	# look for that and use the speed from the first array array, same where we got 
	# model from
	if [[ "$min_max_clock" == 'N/A' && ${a_cpu_working[1]} != '' ]];then
		min_max_clock="${a_cpu_working[1]}"
	fi
	local script_patch_number=$( get_patch_version_string )

	#set_color_scheme 12
	if [[ $B_RUNNING_IN_SHELL == 'false' ]];then
		for i in $C1 $C2 $CN
		do
			case "$i" in
				"$GREEN"|"$WHITE"|"$YELLOW"|"$CYAN")
					b_background_black='true'
					;;
			esac
		done
		if [[ $b_background_black == 'true' ]];then
			for i in C1 C2 CN
			do
				## these need to be in quotes, don't know why
				if [[ ${!i} == $NORMAL ]];then
					declare $i="${!i}15,1"
				else
					declare $i="${!i},1"
				fi
			done
			#C1="${C1},1"; C2="${C2},1"; CN="${CN},1"
		fi
	fi
	short_data="${C1}CPU$cpc_plural${C2}${SEP1}${cpu_data_string} ${cpu_model}$model_plural (${cpu_type}) clocked at ${min_max_clock}${SEP2}${C1}Kernel${C2}${SEP1}${current_kernel}${SEP2}${C1}Up${C2}${SEP1}${up_time}${SEP2}${C1}Mem${C2}${SEP1}${memory}${SEP2}${C1}HDD${C2}${SEP1}${hdd_capacity}($hdd_used)${SEP2}${C1}Procs${C2}${SEP1}${processes}${SEP2}"

	if [[ $SHOW_IRC -gt 0 ]];then
		short_data="${short_data}${C1}Client${C2}${SEP1}${IRC_CLIENT}${IRC_CLIENT_VERSION}${SEP2}"
	fi
	short_data="${short_data}${C1}$SCRIPT_NAME${C2}${SEP1}$SCRIPT_VERSION_NUMBER$script_patch_number${SEP2}${CN}"
	if [[ $SCHEME -gt 0 ]];then
		short_data="${short_data} $NORMAL"
	fi
	print_screen_output "$short_data"
	eval $LOGFE
}

#### LINE ITEM PRINT FUNCTIONS

# print sound card data
print_audio_data()
{
	eval $LOGFS
	local i='' card_id='' audio_data='' a_audio_data='' port_data='' pci_bus_id='' card_string=''
	local a_audio_working='' audio_driver='' alsa_data='' port_plural='' module_version=''
	local bus_usb_text='' bus_usb_id='' line_starter='Audio:' alsa='' alsa_version='' print_data=''
	# set A_AUDIO_DATA and get alsa data
	get_audio_data
	get_audio_alsa_data
	# alsa driver data now prints out no matter what
	if [[ -n $A_ALSA_DATA ]];then
		IFS=","
		if [[ -n ${A_ALSA_DATA[0]} ]];then
			alsa=${A_ALSA_DATA[0]}
		else
			alsa='N/A'
		fi
		if [[ -n ${A_ALSA_DATA[1]} ]];then
			alsa_version=${A_ALSA_DATA[1]}
		else
			alsa_version='N/A'
		fi
		alsa_data="${C1}Sound:${C2} $alsa ${C1}ver$SEP3${C2} $alsa_version"
		IFS="$ORIGINAL_IFS"
	fi
	# note, error handling is done in the get function, so this will never be null, but
	# leaving the test just in case it's changed.
	if [[ -n ${A_AUDIO_DATA[@]} ]];then
		for (( i=0; i< ${#A_AUDIO_DATA[@]}; i++ ))
		do
			IFS=","
			a_audio_working=( ${A_AUDIO_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			port_data=''
			audio_driver=''
			audio_data=''
			card_string=''
			port_plural=''
			module_version=''
			pci_bus_id=''
			bus_usb_text=''
			bus_usb_id=''
			print_data=''
			vendor_product=''
			
			if [[ ${#A_AUDIO_DATA[@]} -gt 1 ]];then
				card_id="-$(( $i + 1 ))"
			fi
			if [[ -n ${a_audio_working[3]} && $B_EXTRA_DATA == 'true' ]];then
				module_version=$( print_module_version "${a_audio_working[3]}" 'audio' )
			elif [[ -n ${a_audio_working[1]} && $B_EXTRA_DATA == 'true' ]];then
				module_version=$( print_module_version "${a_audio_working[1]}" 'audio' )
			fi
			# we're testing for the presence of the 2nd array item here, which is the driver name
			if [[ -n ${a_audio_working[1]} ]];then
				audio_driver="${C1}driver$SEP3${C2} ${a_audio_working[1]} "
			fi
			if [[ -n ${a_audio_working[2]} && $B_EXTRA_DATA == 'true' ]];then
				if [[ $( wc -w <<< ${a_audio_working[2]} ) -gt 1 ]];then
					port_plural='s'
				fi
				port_data="${C1}port$port_plural$SEP3${C2} ${a_audio_working[2]} "
			fi
			if [[ -n ${a_audio_working[4]} && $B_EXTRA_DATA == 'true' ]];then
				if [[ ${a_audio_working[1]} != 'USB Audio' ]];then
					bus_usb_text='bus-ID'
					if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
						vendor_product=$( get_lspci_vendor_product "${a_audio_working[4]}" )
					fi
				else
					bus_usb_text='usb-ID'
					if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
						vendor_product=${a_audio_working[5]}
					fi
				fi
				bus_usb_id=${a_audio_working[4]}
				pci_bus_id="${C1}$bus_usb_text$SEP3${C2} $bus_usb_id "
				if [[ -n $vendor_product ]];then
					vendor_product="${C1}chip-ID$SEP3${C2} $vendor_product "
				fi
			fi
			if [[ -n ${a_audio_working[0]} ]];then
				card_string="${C1}Card$card_id:${C2} ${a_audio_working[0]} "
				audio_data="$audio_driver$port_data$pci_bus_id$vendor_product"
			fi
			# only print alsa on last line if short enough, otherwise print on its own line
			if [[ $i -eq 0 ]];then
				if [[ -n $alsa_data && $( calculate_line_length "$card_string${audio_data}$alsa_data" ) -lt $LINE_MAX ]];then
					audio_data="$audio_data$alsa_data"
					alsa_data=''
				fi
			fi
			if [[ -n $audio_data ]];then
				if [[ $( calculate_line_length "$card_string$audio_data" ) -lt $LINE_MAX ]];then
					print_data=$( create_print_line "$line_starter" "$card_string$audio_data" )
					print_screen_output "$print_data"
				# print the line
				else
					# keep the driver on the same line no matter what, looks weird alone on its own line
					if [[ $B_EXTRA_DATA != 'true' ]];then
						print_data=$( create_print_line "$line_starter" "$card_string$audio_data" )
						print_screen_output "$print_data"
					else
						print_data=$( create_print_line "$line_starter" "$card_string" )
						print_screen_output "$print_data"
						line_starter=' '
						print_data=$( create_print_line "$line_starter" "$audio_data" )
						print_screen_output "$print_data"
					fi
				fi
				line_starter=' '
			fi
		done
	fi
	if [[ -n $alsa_data ]];then
		alsa_data=$( sed 's/ALSA/Advanced Linux Sound Architecture/' <<< $alsa_data )
		alsa_data=$( create_print_line "$line_starter" "$alsa_data" )
		print_screen_output "$alsa_data"
	fi
	eval $LOGFE
}

print_cpu_data()
{
	eval $LOGFS
	local cpu_data='' i='' cpu_clock_speed='' cpu_multi_clock_data=''
	local bmip_data='' cpu_cache='' cpu_vendor='' cpu_flags=''

	##print_screen_output "A_CPU_DATA[0]=\"${A_CPU_DATA[0]}\""
	# Array A_CPU_DATA always has one extra element: max clockfreq found.
	# that's why its count is one more than you'd think from cores/cpus alone
	# load A_CPU_DATA
	get_cpu_data

	IFS=","
	local a_cpu_working=(${A_CPU_DATA[0]})
	IFS="$ORIGINAL_IFS"
	local cpu_model="${a_cpu_working[0]}"
	## assemble data for output
	local cpu_clock="${a_cpu_working[1]}"

	cpu_vendor=${a_cpu_working[5]}

	# set A_CPU_CORE_DATA
	get_cpu_core_count
	local cpc_plural='' cpu_count_print='' model_plural=''
	local cpu_physical_count=${A_CPU_CORE_DATA[0]}
	local cpu_core_count=${A_CPU_CORE_DATA[3]}
	local cpu_core_alpha=${A_CPU_CORE_DATA[1]}
	local cpu_type=${A_CPU_CORE_DATA[2]}

	if [[ $cpu_physical_count -gt 1 ]];then
		cpc_plural='(s)'
		cpu_count_print="$cpu_physical_count "
		model_plural='s'
	fi

	local cpu_data_string="${cpu_count_print}${cpu_core_alpha} core"
	# Strange (and also some expected) behavior encountered. If print_screen_output() uses $1
	# as the parameter to output to the screen, then passing "<text1> ${ARR[@]} <text2>"
	# will output only <text1> and first element of ARR. That "@" splits in elements and "*" _doesn't_,
	# is to be expected. However, that text2 is consecutively truncated is somewhat strange, so take note.
	# This has been confirmed by #bash on freenode.
	# The above mentioned only emerges when using the debugging markers below
	## print_screen_output "a_cpu_working=\"***${a_cpu_working[@]} $hostName+++++++\"----------"
	
	# cpu cache
	if [[ -z ${a_cpu_working[2]} ]];then
		a_cpu_working[2]="unknown"
	fi

	cpu_data=$( create_print_line "CPU$cpc_plural:" "${C1}${cpu_data_string}${C2} ${a_cpu_working[0]}$model_plural (${cpu_type})" )
	if [[ $B_SHOW_CPU == 'true' ]];then
		# update for multicore, bogomips x core count.
		if [[ $B_EXTRA_DATA == 'true' ]];then
# 			if [[ $cpu_vendor != 'intel' ]];then
				bmip_data=$( calculate_multicore_data "${a_cpu_working[4]}" "$(( $cpu_core_count * $cpu_physical_count ))" )
# 			else
# 				bmip_data="${a_cpu_working[4]}"
# 			fi
			bmip_data=" ${C1}bmips$SEP3${C2} $bmip_data"
		fi
		## note: this handles how intel reports L2, total instead of per core like AMD does
		# note that we need to multiply by number of actual cpus here to get true cache size
		if [[ $cpu_vendor != 'intel' ]];then
			cpu_cache=$( calculate_multicore_data "${a_cpu_working[2]}" "$(( $cpu_core_count * $cpu_physical_count ))"  )
		else
			cpu_cache=$( calculate_multicore_data "${a_cpu_working[2]}" "$cpu_physical_count"  )
		fi
		# only print shortened list
		if [[ $B_CPU_FLAGS_FULL != 'true' ]];then
			# gawk has already sorted this output
			cpu_flags=$( process_cpu_flags "${a_cpu_working[3]}" )
			cpu_flags=" ${C1}flags$SEP3${C2} ($cpu_flags)"
		fi
		cpu_data="$cpu_data${C2} ${C1}cache$SEP3${C2} $cpu_cache$cpu_flags$bmip_data${CN}"
	fi
	# we don't this printing out extra line unless > 1 cpu core
	if [[ ${#A_CPU_DATA[@]} -gt 2 && $B_SHOW_CPU == 'true' ]];then
		cpu_clock_speed='' # null < verbosity level 5
	else
		cpu_data="$cpu_data ${C1}clocked at${C2} ${a_cpu_working[1]} MHz${CN}"
	fi

	cpu_data="$cpu_data $cpu_clock_speed"
	print_screen_output "$cpu_data"

	# we don't this printing out extra line unless > 1 cpu core
	# note the numbering, the last array item is the min/max/not found for cpu speeds
	if [[ ${#A_CPU_DATA[@]} -gt 2 && $B_SHOW_CPU == 'true' ]];then
		for (( i=0; i < ${#A_CPU_DATA[@]}-1; i++ ))
		do
			IFS=","
			a_cpu_working=(${A_CPU_DATA[i]})
			IFS="$ORIGINAL_IFS"
			# note: the first iteration will create a first space, for color code separation below
			cpu_multi_clock_data="$cpu_multi_clock_data ${C1}$(( i + 1 )):${C2} ${a_cpu_working[1]} MHz${CN}"
			# someone actually appeared with a 16 core system, so going to stop the cpu core throttle
			# if this had some other purpose which we can't remember we'll add it back in
			#if [[ $i -gt 10 ]];then
			#	break
			#fi
		done
		if [[ -n $cpu_multi_clock_data ]];then
			cpu_multi_clock_data=$( create_print_line " " "${C1}Clock Speeds:${C2}$cpu_multi_clock_data" )
			print_screen_output "$cpu_multi_clock_data"
		fi
	fi
	if [[ $B_CPU_FLAGS_FULL == 'true' ]];then
		print_cpu_flags_full "${a_cpu_working[3]}"
	fi
	eval $LOGFE
}

# takes list of all flags, split them and prints x per line
# args: $1 - cpu flag string
print_cpu_flags_full()
{
	eval $LOGFS
	# note: sort only sorts lines, not words in a string, so convert to lines
	local cpu_flags_full="$( echo $1 | tr " " "\n" | sort )" 
	local a_cpu_flags='' line_starter=''
	local i=0 counter=0 max_length=85 max_length_minus=15 flag='' flag_data=''
	local line_length_max=''
	

	# build the flag line array
	for flag in $cpu_flags_full
	do
		a_cpu_flags[$counter]="${a_cpu_flags[$counter]}$flag "
		if [[ $counter -eq 0 ]];then
			line_length_max=$(( $max_length - $max_length_minus ))
		else
			line_length_max=$max_length
		fi
		
		if [[ $( wc -c <<< ${a_cpu_flags[$counter]} ) -gt $line_length_max ]];then
			(( counter++ ))
		fi
	done
	# then print it out
	for (( i=0; i < ${#a_cpu_flags[@]};i++ ))
	do
		if [[ $i -eq 0 ]];then
			line_starter="${C1}CPU Flags$SEP3${C2} "
		else
			line_starter=''
		fi
		flag_data=$( create_print_line " " "$line_starter${a_cpu_flags[$i]}" )
		print_screen_output "$flag_data"
	done
	eval $LOGFE
}

print_gfx_data()
{
	eval $LOGFS
	local gfx_data='' i='' card_id='' root_alert='' root_x_string='' a_gfx_working=''
	local b_is_mesa='false' display_full_string='' gfx_bus_id='' gfx_card_data=''
	local res_tty='Resolution' xorg_data='' x_vendor_string='' vendor_product=''
	local spacer='' x_driver='' x_driver_string='' x_driver_plural='' direct_render_string=''
	local separator_loaded='' separator_unloaded='' separator_failed='' 
	local loaded='' unloaded='' failed=''
	local line_starter='Graphics:'
	local screen_resolution="$( get_graphics_res_data )"
	# set A_GFX_CARD_DATA
	get_graphics_card_data
	# set A_X_DATA
	get_graphics_x_data
	local x_vendor=${A_X_DATA[0]}
	local x_version=${A_X_DATA[1]}
	# set A_GLX_DATA
	get_graphics_glx_data
	local glx_renderer="${A_GLX_DATA[0]}"
	local glx_version="${A_GLX_DATA[1]}"
	# this can contain a long No case debugging message, so it's being sliced off
	# note: using grep -ioE '(No|Yes)' <<< ${A_GLX_DATA[2]} did not work in Arch, no idea why
	local glx_direct_render=$( gawk '{print $1}' <<< "${A_GLX_DATA[2]}" )
	
	# set A_GRAPHIC_DRIVERS
	get_graphics_driver
	
	if [[ ${#A_GRAPHIC_DRIVERS[@]} -eq 0 ]];then
		x_driver=' N/A'
	else
		for (( i=0; i < ${#A_GRAPHIC_DRIVERS[@]}; i++ ))
		do
			IFS=","
			a_gfx_working=( ${A_GRAPHIC_DRIVERS[i]} )
			IFS="$ORIGINAL_IFS"
			case ${a_gfx_working[1]} in
				loaded)
					loaded="$loaded$separator_loaded${a_gfx_working[0]}"
					separator_loaded=','
					;;
				unloaded)
					unloaded="$unloaded$separator_unloaded${a_gfx_working[0]}"
					separator_unloaded=','
					;;
				failed)
					failed="$failed$separator_failed${a_gfx_working[0]}"
					separator_failed=','
					;;		
			esac
		done
	fi
	if [[ -n $loaded ]];then
		x_driver="${x_driver} $loaded"
	fi
	if [[ -n $unloaded ]];then
		x_driver="${x_driver} (unloaded: $unloaded)"
	fi
	if [[ -n $failed ]];then
		x_driver="${x_driver} ${RED}FAILED:${C2} $failed"
	fi

	if [[ ${#A_GRAPHIC_DRIVERS[@]} -gt 1 ]];then
		x_driver_plural='s'
	fi
	x_driver_string="${C1}driver$x_driver_plural$SEP3${C2}$x_driver "
	
	# some basic error handling:
	if [[ -z $screen_resolution ]];then
		screen_resolution='N/A'
	fi
	if [[ -z $x_vendor || -z $x_version ]];then
		x_vendor_string="${C1}X-Vendor:${C2} N/A "
	else
		x_vendor_string="${C1}$x_vendor$SEP3${C2} $x_version "
	fi

	if [[ $B_ROOT == 'true' ]];then
		root_x_string='for root '
		if [[ $B_RUNNING_IN_SHELL == 'true' || $B_CONSOLE_IRC == 'true' ]];then
			res_tty='tty size'
		fi
	fi
	if [[ $B_RUNNING_IN_X != 'true' ]];then
		root_x_string="${root_x_string}out of X"
		res_tty='tty size'
	fi
	
	if [[ -n $root_x_string ]];then
		root_x_string="${C1}Advanced Data:${C2} N/A $root_x_string"
	fi

	display_full_string="$x_vendor_string$x_driver_string${C1}${res_tty}$SEP3${C2} ${screen_resolution} $root_x_string"

	if [[ ${#A_GFX_CARD_DATA[@]} -gt 0 ]];then
		for (( i=0; i < ${#A_GFX_CARD_DATA[@]}; i++ ))
		do
			IFS=","
			a_gfx_working=( ${A_GFX_CARD_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			gfx_bus_id=''
			gfx_card_data=${a_gfx_working[0]}
			if [[ $B_EXTRA_DATA == 'true' ]];then
				if [[ -n ${a_gfx_working[1]} ]];then
					gfx_bus_id=" ${C1}bus-ID$SEP3${C2} ${a_gfx_working[1]}"
					if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
						vendor_product=$( get_lspci_vendor_product "${a_gfx_working[1]}" )
					fi
				else
					gfx_bus_id=" ${C1}bus-ID$SEP3${C2} N/A"
				fi
			fi
			if [[ -n $vendor_product ]];then
				vendor_product=" ${C1}chip-ID$SEP3${C2} $vendor_product"
			fi
			if [[ ${#A_GFX_CARD_DATA[@]} -gt 1 ]];then
				card_id="Card-$(($i+1)):"
			else
				card_id='Card:'
			fi
			gfx_data="${C1}$card_id${C2} $gfx_card_data$gfx_bus_id$vendor_product "
			if [[ ${#A_GFX_CARD_DATA[@]} -gt 1 ]];then
				gfx_data=$( create_print_line "$line_starter" "${gfx_data}" )
				print_screen_output "$gfx_data"
				line_starter=' '
				gfx_data=''
			fi
		done
	# handle cases where card detection fails, like in PS3, where lspci gives no output, or headless boxes..
	else
		gfx_data="${C1}Card:${C2} Failed to Detect Video Card! "
	fi
	if [[ -n $gfx_data && $( calculate_line_length "${gfx_data}$display_full_string" ) -lt $LINE_MAX ]];then
		gfx_data=$( create_print_line "$line_starter" "${gfx_data}$display_full_string" )
	else
		if [[ -n $gfx_data ]];then
			gfx_data=$( create_print_line "$line_starter" "$gfx_data" )
			print_screen_output "$gfx_data"
			line_starter=' '
		fi
		gfx_data=$( create_print_line "$line_starter" "$display_full_string" )
	fi
	print_screen_output "$gfx_data"
# 	if [[ -z $glx_renderer || -z $glx_version ]];then
# 		b_is_mesa='true'
# 	fi

	## note: if glx render or version have no content, then mesa is true
	# if [[ $B_SHOW_X_DATA == 'true' ]] && [[ $b_is_mesa != 'true' ]];then
	if [[ $B_SHOW_X_DATA == 'true' && $B_ROOT != 'true' ]];then
		if [[ -z $glx_renderer ]];then
			glx_renderer='N/A'
		fi
		if [[ -z $glx_version ]];then
			glx_version='N/A'
		fi
		if [[ -z $glx_direct_render ]];then
			glx_direct_render='N/A'
		fi
		if [[ $B_HANDLE_CORRUPT_DATA == 'true' || $B_EXTRA_DATA == 'true' ]];then
			direct_render_string=" ${C1}Direct Rendering$SEP3${C2} ${glx_direct_render}${CN}"
		fi
		gfx_data="${C1}GLX Renderer$SEP3${C2} ${glx_renderer} ${C1}GLX Version$SEP3${C2} ${glx_version}${CN}$direct_render_string"
		gfx_data=$( create_print_line " " "$gfx_data" )
		
		print_screen_output "$gfx_data"
	fi
	eval $LOGFE
}

print_hard_disk_data()
{
	eval $LOGFS
	local hdd_data='' hdd_data_2='' a_hdd_working='' hdd_temp_data='' hdd_string=''
	local hdd_serial=''
	local dev_data='' size_data='' hdd_model='' usb_data='' hdd_name='' divisor=5
	local Line_Starter='Drives:' # inherited by print_optical_drives

	# load A_HDD_DATA
	get_hdd_data_basic
	## note: if hdd_model is declared prior to use, whatever string you want inserted will
	## be inserted first. In this case, it's desirable to print out (x) before each disk found.
	local a_hdd_data_count=$(( ${#A_HDD_DATA[@]} - 1 ))
	IFS=","
	local a_hdd_basic_working=( ${A_HDD_DATA[$a_hdd_data_count]} )
	IFS="$ORIGINAL_IFS"
	local hdd_capacity="${a_hdd_basic_working[0]}"
	local hdd_used=${a_hdd_basic_working[1]}

	if [[ $B_SHOW_BASIC_DISK == 'true' || $B_SHOW_DISK == 'true' ]];then
	## note: the output part of this should be in the print hdd data function, not here
		get_hard_drive_data_advanced
		for (( i=0; i < ${#A_HDD_DATA[@]} - 1; i++ ))
		do
			# this adds the (x) numbering in front of each disk found, and creates the full disk string
			IFS=","
			a_hdd_working=( ${A_HDD_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			if [[ $B_SHOW_DISK == 'true' ]];then
				if [[ -n ${a_hdd_working[3]} ]];then
					usb_data="${a_hdd_working[3]} "
				else
					usb_data=''
				fi
				dev_data="/dev/${a_hdd_working[0]} "
				size_data=" ${C1}size$SEP3${C2} ${a_hdd_working[1]}"
				if [[ $B_EXTRA_DATA == 'true' && -n $dev_data ]];then
					hdd_temp_data=$( get_hdd_temp_data "$dev_data" )
					# error handling is done in get data function
					if [[ -n $hdd_temp_data ]];then
						hdd_temp_data=" ${C1}temp$SEP3${C2} ${hdd_temp_data}C"
					else
						hdd_temp_data=''
					fi
				fi
				if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
					hdd_serial=$( get_hdd_serial_number "${a_hdd_working[0]}" )
					if [[ -z $hdd_serial ]];then
						hdd_serial='N/A'
					fi
					hdd_serial=" ${C1}serial$SEP3${C2} $hdd_serial"
					divisor=1 # print every line
				else
					divisor=2 # for modulus line print out, either 2 items for full, or default for short
				fi
				dev_data="${C1}id$SEP3${C2} /dev/${a_hdd_working[0]} "
			fi
			hdd_name="${C1}model$SEP3${C2} ${a_hdd_working[2]}"
			hdd_string="$usb_data$dev_data$hdd_name$size_data$hdd_serial$hdd_temp_data"
			hdd_model="${hdd_model}${C1}$(($i+1)):${C2} $hdd_string "
			# printing line one, then new lines according to $divisor setting, and after, if leftovers, print that line.
			case $i in 
				0)
					if [[ $divisor -eq 1 ]];then
						hdd_data=$( create_print_line "$Line_Starter" "${C1}HDD Total Size:${C2} ${hdd_capacity} (${hdd_used})" )
						print_screen_output "$hdd_data"
						Line_Starter=' '
						hdd_data=$( create_print_line "$Line_Starter" "${hdd_model}" )
						print_screen_output "$hdd_data"
						hdd_model=''
					else
						hdd_data=$( create_print_line "$Line_Starter" "${C1}HDD Total Size:${C2} ${hdd_capacity} (${hdd_used}) ${hdd_model}" )
						print_screen_output "$hdd_data"
						hdd_model=''
						Line_Starter=' '
					fi
					;;
				*)
					# using modulus here, if divisible by $divisor, print line, otherwise skip
					if [[ $(( $i % $divisor )) -eq 0 ]];then
						hdd_data=$( create_print_line "$Line_Starter" "${hdd_model}${CN}" )
						print_screen_output "$hdd_data"
						hdd_model=''
						Line_Starter=' '
					fi
					;;
			esac
		done
		# then print any leftover items
		if [[ -n $hdd_model ]];then
			hdd_data=$( create_print_line "$Line_Starter" "${hdd_model}${CN}" )
			print_screen_output "$hdd_data"
		fi
	else
		hdd_data=$( create_print_line "$Line_Starter" "${C1}HDD Total Size:${C2} ${hdd_capacity} (${hdd_used})${CN}" )
		print_screen_output "$hdd_data"
		Line_Starter=' '
	fi
	if [[ $B_SHOW_FULL_OPTICAL == 'true' || $B_SHOW_BASIC_OPTICAL == 'true' ]];then
		print_optical_drive_data
	fi

	eval $LOGFE
}

print_info_data()
{
	eval $LOGFS

	local info_data='' line_starter='Info:'
	local runlvl='' client_data='' shell_data='' shell_parent='' tty_session=''
	local memory="$( get_memory_data )"
	local processes="$(( $( ps aux | wc -l ) - 1 ))"
	local up_time="$( get_uptime )"
	local script_patch_number=$( get_patch_version_string )
	local gcc_string='' gcc_installed='' gcc_others='' closing_data='' 
	
	if [[ $B_EXTRA_DATA == 'true' ]];then
		get_gcc_system_version
		if [[ ${#A_GCC_VERSIONS[@]} -gt 0 ]];then
			if [[ -n ${A_GCC_VERSIONS[0]} ]];then
				gcc_installed=${A_GCC_VERSIONS[0]}
			else
				gcc_installed='N/A'
			fi
			if [[ $B_EXTRA_EXTRA_DATA == 'true' && -n ${A_GCC_VERSIONS[1]} ]];then
				gcc_others=" ${C1}alt$SEP3${C2} $( tr ',' '/' <<< ${A_GCC_VERSIONS[1]} )"
			fi
			gcc_installed="${C1}Gcc sys$SEP3${C2} $gcc_installed$gcc_others "
		fi
	fi
	if [[  $B_RUNNING_IN_SHELL == 'true' ]];then
		shell_data=$( get_shell_data )
		if [[ -n $shell_data ]];then
			# note, if you start this in tty, it will give 'login' as the parent, which we don't want.
			if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
				shell_parent=$( get_shell_parent )
				if [[ $B_RUNNING_IN_X != 'true' ]];then
					shell_parent=$( get_tty_number )
					shell_parent="tty $shell_parent"
				fi
				if [[ $shell_parent == 'login' ]];then
					shell_parent=''
				elif [[ -n $shell_parent ]];then
					shell_parent=" running in $shell_parent"
				fi
			fi
			IRC_CLIENT="$IRC_CLIENT ($shell_data$shell_parent)"
		fi
	fi

	# Some code could look superfluous but BitchX doesn't like lines not ending in a newline. F*&k that bitch!
	# long_last=$( echo -ne "${C1}Processes$SEP3${C2} ${processes}${CN} | ${C1}Uptime$SEP3${C2} ${up_time}${CN} | ${C1}Memory$SEP3${C2} ${MEM}${CN}" )
	info_data="${C1}Processes$SEP3${C2} ${processes} ${C1}Uptime$SEP3${C2} ${up_time} ${C1}Memory$SEP3${C2} ${memory}${CN} "

	# this only triggers if no X data is present or if extra data switch is on
	if [[ $B_SHOW_X_DATA != 'true' || $B_EXTRA_DATA == 'true' ]];then
		runlvl="$( get_runlevel_data )"
		if [[ -n $runlvl ]];then
			info_data="${info_data}${C1}Runlevel$SEP3${C2} ${runlvl} "
		fi
	fi
	if [[ $SHOW_IRC -gt 0 ]];then
		client_data="${C1}Client$SEP3${C2} ${IRC_CLIENT}${IRC_CLIENT_VERSION} "
	fi
	info_data="${info_data}$gcc_installed"
	closing_data="$client_data${C1}$SCRIPT_NAME$SEP3${C2} $SCRIPT_VERSION_NUMBER$script_patch_number${CN}"
	if [[ -n $info_data && $( calculate_line_length "$info_data$closing_data" ) -gt $LINE_MAX ]];then
		info_data=$( create_print_line "$line_starter" "$info_data" )
		print_screen_output "$info_data"
		info_data="$closing_data"
		line_starter=' '
	else
		info_data="${info_data}$closing_data"
	fi
	info_data=$( create_print_line "$line_starter" "$info_data" )
	if [[ $SCHEME -gt 0 ]];then
		info_data="${info_data} ${NORMAL}"
	fi
	print_screen_output "$info_data"
	eval $LOGFE
}

print_machine_data()
{
	eval $LOGFS
	
	local system_line='' mobo_line='' bios_line='' chassis_line=''
	local mobo_vendor='' mobo_model='' mobo_version='' mobo_serial=''
	local bios_vendor='' bios_version='' bios_date=''
	local system_vendor='' product_name='' product_version='' product_serial='' product_uuid=''
	local chassis_vendor='' chassis_type='' chassis_version='' chassis_serial=''
	local b_skip_system='false' b_skip_chassis='false'
	# set A_MACHINE_DATA
	get_machine_data

	IFS=','
	## keys for machine data are:
	# 0-sys_vendor 1-product_name 2-product_version 3-product_serial 4-product_uuid 
	# 5-board_vendor 6-board_name 7-board_version 8-board_serial 
	# 9-bios_vendor 10-bios_version 11-bios_date 
	## with extra data: 
	# 12-chassis_vendor 13-chassis_type 14-chassis_version 15-chassis_serial
	
	if [[ ${#A_MACHINE_DATA[@]} -gt 0 ]];then
		# note: in some case a mobo/version will match a product name/version, do not print those
		# but for laptops, or even falsely id'ed desktops with batteries, let's print it all if it matches
		# there can be false id laptops if battery appears so need to make sure system is filled
		if [[ -z ${A_MACHINE_DATA[0]} ]];then
			b_skip_system='true'
		else
			if [[ $B_PORTABLE != 'true'  ]];then
				# ibm / ibm can be true; dell / quantum is false, so in other words, only do this
				# in case where the vendor is the same and the version is the same and not null, 
				# otherwise the version information is going to be different in all cases I think
				if [[ -n ${A_MACHINE_DATA[0]} && ${A_MACHINE_DATA[0]} == ${A_MACHINE_DATA[5]} ]];then
					if [[ -n ${A_MACHINE_DATA[2]} && ${A_MACHINE_DATA[2]} == ${A_MACHINE_DATA[7]} ]] || \
					[[ -z ${A_MACHINE_DATA[2]} && ${A_MACHINE_DATA[1]} == ${A_MACHINE_DATA[6]} ]];then
						b_skip_system='true'
					fi
				fi
			fi
		fi
		# no point in showing chassis if system isn't there, it's very unlikely that would be correct
		if [[ $B_EXTRA_EXTRA_DATA == 'true' && $b_skip_system != 'true' ]];then
			if [[ -n ${A_MACHINE_DATA[7]} && ${A_MACHINE_DATA[14]} == ${A_MACHINE_DATA[7]} ]];then
				b_skip_chassis='true'
			fi
			if [[ -n ${A_MACHINE_DATA[12]} && $b_skip_chassis != 'true' ]];then
				# no need to print the vendor string again if it's the same
				if [[ ${A_MACHINE_DATA[12]} != ${A_MACHINE_DATA[0]} ]];then
					chassis_vendor=" ${A_MACHINE_DATA[12]}"
				fi
				if [[ -n ${A_MACHINE_DATA[13]} ]];then
					chassis_type=" ${C1}type$SEP3${C2} ${A_MACHINE_DATA[13]}"
				fi
				if [[ -n ${A_MACHINE_DATA[14]} ]];then
					chassis_version=" ${C1}version$SEP3${C2} ${A_MACHINE_DATA[14]}"
				fi
				if [[ -n ${A_MACHINE_DATA[15]} && $B_OUTPUT_FILTER != 'true' ]];then
					chassis_serial=" ${C1}serial$SEP3${C2} ${A_MACHINE_DATA[15]}"
				fi
				if [[ -n "$chassis_vendor$chassis_type$chassis_version$chassis_serial" ]];then
					chassis_line="${C1}Chassis$SEP3${C2}$chassis_vendor$chassis_type$chassis_version$chassis_serial"
				fi
			fi
		fi
		if [[ -n ${A_MACHINE_DATA[5]} ]];then
			mobo_vendor=${A_MACHINE_DATA[5]}
		else
			mobo_vendor='N/A'
		fi
		if [[ -n ${A_MACHINE_DATA[6]} ]];then
			mobo_model=${A_MACHINE_DATA[6]}
		else
			mobo_model='N/A'
		fi
		if [[ -n ${A_MACHINE_DATA[7]} ]];then
			mobo_version=" ${C1}version$SEP3${C2} ${A_MACHINE_DATA[7]}"
		fi
		if [[ -n ${A_MACHINE_DATA[8]} && $B_OUTPUT_FILTER != 'true' ]];then
			mobo_serial=" ${C1}serial$SEP3${C2} ${A_MACHINE_DATA[8]}"
		fi
		if [[ -n ${A_MACHINE_DATA[9]} ]];then
			bios_vendor=${A_MACHINE_DATA[9]}
		else
			bios_vendor='N/A'
		fi
		if [[ -n ${A_MACHINE_DATA[10]} ]];then
			bios_version=${A_MACHINE_DATA[10]}
		else
			bios_version='N/A'
		fi
		if [[ -n ${A_MACHINE_DATA[11]} ]];then
			bios_date=${A_MACHINE_DATA[11]}
		else
			bios_date='N/A'
		fi
		mobo_line="${C1}Mobo$SEP3${C2} $mobo_vendor ${C1}model$SEP3${C2} $mobo_model$mobo_version$mobo_serial"
		bios_line="${C1}Bios$SEP3${C2} $bios_vendor ${C1}version$SEP3${C2} $bios_version ${C1}date$SEP3${C2} $bios_date"
		if [[ $( calculate_line_length "$mobo_line$bios_line" ) -lt $LINE_MAX ]];then
			mobo_line="$mobo_line $bios_line"
			bios_line=''
		fi
		if [[ $b_skip_system == 'true' ]];then
			system_line=$mobo_line
			mobo_line=''
		else
			# this has already been tested for above so we know it's not null
			system_vendor=${A_MACHINE_DATA[0]}
			if [[ $B_PORTABLE == 'true' ]];then
				system_vendor="$system_vendor (portable)"
			fi
 			if [[ -n ${A_MACHINE_DATA[1]} ]];then
				product_name=${A_MACHINE_DATA[1]}
			else
				product_name='N/A'
			fi
			if [[ -n ${A_MACHINE_DATA[2]} ]];then
				product_version=" ${C1}version$SEP3${C2} ${A_MACHINE_DATA[2]}"
			fi
			if [[ -n ${A_MACHINE_DATA[3]} && $B_OUTPUT_FILTER != 'true' ]];then
				product_serial=" ${C1}serial$SEP3${C2} ${A_MACHINE_DATA[3]} "
			fi
			system_line="${C1}System$SEP3${C2} $system_vendor ${C1}product$SEP3${C2} $product_name$product_version$product_serial"
			if [[ -n $chassis_line && $( calculate_line_length "$system_line$chassis_line" ) -lt $LINE_MAX ]];then
				system_line="$system_line $chassis_line"
				chassis_line=''
			fi
		fi
		IFS="$ORIGINAL_IFS"
	else
		system_line="${C2}No /sys/class/dmi machine data - try newer kernel, or install dmidecode${CN}"
	fi
	# patch to dump all of above if dmidecode was data source and non root user
	if [[ ${A_MACHINE_DATA[0]} == 'dmidecode-non-root-user' || ${A_MACHINE_DATA[0]} == 'dmidecode-no-smbios-dmi-data' ]];then
		if [[ ${A_MACHINE_DATA[0]} == 'dmidecode-non-root-user' ]];then
			system_line="${C2}No /sys/class/dmi, using dmidecode: you must be root to run dmidecode${CN}"
		elif [[ ${A_MACHINE_DATA[0]} == 'dmidecode-no-smbios-dmi-data' ]];then
			system_line="${C2}No /sys/class/dmi, using dmidecode: no machine data available${CN}"
		fi
		mobo_line=''
		bios_line=''
		chassis_line=''
	fi
	system_line=$( create_print_line "Machine:" "$system_line" )
	print_screen_output "$system_line"
	if [[ -n $mobo_line ]];then
		mobo_line=$( create_print_line " " "$mobo_line" )
		print_screen_output "$mobo_line"
	fi
	if [[ -n $bios_line ]];then
		bios_line=$( create_print_line " " "$bios_line" )
		print_screen_output "$bios_line"
	fi
	if [[ -n $chassis_line ]];then
		chassis_line=$( create_print_line " " "$chassis_line" )
		print_screen_output "$chassis_line"
	fi
	
	eval $LOGFE
}

# args: $1 - module name (could be > 1, so loop it ); $2 - audio (optional)
print_module_version()
{
	eval $LOGFS
	local module_versions='' module='' version='' prefix='' modules=$1
	
	# note that sound driver data tends to have upper case, but modules are lower
	if [[ $2 == 'audio' ]];then
		if [[ -z $( grep -E '^snd' <<< $modules ) ]];then
			prefix='snd_' # sound modules start with snd_
		fi
		modules=$( tr '[A-Z]' '[a-z]' <<< $modules )
		modules=$( tr '-' '_' <<< $modules )
		# special intel processing, generally no version info though
		if [[ $modules == 'hda intel' ]];then
			modules='hda_intel'
		elif [[ $modules == 'intel ich' ]];then
			modules='intel8x0'
		fi
	fi

	for module in $modules
	do
		version=$( get_module_version_number "$prefix$module" )
		if [[ -n $version ]];then
			module_versions="$module_versions $version"
		fi
	done

	if [[ -n $module_versions ]];then
		echo " ${C1}ver$SEP3${C2}$module_versions"
	fi
	eval $LOGFE
}

print_networking_data()
{
	eval $LOGFS
	local i='' card_id='' network_data='' a_network_working='' port_data='' driver_data=''
	local card_string='' port_plural='' module_version='' pci_bus_id='' bus_usb_text=''
	local bus_usb_id='' line_starter='Network:' card_string='' card_data='' vendor_product=''
	# set A_NETWORK_DATA
	get_networking_data

	# will never be null because null is handled in get_network_data, but in case we change
	# that leaving this test in place.
	if [[ -n ${A_NETWORK_DATA[@]} ]];then
		for (( i=0; i < ${#A_NETWORK_DATA[@]}; i++ ))
		do
			IFS=","
			a_network_working=( ${A_NETWORK_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			bus_usb_id=''
			bus_usb_text=''
			card_data=''
			card_string=''
			driver_data=''
			module_version=''
			network_data=''
			pci_bus_id=''
			port_data=''
			port_plural=''
			vendor_product=''

			if [[ ${#A_NETWORK_DATA[@]} -gt 1 ]];then
				card_id="-$(( $i + 1 ))"
			fi
			if [[ -n ${a_network_working[1]} && $B_EXTRA_DATA == 'true' ]];then
				module_version=$( print_module_version "${a_network_working[1]}" )
			fi
			if [[ -n ${a_network_working[1]} ]];then
				driver_data="${C1}driver$SEP3${C2} ${a_network_working[1]}$module_version "
			fi
			if [[ -n ${a_network_working[2]} && $B_EXTRA_DATA == 'true' ]];then
				if [[ $( wc -w <<< ${a_network_working[2]} ) -gt 1 ]];then
					port_plural='s'
				fi
				port_data="${C1}port$port_plural$SEP3${C2} ${a_network_working[2]} "
			fi
			if [[ -n ${a_network_working[4]} && $B_EXTRA_DATA == 'true' ]];then
				if [[ -z $( grep '^usb-' <<< ${a_network_working[4]} ) ]];then
					bus_usb_text='bus-ID'
					bus_usb_id=${a_network_working[4]}
					if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
						vendor_product=$( get_lspci_vendor_product "${a_network_working[4]}" )
					fi
				else
					bus_usb_text='usb-ID'
					bus_usb_id=$( cut -d '-' -f '2-4' <<< ${a_network_working[4]} )
					if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
						vendor_product=${a_network_working[10]}
					fi
				fi
				pci_bus_id="${C1}$bus_usb_text$SEP3${C2} $bus_usb_id"
				if [[ -n $vendor_product ]];then
					vendor_product=" ${C1}chip-ID$SEP3${C2} $vendor_product"
				fi
			fi
			card_string="${C1}Card$card_id:${C2} ${a_network_working[0]} "
			card_data="$driver_data$port_data$pci_bus_id$vendor_product"
			if [[ $( calculate_line_length "$card_string$card_data" ) -gt $LINE_MAX ]];then
				network_data=$( create_print_line "$line_starter" "$card_string" )
				line_starter=' '
				card_string=''
				print_screen_output "$network_data"
			fi
			network_data=$( create_print_line "$line_starter" "$card_string$card_data" )
			line_starter=' '
			print_screen_output "$network_data"
			if [[ $B_SHOW_ADVANCED_NETWORK == 'true' ]];then
				print_network_advanced_data
			fi
		done
	fi
	if [[ $B_SHOW_IP == 'true' ]];then
		print_networking_ip_data
	fi
	eval $LOGFE
}

print_network_advanced_data()
{
	eval $LOGFS
	local network_data='' if_id='N/A' duplex='N/A' mac_id='N/A' speed='N/A' oper_state='N/A'
	local b_is_wifi='false' speed_string='' duplex_string=''
	
		# first check if it's a known wifi id'ed card, if so, no print of duplex/speed
	if [[ -n $( grep -Esi '(wireless|wifi|wi-fi|wlan|802\.11|centrino)' <<< ${a_network_working[0]} ) ]];then
		b_is_wifi='true'
	fi
	if [[ -n ${a_network_working[5]} ]];then
		if_id=${a_network_working[5]}
	fi
	if [[ -n ${a_network_working[6]} ]];then
		oper_state=${a_network_working[6]}
	fi
	# no print out for wifi since it doesn't have duplex/speed data availabe
	# note that some cards show 'unknown' for state, so only testing explicitly
	# for 'down' string in that to skip showing speed/duplex
	if [[ $b_is_wifi != 'true' && $oper_state != 'down' ]];then
		if [[ -n ${a_network_working[7]} ]];then
			# make sure the value is strictly numeric before appending Mbps
			if [[ -n $( grep -E '^[0-9\.,]+$' <<< "${a_network_working[7]}" ) ]];then
				speed="${a_network_working[7]} Mbps"
			else
				speed=${a_network_working[7]}
			fi
		fi
		speed_string="${C1}speed$SEP3${C2} $speed "
		if [[ -n ${a_network_working[8]} ]];then
			duplex=${a_network_working[8]}
		fi
		duplex_string="${C1}duplex$SEP3${C2} $duplex "
	fi
	if [[ -n ${a_network_working[9]} ]];then
		if [[ $B_OUTPUT_FILTER == 'true' ]];then
			mac_id=$FILTER_STRING
		else
			mac_id=${a_network_working[9]}
		fi
	fi
	network_data="${C1}IF:${C2} $if_id ${C1}state$SEP3${C2} $oper_state $speed_string$duplex_string${C1}mac$SEP3${C2} $mac_id"
	network_data=$( create_print_line " " "$network_data" )
	print_screen_output "$network_data"
	
	eval $LOGFE
}

print_networking_ip_data()
{
	eval $LOGFS
	local ip=$( get_networking_wan_ip_data )
	local wan_ip_data='' a_interfaces_working='' interfaces='' i=''
	local if_id='' if_ip='' if_ipv6='' if_ipv6_string='' full_string='' if_string=''
	local if_id_string='' if_ip_string=''
	local line_max=$(( $LINE_MAX - 50 ))

	# set A_INTERFACES_DATA
	get_networking_local_ip_data
	# first print output for wan ip line. Null is handled in the get function
	if [[ -z $ip ]];then
		ip='N/A'
	else
		if [[ $B_OUTPUT_FILTER == 'true' ]];then
			ip=$FILTER_STRING
		fi
	fi
	wan_ip_data="${C1}WAN IP:${C2} $ip "
	# then create the list of local interface/ip
	i=0 ## loop starts with 1 by auto-increment so it only shows cards > 1
	while [[ -n ${A_INTERFACES_DATA[i]} ]]
	do
		IFS=","
		a_interfaces_working=(${A_INTERFACES_DATA[i]})
		IFS="$ORIGINAL_IFS"
		if_id='N/A'
		if_ip='N/A'
		if_ipv6='N/A'
		if_ipv6_string=''
		if [[ -z $( grep '^Interface' <<< ${a_interfaces_working[0]} ) ]];then
			if [[ -n ${a_interfaces_working[1]} ]];then
				if [[ $B_OUTPUT_FILTER == 'true' ]];then
					if_ip=$FILTER_STRING
				else
					if_ip=${a_interfaces_working[1]}
				fi
			fi
			if_ip_string=" ${C1}ip$SEP3${C2} $if_ip"
			if [[ $B_EXTRA_DATA == 'true' ]];then
				if [[ -n ${a_interfaces_working[3]} ]];then
					if [[ $B_OUTPUT_FILTER == 'true' ]];then
						if_ipv6=$FILTER_STRING
					else
						if_ipv6=${a_interfaces_working[3]}
					fi
				fi
				if_ipv6_string=" ${C1}ip-v6$SEP3${C2} $if_ipv6"
			fi
		fi
		if [[ -n ${a_interfaces_working[0]} ]];then
			if_id=${a_interfaces_working[0]}
		fi
		if_string="$wan_ip_data$if_string${C1}IF:${C2} $if_id$if_ip_string$if_ipv6_string "
		wan_ip_data=''
		if [[ $( calculate_line_length "$if_string" ) -gt $line_max ]];then
			full_string=$( create_print_line " " "$if_string" )
			print_screen_output "$full_string"
			if_string=''
		fi
		((i++))
	done
	
	# then print out anything not printed already
	if [[ -n $if_string ]];then
		full_string=$( create_print_line " " "$if_string" )
		print_screen_output "$full_string"
	fi
	eval $LOGFE
}

print_optical_drive_data()
{
	eval $LOGFS
	local a_drives='' drive_data='' counter='' 
	local drive_id='' drive_links='' vendor='' speed='' multisession='' mcn='' audio=''
	local dvd='' state='' rw_support='' rev='' separator='' drive_string=''
	get_optical_drive_data
	# 0 - true dev path, ie, sr0, hdc
	# 1 - dev links to true path
	# 2 - device vendor - for hdx drives, vendor model are one string from proc
	# 3 - device model
	# 4 - device rev version
	if [[ ${#A_OPTICAL_DRIVE_DATA[@]} -gt 0 ]];then
		for (( i=0; i < ${#A_OPTICAL_DRIVE_DATA[@]}; i++ ))
		do
			IFS=","
			a_drives=(${A_OPTICAL_DRIVE_DATA[i]})
			IFS="$ORIGINAL_IFS"
			audio=''
			drive_data=''
			drive_id=''
			drive_links=''
			dvd='' 
			mcn='' 
			multisession='' 
			rev='' 
			rw_support='' 
			separator=''
			speed='' 
			state='' 
			vendor=''
			if [[ ${#A_OPTICAL_DRIVE_DATA[@]} -eq 1 && -z ${a_drives[0]} && -z ${a_drives[1]} ]];then
				drive_string="No optical drives detected."
				B_SHOW_FULL_OPTICAL='false'
			else
				if [[ ${#A_OPTICAL_DRIVE_DATA[@]} -gt 1 ]];then
					counter="-$(( i + 1 ))"
				fi
				if [[ -z ${a_drives[0]} ]];then
					drive_id='N/A'
				else
					drive_id="/dev/${a_drives[0]}"
				fi
				drive_links=$( sed 's/~/,/g' <<< ${a_drives[1]} )
				if [[ -z $drive_links ]];then
					drive_links='N/A'
				fi
				if [[ -n ${a_drives[2]} ]];then
					vendor=${a_drives[2]}
					if [[ -n ${a_drives[3]} ]];then
						vendor="$vendor ${a_drives[3]}"
					fi
				fi
				if [[ -z $vendor ]];then
					if [[ -n ${a_drives[3]} ]];then
						vendor=${a_drives[3]}
					else
						vendor='N/A'
					fi
				fi
				if [[ $B_EXTRA_DATA == 'true' ]];then
					if [[ -n ${a_drives[4]} ]];then
						rev=${a_drives[4]}
					else
						rev='N/A'
					fi
					rev=" ${C1}rev$SEP3${C2} $rev"
				fi
				drive_string="$drive_id ${C1}model$SEP3${C2} $vendor$rev ${C1}dev-links$SEP3${C2} $drive_links"
			fi
			drive_data="${C1}Optical${counter}:${C2} $drive_string"
			drive_data=$( create_print_line "$Line_Starter" "$drive_data" )
			print_screen_output "$drive_data"
			Line_Starter=' '
			# 5 - speed
			# 6 - multisession support
			# 7 - MCN support
			# 8 - audio read
			# 9 - cdr
			# 10 - cdrw
			# 11 - dvd read
			# 12 - dvdr
			# 13 - dvdram
			# 14 - state
			if [[ $B_SHOW_FULL_OPTICAL == 'true' ]];then
				if [[ -z ${a_drives[5]} ]];then
					speed='N/A'
				else
					speed="${a_drives[5]}x"
				fi
				if [[ -z ${a_drives[8]} ]];then
					audio='N/A'
				elif [[ ${a_drives[8]} == 1 ]];then
					audio='yes'
				else
					audio='no'
				fi
				audio=" ${C1}audio$SEP3${C2} $audio"
				if [[ -z ${a_drives[6]} ]];then
					multisession='N/A'
				elif [[ ${a_drives[6]} == 1 ]];then
					multisession='yes'
				else
					multisession='no'
				fi
				multisession=" ${C1}multisession$SEP3${C2} $multisession"
				if [[ -z ${a_drives[11]} ]];then
					dvd='N/A'
				elif [[ ${a_drives[11]} == 1 ]];then
					dvd='yes'
				else
					dvd='no'
				fi
				if [[ $B_EXTRA_DATA == 'true' ]];then
					if [[ -z ${a_drives[14]} ]];then
						state='N/A'
					else
						state="${a_drives[14]}"
					fi
					state=" ${C1}state$SEP3${C2} $state"
				fi
				if [[ -n ${a_drives[9]} && ${a_drives[9]} == 1 ]];then
					rw_support='cd-r'
					separator=','
				fi
				if [[ -n ${a_drives[10]} && ${a_drives[10]} == 1 ]];then
					rw_support="${rw_support}${separator}cd-rw"
					separator=','
				fi
				if [[ -n ${a_drives[12]} && ${a_drives[12]} == 1 ]];then
					rw_support="${rw_support}${separator}dvd-r"
					separator=','
				fi
				if [[ -n ${a_drives[13]} && ${a_drives[13]} == 1 ]];then
					rw_support="${rw_support}${separator}dvd-ram"
					separator=','
				fi
				if [[ -z $rw_support ]];then
					rw_support='none'
				fi
				
				drive_data="${C1}Features: speed$SEP3${C2} $speed$multisession$audio ${C1}dvd$SEP3${C2} $dvd ${C1}rw$SEP3${C2} $rw_support$state"
				drive_data=$( create_print_line "$Line_Starter" "$drive_data" )
				print_screen_output "$drive_data"
			fi
		done
	else
		:
	fi
	eval $LOGFE
}

print_partition_data()
{
	eval $LOGFS
	local a_partition_working='' partition_used='' partition_data=''
	local counter=0 i=0 a_partition_data='' line_starter='' line_max=$(( $LINE_MAX - 35 ))
	local partitionIdClean='' part_dev='' full_dev='' part_label='' full_label=''
	local part_uuid='' full_uuid='' dev_remote='' full_fs='' line_max_label_uuid=$(( $LINE_MAX - 10 ))

	# set A_PARTITION_DATA
	get_partition_data

	for (( i=0; i < ${#A_PARTITION_DATA[@]}; i++ ))
	do
		IFS=","
		a_partition_working=(${A_PARTITION_DATA[i]})
		IFS="$ORIGINAL_IFS"
		full_label=''
		full_uuid=''

		if [[ $B_SHOW_PARTITIONS_FULL == 'true' ]] || [[ ${a_partition_working[4]} == 'main' ]];then
			if [[ -n ${a_partition_working[2]} ]];then
				partition_used="${C1}used$SEP3${C2} ${a_partition_working[2]} (${a_partition_working[3]}) "
			else
				partition_used='' # reset partition used to null
			fi
			if [[ -n ${a_partition_working[5]} ]];then
				full_fs="${a_partition_working[5]}"
			else
				full_fs='N/A' # reset partition used to null
			fi
			full_fs="${C1}fs$SEP3${C2} $full_fs "

			if [[ $B_SHOW_LABELS == 'true' || $B_SHOW_UUIDS == 'true' ]];then
				if [[ -n ${a_partition_working[6]} ]];then
					if [[ -z $( grep -E '(^//|:/)' <<< ${a_partition_working[6]} ) ]];then
						part_dev="/dev/${a_partition_working[6]}"
						dev_remote='dev'
					else
						part_dev="${a_partition_working[6]}"
						dev_remote='remote'
					fi
				else
					dev_remote='dev'
					part_dev='N/A'
				fi
				full_dev="${C1}$dev_remote$SEP3${C2} $part_dev "
				if [[ $B_SHOW_LABELS == 'true' && $dev_remote != 'remote' ]];then
					if [[ -n ${a_partition_working[7]} ]];then
						part_label="${a_partition_working[7]}"
					else
						part_label='N/A'
					fi
					full_label="${C1}label$SEP3${C2} $part_label "
				fi
				if [[ $B_SHOW_UUIDS == 'true' && $dev_remote != 'remote' ]];then
					if [[ -n ${a_partition_working[8]} ]];then
						part_uuid="${a_partition_working[8]}"
					else
						part_uuid='N/A'
					fi
					full_uuid="${C1}uuid$SEP3${C2} $part_uuid"
				fi
			fi
			# don't show user names in output
			if [[ $B_OUTPUT_FILTER == 'true' ]];then
				partitionIdClean=$( sed -r "s|/home/([^/]+)/(.*)|/home/$FILTER_STRING/\2|" <<< ${a_partition_working[0]} )
			else
				partitionIdClean=${a_partition_working[0]}
			fi
			id_size_fs="${C1}ID:${C2} $partitionIdClean ${C1}size$SEP3${C2} ${a_partition_working[1]} $partition_used$full_fs$full_dev"
			label_uuid="$full_label$full_uuid"
			# label/uuid always print one per line, so only wrap if it's very long
			if [[ $B_SHOW_UUIDS == 'true' && $B_SHOW_LABELS == 'true' && $( calculate_line_length "$id_size_fs$label_uuid" ) -gt $line_max_label_uuid ]];then
				a_partition_data[$counter]="$id_size_fs"
				((counter++))
				a_partition_data[$counter]="$label_uuid"
			else
				a_partition_data[$counter]="${a_partition_data[$counter]}$id_size_fs$label_uuid"
			fi
			# because these lines can vary widely, using dynamic length handling here
			if [[ $B_SHOW_LABELS == 'true' || $B_SHOW_UUIDS == 'true' ]] || [[ $( calculate_line_length "${a_partition_data[$counter]}" ) -gt $line_max ]];then
				((counter++))
			fi
		fi
	done
	# print out all lines, line starter on first line
	for (( i=0; i < ${#a_partition_data[@]};i++ ))
	do
		if [[ $i -eq 0 ]];then
			line_starter='Partition:'
		else
			line_starter=' '
		fi
		partition_data=$( create_print_line "$line_starter" "${a_partition_data[$i]}" )
		print_screen_output "$partition_data"
	done
	
	eval $LOGFE
}

print_ps_data()
{
	eval $LOGFS
	
	local b_print_first='true' 

	if [[ $B_SHOW_PS_CPU_DATA == 'true' ]];then
		get_ps_data 'cpu'
		print_ps_item 'cpu' "$b_print_first"
		b_print_first='false' 
	fi
	if [[ $B_SHOW_PS_MEM_DATA == 'true' ]];then
		get_ps_data 'mem'
		print_ps_item 'mem' "$b_print_first"
	fi
	
	eval $LOGFE
}

# args: $1 - cpu/mem; $2 true/false
print_ps_item()
{
	eval $LOGFS
	local a_ps_data='' ps_data='' line_starter='' line_start_data='' full_line=''
	local app_name='' app_pid='' app_cpu='' app_mem='' throttled='' app_daemon=''
	local b_print_first=$2 line_counter=0 i=0 count_nu='' extra_data=''
	
	if [[ -n $PS_THROTTLED ]];then
		throttled=" ${C1} - throttled from${C2} $PS_THROTTLED"
	fi
	case $1 in
		cpu)
			line_start_data="${C1}CPU - % used - top ${C2} $PS_COUNT ${C1}active$throttled "
			;;
		mem)
			line_start_data="${C1}Memory - MB / % used - top ${C2} $PS_COUNT ${C1}active$throttled"
			;;
	esac
	
	if [[ $b_print_first == 'true' ]];then
		line_starter='Processes:'
	else
		line_starter=' '
	fi
	
	# appName, appPath, appStarterName, appStarterPath, cpu, mem, pid, vsz, user
	ps_data=$( create_print_line "$line_starter" "$line_start_data" )
	print_screen_output "$ps_data"

	for (( i=0; i < ${#A_PS_DATA[@]}; i++ ))
	do
		IFS=","
		a_ps_data=(${A_PS_DATA[i]})
		IFS="$ORIGINAL_IFS"
		
		# handle the converted app names, with ~..~ means it didn't have a path
		if [[ -n $( grep -E '^~.*~$' <<<  ${a_ps_data[0]} ) ]];then
			app_daemon='daemon'
		else
			app_daemon='command'
		fi

		app_name=" ${C1}$app_daemon$SEP3${C2} ${a_ps_data[0]}"
		if [[ ${a_ps_data[0]} != ${a_ps_data[2]} ]];then
			app_name="$app_name ${C1}(started by$SEP3${C2} ${a_ps_data[2]}${C1})${C2}"
		fi
		app_pid=" ${C1}pid$SEP3${C2} ${a_ps_data[6]}"
		#  ${C1}user:${C2} ${a_ps_data[8]}
		case $1 in
			cpu)
				app_cpu=" ${C1}cpu$SEP3${C2} ${a_ps_data[4]}%"
				if [[ $B_EXTRA_DATA == 'true' ]];then
					extra_data=" ${C1}mem$SEP3${C2} ${a_ps_data[7]}MB (${a_ps_data[5]}%)${C2}"
				fi
				;;
			mem)
				app_mem=" ${C1}mem$SEP3${C2} ${a_ps_data[7]}MB (${a_ps_data[5]}%)${C2}"
				if [[ $B_EXTRA_DATA == 'true' ]];then
					extra_data=" ${C1}cpu$SEP3${C2} ${a_ps_data[4]}%"
				fi
				;;
		esac
		(( line_counter++ ))
		count_nu="${C1}$line_counter:${C2}"
		full_line="$count_nu$app_cpu$app_mem$app_name$app_pid$extra_data"
		ps_data=$( create_print_line " " "$full_line" )
		print_screen_output "$ps_data"
	done
	
	eval $LOGFE
}

print_raid_data()
{
	eval $LOGFS
	local device='' device_string='' device_state='' raid_level='' device_components=''
	local device_report='' u_data='' blocks='' super_blocks='' algorithm='' chunk_size=''
	local bitmap_values='' recovery_progress_bar='' recovery_percent='' recovered_sectors=''
	local finish_time='' recovery_speed='' raid_counter=0 device_counter=1 basic_counter=1
	local a_partition_working='' raid_data='' kernel_support='' read_ahead='' unused_devices=''
	local basic_raid='' basic_raid_separator='' basic_raid_plural='' inactive=''
	local component_separator='' device_id='' print_string='' loop_limit=0 array_count_unused=''
	local array_count='' raid_event='' b_print_lines='true'

	get_raid_data

	for (( i=0; i < ${#A_RAID_DATA[@]}; i++ ))
	do
		IFS=","
		a_partition_working=(${A_RAID_DATA[i]})
		IFS="$ORIGINAL_IFS"
		
		# reset on each iteration
		algorithm=''
		bitmap_values=''
		blocks=''
		component_separator=''
		device=''
		device_components=''
		device_id=''
		device_report=''
		device_state=''
		failed=''
		finish_time=''
		inactive=''
		raid_event=''
		raid_level=''
		recovery_percent=''
		recovery_progress_bar=''
		recovered_sectors=''
		recovery_speed=''
		spare=''
		super_blocks=''
		u_data=''
		
		if [[ -n $( grep '^md' <<< ${a_partition_working[0]} ) ]];then
			if [[ $B_SHOW_BASIC_RAID == 'true' ]];then
				if [[ $basic_raid != '' ]];then
					basic_raid_plural='s'
				fi
				if [[ ${a_partition_working[1]} == 'inactive' ]];then
					inactive=" - ${a_partition_working[1]}"
				fi
				basic_raid="$basic_raid$basic_raid_separator${C1}$basic_counter${SEP3}${C2} /dev/${a_partition_working[0]}$inactive"
				basic_raid_separator=' '
				(( basic_counter++ ))
			else
				device_id="-$device_counter"
				device="/dev/${a_partition_working[0]}"
				
				(( device_counter++ ))
				if [[ ${a_partition_working[1]} != '' ]];then
					device_state=" - ${a_partition_working[1]}"
				fi
				
				if [[ ${a_partition_working[2]} == '' ]];then
					raid_level='N/A'
				else
					raid_level=${a_partition_working[2]}
				fi
				# there's one case: md0 : inactive  that has to be protected against
				if [[ ${a_partition_working[2]} == '' && ${a_partition_working[1]} == 'inactive' ]];then
					raid_level=''
				else
					raid_level=" ${C1}raid${SEP3}${C2} $raid_level"
				fi
				if [[ ${a_partition_working[4]} != '' ]];then
					device_report="${a_partition_working[4]}"
				else
					device_report="N/A"
				fi
				if [[ $B_EXTRA_DATA == 'true' ]];then
					if [[ ${a_partition_working[6]} != '' ]];then
						blocks=${a_partition_working[6]}
					else
						blocks='N/A'
					fi
					blocks=" ${C1}blocks${SEP3}${C2} $blocks"
					
					if [[ ${a_partition_working[9]} != '' ]];then
						chunk_size=${a_partition_working[9]}
					else
						chunk_size='N/A'
					fi
					chunk_size=" ${C1}chunk size${SEP3}${C2} $chunk_size"
					if [[ ${a_partition_working[10]} != '' ]];then
						bitmap_value='true'
						bitmap_value=" ${C1}bitmap${SEP3}${C2} $bitmap_value"
					fi
				fi
				if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
					if [[ ${a_partition_working[5]} != '' ]];then
						u_data=" ${a_partition_working[5]}"
					fi
					if [[ ${a_partition_working[7]} != '' ]];then
						super_blocks=" ${C1}super blocks${SEP3}${C2} ${a_partition_working[7]}"
					fi
					if [[ ${a_partition_working[8]} != '' ]];then
						algorithm=" ${C1}algorithm${SEP3}${C2} ${a_partition_working[8]}"
					fi
				fi
				if [[ ${a_partition_working[3]} == '' ]];then
					if [[ ${a_partition_working[1]} != 'inactive' ]];then
						device_components='N/A'
					fi
				else
					for component in ${a_partition_working[3]}
					do
						if [[ $B_EXTRA_DATA != 'true' ]];then
							component=$( sed 's/\[[0-9]\+\]//' <<< $component )
						fi
						if [[ -n $( grep 'F' <<< $component ) ]];then
							component=$( sed -e 's/(F)//' -e 's/F//' <<<  $component )
							failed="$failed $component"
							component=''
						elif [[ -n $( grep 'S' <<< $component ) ]];then
							component=$( sed -e 's/(S)//' -e 's/S//' <<<  $component )
							spare="$spare $component"
							component=''
						else
							device_components=$device_components$component_separator$component
							component_separator=' '
						fi
					done

					if [[ $failed != '' ]];then
						failed=" ${C1}FAILED${SEP3}${C2}$failed${C2}"
					fi
					if [[ $spare != '' ]];then
						spare=" ${C1}spare${SEP3}${C2}$spare${C2}"
					fi
					if [[ $device_components != '' ]];then
						if [[ $B_EXTRA_DATA != 'true' ]];then
							if [[ $device_report != 'N/A' ]];then
								device_components="$device_report - $device_components"
							fi
						fi
						device_components=" ${C1}components${SEP3}${C2} $device_components$failed$spare"
					fi
				fi
				a_raid_data[$raid_counter]="${C1}Device$device_id${SEP3}${C2} $device$device_state$raid_level$device_components"
				
				if [[ $B_EXTRA_DATA == 'true' && ${a_partition_working[1]} != 'inactive' ]];then
					a_raid_data[$raid_counter]="${C1}Device$device_id${SEP3}${C2} $device$device_state$device_components"
					(( raid_counter++ ))
					print_string="${C1}Info${SEP3}${C2}$raid_level ${C1}report${SEP3}${C2} $device_report$u_data"
					print_string="$print_string$blocks$chunk_size$bitmap_value$super_blocks$algorithm"
					a_raid_data[$raid_counter]="$print_string"
				else
					a_raid_data[$raid_counter]="${C1}Device$device_id${SEP3}${C2} $device$device_state$raid_level$device_components"
				fi
				(( raid_counter++ ))
				
				# now let's do the recover line if required
				if [[ ${a_partition_working[12]} != '' ]];then
					recovery_percent=$( cut -d '~' -f 2 <<< ${a_partition_working[12]} )
					if [[ ${a_partition_working[14]} != '' ]];then
						finish_time=${a_partition_working[14]}
					else
						finish_time='N/A'
					fi
					finish_time=" ${C1}time remaining${SEP3}${C2} $finish_time"
					if [[ $B_EXTRA_DATA == 'true' ]];then
						if [[ ${a_partition_working[13]} != '' ]];then
							recovered_sectors=" ${C1}sectors${SEP3}${C2} ${a_partition_working[13]}"
						fi
					fi
					if [[ $B_EXTRA_EXTRA_DATA == 'true' ]];then
						if [[ ${a_partition_working[11]} != '' ]];then
							recovery_progress_bar=" ${a_partition_working[11]}"
						fi
						if [[ ${a_partition_working[15]} != '' ]];then
							recovery_speed=" ${C1}speed${SEP3}${C2} ${a_partition_working[15]}"
						fi
					fi
					
					a_raid_data[$raid_counter]="${C1}Recovering${SEP3}${C2} $recovery_percent$recovery_progress_bar$recovered_sectors$finish_time$recovery_speed"
					(( raid_counter++ ))
				fi
			fi
		elif [[ ${a_partition_working[0]} == 'KernelRaidSupport' ]];then
			if [[ ${a_partition_working[1]} == '' ]];then
				kernel_support='N/A'
			else
				kernel_support=${a_partition_working[1]}
			fi
			kernel_support=" ${C1}supported${SEP3}${C2} $kernel_support"
		elif [[ ${a_partition_working[0]} == 'ReadAhead' ]];then
			if [[ ${a_partition_working[1]} != '' ]];then
				read_ahead=${a_partition_working[1]}
				read_ahead=" ${C1}read ahead${SEP3}${C2} $read_ahead"
			fi
		elif [[ ${a_partition_working[0]} == 'UnusedDevices' ]];then
			if [[ ${a_partition_working[1]} == '' ]];then
				unused_devices='N/A'
			else
				unused_devices=${a_partition_working[1]}
			fi
			unused_devices="${C1}Unused Devices${SEP3}${C2} $unused_devices"
		elif [[ ${a_partition_working[0]} == 'raidEvent' ]];then
			if [[ ${a_partition_working[1]} != '' ]];then
				raid_event=${a_partition_working[1]}
				raid_event=" ${C1}Raid Event${SEP3}${C2} ${a_partition_working[1]}"
			fi
		fi
	done
	
	if [[ $B_SHOW_BASIC_RAID == 'true' && $basic_raid != '' ]];then
		a_raid_data[0]="${C1}Device$basic_raid_plural${SEP3}${C2} $basic_raid"
	fi

	if [[ $B_MDSTAT_FILE != 'true' ]];then
		if [[ $B_SHOW_RAID_R == 'true' ]];then
			a_raid_data[0]="No RAID data available - $FILE_MDSTAT is missing - is md_mod kernel module loaded?"
		else
			b_print_lines='false'
		fi
	else
		if [[ ${a_raid_data[0]} == '' ]];then
			if [[ $B_SHOW_BASIC_RAID != 'true' ]];then
				a_raid_data[0]="No RAID devices detected - /proc/mdstat and md_mod kernel raid module present"
			else
				b_print_lines='false'
			fi
		fi
		# now let's add on the system line and the unused device line. Only print on -xx
		if [[ $kernel_support$read_ahead$raid_event != '' ]];then
			array_count=${#a_raid_data[@]}
			a_raid_data[array_count]="${C1}System${SEP3}${C2}$kernel_support$read_ahead$raid_event"
			loop_limit=1
		fi
		if [[ $unused_devices != '' ]];then
			array_count_unused=${#a_raid_data[@]}
			a_raid_data[array_count_unused]="$unused_devices"
			loop_limit=2
		fi
	fi
	# we don't want to print anything if it's -b and no data is present, just a waste of a line
	if [[ $b_print_lines == 'true' ]];then
		# print out all lines, line starter on first line
		for (( i=0; i < ${#a_raid_data[@]} - $loop_limit;i++ ))
		do
			if [[ $i -eq 0 ]];then
				line_starter='RAID:'
			else
				line_starter=' '
			fi
			if [[ $B_EXTRA_EXTRA_DATA == 'true' && $array_count != '' ]];then
				if [[ $i == 0 ]];then
					raid_data=$( create_print_line "$line_starter" "${a_raid_data[array_count]}" )
					print_screen_output "$raid_data"
					line_starter=' '
				fi
			fi
			raid_data=$( create_print_line "$line_starter" "${a_raid_data[i]}" )
			print_screen_output "$raid_data"
			if [[ $B_EXTRA_EXTRA_DATA == 'true' && $array_count_unused != '' ]];then
				if [[ $i == $(( array_count_unused - 2 )) ]];then
					raid_data=$( create_print_line "$line_starter" "${a_raid_data[array_count_unused]}" )
					print_screen_output "$raid_data"
				fi
			fi
		done
	fi
	
	eval $LOGFE
}

# currently only apt using distros support this feature, but over time we can add others
print_repo_data()
{
	eval $LOGFS
	local repo_count=0 repo_line='' file_name='' file_content='' file_name_holder=''
	local repo_full='' b_print_next_line='false' repo_type=''
	
	get_repo_data
	
	if [[ -n $REPO_DATA ]];then
		# loop through the variable's lines one by one, update counter each iteration
		while read repo_line
		do
			(( repo_count++ ))
			repo_type=$( cut -d ':' -f 1 <<< $repo_line )
			file_name=$( cut -d ':' -f 2 <<< $repo_line )
			file_content=$( cut -d ':' -f 3-7 <<< $repo_line )
			# this will dump unwanted white space line starters. Some irc channels
			# use bots that show page title for urls, so need to break the url by adding 
			# a white space.
			if [[ $B_RUNNING_IN_SHELL != 'true' ]];then
				file_content=$( echo $file_content | sed 's|://|: //|' )
			else
				file_content=$( echo $file_content )
			fi
			# check file name, if different, update the holder for print out
			if [[ $file_name != $file_name_holder ]];then
				if [[ $repo_type != 'pisi repo' ]];then
					repo_full="${C1}Active $repo_type in file:${C2} $file_name"
				else
					repo_full="${C1}$repo_type:${C2} $file_name"
				fi
				file_name_holder=$file_name
				b_print_next_line='true'
			else
				repo_full=$file_content
			fi
			# first line print Repos: 
			if [[ $repo_count -eq 1 ]];then
				repo_full=$( create_print_line "Repos:" "$repo_full" )
			else
				repo_full=$( create_print_line " " "$repo_full" )
			fi
			print_screen_output "$repo_full"
			# this prints the content of the file as well as the file name
			if [[ $b_print_next_line == 'true' ]];then
				repo_full=$( create_print_line " " "$file_content" )
				print_screen_output "$repo_full"
				b_print_next_line='false'
			fi
		done <<< "$REPO_DATA"
	else
		repo_full=$( create_print_line "Repos:" "${C1}Error:${C2} $SCRIPT_NAME does not support this feature for your distro yet." )
		print_screen_output "$repo_full"
	fi
	eval $LOGFE
}

print_script_version()
{
	local script_patch_number=$( get_patch_version_string )
	local script_version="${C1}$SCRIPT_NAME$SEP3${C2} $SCRIPT_VERSION_NUMBER$script_patch_number${CN}"
	# great trick from: http://ideatrash.net/2011/01/bash-string-padding-with-sed.html
	# left pad: sed -e :a -e 's/^.\{1,80\}$/& /;ta'
	# right pad: sed -e :a -e 's/^.\{1,80\}$/ &/;ta'
	# center pad: sed -e :a -e 's/^.\{1,80\}$/ & /;ta'
	#local line_max=$(( $LINE_MAX - 10 ))
	#script_version="$( sed -e :a -e "s/^.\{1,$line_max\}$/ &/;ta" <<< $script_version )" # use to create padding if needed
	# script_version=$( create_print_line "Version:" "$script_version" )
	print_screen_output "$script_version"
}

print_sensors_data()
{
	eval $LOGFS
	local mobo_temp='' cpu_temp='' psu_temp='' cpu_fan='' mobo_fan='' ps_fan='' sys_fans='' sys_fans2='' 
	local temp_data='' fan_data='' fan_data2='' b_is_error='false' fan_count=0 gpu_temp=''
	local a_sensors_working=''
	local Sensors_Data="$( get_sensors_output )"
	get_sensors_data
	
	IFS=","
	a_sensors_working=( ${A_SENSORS_DATA[0]} )
	IFS="$ORIGINAL_IFS"
	# initial error cases, for missing app or unconfigured sensors. Note that array 0
	# always has at least 3 items, cpu/mobo/psu temp in it. If the count is 0, then
	# no sensors are installed/configured
	if [[ ${#a_sensors_working[@]} -eq 0 ]];then
		cpu_temp="None detected - is lm-sensors installed and configured?"
		b_is_error='true'
	else
		for (( i=0; i < ${#A_SENSORS_DATA[@]}; i++ ))
		do
			IFS=","
			a_sensors_working=( ${A_SENSORS_DATA[i]} )
			IFS="$ORIGINAL_IFS"
			case $i in
				# first the temp data
				0)
					if [[ -n ${a_sensors_working[0]} ]];then
						cpu_temp=${a_sensors_working[0]}
					else
						cpu_temp='N/A'
					fi
					cpu_temp="${C1}System Temperatures: cpu$SEP3${C2} $cpu_temp "

					if [[ -n ${a_sensors_working[1]} ]];then
						mobo_temp=${a_sensors_working[1]}
					else
						mobo_temp='N/A'
					fi
					mobo_temp="${C1}mobo$SEP3${C2} $mobo_temp "

					if [[ -n ${a_sensors_working[2]} ]];then
						psu_temp="${C1}psu$SEP3${C2} ${a_sensors_working[2]} "
					fi
					gpu_temp=$( get_gpu_temp_data )
					# dump the unneeded screen data for single gpu systems 
					if [[ $( wc -w <<< $gpu_temp ) -eq 1 && $B_EXTRA_DATA != 'true' ]];then
						gpu_temp=$( cut -d ':' -f 2 <<< $gpu_temp )
					fi
					if [[ -n $gpu_temp ]];then
						gpu_temp="${C1}gpu$SEP3${C2} ${gpu_temp} "
					fi
					;;
				# then the fan data from main fan array
				1)
					for (( j=0; j < ${#a_sensors_working[@]}; j++ ))
					do
						case $j in
							0)
								# we need to make sure it's either cpu fan OR cpu fan and sys fan 1
								if [[ -n ${a_sensors_working[0]} ]];then
									cpu_fan="${a_sensors_working[0]}"
								elif [[ -z ${a_sensors_working[0]} && -n ${a_sensors_working[1]} ]];then
									cpu_fan="${a_sensors_working[1]}"
								else
									cpu_fan='N/A'
								fi
								cpu_fan="${C1}Fan Speeds (in rpm): cpu$SEP3${C2} $cpu_fan "
								(( fan_count++ ))
								;;
							1)
								if [[ -n ${a_sensors_working[1]} ]];then
									mobo_fan="${C1}mobo$SEP3${C2} ${a_sensors_working[1]} "
									(( fan_count++ ))
								fi
								;;
							2)
								if [[ -n ${a_sensors_working[2]} ]];then
									ps_fan="${C1}psu$SEP3${C2} ${a_sensors_working[2]} "
									(( fan_count++ ))
								fi
								;;
							[3-9]|[1-9][0-9])
								if [[ -n ${a_sensors_working[$j]} ]];then
									fan_number=$(( $j - 2 )) # sys fans start on array key 5
									# wrap after fan 6 total
									if [[ $fan_count -lt 7 ]];then
										sys_fans="$sys_fans${C1}sys-$fan_number$SEP3${C2} ${a_sensors_working[$j]} "
									else
										sys_fans2="$sys_fans2${C1}sys-$fan_number$SEP3${C2} ${a_sensors_working[$j]} "
									fi
									(( fan_count++ ))
								fi
								;;
						esac
					done
					;;
				2)
					for (( j=0; j < ${#a_sensors_working[@]}; j++ ))
					do
						case $j in
							[0-9]|[1-9][0-9])
								if [[ -n ${a_sensors_working[$j]} ]];then
									fan_number=$(( $j + 1 )) # sys fans start on array key 5
									# wrap after fan 6 total
									if [[ $fan_count -lt 7 ]];then
										sys_fans="$sys_fans${C1}fan-$fan_number$SEP3${C2} ${a_sensors_working[$j]} "
									else
										sys_fans2="$sys_fans2${C1}fan-$fan_number$SEP3${C2} ${a_sensors_working[$j]} "
									fi
									(( fan_count++ ))
								fi
								;;
						esac
					done
					;;
			esac
		done
	fi
	# turning off all output for case where no sensors detected or no sensors output 
	# unless -s used explicitly. So for -F type output won't show unless valid or -! 1 used
	if [[ $b_is_error != 'true' || $B_SHOW_SENSORS == 'true' || $B_TESTING_1 == 'true' ]];then
		temp_data="$cpu_temp$mobo_temp$psu_temp$gpu_temp"
		temp_data=$( create_print_line "Sensors:" "$temp_data" )
		print_screen_output "$temp_data"
		# don't print second or subsequent lines if error data
		fan_data="$cpu_fan$mobo_fan$ps_fan$sys_fans"
		if [[ $b_is_error != 'true' && -n $fan_data ]];then
			fan_data=$( create_print_line " " "$fan_data" )
			print_screen_output "$fan_data"
			# and then second wrapped fan line if needed
			if [[ -n $sys_fans2 ]];then
				fan_data2=$( create_print_line " " "$sys_fans2" )
				print_screen_output "$fan_data2"
			fi
		fi
	fi
	eval $LOGFE
}

print_system_data()
{
	eval $LOGFS
	local system_data='' bits='' desktop_environment='' dm_data='' de_extra_data=''
	local host_kernel_string='' de_distro_string='' host_string='' desktop_type='Desktop'
	local host_name=$HOSTNAME
	local current_kernel=$( uname -rm ) # | gawk '{print $1,$3,$(NF-1)}' )
	local distro="$( get_distro_data )"
	local tty_session=''
	
	# I think these will work, maybe, if logged in as root and in X
	if [[ $B_RUNNING_IN_X == 'true' ]];then
		desktop_environment=$( get_desktop_environment )
		if [[ -z $desktop_environment ]];then
			desktop_environment='N/A'
		fi
		
		if [[  $B_EXTRA_EXTRA_EXTRA_DATA == 'true' ]];then
			de_extra_data=$( get_desktop_extra_data )
			if [[ -n $de_extra_data ]];then
				de_extra_data=" ${C1}info$SEP3${C2} $de_extra_data"
			fi
		fi
	else
		tty_session=$( get_tty_number )
		if [[ -z $tty_session && $B_CONSOLE_IRC == 'true' ]];then
			tty_session=$( get_tty_console_irc )
		fi
		if [[ -n $tty_session ]];then
			tty_session=" $tty_session"
		fi
		desktop_environment="tty$tty_session"
		desktop_type='Console'
	fi
	# having dm type can be useful if you are accessing remote system
	# or are out of X and don't remember which dm is running the system
	if [[  $B_EXTRA_EXTRA_DATA == 'true' ]];then
		dm_data=$( get_display_manager )
		# here we only want the dm info to show N/A if in X
		if [[ -z $dm_data && $B_RUNNING_IN_X == 'true' ]];then
			dm_data='N/A'
		fi
		# only print out of X if dm_data has info, then it's actually useful, but
		# for headless servers, no need to print dm stuff.
		if [[ -n $dm_data ]];then
			dm_data=" ${C1}dm$SEP3${C2} $dm_data"
		fi
	fi
	
	de_distro_string="${C1}$desktop_type$SEP3${C2} $desktop_environment$de_extra_data$dm_data ${C1}Distro$SEP3${C2} $distro"
	if [[ $B_EXTRA_DATA == 'true' ]];then
		gcc_string=$( get_gcc_kernel_version )
		if [[ -n $gcc_string ]];then
			gcc_string=", ${C1}gcc$SEP3${C2} $gcc_string"
		fi
	fi
	# check for 64 bit first
	if [[ -n $( uname -m | grep -o 'x86_64' ) ]];then
		bits="64"
	else
		bits="32"
	fi
	bits=" (${bits} bit${gcc_string})"
	if [[ $B_SHOW_HOST == 'true' ]];then
		if [[ -z $HOSTNAME ]];then
			if [[ -n $( type p hostname ) ]];then
				host_name=$( hostname )
			fi
			if [[ -z $host_name ]];then
				host_name='N/A'
			fi
		fi
		host_string="${C1}Host$SEP3${C2} $host_name "
		system_data=$( create_print_line "System:" "$host_string$host_name ${C1}Kernel$SEP3${C2}" )
	fi
	host_kernel_string="$host_string${C1}Kernel$SEP3${C2} $current_kernel$bits "
	if [[ $( calculate_line_length "$host_kernel_string$de_distro_string" ) -lt $LINE_MAX ]];then
		system_data="$host_kernel_string$de_distro_string"
		system_data=$( create_print_line "System:" "$system_data" )
	else
		system_data=$( create_print_line "System:" "$host_kernel_string" )
		print_screen_output "$system_data"
		system_data=$( create_print_line " " "$de_distro_string" )
	fi
	print_screen_output "$system_data"
	eval $LOGFE
}

print_unmounted_partition_data()
{
	eval $LOGFS
	local a_unmounted_data='' line_starter='' unmounted_data='' full_fs=''
	local full_dev='' full_size='' full_label='' full_uuid='' full_string=''
	
	if [[ -z ${A_PARTITION_DATA} ]];then
		get_partition_data
	fi
	get_unmounted_partition_data
	
	if [[ ${#A_UNMOUNTED_PARTITION_DATA[@]} -ge 1 ]];then
		for (( i=0; i < ${#A_UNMOUNTED_PARTITION_DATA[@]}; i++ ))
		do
			IFS=","
			a_unmounted_data=(${A_UNMOUNTED_PARTITION_DATA[i]})
			IFS="$ORIGINAL_IFS"
			if [[ -z ${a_unmounted_data[0]} ]];then
				full_dev='N/A'
			else
				full_dev="/dev/${a_unmounted_data[0]}"
			fi
			full_dev="${C1}ID:${C2} $full_dev"
			if [[ -z ${a_unmounted_data[1]} ]];then
				full_size='N/A'
			else
				full_size=${a_unmounted_data[1]}
			fi
			full_size="${C1}size$SEP3${C2} $full_size"
			if [[ -z ${a_unmounted_data[2]} ]];then
				full_label='N/A'
			else
				full_label=${a_unmounted_data[2]}
			fi
			full_label="${C1}label$SEP3${C2} $full_label"
			if [[ -z ${a_unmounted_data[3]} ]];then
				full_uuid='N/A'
			else
				full_uuid=${a_unmounted_data[3]}
			fi
			full_uuid="${C1}uuid$SEP3${C2} $full_uuid"
			if [[ -z ${a_unmounted_data[4]} ]];then
				full_fs=''
			else
				full_fs="${C1}fs$SEP3${C2} ${a_unmounted_data[4]}"
			fi
			full_string="$full_dev $full_size $full_label $full_uuid $full_fs"
			if [[ $i -eq 0 ]];then
				line_starter='Unmounted:'
			else
				line_starter=' '
			fi
			unmounted_data=$( create_print_line "$line_starter" "$full_string" )
			print_screen_output "$unmounted_data"
		done
	else
		unmounted_data=$( create_print_line "Unmounted:" "No unmounted partitions detected" )
		print_screen_output "$unmounted_data"
	fi
	
	eval $LOGFE
}
main $@
###**EOF**###
