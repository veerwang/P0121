/*
 * =====================================================================================
 *
 *       Filename:  utils.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  11/03/2016 01:38:11 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  kevin (WangWei), kevin.wang2004@hotmail.com
 *        Company:  LiLin-Tech
 *   Organization:  GNU
 *
 * =====================================================================================
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define EACHLINEMAX 1024
static char * replace_string (char * string, const char * source, const char * destination )  
{
	char* sk = strstr (string, source);  
	if (sk == NULL) return NULL;  

	char* tmp;  
	size_t size = strlen(string)+strlen(destination)+1;  

	char* newstr = (char*)calloc (1, size);  
	if (newstr == NULL) return NULL;  

	char* retstr = (char*)calloc (1, size);  
	if (retstr == NULL)  
	{  
		free (newstr);  
		return NULL;  
	}  

	snprintf (newstr, size-1, "%s", string);  
	sk = strstr (newstr, source);  

	while (sk != NULL)  
	{  
		int pos = 0;  
		memcpy (retstr+pos, newstr, sk - newstr);  
		pos += sk - newstr;  
		sk += strlen(source);  
		memcpy (retstr+pos, destination, strlen(destination));  
		pos += strlen(destination);  
		memcpy (retstr+pos, sk, strlen(sk));  

		tmp = newstr;  
		newstr = retstr;  
		retstr = tmp;  

		memset (retstr, 0, size);  
		sk = strstr (newstr, source);  
	}  
	free (retstr);  
	return newstr;  
}

/*  
 *  将某个文件中的某个字符串替换为另外一个字符串
 *  return value: 0: success
 *		 -1: fail
 */
int convert_file_containt(const char* src,const char* des)
{
	char filepath[256];
	char desfilepath[256];
	char eachline[EACHLINEMAX];
	char *s;
	char br[256];
	char ar[256];
	sprintf(br,"pm install ");
	sprintf(ar,"pm installex ");
	sprintf(filepath,"%s",src);
	sprintf(desfilepath,"%s",des);

	FILE *fp = fopen(filepath,"r");
	if ( fp == NULL )
	{
		printf("open file %s fail\n",filepath);
		return -1;
	}

	FILE *dfp = fopen(desfilepath,"w");
	if ( dfp == NULL )
	{
		printf("open file %s fail\n",desfilepath);
		fclose(fp);
		return -1;
	}

	while(!feof(fp))
	{
		if (fgets(eachline,EACHLINEMAX,fp) == NULL )  	//读取一行
			continue;

		s = replace_string(eachline,br,ar);
		if ( s != NULL )
		{
			fwrite(s,strlen(s),1,dfp);
			free(s);
		}
		else 
			fwrite(eachline,strlen(eachline),1,dfp);
	}

	fclose(fp);
	fp = NULL;
	fclose(dfp);
	dfp = NULL;

	return 0;
}
