/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.data
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.finalbug.events.DataEvent;
	import org.finalbug.events.LoadEvent;
	import org.finalbug.net.BitmapPool;
	
	/**
	 * AppInit
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class AppInit extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private var resList:Array;
		private var resTotalNum:uint;
		private var resLoader:Loader;
		
		private var txtList:Array;
		private var txtTotalNum:uint;
		private var txtLoader:URLLoader;
		
		private var currentLoadName:String;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function AppInit()
		{
			
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		public function start(configURL:String):void
		{
			dispatchChange("Loading Config...");
			//
			ConfigModel.instance.loadConfig(configURL);
			ConfigModel.instance.addEventListener(LoadEvent.LOAD_SUCCESS, loadedConfigHandler);
			ConfigModel.instance.addEventListener(LoadEvent.LOAD_FAILED, loadConfigErrorHandler);
		}
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
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
			if(res != null && res.length > 0)
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
			if(resList.length > 0)
			{
				dispatchChange("Loading res ..." + resList.length + " / " + resTotalNum);
				var str:String = resList.shift();
				var index:uint = str.indexOf(":");
				if(index == -1) loadRes();
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
			if(txt != null && txt.length > 0)
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
			if(txtList.length > 0)
			{
				dispatchChange("Loading txt ..." + txtList.length + " / " + txtTotalNum);
				var str:String = txtList.shift();
				var index:uint = str.indexOf(":");
				if(index == -1) loadTxt();
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
		
		//***************************************
		// HANDLER
		//***************************************/
		
		private function loadedConfigHandler(e:LoadEvent):void
		{
			dispatchChange("Loading image files...");
			var images:Array = ConfigModel.instance.getConfig("loadImage");
			if(images != null)
			{
				var len:uint = images.length;
				for(var i:uint = 0 ; i < len ; i++)
				{
					var str:String = images[i].toString();
					var index:uint = str.indexOf(":");
					if(index == -1) continue; // format error
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
			var numStr:String = e.loadedNum + "/" + e.totalNum
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