// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.utils.motion
{
	/**
	 * motion.SizeMotion
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class SizeMotion extends Motion
	{

		/******************* OVERRIDE **************************************************/
		override protected function count(target:Object):void
		{
			if (times >= 0)
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

		/******************* DEFINE ****************************************************/
		/**
		 * If widthFrom is not set, target's current width will be set as default. 
		 * 
		 * @default NaN
		 */
		public var widthFrom:Number;

		/**
		 * If heightFrom is not set, target's current height will be set as default.
		 * 
		 * @default NaN
		 */
		public var heightFrom:Number;

		/**
		 * If widthTo is not set, target's current width will be set as default
		 * 
		 * @default NaN
		 */
		public var widthTo:Number;

		/**
		 * If heightTo is not set, target's current height will be set as default.
		 * 
		 * @default NaN
		 */
		public var heightTo:Number;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new SizeMotion.
		 * 
		 * @param target The target object which will be resized.
		 */
		public function SizeMotion(target:Object = null)
		{
			super(target);
		}
		/******************* PUBLIC ****************************************************/
		
		
		
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}