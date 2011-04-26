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
	 * motion.FadeMotion
	 *  
	 * @author Tang Bin
	 * @since old version
	 */
	public class FadeMotion extends Motion
	{

		/******************* OVERRIDE **************************************************/
		override protected function count(target:Object):void
		{
			if (times >= 0)
			{
				/* account x values */
				var a0:Number = isNaN(alphaFrom) ? target["alpha"] : alphaFrom;
				// alpha from
				var a1:Number = isNaN(alphaTo) ? target["alpha"] : alphaTo;
				// alpha to
				var aSteps:Array = repeatSteps(counter.count([a0], [a1], this.during)[0]);
				// register moting to runner.
				registeredMotions.push(MotionRunner.instance.register(target, "alpha", aSteps, this.times));
			}
		}

		/******************* DEFINE ****************************************************/
		/**
		 * 
		 * @default 
		 */
		public var alphaFrom:Number;

		/**
		 * 
		 * @default 
		 */
		public var alphaTo:Number;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 * @param target
		 */
		public function FadeMotion(target:Object = null)
		{
			super(target);
		}
		/******************* PUBLIC ****************************************************/
		
		
		
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}