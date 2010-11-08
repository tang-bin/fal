/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.control
{
	import flash.display.DisplayObject;
	
	import org.finalbug.core.display.Bin;
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.utils.DataUtil;
	
	/**
	 * Icon
	 * 
	 * @author Tang Bin
	 * @since 2010.11
	 */	
	public class Icon extends Bin
	{
		//***************************************
		// DEFINE
		//***************************************
		
		public static const ICON_16:String = "icon16";
		public static const ICON_32:String = "icon32";
		public static const ICON_48:String = "icon48";
		public static const ICON_128:String = "icon128";
		
		private var defaultImg:Image;
		private var imgs:Object = new Object();
		private var img:Image;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		private function get icon16():Image
		{
			return imgs[ICON_16] as Image;
		}
		
		private function get icon32():Image
		{
			return imgs[ICON_32] as Image;
		}
		
		private function get icon48():Image
		{
			return imgs[ICON_48] as Image;
		}
		
		private function get icon128():Image
		{
			return imgs[ICON_128] as Image;
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function Icon()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function updateView():void
		{
			super.updateView();
			// get shown image
			var size:Number = Math.max(this.displayWidth, this.displayHeight);
			var newImg:Image;
			if(size >= 48) newImg = icon128;
			else if(size >= 32) newImg = icon48;
			else if(size >= 16) newImg = icon32;
			else newImg = icon16;
			if(newImg == null) newImg = this.defaultImg;
			// remove current image
			if(img != null && img != newImg)
			{
				this.removeChild(img);
			}
			// add new image.
			img = newImg;
			if(img != null)
			{
				this.addChild(img);
				img.width = this.displayWidth;
				img.height = this.displayHeight;
			}
		}
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function addImage(img:DisplayObject, type:String):void
		{
			if(DataUtil.included(type, ICON_16, ICON_32, ICON_48, ICON_128))
			{
				if(img is Image)
				{
					imgs[type] = img;
				}
				else if(img.width > 0 && img.height > 0)
				{
					var newImg:Image = new Image();
					newImg.setImage(img);
					imgs[type] = newImg;
				}
				else
				{
					throw new DataError(DataError.SIZE_ERROR);
				}
				setDefaultImg();
			}
			else
			{
				throw new DataError(DataError.TYPE_ERROR);
			}
		}
		
		public function addImagePath(path:String, type:String):void
		{
			if(DataUtil.included(type, ICON_16, ICON_32, ICON_48, ICON_128))
			{
				var newImg:Image = new Image(path);
				imgs[type] = newImg;
				setDefaultImg();
			}
			else
			{
				throw new DataError(DataError.TYPE_ERROR);
			}
		}
		
		public function clone():Icon
		{
			var newIcon:Icon = new Icon();
			if(icon16 != null) newIcon.addImage(icon16.clone(), ICON_16);
			if(icon32 != null) newIcon.addImage(icon32.clone(), ICON_32);
			if(icon48 != null) newIcon.addImage(icon48.clone(), ICON_48);
			if(icon128 != null) newIcon.addImage(icon128.clone(), ICON_128);
			newIcon.width = this.displayWidth;
			newIcon.height = this.displayHeight;
			return newIcon;
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function setDefaultImg():void
		{
			if(imgs[ICON_128] != null) defaultImg = imgs[ICON_128];
			else if(imgs[ICON_48] != null) defaultImg = imgs[ICON_48];
			else if(imgs[ICON_32] != null) defaultImg = imgs[ICON_32];
			else if(imgs[ICON_16] != null) defaultImg = imgs[ICON_16];
			else defaultImg = null;
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}