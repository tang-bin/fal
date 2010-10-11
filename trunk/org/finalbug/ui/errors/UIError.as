/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.ui.errors
{
	public class UIError extends Error
	{
		public static const WRONG_SCROLLBAR_TYPE:String = "ScrollBar component type error.";
		public static const CONTROL_NULL:String = "Must register status before effect.";
		public static const DISPLAY_OBJECT_NULL:String = "Target displayObject not exist.";
		
		public static const WRONG_TYPE:String = "Type Error.";
		
		public function UIError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}