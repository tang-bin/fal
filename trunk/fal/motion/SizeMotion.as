package fal.motion
{
	import fal.errors.UIError;
	
	public class SizeMotion extends Motion
	{
		public var widthFrom:Number;
		public var heightFrom:Number;
		public var widthTo:Number;
		public var heightTo:Number;
		
		public function SizeMotion(target:Object)
		{
			super(target);
		}
		
		override protected function account(target:Object):void
		{
			try
			{
				if(time >= 1)
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
					registeredMotions.push(MotionRunner.instance.register(target, "width", wSteps, this.time, this));
					registeredMotions.push(MotionRunner.instance.register(target, "height", hSteps, this.time));
				}
			}
			catch(e:Error)
			{
				throw new UIError(UIError.NO_IUI);
			}
		}
	}
}