package fas.utils
{
	import flash.events.EventDispatcher;
	
	public class StaticAdvancedObject
	{
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		public static function addEventListener(type:String,
										listener:Function,
										useCapture:Boolean = false,
										priority:int = 0,
										useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
	}
}