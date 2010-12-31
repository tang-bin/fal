//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.utils.motion
{
	
	/**
	 * motion.SizeMotion
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class SizeMotion extends Motion
	{
		/**
		 * 
		 * @default 
		 */
		public var widthFrom:Number;
		/**
		 * 
		 * @default 
		 */
		public var heightFrom:Number;
		/**
		 * 
		 * @default 
		 */
		public var widthTo:Number;
		/**
		 * 
		 * @default 
		 */
		public var heightTo:Number;
		
		/**
		 * 
		 * @param target
		 */
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