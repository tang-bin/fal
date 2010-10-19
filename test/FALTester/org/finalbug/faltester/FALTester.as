/****************************
 * falTester
 *
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package org.finalbug.faltester
{
	import org.finalbug.data.Position;
	import org.finalbug.faltester.tester.GridTester;
	import org.finalbug.faltester.tester.MotionTester;
	import org.finalbug.faltester.tester.TextAreaTester;
	import org.finalbug.faltester.tester.UITester;
	import org.finalbug.framework.app.App;
	import org.finalbug.framework.app.Tooltip;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.ScrollBar;
	import org.finalbug.ui.control.TextArea;
	import org.finalbug.ui.control.UIObject;
	
	public class FALTester extends App
	{
		public function FALTester()
		{
			super(false);
			//
			var num:uint = 0;
			var tester:UIObject;
			switch(num)
			{
				case 0: tester = new UITester();break;
				case 1: tester = new MotionTester();break;
				case 2: tester = new TextAreaTester();break;
				case 3: tester = new GridTester();break;
			}
			if(tester != null)
			{
				this.addAll(tester);
			}
		}
	}
}