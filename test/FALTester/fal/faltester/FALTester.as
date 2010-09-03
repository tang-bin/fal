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
	import fal.controls.RadioButton;
	import fal.controls.TextArea;
	import fal.controls.TextInput;
	
	public class FALTester extends FALApp
	{
		public function FALTester()
		{
			var ti:TextArea = new TextArea();
			this.addAll(ti);
			ti.toCenter();
		}
	}
}