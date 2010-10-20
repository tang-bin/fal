/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.core.motion
{
	
	
	/**
	 * motion.SizeMotion
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class SizeMotion extends Motion
	{
		public var widthFrom:Number;
		public var heightFrom:Number;
		public var widthTo:Number;
		public var heightTo:Number;
		
		public function SizeMotion(target:Object = null)
		{
			super(target);
		}
		
		override protected function count(target:Object):void
		{
			if(times >= 0)
			{
				/* account values */
				var w0:Number = isNaN(widthFrom) ? target["width"] : widthFrom;
				var w1:Number = isNaN(widthTo) ? target["width"] : widthTo;
				//
				var h0:Number = isNaN(heightFrom) ? target["height"] : heightFrom;
				var h1:Number = isNaN(heightTo) ? target["height"] : heightTo;
				//
				var startValues:Array = [w0, h0];
				var endValues:Array = [w1, h1];
				var steps:Array = counter.count(startValues, endValues, this.during);
				var wSteps:Array = steps[0];
				var hSteps:Array = steps[1];
				// register moting to runner.
				registeredMotions.push(MotionRunner.instance.register(target, "width", wSteps, this.times, this));
				registeredMotions.push(MotionRunner.instance.register(target, "height", hSteps, this.times));
			}
		}
	}
}