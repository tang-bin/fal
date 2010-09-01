/****************************
 * .FALTester
 *
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package fal.faltester
{
	import fal.app.FALApp;
	import fal.controls.Label;
	import fal.display.Flat;
	import fal.events.MotionEvent;
	import fal.motion.MoveMotion;
	import fal.motion.SizeMotion;
	
	public class FALTester extends FALApp
	{
		public function FALTester()
		{
			debug("asdf");
			var ft:Flat = new Flat(50, 50);
			this.addChild(ft);
			ft.moveTo(300, 400, 1000);
			//ft.zoomTo(400, 400, 3000);
			//
			var l:Label = new Label("asdfasdf");
			this.addChild(l);
			l.x = l.y = 300;
		}
	}
}