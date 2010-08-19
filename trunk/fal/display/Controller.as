/******************************************
 * Finalbug ActionScript Library ( http://www.finalbug.org/ )
 * 
 * fal.display.Controller
 *
 * @author Tang Bin (tangbin@finalbug.org)
 * @since Jul 12, 2010 7:23:15 PM
 *
 *****************************************/
package fal.display
{
	import fal.style.CSSStyle;
	
	public class Controller extends Bin
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		protected var statusList:Object = new Object();
		protected var defaultStatus:String;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * fal.display.Controller constructor.
		 ****************************************/
		public function Controller()
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
		
		public function registerStatus(name:String, style:CSSStyle, setAsDefault:Boolean = false):void
		{
			statusList[name] = style;
			if(setAsDefault) defaultStatus = name;
			updateView();
		}
		
		/**
		 * unregister a status of controller.
		 * if defaultName is not empty or null, change the default status.
		 * if defaultName is empty or null, and the unregistering status is the default one
		 * select any one status as the default.
		 * 
		 * @param name
		 * @param defaultName
		 */		
		public function unregisterStatus(name:String, defaultName:String = ""):void
		{
			if(statusList[name] != null)
			{
				
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