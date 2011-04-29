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
package ftk.test
{
	import flash.display.Sprite;

	import ftk.layout.Container;
	import ftk.navigate.AppRoot;

	/*
	import ftk.navigate.NavigateTab;
	import ftk.test.tester.ControlsTest;
	import ftk.test.tester.FreeTester;
	import ftk.test.tester.InputTest;
	 * 
	 */
	public class Tester extends AppRoot
	{
		public function Tester()
		{
			super();
			//
			/*
			var tabs:NavigateTab = new NavigateTab();
			tabs.layoutStyle.setAroundStyle(10, 10, 10, 10);
			this.addAll(tabs);
			// tabs.addTab("Free", new FreeTester());
			tabs.addTab("Controls", new ControlsTest());
			tabs.addTab("Inputs", new InputTest());
			 * 
			 */

			var c:Container = new Container();
			this.addAll(c);
			c.width = c.height = 200;
			c.backgroundColor = 0xFF9900;
			c.backgroundAlpha = 1;
			var sp:Sprite = new Sprite();
			sp.graphics.lineStyle(2, 0x009900);
			sp.graphics.moveTo(0, 0);
			sp.graphics.lineTo(500, 500);
			c.addChild(sp);
		}
	}
}