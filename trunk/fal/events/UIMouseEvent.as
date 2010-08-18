package fas.events
{
	import flash.events.Event;

	/**
	 * Class FOSUIEvent defined events which will be dispatched by FOS UI Components.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 * 
	 */	
	public class UIMouseEvent extends Event
	{
		public static const FE_CLICK:String = "feClick";
		public static const FE_PRESS:String = "fePress";
		public static const FE_RELEASE_OUTSIDE:String = "feReleaseOutside";
		
		public static const FE_START_DRAG:String = "feStartDrag";
		public static const FE_DRAGING:String = "feDraging";
		public static const FE_STOP_DRAG:String = "feStopDrag";
		
		public var targetStatus:String = "";
		
		public function UIMouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}