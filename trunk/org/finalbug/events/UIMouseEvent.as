//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.events
{
	import flash.events.Event;

	/**
	 * Class FOSUIEvent defined events which will be dispatched by FOS UI Components.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class UIMouseEvent extends Event
	{
		/**
		 * 
		 * @default 
		 */
		public static const FE_CLICK:String = "feClick";
		/**
		 * 
		 * @default 
		 */
		public static const FE_PRESS:String = "fePress";
		/**
		 * 
		 * @default 
		 */
		public static const FE_RELEASE_OUTSIDE:String = "feReleaseOutside";
		
		/**
		 * 
		 * @default 
		 */
		public static const FE_START_DRAG:String = "feStartDrag";
		/**
		 * 
		 * @default 
		 */
		public static const FE_DRAGING:String = "feDraging";
		/**
		 * 
		 * @default 
		 */
		public static const FE_STOP_DRAG:String = "feStopDrag";
		
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
		public function UIMouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
