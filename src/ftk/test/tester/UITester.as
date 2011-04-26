// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.test.tester
{
	import ftk.ui.control.Button;
	import ftk.ui.control.Container;
	import ftk.ui.control.TextArea;

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