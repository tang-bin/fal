/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.data
{
	import org.finalbug.utils.DataUtil;

	/**
	 * @author Tang Bin
	 */
	public class Status
	{
		public static const YES:String = "yesStatus";
		public static const NO:String = "noStatus";
		public static const CANCEL:String = "cancelStatus";
		
		public static const LEFT:String = "leftStatus";
		public static const RIGHT:String = "rightStatus";
		public static const UP:String = "upStatus";
		public static const DOWN:String = "downStatus";
		
		public static const NORMAL:String = "normalStatus";
		public static const MOUSE_OVER:String = "mouseOverStatus";
		public static const MOUSE_DOWN:String = "mouseDownStatus";
		public static const HOLD:String = "holdStatus";
		public static const SELECTED:String = "selectedStatus";
		public static const SELECTED_MOUSE_OVER:String = "selectedMouseOverStatus";
		public static const SELECTED_MOUSE_DOWN:String = "selectedMOuseDownStatus";
		public static const SELECTED_DISABLE:String = "selectedDisableStatus";
		public static const DISABLE:String = "disableStatus";
		
		public static const ACTIVE:String = "activeStatus";
		
		public static function isValidUISkinStatus(status:String):Boolean
		{
			return DataUtil.included(status,
				NORMAL,
				MOUSE_OVER,
				MOUSE_DOWN,
				HOLD,
				SELECTED,
				DISABLE);
		}
	}
}