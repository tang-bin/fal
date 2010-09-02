/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.glazes
{
	import fal.display.Glaze;
	import fal.events.LoadEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */
	public class Image extends Glaze
	{
		private var loader:Loader;
		private var url:String;
		private var setSizeAfterLoaded:Boolean = false;
		private var img:Bitmap;
		private var orgw:Number = 0;
		private var orgh:Number = 0;
		
		public function get originalWidth():Number
		{
			return orgw;
		}
		
		public function get originalHeight():Number
		{
			return orgh;
		}
		
		public function Image(url:String = "")
		{
			super();
			this.url = url;
			loadImg();
		}
		
		override protected function updateView():void
		{
			if(img == null)
			{
				setSizeAfterLoaded = true;
			}
			else
			{
				img.width = this.displayWidth;
				img.height = this.displayHeight;
			}
		}
		
		private function loadImg():void
		{
			if(url == "" || url == null)
			{
				url = "";
				if(img != null && this.contains(img))
				{
					this.removeChild(img);
					img = null;
				}
			}
			else
			{
				if(loader != null)
				{
					removeLoaderEvent();
				}
				loader = new Loader();
				loader.load(new URLRequest(url));
				addLoaderEvent();
			}
		}
		
		private function removeLoaderEvent():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadingHandler);
		}
		
		private function addLoaderEvent():void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadingHandler);
		}
		
		private function loadedHandler(e:Event):void
		{
			img = loader.content as Bitmap;
			orgw = img.width;
			orgh = img.height;
			if(setSizeAfterLoaded)
			{
				this.updateView();
			}
			this.addChild(img);
			setSizeAfterLoaded = false;
		}
		
		private function loadErrorHandler(e:IOErrorEvent):void
		{
			trace("load img error");
		}
		
		private function loadingHandler(e:ProgressEvent):void
		{
			
		}
	}
}