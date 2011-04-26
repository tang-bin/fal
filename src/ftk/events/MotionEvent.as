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
package ftk.events
{
	import flash.events.Event;
	import ftk.utils.motion.Motion;


	/**
	 * Event class for Class Move.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class MotionEvent extends Event
	{

		/**
		 * Trigger handler when moving object.
		 * 
		 * @eventType motionRunning
		 */
		public static const MOTION_RUNNING:String = "motionRunning";

		/**
		 * Trigger handler when a move is done.
		 * 
		 * @eventType motionStop
		 */
		public static const MOTION_STOP:String = "motionStop";

		/**
		 * Trigger handler when start a move.
		 * 
		 * @eventType motionStart
		 */
		public static const MOTION_START:String = "motionStart";

		/**
		 * move object.
		 */
		public var motionTarget:*;

		/**
		 * 
		 * @default 
		 */
		public var motion:Motion;

		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function MotionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
