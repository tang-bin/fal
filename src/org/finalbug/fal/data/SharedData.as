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
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import org.finalbug.fal.errors.DataError;
	import org.finalbug.fal.events.DataEvent;

	/**
	 * <p>SharedData is a collection of number, string, boolean, SharedData, byteArray and TreeModel.</p>
	 * 
	 * <p>For sharedData object, there is a level value (int) for each event listener.
	 * When you call setData() method to set property of sharedData, 
	 * a DataEvent.CHANGE_DATA event may dispatched, 
	 * and you can set the dispatch level and type of this property.</p>
	 * 
	 * @author		Tang Bin
	 * @since		2012.12-1
	 */
	public class SharedData extends Proxy
	{
		/**
		 * Create an new sharedData object.
		 */
		public function SharedData()
		{
			super();
		}

		/**
		 * Get property of sharedData object.
		 */
		override flash_proxy function getProperty(name:*):*
		{
			return data[name];
		}

		override flash_proxy function setProperty(name:*, value:*):void
		{
			this.setData(name, value);
		}

		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			// nothing need to be done here.
		}

		// sharedData's parent.
		private var _parent:SharedData;

		// name of data.
		private var _name:String = "";

		// data contains all properties of sharedData.
		private var data:Dictionary = new Dictionary();

		// dispatchers contains all event dispatchers for each property.
		private var eventDispatcher:EventDispatcher = new EventDispatcher();

		private var _remotePath:String;

		/**
		 * SharedData object's parent.
		 */
		public function get parent():SharedData
		{
			return _parent;
		}

		public function set parent(value:SharedData):void
		{
			_parent = value;
		}

		/**
		 * Name of sharedData object.
		 */
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		/**
		 * Convert the data between SharedData format and ByteArray format.
		 * NOT finished.
		 */
		public function get byteArray():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			// TODO: create byteArray by sharedData.
			return ba;
		}

		public function set byteArray(value:ByteArray):void
		{
			// TODO: set shareData by byteArray
		}

		/**
		 * Path of sharedData object.
		 * e.g, suppose A, B, C all are sharedData objects, and D is a number value, 
		 * B is a property of A, C is a property of B and D is a property of C.
		 * you can get D by "A.B.C.D", and the path string of d is "A/B/C/D".
		 */
		public function get path():String
		{
			var sd:SharedData = this;
			var path:String = "";
			while (sd != null && sd.name != "")
			{
				path = sd.name + "/" + path;
				sd = sd.parent;
			}
			return path;
		}

		/**
		 * Add new event listener to this shared data object.
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * Remove a listener of the shared data object.
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * Set a data of shared data object.
		 * name and value are limited to number, string, boolean, bytearray, treeModel and sharedData only.
		 * 
		 * @param name The name of shared data.
		 * @param value Value of shared data.
		 */
		private function setData(name:String, value:*):void
		{
			if (checkData(value) && data[name] != value)
			{
				// create event first.
				var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
				ee.dataName = name;
				ee.oldData = data[name];
				ee.newData = value;
				ee.dataPath = this.path + name;
				// save data
				data[name] = value;
				// save parent and name of sharedData.
				if (value is SharedData)
				{
					(value as SharedData).parent = this;
					(value as SharedData).name = name;
				}
				// dispatch event, if level matches.
				eventDispatcher.dispatchEvent(ee);
			}
			else
			{
				throw new DataError(DataError.SHARED_DATA_TYPE_ERROR);
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function toString():String
		{
			return "[SharedData " + _name + "]";
		}

		/**
		 * Get data by path string.
		 * 
		 * @param path
		 * @param fromRoot Default false. If true, the path will be base on the root sharedData object
		 * 					If false, the path will base on current sharedData object.
		 * @return 
		 */
		public function getData(path:String, fromRoot:Boolean = false):*
		{
			var getArr:Array = path.split("/");
			var len:uint = getArr.length;
			var sd:SharedData = fromRoot ? getRoot() : this;
			var data:Object;
			for (var i:uint = 0 ; i < len ; i++)
			{
				var dataName:String = getArr[i];
				if (dataName != null && dataName != "")
				{
					data = sd[dataName];
					if (i == len - 1)
					{
						return data;
					}
					else if (data is SharedData)
					{
						sd = data as SharedData;
					}
					else
					{
						return null;
					}
				}
			}
			return null;
		}

		private function checkData(data:*):Boolean
		{
			if (data is Number || 
				data is String || 
				data is Boolean || 
				data is ByteArray || 
				data is SharedData || 
				data is TreeData)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		private function getRoot():SharedData
		{
			var sd:SharedData = this;
			while (sd.parent != null)
			{
				sd = sd.parent;
			}
			return sd;
		}
	}
}
