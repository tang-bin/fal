package fal.events
{
	import flash.events.Event;
	
	/**
	 * Event class for UI component that is changing style.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class UIStyleEvent extends Event
	{
		/**
		* Trigger handler when style is changed.
		 * 
		 * @eventType changeStyle
		*/		
		public static const CHANGE:String = "changeStyle";
		
		public function UIStyleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}