package org.finalbug.fal.events
{
	import flash.events.Event;
	
	import org.finalbug.fal.net.Protocol;

	public class ConnEvent extends Event
	{
		public static const GET_DATE:String = "getData";
		public var protocol:Protocol;
		
		public static const CONNECT_ERROR:String = "ConnectError";
		public static const CONNECT:String = "connect";
		public static const CONNECT_CLOSE:String = "connectClose";
		
		public function ConnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}