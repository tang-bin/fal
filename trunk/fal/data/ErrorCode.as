package fas.data
{
	
	/******************************************
	 * Finalbug's ActionScript ( http://www.finalbug.org/ )
	 * 
	 * fas.data.ErrorCode
	 *
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since Aug 8, 2010 6:40:03 PM
	 *
	 *****************************************/
	public class ErrorCode extends Error
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		public static const SINGLETON:String = "Class using singleton pattern cannot be instanced.";
		
		// for css 
		public static const CSS_UNREGISTERED:String = "Bind CSS in Class Bin must be registered in CSSManager.";
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * fas.data.ErrorCode constructor.
		 ****************************************/
		public function ErrorCode(message:*="", id:*=0)
		{
			super(message, id);
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}