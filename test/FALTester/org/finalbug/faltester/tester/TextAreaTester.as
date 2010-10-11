/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.faltester.tester
{
	import flash.events.MouseEvent;
	
	import org.finalbug.framework.layout.Container;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.TextArea;
	
	
	/******************************************
	 * org.finalbug.faltester.tester.TextAreaTester
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 *****************************************/
	public class TextAreaTester extends Container
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
				//txt.layoutStyle = new LayoutStyle();
				//
				btn = new Button("CLICK");
				btn.x = btn.y = 20;
				btn.addEventListener(MouseEvent.CLICK, clickBtnHandler);
				//
				this.addAll(btn, txt);
				this.horizontalRank(20);
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
			txt.setLayoutValue("width", "50%");
			txt.setLayoutValue("height", "50%");
			trace(txt.width, txt.height);
		}
	}
}