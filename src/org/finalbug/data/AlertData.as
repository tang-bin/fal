// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
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
		 * The alert string will be shown
		 * 
		 * @default Alert
		 */
		public var label:String = "Alert";

		/**
		 * Show yes button or not.
		 * 
		 * @default true
		 */
		public var showYes:Boolean = true;

		/**
		 * The text string on yes button.
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
		 * Show no button or not.
		 * 
		 * @default false
		 */
		public var showNo:Boolean = false;

		/**
		 * The text string on no button.
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
		 * Show cancel button or not.
		 * 
		 * @default false
		 */
		public var showCancel:Boolean = false;

		/**
		 * The text on cancel button.
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
