package org.finalbug.events
{
	import flash.events.Event;
	
	import org.finalbug.core.motion.Motion;
	
	/**
	 * Event class for Class Move.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)n	 */	
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
		public var motion:Motion;
		
		public function MotionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}