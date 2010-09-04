/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.errors
{
	/****************************
	 * fal.errors.FALError
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 ****************************/
	public class FALError extends Error
	{
		public static const SINGLETON:String = "Class using singleton pattern cannot be instanced.";
		
		public static const APP_NOT_ROOT:String = "Class FALApp must be used as ROOT object.";
		public static const APP_WIDTH_UNCHANGEABLE:String = "Width value of App CANNOT be changed.";
		public static const APP_HEIGHT_UNCHANGEABLE:String = "Height value of App CANNOT be changed.";
		
		public static const NAME_EXIST:String = "The name of this data already exist.";
		public static const NAME_NOT_EXIST:String = "Object not exist.";
		
		public function FALError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}