/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************************/
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
		 * @default 
		 */
		public static const GET_DATE:String = "getData";
		
		/**
		 * 
		 * @default 
		 */
		public static const CONNECT_ERROR:String = "ConnectError";
		/**
		 * 
		 * @default 
		 */
		public static const CONNECT:String = "connect";
		/**
		 * 
		 * @default 
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