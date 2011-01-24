//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.events
{
	import flash.events.Event;
	
	/**
	 * ConnEvent
	 * 
	 * @author Tang Bin
	 * @since 2010.8
	 */	
	public class ConnEvent extends Event
	{
		/**
		 * 
		 * @eventType getData 
		 */
		public static const GET_DATE:String = "getData";
		
		/**
		 * 
		 * @eventType connectError 
		 */
		public static const CONNECT_ERROR:String = "connectError";
		/**
		 * 
		 * @eventType connect 
		 */
		public static const CONNECT:String = "connect";
		/**
		 * 
		 * @connectError connectClose 
		 */
		public static const CONNECT_CLOSE:String = "connectClose";
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function ConnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}