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
	import ftk.navigate.AppRoot;
	import ftk.navigate.NavigateTab;
	import ftk.test.tester.ControlsTest;
	import ftk.test.tester.FreeTester;

	public class Tester extends AppRoot
	{
		public function Tester()
		{
			super();
			var tab:NavigateTab = new NavigateTab();
			tab.addTab("Playground", new FreeTester());
			tab.addTab("UI Controls", new ControlsTest());
			tab.layoutStyle.setAroundStyle(5, 5, 5, 5);
			this.addAll(tab);
		}
	}
}