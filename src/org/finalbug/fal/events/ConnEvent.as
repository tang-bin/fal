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
	
	public class ConnEvent extends Event
	{
		public static const CONN_SUCCESS:String = "connSuccess";
		public static const CONN_FAILED:String = "connFailed";
		public static const CONN_CLOSE:String = "connClose";
		
		public function ConnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
		}
	}
}