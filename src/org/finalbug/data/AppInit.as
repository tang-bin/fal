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
	import org.finalbug.events.LoadEvent;
	import org.finalbug.net.BitmapPool;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * Dispatched when loading status is changed.
	 * Current loading status is contains in DataEvent.status.
	 * 
	 * @eventType org.finalbug.events.DataEvent.CHANGE_DATA
	 */
	[Event(name="changeData", type="org.finalbug.events.DataEvent")]
	
	/**
	 * Dispatched when init success.
	 * After initialize success, AppInit object not longer useful, you can remove
	 * and delete it. All attributes and loaded objects are in the ConfigModel and 
	 * BitmapPool.
	 * 
	 * @eventType org.finalbug.event.DataEvent.INIT_END 
	 */
	[Event(name="initEnd", type="org.finalbug.events.DataEvent")]
	
	/**
	 * <p>AppInit is used to initialize an appliction, such as load config files and 
	 * images, swf files and text files. 
	 * To use this class, you must define at least one config files.</p>
	 * 
	 * <p>AppInit does following items in order:</p>
	 * <ul>
	 * <li>1, load config files and save attributes into <code>ConfigModel</code> (as singleton). 
	 * if config files include other config files, load them too.</li>
	 * <li>2, If config contains images, load all images and save into <code>BitmapPool</code> (as singleton).</li>
	 * <li>3, If config contains swf files, load them all and save into <code>ConfigModel</code>'s res object.</li>
	 * <li>4, If config contains text files, load them all and save into <code>ConfigModel</code>'s txt object.</li>
	 * </ul>
	 * <p>Please check <code>ConfigModel</code> for the format of config file.</p>
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 * @see org.finalbug.data.ConfigModel
	 * @see org.finalbug.net.BitmapPool
	 */
	public class AppInit extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		private var resList:Array;

		private var resTotalNum:uint;

		private var resLoader:Loader;

		private var txtList:Array;

		private var txtTotalNum:uint;

		private var txtLoader:URLLoader;

		private var currentLoadName:String;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new AppInit object.
		 */
		public function AppInit()
		{
			super();
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Start load confile file.
		 * 
		 * @param configURL URL of config file.
		 */
		public function start(configURL:String):void
		{
			dispatchChange("Loading Config...");
			//
			ConfigModel.instance.loadConfig(configURL);
			ConfigModel.instance.addEventListener(LoadEvent.LOAD_SUCCESS, loadedConfigHandler);
			ConfigModel.instance.addEventListener(LoadEvent.LOAD_FAILED, loadConfigErrorHandler);
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function dispatchChange(str:String):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			ee.dataStatus = str;
			this.dispatchEvent(ee);
		}

		private function startLoadRes():void
		{
			dispatchChange("Loading res ...");
			var res:Array = ConfigModel.instance.getConfig("loadRes");
			if (res != null && res.length > 0)
			{
				resList = res;
				resTotalNum = res.length;
				loadRes();
			}
			else
			{
				startLoadTxt();
			}
		}

		private function loadRes():void
		{
			if (resList.length > 0)
			{
				dispatchChange("Loading res ..." + resList.length + " / " + resTotalNum);
				var str:String = resList.shift();
				var index:uint = str.indexOf(":");
				if (index == -1) loadRes();
				currentLoadName = str.substring(0, index).toString();
				var resURL:String = str.substring(index + 1).toString();
				//
				resLoader = new Loader();
				resLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedResHandler);
				resLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadResErrorHandler);
				resLoader.load(new URLRequest(resURL));
			}
			else
			{
				startLoadTxt();
			}
		}

		private function startLoadTxt():void
		{
			dispatchChange("Loading txt ...");
			var txt:Array = ConfigModel.instance.getConfig("loadTxt");
			if (txt != null && txt.length > 0)
			{
				txtList = txt;
				txtTotalNum = txt.length;
				loadTxt();
			}
			else
			{
				initEnd();
			}
		}

		private function loadTxt():void
		{
			if (txtList.length > 0)
			{
				dispatchChange("Loading txt ..." + txtList.length + " / " + txtTotalNum);
				var str:String = txtList.shift();
				var index:uint = str.indexOf(":");
				if (index == -1) loadTxt();
				currentLoadName = str.substring(0, index).toString();
				var txtURL:String = str.substring(index + 1).toString();
				//
				txtLoader = new URLLoader(new URLRequest(txtURL));
				txtLoader.addEventListener(Event.COMPLETE, loadedTxtHandler);
				txtLoader.addEventListener(IOErrorEvent.IO_ERROR, loadTxtErrorHandler);
			}
			else
			{
				initEnd();
			}
		}

		private function initEnd():void
		{
			dispatchChange("Init End");
			var ee:DataEvent = new DataEvent(DataEvent.INIT_END);
			this.dispatchEvent(ee);
		}

		/******************* PRIVATE ***************************************************/
		private function loadedConfigHandler(e:LoadEvent):void
		{
			dispatchChange("Loading image files...");
			var images:Array = ConfigModel.instance.getConfig("loadImage");
			if (images != null)
			{
				var len:uint = images.length;
				for (var i:uint = 0 ; i < len ; i++)
				{
					var str:String = images[i] as String;
					var index:uint = str.indexOf(":");
					if (index == -1) continue;
					// format error
					var name:String = str.substring(0, index);
					var url:String = str.substring(index + 1);
					BitmapPool.instance.addBitmap(name, url);
				}
				BitmapPool.instance.startLoad();
				BitmapPool.instance.addEventListener(LoadEvent.LOAD_SUCCESS, loadBitmapHandler);
				BitmapPool.instance.addEventListener(LoadEvent.LOAD_FAILED, loadBitmapErrorHandler);
				BitmapPool.instance.addEventListener(LoadEvent.LOADING, loadingBitmapHandler);
			}
			else
			{
				startLoadRes();
			}
		}

		private function loadConfigErrorHandler(e:LoadEvent):void
		{
			dispatchChange("Loading config failed.");
		}

		private function loadBitmapHandler(e:LoadEvent):void
		{
			startLoadRes();
		}

		private function loadBitmapErrorHandler(e:LoadEvent):void
		{
			dispatchChange("Loading image files failed.");
		}

		private function loadingBitmapHandler(e:LoadEvent):void
		{
			var numStr:String = e.loadedNum + "/" + e.totalNum;
			dispatchChange("Loading image files..." + numStr);
		}

		private function loadedResHandler(e:Event):void
		{
			ConfigModel.instance.res[currentLoadName] = resLoader.content;
			loadRes();
		}

		private function loadResErrorHandler(e:IOErrorEvent):void
		{
			dispatchChange("Loading res failed.");
		}

		private function loadedTxtHandler(e:Event):void
		{
			ConfigModel.instance.txt[currentLoadName] = txtLoader.data;
			loadTxt();
		}

		private function loadTxtErrorHandler(e:IOErrorEvent):void
		{
			dispatchChange("Loading txt failed.");
		}
	}
}
