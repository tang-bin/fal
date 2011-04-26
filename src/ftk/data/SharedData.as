// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.data
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import ftk.errors.DataError;
	import ftk.events.DataEvent;


	/**
	 * <p>SharedData is a collection of number, string, boolean, SharedData, byteArray and TreeModel.</p>
	 * 
	 * <p>For sharedData object, there is a level value (int) for each event listener.
	 * When you call setData() method to set property of sharedData, 
	 * a DataEvent.CHANGE_DATA event may dispatched, 
	 * and you can set the dispatch level and type of this property.</p>
	 * 
	 * <p>The dispatch type and level works like this:</p>
	 * 
	 * <ul>
	 * <li>type = DispatchType.ALL: all listeners will be dispatched.</li>
	 * <li>type = DispatchType.SEFL: only the listeners whose level are the same as data will be dispatched.</li>
	 * <li>type = DispatchType.OTHERS: only the listeners whose level are NOT the same as data will be dispatched.</li>
	 * </ul>
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class SharedData extends Proxy
	{

		/******************* OVERRIDE **************************************************/
		/**
		 * Get property of sharedData object.
		 */
		override flash_proxy function getProperty(name:*):*
		{
			return data[name];
		}

		/**
		 * You CANNOT set property of SharedData object directly, please use setData() method.
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			throw new DataError(DataError.SET_SHARED_DATA_ERROR);
		}

		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			// nothing need to be done here.
		}

		/******************* DEFINE ****************************************************/
		// sharedData's parent.
		private var _parent:SharedData;

		// name of data.
		private var _name:String = "";

		// data contains all properties of sharedData.
		private var data:Dictionary = new Dictionary();

		// dispatchers contains all event dispatchers for each property.
		private var dispatchers:Array = new Array();

		private var _cert:Certificate;

		private var _remotePath:String;

		/******************* GETTER and SETTER *****************************************/
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

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new sharedData object.
		 */
		public function SharedData()
		{
			super();
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Add new event listener to this shared data object.
		 * Different with other addEventListener(), this method has a argument named "level".
		 * With argument "level" you can define different level of listener.
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * @param level Define the level of the listener. One listener can be 
		 * 				added to different level. Default value is 1.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false, level:uint = 1):void
		{
			if (dispatchers[level] == null) dispatchers[level] = new EventDispatcher();
			(dispatchers[level] as EventDispatcher).addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * Remove a listener of the shared data object.
		 * Different with other addEventListener(), this method has a argument named "level".
		 * Remove listener from one level will not influence the listeners of other level.
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param level Removed level.
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
		 * @param level The setter's level, used with dispatchType. Default value is 1.
		 * @param dispatchType Can be DispatchType.ALL, DispatchType.SEFL and DispatchType.OTHERS.
		 * 					Default value is DispatchType.OTHERS.
		 * 					For All, this change will be dispatched to listeners at all leve.
		 * 					For SEFL, change will only be dispatched to the same level as parem "level".
		 * 					For OTHERS, change will be dispatched to all listeners except level "level".
		 */
		public function setData(name:String, value:*, level:uint = 1, dispatchType:String = "others"):void
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
				for (var i:uint = dispatchers.length ; --i >= 0 ; )
				{
					var dispatcher:EventDispatcher = dispatchers[i] as EventDispatcher;
					if (dispatcher != null)
					{
						if (dispatchType == DispatchType.ALL || (dispatchType == DispatchType.OTHERS && i != level) || (dispatchType == DispatchType.SELF && i == level))
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

		/**
		 * sync this sharedData with remote data.
		 * 
		 * @param cert Certificate object, used to connect and verify and data transfer.
		 * @param path Remote data path.
		 */
		public function startSync(cert:Certificate, path:String):void
		{
			this._cert = cert;
			this._remotePath = path;
		}

		/**
		 * stop sync with remote data.
		 */
		public function stopSync():void
		{
			if (this._cert != null)
			{
			}
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
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

		private function getRoot():SharedData
		{
			var sd:SharedData = this;
			while (sd.parent != null)
			{
				sd = sd.parent;
			}
			return sd;
		}
		/******************* PRIVATE ***************************************************/
	}
}
