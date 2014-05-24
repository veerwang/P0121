"""""""""""""""""""""""""""""""""""""""""""""""""""""
"        Vim Script Create for Test!                 
"        the functions sets used for making vim tool
"        more comfortable
"        		Author: Kevin                 
"        		V 1.00                        
j""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:kevin_script_lib_loaded_flag')
    runtime! plugin/kevin-script-lib.vim
endif

if !has("python")
	echo "Error:Required vim compiled with Python"
	finish
endif


function! Global_Fun_CopyScripts()
python << EOF
import os
import logging
logging.info("Start Copying!")
os.system("cp ./makescript.vim /home/kevin/.vim/plugin/")
os.system("cp ./kevin-script-lib.vim /home/kevin/.vim/plugin/")
logging.info("End Copying!")
EOF
endfunction

function! Global_Fun_Change2WorkDir(projectpath)
python << EOF
import os
import vim
os.chdir(vim.eval("a:projectpath"))
EOF
execute ":edit" . " README" 
endfunction


function! Global_Fun_TMP(makecmd)


endfunction


function! Global_Fun_MakeCMD(makecmd)

"	new
"	call append('','hello this study')
"	call append('$','')
"	call append('$','hello')

let s:tmpfile = ".fuckfile"
let s:cmd     = a:makecmd. " 2>" .s:tmpfile." 1>/dev/null"

let old_efm   = &efm
set efm=%f:%\\s%#%l:%m

python << EOF
import os
os.system(vim.eval("s:cmd"))
EOF

if exists(":cgetfile")
    execute "silent! cgetfile " . s:tmpfile
else
    execute "silent! cfile " . s:tmpfile
endif

if exists('s:tmpfile')
        call delete(s:tmpfile)
endif

botright copen

let &efm = old_efm

endfunction



let s:ProjectName="/home/kevin/armworkcopy/Ruby/"
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

os.system("ls -al")

EOF
execute ":e!"
endfunction

function! Global_Fun_MakeTar()

call Library_Function_MakeTar()

endfunction

function! Global_Fun_Test()

40vsplit README

python << EOF
import vim
import os
import time

#print time.strftime('%H:%M:%S',time.localtime(time.time()))

start = time.time()
print time.strftime('%H:%M:%S',time.localtime(start))

time.sleep(1)

end   = time.time()
print time.strftime('%H:%M:%S',time.localtime(end))

EOF
endfunction

function! Global_Fun_Network(interface,status)
python << EOF
import os
import vim
print __name__
if vim.eval("a:interface")  == "arm":
	if vim.eval("a:status")  == "up":
		os.system("sudo ifup /etc/sysconfig/network-scripts/ifcfg-ARM_调试网络")
	elif vim.eval("a:status")  == "down":
		os.system("sudo ifdown /etc/sysconfig/network-scripts/ifcfg-ARM_调试网络")
elif vim.eval("a:interface")  == "normal":
	if vim.eval("a:status")  == "up":
		os.system("sudo ifup /etc/sysconfig/network-scripts/ifcfg-eth0")
	elif vim.eval("a:status")  == "down":
		os.system("sudo ifdown /etc/sysconfig/network-scripts/ifcfg-eth0")
EOF
endfunction

function! Global_Fun_Resize()
40vsplit
endfunction

function! Make_Normal_Function()
	call conque_term#get_instance(0).writeln('clear')
	call conque_term#get_instance(0).writeln('./scripts/makestatic.sh')
endfunction

function! Make_Clean_Function()
	call conque_term#get_instance(0).writeln('clear')
	call conque_term#get_instance(0).writeln('./scripts/makeclean.sh')
endfunction

nmap <leader>mk :call Make_Normal_Function()<CR>
nmap <leader>mc :call Make_Clean_Function()<CR>

map rsw :call Global_Fun_Resize()<CR>
map and :call Global_Fun_Network("arm","down")<CR>
map anu :call Global_Fun_Network("arm","up")<CR>
map nnd :call Global_Fun_Network("normal","down")<CR>
map nnu :call Global_Fun_Network("normal","up")<CR>

map test :call Global_Fun_Test()<CR>
map tar :call Global_Fun_MakeTar()<CR>

map tt :call Global_Fun_AddTitle()<CR>
map mv :call Global_Fun_CopyScripts()<CR>
map mpr :call Global_Fun_Change2WorkDir("/home/kevin/armworkcopy/Ruby")<CR>
map mps :call Global_Fun_Change2WorkDir("/home/kevin/armworkcopy/git_Smart/Smart/")<CR>
map mpp :call Global_Fun_Change2WorkDir("/home/kevin/work_old/P0121/vimscript-python/")<CR>
map mpk :call Global_Fun_Change2WorkDir("/home/kevin/Eddysun_ARM/newkernel/gitlinux/")<CR>

map <silent>mk1 :call Global_Fun_MakeCMD("./scripts/makestatic.sh")<CR>
map <silent>mk2 :call Global_Fun_MakeCMD("./scripts/makeclean.sh")<CR>

map <silent>mk3 :call Global_Fun_TMP("./scripts/makeclean.sh")<CR>
