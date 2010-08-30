/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.display
{
	import fal.errors.FALError;
	import fal.style.CSSStyle;
	
	/**
	 * Class Control is the super class for all of the controls.
	 * 
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since 2010.08
	 */	
	public class Control extends Bin
	{
		/****************************************
		 * 
		 * DEFINE
		 * 
		 ****************************************/
		
		public var defaultStatus:String = "";
		
		protected var statusList:Object = new Object();
		protected var currentStatus:String;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		public function get status():String
		{
			return currentStatus;
		}
		public function set status(value:String):void
		{
			if(value != currentStatus && value != "")
			{
				if(statusList[value] != null)
				{
					currentStatus = value;
					updateView();
				}
				else if(defaultStatus != "" && statusList[defaultStatus] != null)
				{
					currentStatus = defaultStatus;
					updateView();
				}
			}
		}
		
		/****************************************
		 * 
		 * fal.display.Controller constructor.
		 * 
		 ****************************************/
		public function Control()
		{
			super();
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		public function registerStatus(name:String, style:CSSStyle):void
		{
			statusList[name] = style;
		}
		
		/**
		 * unregister a status of controller.
		 * if defaultName is not empty or null, change the default status.
		 * if defaultName is empty or null, and the unregistering status is the default one
		 * select any one status as the default.
		 * 
		 * @param name
		 */		
		public function unregisterStatus(name:String):void
		{
			if(statusList[name] != null)
			{
				delete statusList[name];
				statusList[name] = null;
			}
		}
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}