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
		
		public static const NULL_CONTAINER:String = "Container is null.";
		
		public static const NAME_NULL:String = "Parameter name cannot be null or empty.";
		public static const CSS_TYPE_ERROR:String = "Parameter type must be one of the following " +
			"values:classType, idType, selectorType.";
		
		public static const CONTROL_STATUS_NULL:String = "Must register status before effect.";
		
		public function FALError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}