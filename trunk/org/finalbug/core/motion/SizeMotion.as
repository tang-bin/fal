/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.core.motion
{
	
	
	/**
	 * org.finalbug.fal.motion.SizeMotion
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
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
		
		override protected function account(target:Object):void
		{
			if(times >= 0)
			{
				/* account values */
				var w0:Number = isNaN(widthFrom) ? target["width"] : widthFrom;
				var w1:Number = isNaN(widthTo) ? target["width"] : widthTo;
				var wSteps:Array = getStepList(w0, w1);
				//
				var h0:Number = isNaN(heightFrom) ? target["height"] : heightFrom;
				var h1:Number = isNaN(heightTo) ? target["height"] : heightTo;
				var hSteps:Array = getStepList(h0, h1);
				// register moting to runner.
				registeredMotions.push(MotionRunner.instance.register(target, "width", wSteps, this.times, this));
				registeredMotions.push(MotionRunner.instance.register(target, "height", hSteps, this.times));
			}
		}
	}
}