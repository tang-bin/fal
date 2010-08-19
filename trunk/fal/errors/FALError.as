/****************************
 * fal.errors.FALError
 *
 * @author Tang Bin
 * @since 2010-8-19
 ****************************/
package fal.errors
{
	public class FALError extends Error
	{
		public static const APP_NOT_ROOT:String = "Class FALApp must be used as ROOT object.";
		public static const APP_WIDTH_UNCHANGEABLE:String = "Width value of App CANNOT be changed.";
		public static const APP_HEIGHT_UNCHANGEABLE:String = "Height value of App CANNOT be changed.";
		
		public static const NULL_CONTAINER:String = "Container is null.";
		
		public function FALError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}