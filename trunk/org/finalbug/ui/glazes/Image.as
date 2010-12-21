/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.glazes
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import org.finalbug.ui.Glaze;
	import org.finalbug.events.LoadEvent;
	
	/**
	 * @author Tang Bin
	 * @since old version
	 */
	public class Image extends Glaze
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private var loader:Loader;
		private var url:String;
		private var setSizeAfterLoaded:Boolean = false;
		private var img:Bitmap;
		private var orgw:Number = 0;
		private var orgh:Number = 0;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get originalWidth():Number
		{
			return orgw;
		}
		
		public function get originalHeight():Number
		{
			return orgh;
		}
		
		public function get bitmap():Bitmap
		{
			return img;
		}
		
		public function set bitmap(data:Bitmap):void
		{
			if(data != img)
			{
				img = data;
				setSizeAfterLoaded = true;
				this.addImg();
			}
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function Image(url:String = "")
		{
			super();
			this.url = url;
			loadImg();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
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
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function setImage(obj:DisplayObject):void
		{
			var bd:BitmapData = new BitmapData(obj.width, obj.height, true, 0x00FFFFFF);
			bd.draw(obj, null, null, null, null, true);
			this.bitmap = new Bitmap(bd);
		}
		
		public function clone():Image
		{
			var newImg:Image = new Image();
			if(this.bitmap != null)
			{
				newImg.bitmap = new Bitmap(this.bitmap.bitmapData.clone());
			}
			newImg.width = this.displayWidth;
			newImg.height = this.displayHeight;
			return newImg;
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
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
		
		private function addImg():void
		{
			orgw = img.width;
			orgh = img.height;
			if(setSizeAfterLoaded)
			{
				this.updateView();
			}
			this.addChild(img);
			setSizeAfterLoaded = false;
		}
		
		//***************************************
		// HANDLER
		//***************************************
		
		private function loadedHandler(e:Event):void
		{
			img = loader.content as Bitmap;
			addImg();
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