/****************************
 * .FALTester
 *
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package fal.faltester
{
	import org.finalbug.framework.app.FALApp;
	import org.finalbug.framework.app.Tooltip;
	import org.finalbug.ui.control.TextArea;
	
	public class FALTester extends org.finalbug.framework.app.FALApp
	{
		public function FALTester()
		{
			var ti:TextArea = new TextArea();
			this.addAll(ti);
			ti.toCenter();
			Tooltip.show("asdf");
		}
	}
}