/******************************************
 * [fb-aslib] Finalbug ActionScript Library ( http://www.finalbug.org/ )
 * 
 * org.finalbug.fal.events.UIEvent
 *
 * @author Tang Bin (tangbin@finalbug.org)
 * @since Jul 12, 2010 7:24:08 PM
 *
 *****************************************/
package org.finalbug.events
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		/**
		* Trigger handler when scroll.
		 * 
		 * @eventType scroll
		*/		
		public static const SCROLL:String = "scroll";
		
		public static const CLOSE:String = "close";
		public var closeTarget:*;
		
		public static const HIDE:String = "hide";
		
		public static const RESIZE:String = "resize";
		
		public static const SWITCH_TARGET:String = "switchTarget";
		public var oldTarget:*;
		public var newTarget:*;
		
		/**
		* current position / total length.
		*/		
		public var position:Number = 0;
		
		public function UIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}