/******************************************
 * Finalbug ActionScript Library 
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.fal.data
{
	import org.finalbug.fal.events.DataEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
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
		private var dispatcher:EventDispatcher = new EventDispatcher();
		private var data:Object = new Object();
		private var modifyLogs:Array = new Array();
		
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
			if(this._parent != null)
			{
				this._parent.dispatchEvent(event);
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
						this.dispatchEvent(ee);
					}
					else
					{
						// error/
					}
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