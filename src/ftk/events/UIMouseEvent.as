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
	 * Class UIMouseEvent defined events which will be dispatched by UI control 
	 * components with mouse event.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class UIMouseEvent extends Event
	{
		/**
		 * 
		 * @eventType mouseClick 
		 */
		public static const MOUSE_CLICK:String = "mouseClick";

		/**
		 * 
		 * @eventType mousePress
		 */
		public static const MOUSE_PRESS:String = "mousePress";

		/**
		 * 
		 * @eventType mouseReleaseOutside
		 */
		public static const MOUSE_RELEASE_OUTSIDE:String = "mouseReleaseOutside";

		/**
		 * 
		 * @eventType mouseStartDrag
		 */
		public static const MOUSE_START_DRAG:String = "mouseStartDrag";

		/**
		 * 
		 * @eventType mouseDraging
		 */
		public static const MOUSE_DRAGING:String = "mouseDraging";

		/**
		 * 
		 * @eventType mouseStopDrag
		 */
		public static const MOUSE_STOP_DRAG:String = "mouseStopDrag";

		/**
		 * 
		 * @default 
		 */
		public var targetStatus:String = "";

		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function UIMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
