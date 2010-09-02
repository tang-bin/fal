 package fal.events
{
	import flash.events.Event;

	public class DataEvent extends Event
	{
		/**
		 * @eventType FOSChangeData
		 */		
		public static const CHANGE_DATA:String = "FOSChangeData";
		
		public var dataName:String = "";
		public var oldData:*;
		public var newData:*;
		
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}