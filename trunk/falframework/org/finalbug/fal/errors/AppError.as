/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.fal.errors
{
	/****************************
	 * org.finalbug.fal.errors.FALError
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 ****************************/
	public class AppError extends Error
	{
		public static const APP_NOT_ROOT:String = "Class FALApp must be used as ROOT object.";
		public static const APP_WIDTH_UNCHANGEABLE:String = "Width value of App CANNOT be changed.";
		public static const APP_HEIGHT_UNCHANGEABLE:String = "Height value of App CANNOT be changed.";
		
		public function AppError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}