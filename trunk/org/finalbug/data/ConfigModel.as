//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.data
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.events.LoadEvent;
	import org.finalbug.utils.StringUtil;
	
	
	/**
	 * ConfigModel
	 * Config fomat
	 * 
	 * #comment
	 * attrName=attrValue # will be saved in ConfigModel
	 * loadImage=imageName:imageURL # will be saved in BitmapPool
	 * loadRes=resName:resURL # use Loader to load, saved in ConfigModel's res
	 * loadTxt=txtName:txtURL # use URLLoader to load, saved in ConfigModel's txt
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class ConfigModel extends DataModel
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// SINGELTON
		//#######################################
		
		private static var instanceable:Boolean = false;
		private static var cm:ConfigModel;
		
		/**
		 * 
		 * @return 
		 */
		public static function get instance():ConfigModel
		{
			if(cm == null)
			{
				instanceable = true;
				cm = new ConfigModel();
				instanceable = false;
			}
			return cm;
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public var res:Dictionary = new Dictionary();
		/**
		 * 
		 * @default 
		 */
		public var txt:Dictionary = new Dictionary();
		
		private var loader:URLLoader;
		private var loadQueue:Array = new Array();
		private var attrs:Dictionary = new Dictionary();
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @throws DataError
		 */
		public function ConfigModel()
		{
			super();
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param URL
		 */
		public function loadConfig(URL:String):void
		{
			loadQueue = new Array();
			doLoad(URL);
		}
		
		/**
		 * 
		 * @param configName
		 * @return 
		 */
		public function getConfig(configName:String):Array
		{
			return attrs[configName];
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function doLoad(url:String):void
		{
			loader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, loadedHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
		}
		
		private function parseConfig(str:String):void
		{
			str = StringUtil.trim(str);
			str = str.replace(/\t/gi, "");
			str = str.replace(/(\n)+/gi, "\n"); 
			//
			var arr:Array = str.split("\n");
			var len:uint = arr.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				// line string:
				var s:String = StringUtil.trim(arr[i].toString());
				// if is comment of empty line;
				if(s.charAt(0) == "#" || s == "") continue;
				// remove ; fron end
				while(s.charAt(s.length - 1) == ";") s = s.substring(0, s.length - 1);
				//
				var index:uint = s.indexOf("=");
				var left:String = StringUtil.trim(s.substring(0, index));
				var right:String = StringUtil.trim(s.substring(index + 1));
				//
				if(left.toLowerCase() == "include")
				{
					loadQueue.push(right);
				}
				else
				{
					if(attrs[left] == null) attrs[left] = new Array();
					attrs[left].push(right);
				}
			}
		}
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function loadedHandler(e:Event):void
		{
			parseConfig(String(loader.data));
			if(loadQueue.length > 0)
			{
				doLoad(loadQueue.shift());
			}
			else
			{
				var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
				this.dispatchEvent(ee);
			}
		}
		
		private function loadErrorHandler(e:IOErrorEvent):void
		{
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			this.dispatchEvent(ee);
		}
	}
}
