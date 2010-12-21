/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 ******************************************/
package org.finalbug.errors
{
	
	/******************************************************
	 * errors.StyleError
	 *
	 * @author Tang Bin
	 * @since 2010.08
	  *****************************************************/  
	public class StyleError extends Error
	{
		/****************************************
		 *
		 * DEFINE
		 *
		 ****************************************/
		
		public static const CSS_UNREGISTERED:String = "Bind CSS in Class Bin must be registered in CSSManager.";
		public static const CSS_TYPE_ERROR:String = "CSS type must be one of classType, idType and selectorType.";
		
		/****************************************
		 *
		 * GETTER and SETTER
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * errors.StyleError constructor.
		 *
		 ****************************************/
		public function StyleError(message:*="", id:*=0)
		{
			super(message, id);
		}
		
		/****************************************
		 *
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PUBLIC
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PROTECTED
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PRIVATE
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * HANDLER
		 *
		 ****************************************/
	}
}