package fas.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/******************************************
	 * Finalbug's ActionScript ( http://www.finalbug.org/ )
	 * 
	 * fas.data.DataModel
	 *
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since Aug 7, 2010 7:08:33 PM
	 *
	 *****************************************/
	public class DataModel
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		protected var dispatcher:EventDispatcher = new EventDispatcher();
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * fas.data.DataModel constructor.
		 ****************************************/
		public function DataModel()
		{
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
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
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}