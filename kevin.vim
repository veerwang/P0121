"
" It is my first vim script
"
"			V1.00
"
"

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
