// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.events
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
		public static const CONNECTED:String = "connect";

		public static const UNCONNECTED:String = "unconnected";

		/**
		 * 
		 * @connectError connectClose 
		 */
		public static const CONNECT_CLOSE:String = "connectClose";

		public static const VERIFIED:String = "verified";

		public static const UNVERIFIED:String = "unverified";

		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function ConnEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}