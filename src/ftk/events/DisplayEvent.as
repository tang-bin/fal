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
	 * DisplayEvent
	 * 
	 * @author Tang Bin
	 * @since 2011
	 */
	public class DisplayEvent extends Event
	{
		/**
		 * 
		 * @eventType endZoom 
		 */
		public static const END_ZOOM:String = "endZoom";

		/**
		 * 
		 * @eventType endMove 
		 */
		public static const END_MOVE:String = "endMove";

		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function DisplayEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}