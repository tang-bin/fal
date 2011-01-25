//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.test
{
	import org.finalbug.test.tester.BasicTest;
	import org.finalbug.test.tester.InputTest;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.CheckBox;
	import org.finalbug.ui.navigate.AppRoot;
	import org.finalbug.ui.navigate.NavigateTab;
	
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
			tabs.addTab("BasicBasicBasic", new BasicTest());
			tabs.addTab("Inputs", new InputTest());
		}
	}
}