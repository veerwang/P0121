/*
 * =====================================================================================
 *
 *       Filename:  main.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2018年04月16日 14时32分55秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  kevin (WangWei), kevin.wang2004@hotmail.com
 *        Company:  LiLin-Tech
 *   Organization:  GNU
 *
 * =====================================================================================
 */

#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/reg.h>

#include "base.h"

class People
{
	public:
		People() {;} 
		~People() {;} 
};

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  main
 *  Description:  
 * =====================================================================================
 */
	int
main ( int argc, char *argv[] )
{
	long orig_eax;
	Base base;
	base.m_id.set(10);
	std::cout<<base.m_id.get()<<std::endl;

	base.m_name.set("kevin");
	std::cout<<base.m_name.get()<<std::endl;

	DoProcessTraits<int>::Process();
	DoProcessTraits<char>::Process();

	People p;
	main_process(p);

	std::cout<<"hello the world"<<std::endl;

	int pid;
	pid = fork();	//返回的是子进程的进程号
	if ( pid == -1 )
		std::cout<<"bad fork process"<<std::endl;
	else if ( pid == 0 )
	{
		std::cout<<"----"<<std::endl;
		std::cout<<"I am chird: "<<pid<<std::endl;
		std::cout<<"getpid: "<<getpid()<<std::endl;
		std::cout<<"getppid: "<<getppid()<<std::endl;

		ptrace(PTRACE_TRACEME,0,NULL,NULL);	// 子进程允许父进程调试自己
		// ptrace(PTRACE_ATTACH,0,);		// 与父进程建立链接 
		execl("/bin/ls","ls",NULL);
	}
	else
	{
		wait(NULL);		// 注意这里需要等待,否则正确的结果将不会显示，因为时间不够
		//orig_eax = ptrace(PTRACE_PEEKUSER,pid,4 * ORIG_EAX,NULL); 
		//orig_eax = ptrace(PTRACE_PEEKUSER,pid,4 * 11,NULL); 
		std::cout<<"----"<<std::endl;
		std::cout<<"I am father: "<<pid<<std::endl;
		std::cout<<"getpid: "<<getpid()<<std::endl;
		std::cout<<"getppid: "<<getppid()<<std::endl;
		//orig_eax = ptrace(PTRACE_CONT,pid,NULL,NULL); 
	}

	sleep(1);		// 如果没有休眠，父进程退出之后，子进程的父进程会附加到某个进程中

	return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */
