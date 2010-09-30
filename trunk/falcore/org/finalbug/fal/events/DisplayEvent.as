/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.fal.events
{
	import flash.events.Event;
	
	public class DisplayEvent extends Event
	{
		public static const END_ZOOM:String = "endZoom";
		
		public static const END_MOVE:String = "endMove";
		
		public function DisplayEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}