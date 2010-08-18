package fas.ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class Image extends UIObject
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
		
		override public function resize() : void
		{
			super.resize();
			if(img == null)
			{
				setSizeAfterLoaded = true;
			}
			else
			{
				img.width = this.width;
				img.height = this.height;
			}
		}
		
		public function Image(url:String = "")
		{
			super();
			this.uiName = "Image";
			this.url = url;
			loadImg();
		}
		
		private function loadImg():void
		{
			if(url == "" || url == null)
			{
				url = "";
				if(img != null)
				{
					if(this.contains(img))
					{
						this.removeChild(img);
					}
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
				img.width = this.width;
				img.height = this.height;
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