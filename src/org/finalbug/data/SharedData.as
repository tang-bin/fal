// ##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__|     |__|___|__(______/____/_____/____/\___  /
// /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
// ##########################################################
package org.finalbug.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import org.finalbug.errors.DataError;
	import org.finalbug.events.DataEvent;

	/**
	 * SharedData is a collection of data which type is one of number, string, boolean,
	 * SharedData, byteArray and TreeModel.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	dynamic public class SharedData extends Proxy
	{
		// #######################################
		// OVERRIDE
		// #######################################
		override flash_proxy function getProperty(name:*):*
		{
			return data[name];
		}

		override flash_proxy function setProperty(name:*, value:*):void
		{
			throw new DataError(DataError.SET_SHARED_DATA_ERROR);
		}

		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			// nothing need to be done here.
		}

		// #######################################
		// DEFINE
		// #######################################
		private var _parent:SharedData;
		private var _name:String = "";
		private var data:Dictionary = new Dictionary();
		private var modifyLogs:Array = new Array();
		private var dispatchers:Array = new Array();

		// #######################################
		// GETTER and SETTER
		// #######################################
		/**
		 * 
		 * @return 
		 */
		public function get parent():SharedData
		{
			return _parent;
		}

		/**
		 * 
		 * @param value
		 */
		public function set parent(value:SharedData):void
		{
			_parent = value;
		}

		/**
		 * 
		 * @return 
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * 
		 * @param value
		 */
		public function set name(value:String):void
		{
			_name = value;
		}

		/**
		 * 
		 * @return 
		 */
		public function get byteArray():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			// create byteArray by sharedData.
			return ba;
		}

		/**
		 * 
		 * @param value
		 */
		public function set byteArray(value:ByteArray):void
		{
			// TODO : set shareData by byteArray
		}

		// #######################################
		// CONSTRUCTOR
		// #######################################
		/**
		 * 
		 */
		public function SharedData()
		{
		}

		// #######################################
		// PUBLIC
		// #######################################
		/**
		 * add new event listener to this shared data object.
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * @param level Define the level of the listener. One listener can be 
		 * 				added to different level.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false, level:uint = 1):void
		{
			if (dispatchers[level] == null) dispatchers[level] = new EventDispatcher();
			(dispatchers[level] as EventDispatcher).addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * Remove a listener of the shared data object.
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param level Remove level.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false, level:uint = 1):void
		{
			if (dispatchers[level] != null)
			{
				(dispatchers[level] as EventDispatcher).removeEventListener(type, listener, useCapture);
			}
		}

		/**
		 * Set a data of shared data object.
		 * name and value are limited to number, string, boolean, bytearray, treeModel and sharedData only.
		 * 
		 * @param name The name of shared data.
		 * @param value Value of shared data.
		 * @param level The setter's level, used with dispatchType.
		 * @param dispatchType Can be DispatchType.ALL, DispatchType.SEFL and DispatchType.OTHERS.
		 * 					For All, this change will be dispatched to listeners at all leve.
		 * 					For SEFL, change will only be dispatched to the same level as parem "level".
		 * 					For OTHERS, change will be dispatched to all listeners except level "level".
		 */
		public function setData(name:*, value:*, level:uint = 1, dispatchType:String = "others"):void
		{
			if (checkData(name) && checkData(value))
			{
				// create event first.
				var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
				ee.dataName = name;
				ee.oldData = data[name];
				ee.newData = value;
				ee.dataPath = this.getPath() + name.toString();
				// save data
				data[name] = value;
				if (value is SharedData)
				{
					(value as SharedData).parent = this;
					(value as SharedData).name = name.toString();
				}
				// dispatch event
				for (var i:uint = dispatchers.length ; --i >= 0 ; )
				{
					var dispatcher:EventDispatcher = dispatchers[i] as EventDispatcher;
					if (dispatcher != null)
					{
						if (dispatchType == DispatchType.ALL)
						{
							dispatcher.dispatchEvent(ee);
						}
						else if (dispatchType == DispatchType.OTHERS && i != level)
						{
							dispatcher.dispatchEvent(ee);
						}
						else if (dispatchType == DispatchType.SELF && i == level)
						{
							dispatcher.dispatchEvent(ee);
						}
					}
				}
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
		 * 
		 * @return 
		 */
		public function getPath():String
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
		 * 
		 * @param path
		 * @return 
		 */
		public function getData(path:String):*
		{
			var getArr:Array = path.split("/");
			var len:uint = getArr.length;
			var sd:SharedData = this;
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

		// #######################################
		// PROTECTED
		// #######################################
		// #######################################
		// PRIVATE
		// #######################################
		private function dispatchEvent(event:Event):void
		{
			this.dispatcher.dispatchEvent(event);
			if (this._parent != null)
			{
				this._parent.dispatchEvent(event);
			}
		}

		private function checkData(data:*):Boolean
		{
			if (data is Number || data is String || data is Boolean || data is ByteArray || data is SharedData || data is TreeData)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		// #######################################
		// HANDLER
		// #######################################
	}
}
