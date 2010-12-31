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
package org.finalbug.ui.skin
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import org.finalbug.data.Status;
	import org.finalbug.ui.Glaze;
	import org.finalbug.ui.glazes.Scale9Bitmap;
	import org.finalbug.ui.style.FillStyle;
	
	
	/**
	 * SkinElement is a display element to show skin.
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class SkinElement extends Glaze
	{
		//#######################################
		// DEFINE
		//#######################################
		
		private var skinList:Dictionary = new Dictionary();
		
		private var currentStatus:String;
		
		private var skinChanged:Boolean = false;
		
		private var _autoMouseEvent:Boolean = false;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get status():String
		{
			return currentStatus;
		}
		/**
		 * 
		 * @param value
		 */
		public function set status(value:String):void
		{
			if(value != "" && value != currentStatus && skinList[value] != null)
			{
				currentStatus = value;
				skinChanged = true;
				updateView();
			}
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get autoMouseEvent():Boolean
		{
			return _autoMouseEvent;
		}
		/**
		 * 
		 * @param value
		 */
		public function set autoMouseEvent(value:Boolean):void
		{
			if(value != _autoMouseEvent)
			{
				_autoMouseEvent = value;
				if(_autoMouseEvent)
				{
					setMouseEvent();
				}
				else
				{
					removeMouseEvent();
				}
			}
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function SkinElement()
		{
			super();
		}
		
		//#######################################
		// OVERRIDE
		// Whit out getter, setter and handler
		// include public, protected and private.
		//#######################################
		
		override protected function updateView():void
		{
			this.graphics.clear();
			// remove skin if is changed.
			if(skinChanged) this.removeAll();
			//
			var data:SkinElementData = skinList[currentStatus] as SkinElementData;
			if(data != null)
			{
				var rect:Rectangle = data.scale9;
				// set view start
				if(data.type == SkinElementData.FILL_TYPE)
				{
					// fill type, just fill it!
					this.fillStyle = data.data as FillStyle;
				}
				else if(data.type == SkinElementData.VECTORIAL_TYPE)
				{
					// vectogram type, use displayobject directly.
					var obj:DisplayObject;
					if(skinChanged)
					{
						// add skin if is changed.
						obj = data.data as DisplayObject
						if(obj != null)
						{
							if(rect == null)
							{
								rect = new Rectangle(0, 0, obj.width, obj.height);
							}
							obj.scale9Grid = rect;
							obj.name = "skin";
							this.addChild(obj);
							obj.width = this.displayWidth;
							obj.height = this.displayHeight;
						}
					}
					else
					{
						// if skin not changed, just resize skin's size.
						obj = this.getChildByName("skin") as DisplayObject;
						if(obj != null)
						{
							obj.width = this.displayWidth;
							obj.height = this.displayHeight;
						}
					}
				}
				else if(data.type == SkinElementData.BITMAP_TYPE)
				{
					// bitmap type, use scale9grid bitmap.
					var img:Scale9Bitmap;
					if(skinChanged)
					{
						// if skin is changed. reset bitmap
						var bm:Bitmap;
						if(data.data is Bitmap)
						{
							// if the data is bitmap, can be used as bitmap directly.
							bm = data.data as Bitmap;
						}
						else if(data.data is BitmapData)
						{
							// if the data is bitmapData, create new bitmap using it.
							bm = new Bitmap(data.data as BitmapData);
						}
						else if(data.data is DisplayObject)
						{
							// if the data is not bitmap/bitmapdata, but still a displayobject.
							// create new bitmap using it.
							var bdObj:DisplayObject = data.data as DisplayObject;
							var bd:BitmapData = new BitmapData(bdObj.width, bdObj.height, true, 0xFFFFFFFF);
							bd.draw(bdObj, null, null, null, null, true);
							bm = new Bitmap(bd);
						}
						if(bm != null)
						{
							// if bitmap is created.
							if(rect == null)
							{
								rect = new Rectangle(0, 0, bm.width, bm.height);
							}
							img = new Scale9Bitmap(bm, rect);
							img.name = "skin";
							this.addChild(img);
							img.width = this.displayWidth;
							img.height = this.displayHeight;
						}
					}
					else
					{
						// if skin is not changed, just resize skin.
						img = this.getChildByName("skin") as Scale9Bitmap;
						if(img != null)
						{
							img.width = this.displayWidth;
							img.height = this.displayHeight;
						}
					}
				}
				this.skinChanged = false;
				super.updateView();
			}
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param data
		 */
		public function setSkin(data:SkinElementData):void
		{
			skinList[data.status] = data;
			if(data.asDefault)
			{
				this.status = data.status;
			}
		}
		
		/**
		 * 
		 * @param status
		 */
		public function removeSkin(status:String):void
		{
			if(skinList[status] != null)
			{
				skinList[status] = null;
				delete skinList[status];
			}
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function setMouseEvent():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		private function removeMouseEvent():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function overHandler(e:MouseEvent):void
		{
			if(status != Status.DISABLE)
			{
				this.status = Status.MOUSE_OVER;
			}
		}
		
		private function outHandler(e:MouseEvent):void
		{
			if(status != Status.DISABLE)
			{
				this.status = Status.NORMAL;
			}
		}
		
		private function downHandler(e:MouseEvent):void
		{
			if(status != Status.DISABLE)
			{
				this.status = Status.MOUSE_DOWN;
			}
		}
		
		private function upHandler(e:MouseEvent):void
		{
			if(status != Status.DISABLE)
			{
				this.status = Status.MOUSE_OVER;
			}
		}
	}
}