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
package org.finalbug.events
{
	import flash.events.Event;
	
	import org.finalbug.utils.motion.Motion;
	
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
		 * @eventType moving
		*/		
		public static const MOTION_RUNNING:String = "motionRunning";
		/**
		* Trigger handler when a move is done.
		 * 
		 * @eventType stopMove
		*/		
		public static const MOTION_STOP:String = "motionStop";
		/**
		* Trigger handler when start a move.
		 * 
		 * @eventType startMove
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
