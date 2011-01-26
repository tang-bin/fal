// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.data
{
	import org.finalbug.events.DataEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;

	/**
	 * DataModel can be used as the base class for data objects.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class DataModel extends Proxy
	{

		// ******************* OVERRIDE *****************************
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

		// ******************* DEFINE *******************************
		private var dispatcher:EventDispatcher = new EventDispatcher();

		private var data:Object = new Object();

		// ******************* GETTER and SETTER ********************
		// ******************* CONSTRUCTOR **************************
		/**
		 * 
		 */
		public function DataModel()
		{
			super();
		}

		// ******************* PUBLIC *******************************
		/**
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false,
											priority:int = 0,
											useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String,
												listener:Function,
												useCapture:Boolean = false):void
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

		// ******************* PROTECTED ****************************
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
		// ******************* PRIVATE ******************************
		
		
		
		// ******************* HANDLER ******************************
	}
}