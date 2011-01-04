//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.glazes
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import org.finalbug.events.LoadEvent;
	import org.finalbug.ui.Glaze;
	
	/**
	 * @author Tang Bin
	 * @since old version
	 */
	public class Image extends Glaze
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		override protected function updateView():void
		{
			if(img != null && this.contains(img))
			{
				img.width = this.displayWidth;
				img.height = this.displayHeight;
			}
		}
		
		override public function resize(width:Number, height:Number):void
		{
			this.useFixedSize = true;
			super.resize(width, height);
		}
		
		override public function set width(value:Number):void
		{
			this.useFixedSize = true;
			super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			this.useFixedSize = true;
			super.height = value;
		}
		
		override public function get scale9Grid():Rectangle
		{
			return scale9;
		}
		override public function set scale9Grid(innerRectangle:Rectangle):void
		{
			scale9 = innerRectangle;
			if(img != null && this.contains(img))
			{
				img.scale9Grid = scale9;
			}
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public var useFixedSize:Boolean = false;
		
		private var loader:Loader;
		private var _url:String;
		private var bitmapData:BitmapData;
		private var img:Scale9Bitmap;
		private var orgw:Number = 0;
		private var orgh:Number = 0;
		private var scale9:Rectangle;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get originalWidth():Number
		{
			return orgw;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get originalHeight():Number
		{
			return orgh;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get bitmap():Bitmap
		{
			return img;
		}
		
		/**
		 * 
		 * @param data
		 */
		public function set bitmap(data:Bitmap):void
		{
			var newBD:BitmapData = data.bitmapData;
			if(newBD != bitmapData)
			{
				bitmapData = newBD.clone();
				this.addImg();
			}
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @param url
		 */
		public function Image(url:String = "")
		{
			super();
			loadImg(url);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param obj
		 */
		public function setImage(obj:DisplayObject):void
		{
			_url = "";
			//
			var bd:BitmapData = new BitmapData(obj.width, obj.height, true, 0x00FFFFFF);
			bd.draw(obj, null, null, null, null, true);
			this.bitmap = new Bitmap(bd);
		}
		
		/**
		 * 
		 * @param url
		 */
		public function loadImg(url:String = ""):void
		{
			_url = url;
			if(_url == "" || _url == null)
			{
				_url = "";
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
				loader.load(new URLRequest(_url));
				addLoaderEvent();
			}
		}
		
		/**
		 * 
		 * @return 
		 */
		public function clone():Image
		{
			var newImg:Image = new Image();
			newImg._url = this._url;
			newImg.bitmapData = this.bitmapData;
			newImg.displayWidth = this.displayWidth;
			newImg.displayHeight = this.displayHeight;
			newImg.addImg();
			return newImg;
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
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
			orgw = bitmapData.width;
			orgh = bitmapData.height;
			if(!useFixedSize)
			{
				this.displayWidth = orgw;
				this.displayHeight = orgh;
			}
			//
			if(img != null && this.contains(img))
			{
				this.removeChild(img);
			}
			//
			if(scale9 == null) scale9 = new Rectangle(0, 0, orgw, orgh);
			img = new Scale9Bitmap(new Bitmap(this.bitmapData), scale9);
			this.addChild(img);
			//
			this.updateView();
		}
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function loadedHandler(e:Event):void
		{
			this.bitmapData = (loader.content as Bitmap).bitmapData;
			addImg();
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			this.dispatchEvent(ee);
		}
		
		private function loadErrorHandler(e:IOErrorEvent):void
		{
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			this.dispatchEvent(ee);
		}
		
		private function loadingHandler(e:ProgressEvent):void
		{
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			ee.bytesLoaded = e.bytesLoaded;
			ee.bytesTotal = e.bytesTotal;
			ee.loadedRate = ee.bytesLoaded / ee.bytesTotal;
			this.dispatchEvent(ee);
		}
	}
}