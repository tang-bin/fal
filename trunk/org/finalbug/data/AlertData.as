/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.data
{
	/**
	 * data.AlertData
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class AlertData
	{
		public var label:String = "Alert";
		
		public var showYes:Boolean = true;
		public var yesLabel:String = "Yes";
		public var yesFunction:Function;
		
		public var showNo:Boolean = false;
		public var noLabel:String = "No";
		public var noFunction:Function;
		
		public var showCancel:Boolean = false;
		public var cancelLabel:String = "Cancel";
		public var cancelFunction:Function;
	}
}