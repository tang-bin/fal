// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.test.tester
{
	import ftk.controls.Button;
	import ftk.controls.TextArea;
	import ftk.layout.Container;

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