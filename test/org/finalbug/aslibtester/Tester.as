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
	import org.finalbug.aslibtester.tester.TreeModelTester;
	import org.finalbug.aslibtester.tester.UITester;
	import org.finalbug.ui.Bin;
	import org.finalbug.ui.control.UIObject;
	
	public class Tester extends Bin
	{
		public function Tester()
		{
			super();
			stage.scaleMode = "noScale";
			stage.align = "TL";
			//
			var num:uint = 0;
			var tester:UIObject;
			switch(num)
			{
				case 0: tester = new UITester();break;
				case 1: tester = new MotionTester();break;
				case 2: tester = new TextAreaTester();break;
				case 3: tester = new GridTester();break;
				case 4: tester = new FolderTest();break;
				case 5: tester = new TreeModelTester();break;
			}
			if(tester != null)
			{
				this.addAll(tester);
			}
		}
	}
}