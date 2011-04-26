// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.motion
{
	import ftk.errors.MotionError;
	import ftk.events.MotionEvent;

	/**
	 * MotionCounter is the value counter for a motion.
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class MotionCounter
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
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
		 * @see motion.Moting.SPEED_UP
		 * @see motion.Moting.SPEED_DOWN
		 * @see motion.Moting.EVEN_PACE
		 */
		public var speedType:String = "speedDown";

		/**
		 * 
		 * @default 
		 */
		public var countFunction:Function = getStepList;

		/**
		 * 
		 * @default 
		 */
		protected var startValues:Array;

		/**
		 * 
		 * @default 
		 */
		protected var endValues:Array;

		/**
		 * 
		 * @default 
		 */
		protected var during:uint = 0;

		/**
		 * 
		 * @default 
		 */
		protected var stepList:Array;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 */
		public function MotionCounter()
		{
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 * @param startValues
		 * @param endValues
		 * @param during
		 * @return 
		 * @throws MotionError
		 */
		public function count(startValues:Array, endValues:Array, during:uint):Array
		{
			if (startValues.length != endValues.length)
			{
				throw new MotionError(MotionError.START_END_NOT_MATCH);
			}
			this.startValues = startValues;
			this.endValues = endValues;
			this.during = during;
			this.stepList = new Array();
			if (countFunction != null)
			{
				countFunction.call(this);
				return stepList;
			}
			else
			{
				return new Array();
			}
		}

		/******************* PROTECTED *************************************************/
		/**
		 * 
		 * @throws MotionEvent
		 */
		protected function getStepList():void
		{
			var len:uint = startValues.length;
			for (var index:uint = 0 ; index < len ; index++)
			{
				var startValue:Number = Number(startValues[index]);
				var endValue:Number = Number(endValues[index]);
				if (isNaN(startValue) || isNaN(endValue))
				{
					throw new MotionEvent(MotionError.COUNT_VALUE_NOT_NUMBER);
				}
				var steps:Array = [startValue];
				var step:uint = Math.floor(during / Motion.INTERVAL);
				var acc:Number = 2 * (endValue - startValue) / Math.pow(during, 2);
				// accelerated speed on x way
				var maxSpeed:Number = during * acc;
				var oneStep:Number = (endValue - startValue) / step;
				for (var i:Number = 1 ; i <= step ; i++)
				{
					var T:Number = i * Motion.INTERVAL;
					var powT:Number = Math.pow(T, 2);
					// t^2
					if (speedType == SPEED_UP)
					{
						steps.push(startValue + (acc * powT / 2));
						// s = (a * t^2) / 2
					}
					else if (speedType == SPEED_DOWN)
					{
						steps.push(startValue + maxSpeed * T + (-acc * powT / 2));
						// s = v0*t + (a * t^2) / 2
					}
					else
					{
						steps.push(startValue + i * oneStep);
					}
				}
				steps.push(endValue);
				stepList.push(steps);
			}
		}
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}
