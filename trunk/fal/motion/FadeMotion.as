/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.motion
{
	import flash.utils.Timer;
	
	import fal.errors.UIError;
	
	/**
	 * fal.motion.FadeMotion
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
		
		override protected function account(target:Object):void
		{
			try
			{
				if(times >= 0)
				{
					/* account x values */
					var a0:Number = isNaN(alphaFrom) ? target["alpha"] : alphaFrom; // alpha from
					var a1:Number = isNaN(alphaTo) ? target["alpha"] : alphaTo; // alpha to
					var aSteps:Array = getStepList(a0, a1);
					// register moting to runner.
					registeredMotions.push(MotionRunner.instance.register(target, "alpha", aSteps, this.times));
				}
			}
			catch(e:Error)
			{
				throw new UIError(UIError.NO_IUI);
			}
		}
	}
}