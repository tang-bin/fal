//##########################################################
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
	/**
	 * AlertData defines the display attributes for Alert.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class AlertData
	{
		/**
		 * 
		 * @default Alert
		 */
		public var label:String = "Alert";
		
		/**
		 * 
		 * @default true
		 */
		public var showYes:Boolean = true;
		/**
		 * 
		 * @default Yes
		 */
		public var yesLabel:String = "Yes";
		/**
		 * The function will be called when "yes" button is clicked on Alert panel.
		 * 
		 * @default null
		 */
		public var yesFunction:Function;
		
		/**
		 * 
		 * @default false
		 */
		public var showNo:Boolean = false;
		/**
		 * 
		 * @default No
		 */
		public var noLabel:String = "No";
		/**
		 * This function will be called when "no" button is clicked on Alert panel.
		 * 
		 * @default null
		 */
		public var noFunction:Function;
		
		/**
		 * 
		 * @default false
		 */
		public var showCancel:Boolean = false;
		/**
		 * 
		 * @default Cancel
		 */
		public var cancelLabel:String = "Cancel";
		/**
		 * This function will be called when "cancel" button is clicked on Alert panel.
		 * 
		 * @default 
		 */
		public var cancelFunction:Function;
	}
}
