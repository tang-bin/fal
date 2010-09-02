/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.errors
{
	public class ControlError extends Error
	{
		public static const WRONG_SCROLLBAR_TYPE:String = "ScrollBar component type error.";
		
		public function ControlError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}