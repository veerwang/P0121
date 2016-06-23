/*
 * =====================================================================================
 *
 *       Filename:  new.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2016年06月23日 14时03分20秒
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

#define cmd "mv"
#define para1 "test"
#define para2 "testnew"
/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  main
 *  Description:  
 * =====================================================================================
 */
	int
main ( int argc, char *argv[] )
{
	char* xmlargv[4];
	xmlargv[0] = cmd;
	xmlargv[1] = para1;
	xmlargv[2] = para2;
	xmlargv[3] = NULL;

	execvp(xmlargv[0],xmlargv);
	return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */
