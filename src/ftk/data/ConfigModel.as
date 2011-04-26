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
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import ftk.errors.DataError;
	import ftk.events.LoadEvent;
	import ftk.utils.StringUtil;

	/**
	 * Dispatched when load config file success.
	 * 
	 * @eventType ftk.event.LoadEvent.LOAD_SUCCESS
	 */
	[Event(name="loadSuccess", type="ftk.events.LoadEvent")]
	/**
	 * Dispatched when load config file failed.
	 * 
	 * @eventType ftk.event.LoadEvent.LOAD_FAILED
	 */
	[Event(name="loadFailed", type="ftk.events.LoadEvent")]
	/**
	 * Dispatched when loading config file.
	 * 
	 * @eventType ftk.event.LoadEvent.LOADING
	 */
	[Event(name="loading", type="ftk.events.LoadEvent")]
	/**
	 * <p>ConfigModel (as singleton) is used to load and keep config attributes.
	 * Config file should be a text file, each line is one attribute.
	 * The line format should like this:</p>
	 * 
	 * <table>
	 * <tr>
	 * <td>#comment</td>
	 * <td>line start with # is a comment line</td>
	 * </tr>
	 * <tr>
	 * <td><em>attrName</em>=<em>attrValue</em></td>
	 * <td>will be saved in ConfigModel as name is attrName and value is attrValue</td>
	 * </tr>
	 * <tr>
	 * <td><strong>include</strong>=<em>other config file URL</em></td>
	 * <td>include other config files which will be loaded too.</td>
	 * </tr>
	 * <tr>
	 * <td><strong>loadImage</strong>=<em>imageName:imageURL</em></td>
	 * <td>will be loaded and saved in BitmapPool, 
	 * imageName is the name of the bitmap object.
	 * To load images automatically, please use AppInit object.</td>
	 * </tr>
	 * <tr>
	 * <td><strong>loadRes</strong>=<em>resName:resURL</em></td>
	 * <td>use Loader to load, saved in ConfigModel's res dictionary.
	 * To load res files automatically, please use AppInit object.</td>
	 * </tr>
	 * <tr>
	 * <td><strong>loadTxt</strong>=<em>txtName:txtURL</em></td>
	 * <td>Use URLLoader to load, saved in ConfigModel's txt dictionary.
	 * To load text files automatically, please use AppInit object.</td>
	 * </tr></table>
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 * @see ftk.net.BitmapPool
	 * @see ftk.data.AppInit
	 */
	public class ConfigModel extends DataModel
	{
		/**
		 * 
		 * @throws DataError
		 */
		public function ConfigModel()
		{
			super();
			if (!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
		}

		// SINGELTON
		private static var instanceable:Boolean = false;
		private static var cm:ConfigModel;

		/**
		 * 
		 * @return 
		 */
		public static function get instance():ConfigModel
		{
			if (cm == null)
			{
				instanceable = true;
				cm = new ConfigModel();
				instanceable = false;
			}
			return cm;
		}

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
			for (var i:uint = 0 ; i < len ; i++)
			{
				// line string:
				var s:String = StringUtil.trim(String(arr[i]));
				// if is comment of empty line;
				if (s.charAt(0) == "#" || s == "") continue;
				// remove ; fron end
				while (s.charAt(s.length - 1) == ";") s = s.substring(0, s.length - 1);
				//
				var index:uint = s.indexOf("=");
				var left:String = StringUtil.trim(s.substring(0, index));
				var right:String = StringUtil.trim(s.substring(index + 1));
				//
				if (left.toLowerCase() == "include")
				{
					loadQueue.push(right);
				}
				else
				{
					if (attrs[left] == null) attrs[left] = new Array();
					(attrs[left] as Array).push(right);
				}
			}
		}

		private function loadedHandler(e:Event):void
		{
			parseConfig(String(loader.data));
			if (loadQueue.length > 0)
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
