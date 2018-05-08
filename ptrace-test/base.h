#if !defined(INCLUDED_BASE_H)
#define INCLUDED_BASE_H  1

/*
 * =====================================================================================
 *
 *       Filename:  base.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2018年04月16日 14时34分43秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  kevin (WangWei), kevin.wang2004@hotmail.com
 *        Company:  LiLin-Tech
 *   Organization:  GNU
 *
 * =====================================================================================
 */

#include "template.h"


/*
 * =====================================================================================
 *        Class:  Base
 *  Description:  
 * =====================================================================================
 */
class Base
{
	public:
		/* ====================  LIFECYCLE     ======================================= */
		Base () : m_id(100),m_name(std::string("wangwei"))
		{
			;
		}                                       	/* constructor */
		~Base ();                                       /* destructor  */

		/* ====================  ACCESSORS     ======================================= */

		/* ====================  MUTATORS      ======================================= */

		/* ====================  OPERATORS     ======================================= */
		Value<int> 	   	m_id;
		Value<std::string> 	m_name;
	protected:
		/* ====================  DATA MEMBERS  ======================================= */

	private:
		/* ====================  DATA MEMBERS  ======================================= */

}; /* -----  end of class Base  ----- */

#endif /* !defined(INCLUDED_BASE_H) */
