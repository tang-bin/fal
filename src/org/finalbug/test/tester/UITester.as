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
package org.finalbug.test.tester
{
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.Container;
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
			/*
			ta = new TextArea();
			ta.x = 10;
			ta.y = 50;
			 */
			//
			this.addAll(btn);
		}
	}
}