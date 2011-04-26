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
package ftk.test
{
	import ftk.test.tester.BasicTest;
	import ftk.test.tester.FreeTester;
	import ftk.test.tester.InputTest;
	import ftk.ui.navigate.AppRoot;
	import ftk.ui.navigate.NavigateTab;

	public class Tester extends AppRoot
	{

		public function Tester()
		{
			super();
			//
			var tabs:NavigateTab = new NavigateTab();
			tabs.layoutStyle.setAroundStyle(10, 10, 10, 10);
			this.addAll(tabs);
			//
			tabs.addTab("Free", new FreeTester());
			tabs.addTab("BasicBasicBasic", new BasicTest());
			tabs.addTab("Inputs", new InputTest());
		}
	}
}