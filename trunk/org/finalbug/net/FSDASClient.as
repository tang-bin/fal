/******************************************
* [fb-aslib] Finalbug ActionScript Library
* http://www.finalbug.org/
******************************************/
package org.finalbug.net
{
	import flash.utils.Dictionary;
	
	import org.finalbug.core.data.SharedData;

	public class FSDASClient
	{
		private var datas:Dictionary = new Dictionary();
		
		public function FSDASClient()
		{
		}
		
		public function connect(host:String, port:uint):void
		{
			
		}
		
		public function close():void
		{
			
		}
		
		public function listenData(path:String, verification:Array = null):SharedData
		{
			if(datas[path] != null)
			{
				return null;
			}
			else
			{
				var sd:SharedData = new SharedData();
				// TODO: send request
				//
				return sd;
			}
		}
		
		public function stopListenData(path:String):void
		{
			
		}
	}
}