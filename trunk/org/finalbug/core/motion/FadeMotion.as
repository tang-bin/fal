/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.core.motion
{
	/**
	 * org.finalbug.fal.motion.FadeMotion
	 *  
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	public class FadeMotion extends Motion
	{
		public var alphaFrom:Number;
		public var alphaTo:Number;
		
		public function FadeMotion(target:Object = null)
		{
			super(target);
		}
		
		override protected function count(target:Object):void
		{
			if(times >= 0)
			{
				/* account x values */
				var a0:Number = isNaN(alphaFrom) ? target["alpha"] : alphaFrom; // alpha from
				var a1:Number = isNaN(alphaTo) ? target["alpha"] : alphaTo; // alpha to
				var aSteps:Array = repeatSteps(counter.count([a0], [a1], this.during)[0]);
				// register moting to runner.
				registeredMotions.push(MotionRunner.instance.register(target, "alpha", aSteps, this.times));
			}
		}
	}
}