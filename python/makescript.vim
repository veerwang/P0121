"""""""""""""""""""""""""""""""""""""""""""""""""""""
"        Vim Script Create for Test!                 
"        		Author: Kevin                 
"        		V 1.00                        
"""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has("python")
	echo "Error:Required vim compiled with Python"
	finish
endif


let s:ProjectName="/home/kevin/armworkcopy/Ruby/"

function! Global_Fun_CopyScripts()
python << EOF
import os
import logging
logging.info("Start Copying!")
os.system("cp ./makescript.vim /home/kevin/.vim/plugin/")
logging.info("End Copying!")
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
	content = f.read()
	f.close()

	content = content[:0] + "hello the world\n" + content[0:] 

	f = open(vim.eval("s:ProjectFileName"),'w')
	f.write(content)
	f.close()
EOF
endfunction


function! Global_Fun_AddTitle()

let s:filename = expand('%:p')

python << EOF
import os
import vim
import sys

f = open(vim.eval("s:filename"),'r')
content = f.read()
f.close()

content = content[:0] + '"""""""""""""""""""""""""""""""""""""""""""""""""""""\n' + content[0:] 
content = content[:0] + '"        		 V1.00                        \n' + content[0:] 
content = content[:0] + '"        		Author: Kevin                 \n' + content[0:] 
content = content[:0] + '"        Vim Script Create for Test!                 \n' + content[0:] 
content = content[:0] + '"""""""""""""""""""""""""""""""""""""""""""""""""""""\n' + content[0:] 

f = open(vim.eval("s:filename"),'w')
f.write(content)
f.close()
EOF
execute ":e!"
endfunction

function! Global_Fun_MakeTar()
let s:olddir  = getcwd() 
let s:tardir  = "/home/kevin/armworkcopy/"
let s:tarfile = "Ruby"
let s:desfile = s:tarfile . ".tar.bz2"

python << EOF
import tarfile 
import vim
import os

os.chdir(vim.eval("s:tardir"))

IsExists = os.path.exists(vim.eval("s:tarfile"))
if not IsExists:
	print "error: destination directory not found"
else:
	tar = tarfile.open(vim.eval("s:desfile"),'w|bz2')
	tar.add(vim.eval("s:tarfile"));
	tar.close()
	os.chdir(vim.eval("s:olddir"))
EOF
endfunction

function! Global_Fun_Test()
python << EOF
import vim
import os
import time

#print time.strftime('%H:%M:%S',time.localtime(time.time()))

start = time.time()
print time.strftime('%H:%M:%S',time.localtime(start))

time.sleep(5)

end   = time.time()
print time.strftime('%H:%M:%S',time.localtime(end))

EOF
endfunction

map test :call Global_Fun_Test()<CR>
map tar :call Global_Fun_MakeTar()<CR>
map tt :call Global_Fun_AddTitle()<CR>
map mv :call Global_Fun_CopyScripts()<CR>
map gh :call Global_Fun_Change2WorkDir()<CR>
map <F2> :call Global_Fun_MakeProject()<CR>
map <F3> :call Global_Fun_MakeCleanProject()<CR>
