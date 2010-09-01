/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.controls
{
	import fal.display.Control;
	
	/******************************************
	 * fal.controls.Button
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 *****************************************/
	public class Button extends Control
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * 
		 * fal.controllers.Button constructor.
		 * 
		 ****************************************/
		public function Button(text:String = "Button")
		{
			this.displayWidth = 80;
			this.displayHeight = 20;
			super();
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		override protected function updateView():void
		{
			
		}
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
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