////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.events
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		public static const SWITCH_VIEW:String = "switchView";
		public static const CLOSE_WIN:String = "closeWin";
		
		public var targetView:String = "";
		public var closeWithExecute:Boolean = false;
		
		public function UIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
		}
	}
}