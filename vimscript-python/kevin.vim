"
" It is my first vim script
"
"			V1.00
"
"
if !has("python")
	echo "Error:Required vim compiled with Python"
	finish
endif


function! Hello()
	echo "hello the world"
endfunction

let g:i = 5
while i > 0
	echo i
	let i = i - 1
	call Hello()
endwhile

for g:j in range(4)
	if g:j == 2
		echo "Bad"
	elseif g:j == 3
		echo "good"
	else
		echo j
	endif
endfor

echo hostname() 

function! DoMyJob()
python << EOF
import vim
for i in range(1,5):
	print i
vim.current.buffer.append(10*'*')
EOF
endfunction

call DoMyJob()
