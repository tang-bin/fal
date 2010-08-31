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
	import fal.events.MotionEvent;
	import fal.motion.MoveMotion;
	
	public class FALTester extends FALApp
	{
		public function FALTester()
		{
			debug("asdf");
			var ft:Flat = new Flat(50, 50);
			this.addChild(ft);
			//
			var mm:MoveMotion = new MoveMotion();
			mm.xFrom = 100;
			mm.yFrom = 100;
			mm.xTo = 1000;
			mm.yTo = 50;
			mm.during = 1000;
			mm.addEventListener(MotionEvent.MOTION_RUNNING, m1);
			mm.addEventListener(MotionEvent.MOTION_STOP, m2);
			mm.delayTime = 3000;
			mm.start([ft]);
		}
		
		private function m1(e:MotionEvent):void
		{
			trace("run");
		}
		
		private function m2(e:MotionEvent):void
		{
			trace("top");
		}
	}
}