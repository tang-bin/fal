/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.events
{
	import flash.events.Event;

	public class DataEvent extends Event
	{
		/**
		 * @eventType ChangeData
		 */		
		public static const CHANGE_DATA:String = "ChangeData";
		
		public var dataPath:String = "";
		public var dataName:String = "";
		public var oldData:*;
		public var newData:*;
		
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}