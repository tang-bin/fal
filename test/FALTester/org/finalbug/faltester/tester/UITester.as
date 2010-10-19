package org.finalbug.faltester.tester
{
	import org.finalbug.framework.layout.Container;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.TextArea;
	
	public class UITester extends Container
	{
		private var btn:Button;
		private var ta:TextArea;
		
		public function UITester()
		{
			super();
			//
			btn = new Button("button");
			btn.x = btn.y = 10;
			//
			ta = new TextArea();
			ta.x = 10;
			ta.y = 50;
			//
			this.addAll(btn, ta);
		}
	}
}