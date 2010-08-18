package fas.motion
{
	import flash.utils.Timer;
	
	import fas.errors.UIError;
	
	public class FadeMotion extends Motion
	{
		public var alphaFrom:Number;
		public var alphaTo:Number;
		
		public function FadeMotion(target:Object)
		{
			super(target);
		}
		
		override protected function account(target:Object):void
		{
			try
			{
				if(time >= 0)
				{
					/* account x values */
					var a0:Number = isNaN(alphaFrom) ? target["alpha"] : alphaFrom; // alpha from
					var a1:Number = isNaN(alphaTo) ? target["alpha"] : alphaTo; // alpha to
					var aSteps:Array = getStepList(a0, a1);
					// register moting to runner.
					registeredMotions.push(MotionRunner.instance.register(target, "alpha", aSteps, this.time));
				}
			}
			catch(e:Error)
			{
				throw new UIError(UIError.NO_IUI);
			}
		}
	}
}