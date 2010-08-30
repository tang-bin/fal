/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package fal.errors
{
	
	/******************************************
	 * fal.errors.StyleError
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 *****************************************/
	public class StyleError extends Error
	{
		/****************************************
		 *
		 * DEFINE
		 *
		 ****************************************/
		
		public static const CSS_UNREGISTERED:String = "Bind CSS in Class Bin must be registered in CSSManager.";
		
		/****************************************
		 *
		 * GETTER & SETTER
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * fal.errors.StyleError constructor.
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