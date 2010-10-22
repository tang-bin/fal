/****************************
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package org.finalbug.aslibtester
{
	import org.finalbug.aslibtester.tester.FolderTest;
	import org.finalbug.aslibtester.tester.GridTester;
	import org.finalbug.aslibtester.tester.MotionTester;
	import org.finalbug.aslibtester.tester.TextAreaTester;
	import org.finalbug.aslibtester.tester.UITester;
	import org.finalbug.data.Position;
	import org.finalbug.framework.app.App;
	import org.finalbug.framework.app.Tooltip;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.ScrollBar;
	import org.finalbug.ui.control.TextArea;
	import org.finalbug.ui.control.UIObject;
	
	public class Tester extends App
	{
		public function Tester()
		{
			super(false);
			//
			var num:uint = 4;
			var tester:UIObject;
			switch(num)
			{
				case 0: tester = new UITester();break;
				case 1: tester = new MotionTester();break;
				case 2: tester = new TextAreaTester();break;
				case 3: tester = new GridTester();break;
				case 4: tester = new FolderTest();break;
			}
			if(tester != null)
			{
				this.addAll(tester);
			}
		}
	}
}