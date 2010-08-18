package fal.events
{
	import flash.events.Event;
	
	/**
	 * Event class for Class Move.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 * 
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
		public var moveObject:*;
		public var movedRate:Number;
		/**
		* move type.
		*/		
		public var moveType:String;
		
		public function MotionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}