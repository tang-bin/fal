package fas.motion
{
	import fas.utils.AdvancedObject;
	
	/**
	 * Class Motion is the superclass of all motion classes such as move and fade.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class Motion extends AdvancedObject
	{
		public static const INTERVAL:Number = 30;
		
		/**
		 * even accelerated motion from start point to end point.
		 */		
		public static const SPEED_UP:String = "speedUp";
		
		/**
		 * even speed down motion from start point to end point.
		 */		
		public static const SPEED_DOWN:String = "speedDown";
		
		/**
		 * move from start point to end point as even pace.
		 */		
		public static const EVEN_PACE:String = "evenPace";
		
		/**
		 * move speed type. can be speed up, speed down and even pace.
		 * 
		 * @see fas.motion.Moting.SPEED_UP
		 * @see fas.motion.Moting.SPEED_DOWN
		 * @see fas.motion.Moting.EVEN_PACE
		 */		
		public var speedType:String = "speedDown";
		
		public var during:Number = 300; // motion will be done during this time, in millisecond.
		public var delayTime:Number = 0;
		
		protected var targetList:Array; // list of display objects
		protected var time:uint = 1;
		protected var getBack:Boolean = false;
		protected var registeredMotions:Array;
		
		public function Motion(target:Object)
		{
			targetList = [target];
		}
		
		/**
		 * Start motion play.
		 * 
		 * @param targets List of display objects which will run the motion.
		 * @param back Play back after motion end.
		 * @param time Play times.
		 */		
		public function start(targets:Array = null, getBack:Boolean = false, time:uint = 1):void
		{
			if(targets != null)
			{
				targetList = targets;
			}
			this.getBack = getBack;
			this.time = time;
			registeredMotions = new Array();
			//
			for(var i:Number = 0 ; i < targetList.length ; i++)
			{
				account(targetList[i]);
			}
		}
		
		/**
		 * Stop motion(s).
		 */		
		public function stop():void
		{
			registeredMotions.forEach(stopMotion);
		}
		
		private function stopMotion(element:*, index:int, arr:Array):void
		{
			MotionRunner.instance.stopAndRemoveMotion(element);
		}
		
		/**
		 * account method dont need complete in Class Motion
		 * @param target
		 */		
		protected function account(target:Object):void{}
		
		protected function repeatSteps(steps:Array):Array
		{
			setDelay(steps);
			if(time != 1)
			{
				var back:Boolean = false;
				var s1:Array = steps.concat();
				var s2:Array = steps.concat().reverse();
				for(var i:Number = (time == 0 ? 2 : time) ; --i > 0 ;)
				{
					back = getBack ? !back : false;
					steps = steps.concat(back ? s2 : s1);
				}
			}
			return steps;
		}
		
		private function setDelay(steps:Array):void
		{
			if(delayTime != 0)
			{
				var delayCount:uint = Math.round(delayTime / Motion.INTERVAL);
				for(var i:Number = delayCount ; --i >= 0 ;)
				{
					steps.unshift(steps[0]);
				}
			}
		}
		
		protected function getStepList(fromValue:Number, toValue:Number):Array
		{
			var step:uint = Math.floor(during / Motion.INTERVAL);
			var acc:Number = 2 * (toValue - fromValue) / Math.pow(during, 2); // accelerated speed on x way
			var steps:Array = [fromValue];
			var maxSpeed:Number = during * acc;
			var oneStep:Number = (toValue - fromValue) / step;
			for(var i:Number = 1 ; i <= step ; i++)
			{
				var T:Number = i * Motion.INTERVAL;
				var powT:Number = Math.pow(T, 2); // t^2
				if(speedType == Motion.SPEED_UP)
				{
					steps.push(fromValue + (acc * powT / 2));
					// s = (a * t^2) / 2
				}
				else if(speedType == Motion.SPEED_DOWN)
				{
					steps.push(fromValue + maxSpeed * T + (-acc * powT / 2));
					// s = v0*t + (a * t^2) / 2
				}
				else
				{
					steps.push(fromValue + i * oneStep);
				}
			}
			steps.push(toValue);
			steps = repeatSteps(steps);
			return steps;
		}
	}
}