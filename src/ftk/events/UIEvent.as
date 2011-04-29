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
	 * UIEvent
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class UIEvent extends Event
	{
		/**
		 * Trigger handler when scroll.
		 * 
		 * @eventType scroll
		 */
		public static const SCROLL:String = "scroll";

		/**
		 * 
		 * @eventType close 
		 */
		public static const CLOSE:String = "close";

		/**
		 * 
		 * @eventType hide 
		 */
		public static const HIDE:String = "hide";

		/**
		 * 
		 * @eventType resize 
		 */
		public static const RESIZE:String = "resize";

		/**
		 * 
		 * @default 
		 */
		public static const REPOSITION:String = "reposition";

		/**
		 * 
		 * @eventType switchTarget 
		 */
		public static const SWITCH_TARGET:String = "switchTarget";

		/**
		 * 
		 * @eventType childrenChanged 
		 */
		public static const CHILDREN_CHANGED:String = "childrenChanged";

		/**
		 * 
		 * @default 
		 */
		public static const CHILDREN_RESIZE:String = "childrenResize";

		/**
		 * 
		 * @default 
		 */
		public static const CHILDREN_REPOSITION:String = "childrenReposition";

		public static const CHANGE:String = "change";

		public var closeTarget:*;

		public var selectedIndex:uint;

		public var selectedID:uint;

		public var oldTarget:*;

		public var newTarget:*;

		/**
		 * current position / total length.
		 */
		public var position:Number = 0;

		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function UIEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}