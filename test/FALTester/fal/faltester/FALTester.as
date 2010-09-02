/****************************
 * .FALTester
 *
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package fal.faltester
{
	import fal.app.FALApp;
	import fal.controls.CheckBox;
	
	public class FALTester extends FALApp
	{
		public function FALTester()
		{
			var cb:CheckBox = new CheckBox();
			this.addAll(cb);
			cb.x = cb.y = 300;
		}
	}
}