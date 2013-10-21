let g:kevin_script_lib_loaded_flag = 1

function! Library_Function_MakeTar()

let s:tardir  = "/home/kevin/armworkcopy/"
let s:project = input("Enter Project Name:")
let s:olddir  = getcwd()
let s:tarfile = s:project
let s:desfile = s:tarfile . ".tar.bz2"

python << EOF
import tarfile 
import vim
import os
import threading
import time

class AnsyTar(threading.Thread):
	def __init__(self,olddir,indir,infile,outfile):
		threading.Thread.__init__(self)
		self.infile  = infile
		self.outfile = outfile
		self.indir   = indir
		self.olddir  = olddir
		self.flag    = "f" 
	def run(self):
		os.chdir(self.indir)
		IsExists = os.path.exists(self.infile)
		if not IsExists:
			print "error: file need to tar not found"
			os.chdir(self.olddir)
		else:
			tar = tarfile.open(self.outfile,'w|bz2')
			tar.add(self.infile);
			tar.close()
			os.chdir(self.olddir)
			self.flag = "t"
			print "tar job finished"

	def getflag(self):
		return self.flag

background = AnsyTar(vim.eval("s:olddir"),
		     vim.eval("s:tardir"),
		     vim.eval("s:tarfile"),
		     vim.eval("s:desfile"))
background.start()


background.join()

EOF
endfunction
