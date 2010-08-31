package fal.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * This class extends from Object directly and create some methods for sub class to invake easily.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 */
	public class AdvancedObject extends Object
	{
		protected var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function addEventListener(type:String,
										listener:Function,
										useCapture:Boolean = false,
										priority:int = 0,
										useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):void
		{
			this.dispatcher.dispatchEvent(event);
		}
	}
}