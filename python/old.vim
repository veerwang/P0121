
















function! Kevin_Python_Title()
python << EOF
import vim
import time

cw = vim.current.window
linelen =  len(cw.buffer)


cw.buffer[0] = '"""""""""""""""""""""""""""""""""""""""""""""'
cw.buffer[1] = '"  		       Vim Script Title      '
cw.buffer[2] = '"  	 	       Author:    Kevin      '
cw.buffer[3] = '"  		      Version:    V1.0       '
cw.buffer[4] = '"  		         Date:   ' + time.strftime('%Y-%m-%d',time.localtime(time.time()))
cw.buffer[5] = '"  		         Time:   ' + time.strftime('%H:%M:%S',time.localtime(time.time()))
cw.buffer[6] = cw.buffer[0]

EOF
endfunction
