#if !defined(INCLUDED_TEMPLATE_H)
#define INCLUDED_TEMPLATE_H  1

/*
 * =====================================================================================
 *
 *       Filename:  template.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2018年04月16日 14时51分05秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  kevin (WangWei), kevin.wang2004@hotmail.com
 *        Company:  LiLin-Tech
 *   Organization:  GNU
 *
 * =====================================================================================
 */

#include <cstdio>
#include <cstdlib>
#include <string>
#include <iostream>

template<typename T>
class Value
{
	public:
		Value() {;}
		Value(T v) { _object = v; }
		~Value() {;}

		void set(T v)
		{
			_object = v;
		}

		T get()
		{
			return _object;
		}

	private:
		T 	_object;
};

template <typename T>
class DoProcessTraits;

template<>
class DoProcessTraits<int>
{
	public:
		DoProcessTraits(){;}
		~DoProcessTraits(){;}

		static void Process()
		{
			std::cout<<"int"<<std::endl;
		}
};

template<>
class DoProcessTraits<char>
{
	public:
		DoProcessTraits(){;}
		~DoProcessTraits(){;}

		static void Process()
		{
			std::cout<<"char"<<std::endl;
		}
};

class People;

template<>
class DoProcessTraits<class People>
{
	public:
		DoProcessTraits(){;}
		~DoProcessTraits(){;}

		static void Process()
		{
			std::cout<<"People"<<std::endl;
		}
};

template<>
class DoProcessTraits<double>
{
	public:
		DoProcessTraits(){;}
		~DoProcessTraits(){;}

		static void Process()
		{
			std::cout<<"double"<<std::endl;
		}
};

template<typename T,typename DP = DoProcessTraits<T> >
void main_process(const T& c)
{
	DP::Process();
}

/*
template<typename T>
class Object 
{
public:
	Object() {;}
	~Object() {;}
};

template<>
Object<std::string>::Object()
{
	//std::cout<<"Object string create"<<std::endl;
}
*/





#endif /* !defined(INCLUDED_TEMPLATE_H) */
