/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import org.finalbug.ui.Glaze;
	import org.finalbug.ui.style.FillStyle;
	import org.finalbug.ui.glazes.Scale9Bitmap;
	
	
	/**
	 * SkinBox
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class SkinElement extends Glaze
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private var skinList:Dictionary = new Dictionary();
		
		private var currentStatus:String;
		
		private var skinChanged:Boolean = false;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get status():String
		{
			return currentStatus;
		}
		public function set status(value:String):void
		{
			if(value != "" && value != currentStatus && skinList[value] != null)
			{
				currentStatus = value;
				skinChanged = true;
				updateView();
			}
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function SkinElement()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		override protected function updateView():void
		{
			this.graphics.clear();
			// remove skin if is changed.
			if(skinChanged) this.removeAll();
			//
			var data:SkinData = skinList[currentStatus] as SkinData;
			if(data.type == SkinData.FILL_TYPE)
			{
				this.fillStyle = data.data as FillStyle;
			}
			else if(data.type == SkinData.VECTORIAL_TYPE)
			{
				// add skin if is changed.
				var obj:DisplayObject;
				if(skinChanged)
				{
					obj = data.data as DisplayObject
					if(obj != null)
					{
						var objRect:Rectangle = new Rectangle(obj.width / 2 - 1, obj.height / 2 - 1, 2, 2);
						obj.scale9Grid = objRect;
						obj.name = "skin";
						this.addChild(obj);
						obj.width = this.displayWidth;
						obj.height = this.displayHeight;
					}
				}
				else
				{
					obj = this.getChildByName("skin") as DisplayObject;
					if(obj != null)
					{
						obj.width = this.displayWidth;
						obj.height = this.displayHeight;
					}
				}
			}
			else if(data.type == SkinData.BITMAP_TYPE)
			{
				var img:Scale9Bitmap;
				if(skinChanged)
				{
					var bm:Bitmap;
					if(data.data is Bitmap)
					{
						bm = data.data as Bitmap;
					}
					else if(data.data is BitmapData)
					{
						bm = new Bitmap(data.data as BitmapData);
					}
					else if(data.data is DisplayObject)
					{
						var bdObj:DisplayObject = data.data as DisplayObject;
						var bd:BitmapData = new BitmapData(bdObj.width, bdObj.height, true, 0xFFFFFFFF);
						bd.draw(bdObj, null, null, null, null, true);
						bm = new Bitmap(bd);
					}
					if(bm != null)
					{
						var bmRect:Rectangle = new Rectangle(bm.width / 2 - 1, bm.height / 2 - 1, 2, 2);
						img = new Scale9Bitmap(bm, bmRect);
						img.name = "skin";
						this.addChild(img);
						img.width = this.displayWidth;
						img.height = this.displayHeight;
					}
				}
				else
				{
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
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		public function setSkin(data:SkinData):void
		{
			skinList[data.status] = data;
			if(data.asDefault)
			{
				this.status = data.status;
			}
		}
		
		public function removeSkin(status:String):void
		{
			if(skinList[status] != null)
			{
				skinList[status] = null;
				delete skinList[status];
			}
		}
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}