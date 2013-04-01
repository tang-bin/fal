////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;
	
	import org.finalbug.fal.events.DataEvent;

	[Event(name="ChangeData", type="org.finalbug.fal.events.DataEvent")]
	
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