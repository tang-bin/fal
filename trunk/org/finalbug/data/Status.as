﻿//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.data
{
	import org.finalbug.utils.DataUtil;

	/**
	 * @author Tang Bin
	 * @since old version
	 */
	public class Status
	{
		/**
		 * 
		 * @default 
		 */
		public static const YES:String = "yesStatus";
		/**
		 * 
		 * @default 
		 */
		public static const NO:String = "noStatus";
		/**
		 * 
		 * @default 
		 */
		public static const CANCEL:String = "cancelStatus";
		
		/**
		 * 
		 * @default 
		 */
		public static const LEFT:String = "leftStatus";
		/**
		 * 
		 * @default 
		 */
		public static const RIGHT:String = "rightStatus";
		/**
		 * 
		 * @default 
		 */
		public static const UP:String = "upStatus";
		/**
		 * 
		 * @default 
		 */
		public static const DOWN:String = "downStatus";
		
		/**
		 * 
		 * @default 
		 */
		public static const NORMAL:String = "normalStatus";
		/**
		 * 
		 * @default 
		 */
		public static const MOUSE_OVER:String = "mouseOverStatus";
		/**
		 * 
		 * @default 
		 */
		public static const MOUSE_DOWN:String = "mouseDownStatus";
		/**
		 * 
		 * @default 
		 */
		public static const HOLD:String = "holdStatus";
		/**
		 * 
		 * @default 
		 */
		public static const SELECTED:String = "selectedStatus";
		/**
		 * 
		 * @default 
		 */
		public static const SELECTED_MOUSE_OVER:String = "selectedMouseOverStatus";
		/**
		 * 
		 * @default 
		 */
		public static const SELECTED_MOUSE_DOWN:String = "selectedMOuseDownStatus";
		/**
		 * 
		 * @default 
		 */
		public static const SELECTED_DISABLE:String = "selectedDisableStatus";
		/**
		 * 
		 * @default 
		 */
		public static const DISABLE:String = "disableStatus";
		
		/**
		 * 
		 * @default 
		 */
		public static const ACTIVE:String = "activeStatus";
		
		/**
		 * 
		 * @param status
		 * @return 
		 */
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