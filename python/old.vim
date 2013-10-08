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

function! DoMyJob()
python << EOF
import vim
for i in range(1,5):
	print i
vim.current.buffer.append(10*'*')
EOF
endfunction
