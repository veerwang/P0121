"
" The script used to make my program
"
"			V1.00
"
"
"

if !has("python")
	echo "Error:Required vim compiled with Python"
	finish
endif

function! Global_Fun_Change2WorkDir()
python << EOF
import os
os.chdir("/home/kevin/armworkcopy/Ruby/")
EOF
execute ":edit" . " README" 
endfunction
