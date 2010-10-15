/******************************************
 * [fb-aslib] Finalbug ActionScript Library 
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.events.DataEvent;
	
	/**
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	dynamic public class SharedData extends Proxy
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		private var _parent:SharedData;
		private var _name:String = "";
		private var data:Object = new Object();
		private var modifyLogs:Array = new Array();
		private var dispatchers:Array = new Array();
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * org.finalbug.fal.data.SharedData constructor.
		 ****************************************/
		public function SharedData(){}
		
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
										 useWeakReference:Boolean = false,
										 level:uint = 1):void
		{
			if(dispatchers[level] == null) dispatchers[level] = new EventDispatcher();
			(dispatchers[level] as EventDispatcher).addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false,
											level:uint = 1):void
		{
			if(dispatchers[level] != null)
			{
				(dispatchers[level] as EventDispatcher).removeEventListener(type, listener, useCapture);
			}
		}
		
		public function dispatchEvent(event:Event):void
		{
			this.dispatcher.dispatchEvent(event);
			if(this._parent != null)
			{
				this._parent.dispatchEvent(event);
			}
		}
		
		public function setData(name:*, value:*, level:uint = 1, dispatchType:String = "others"):void
		{
			if(checkData(value))
			{
				// create event first.
				var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
				ee.dataName = name;
				ee.oldData = data[name];
				ee.newData = value;
				ee.dataPath = this.getPath() + name.toString();
				// save data
				data[name] = value;
				if(value is SharedData)
				{
					(value as SharedData).parent = this;
					(value as SharedData).name = name.toString();
				}
				// dispatch event
				for(var i:uint = dispatchers.length ; --i >= 0 ; )
				{
					var dispatcher:EventDispatcher = dispatchers[i] as EventDispatcher;
					if(dispatcher != null)
					{
						if(dispatchType == DispatchType.ALL)
						{
							dispatcher.dispatchEvent(ee);
						}
						else if(dispatchType == DispatchType.OTHERS && i != level)
						{
							dispatcher.dispatchEvent(ee);
						}
						else if(dispatchType == DispatchType.SELF && i == level)
						{
							dispatcher.dispatchEvent(ee);
						}
					}
				}
			}
			else
			{
				// error/
			}
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			switch(name.toString())
			{
				case "parent": return _parent;break;
				case "name": return _name;break;
				default: return data[name];
			}
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			switch(name.toString())
			{
				case "parent": _parent = value; break;
				case "name": _name = value.toString();break;
				default:
					throw new DataError(DataError.SET_SHARED_DATA_ERROR);
					break;
			}
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			switch(methodName.toString())
			{
				default:
					return "";
					break;
			}
		}
		
		public function toString():String
		{
			return "[SharedData " + _name + "]";
		}
		
		public function getPath():String
		{
			var sd:SharedData = this;
			var path:String = "";
			while(sd != null && sd.name != "")
			{
				path = sd.name + "/" + path;
				sd = sd.parent;
			}
			return path;
		}
		
		public function getData(path:String):*
		{
			var getArr:Array = path.split("/");
			var len:uint = getArr.length;
			var sd:SharedData = this;
			var data:Object;
			for(var i:uint = 0 ; i < len ; i++)
			{
				var dataName:String = getArr[i];
				if(dataName != null && dataName != "")
				{
					data = sd[dataName];
					if(i == len - 1)
					{
						return data;
					}
					else if(data is SharedData)
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
		
		public function createModifyByteArray(path:String, oldData:*, newData:*):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			return ba;
		}
		
		public function appendModify(data:ByteArray):void
		{
			
		}
		
		public function getByteArray():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			return ba;
		}
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		private function checkData(data:*):Boolean
		{
			if(data is uint ||
				data is Number ||
				data is String ||
				data is Boolean ||
				data is ByteArray ||
				data is SharedData)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}