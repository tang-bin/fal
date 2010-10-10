/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.faltester.tester
{
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.finalbug.debugger.Debug;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.TextArea;
	import org.finalbug.ui.control.UIObject;
	
	
	/******************************************
	 * org.finalbug.faltester.tester.TextAreaTester
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 *****************************************/
	public class TextAreaTester extends UIObject
	{
		/****************************************
		 *
		 * DEFINE
		 *
		 ****************************************/
		
		private var txt:TextArea;
		private var btn:Button;
		
		/****************************************
		 *
		 * GETTER & SETTER
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * org.finalbug.faltester.tester.TextAreaTester constructor.
		 *
		 ****************************************/
		public function TextAreaTester()
		{
			super();
		}
		
		/****************************************
		 *
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 *
		 ****************************************/
		
		override protected function callAtAdded():void
		{
			super.callAtAdded();
			if(txt == null)
			{
				txt = new TextArea();
				txt.x = txt.y = 100;
				btn = new Button("CLICK");
				btn.x = btn.y = 20;
				btn.addEventListener(MouseEvent.CLICK, clickBtnHandler);
				//
				this.addAll(btn, txt);
				
			}
		}
		
		/****************************************
		 *
		 * PUBLIC
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PROTECTED
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PRIVATE
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * HANDLER
		 *
		 ****************************************/
		
		private function clickBtnHandler(e:MouseEvent):void
		{
			txt.width += 10;
			txt.height += 5;
			Debug.log(txt.width, txt.height);
		}
	}
}