/****************************
 * .FALTester
 *
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package fal.faltester
{
	import fal.app.FALApp;
	import fal.display.Flat;
	
	public class FALTester extends FALApp
	{
		public function FALTester()
		{
			debug("asdf");
			var ft:Flat = new Flat(50, 50);
			this.addChild(ft);
			ft.zoom(300, 300, 500);
			//ft.move(300, 300, 500);
		}
	}
}