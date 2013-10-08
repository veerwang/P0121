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


let s:ProjectName="/home/kevin/armworkcopy/Ruby/"

function! Global_Fun_CopyScripts()
python << EOF
import os
os.system("cp ./makescript.vim /home/kevin/.vim/plugin/")
EOF
endfunction

function! Global_Fun_Change2WorkDir()
python << EOF
import os
import vim
os.chdir(vim.eval("s:ProjectName"))
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

function! Global_Fun_CreateProjectFile()
let s:ProjectFileName=s:ProjectName . "Ruby.prj"
python << EOF
import os
import vim
IsExists = os.path.exists(vim.eval("s:ProjectFileName"))

if not IsExists:
	f = open(vim.eval("s:ProjectFileName"),'w')
	f.write('MAKECMD=./makestatic.sh\n')
	f.write('MAKECLEANCMD=./makeclean.sh\n')
	f.close()
else:
	f = open(vim.eval("s:ProjectFileName"),'r')
	print f.readline()
	print f.readline()
	f.close()
EOF
endfunction

map test :call Global_Fun_CreateProjectFile()<CR>
map mv :call Global_Fun_CopyScripts()<CR>
map gh :call Global_Fun_Change2WorkDir()<CR>
map <F2> :call Global_Fun_MakeProject()<CR>
map <F3> :call Global_Fun_MakeCleanProject()<CR>
