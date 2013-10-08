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

function! Global_Fun_MakeProject()
python << EOF
import os
os.system("./makestatic.sh")
EOF
endfunction

function! Global_Fun_MakeCleanProject()
python << EOF
import os
os.system("./makeclean.sh")
EOF
endfunction



map gh :call Global_Fun_Change2WorkDir()<CR>
map <F2> :call Global_Fun_MakeProject()<CR>
map <F3> :call Global_Fun_MakeCleanProject()<CR>
