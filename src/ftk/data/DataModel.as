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
package ftk.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;

	import ftk.events.DataEvent;

	/**
	 * DataModel can be used as the base class for data objects.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class DataModel extends Proxy
	{
		/**
		 * 
		 */
		public function DataModel()
		{
			super();
		}

		override flash_proxy function getProperty(name:*):*
		{
			return data[name];
		}

		override flash_proxy function setProperty(name:*, value:*):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			ee.oldData = data[name];
			ee.newData = value;
			data[name] = value;
			this.dispatchEvent(ee);
		}

		private var dispatcher:EventDispatcher = new EventDispatcher();

		private var data:Object = new Object();

		/**
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * 
		 * @param event
		 */
		public function dispatchEvent(event:Event):void
		{
			this.dispatcher.dispatchEvent(event);
		}

		/**
		 * 
		 * @return 
		 */
		public function toString():String
		{
			return flash.utils.getQualifiedClassName(this);
		}

		/**
		 * Dispatch change data event.
		 * 
		 * @param name Name of data
		 * @param oldValue Data's old value
		 * @param newValue Data's new value.
		 */
		protected function dispatchChangeData(name:String, oldValue:*, newValue:*):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			ee.oldData = oldValue;
			ee.newData = newValue;
			ee.dataName = name;
			this.dispatchEvent(ee);
		}
	}
}