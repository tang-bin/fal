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
package org.finalbug.ui.control
{
	import flash.display.Bitmap;
	
	import org.finalbug.data.Status;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.ui.style.stylefactory.ButtonStyleFactory;
	
	/******************************************************
	 * Button
	 * 
	 * @author Tang Bin
	 * @since old version
	  *****************************************************/  
	public class Button extends UIObject
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private var _labelStr:String = "Button";
		
		private var _label:Label;
		private var bg:Flat;
		private var imgBg:Bitmap;
		private var icon:Image;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get label():String
		{
			return _labelStr;
		}
		public function set label(value:String):void
		{
			if(_labelStr != value)
			{
				_labelStr = value;
				this.updateView();
			}
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function Button(text:String = "Button")
		{
			super();
			this.mouseChildren = false;
			this._labelStr = text;
			this.initSize(80, 20);
			createChildren();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function updateView():void
		{
			super.updateView();
			if(currentSkin != null)
			{
				if(imgBg != null && this.contains(imgBg))
				{
					this.removeChild(imgBg);
				}
				if(currentSkin.bitmapSkin != null)
				{
					imgBg = currentSkin.bitmapSkin;
					imgBg.width = this.displayWidth;
					imgBg.height = this.displayHeight;
					this.addChild(imgBg);
					bg.visible = false;
				}
				else
				{
					bg.fillStyle = currentSkin.fillStyle;
					bg.resize(displayWidth, displayHeight);
					bg.visible = true;
				}
				_label.textFormat = currentSkin.textStyle.format;
				_label.toCenter();
				_label.toFront();
			}
		}
		
		//***************************************
		// PUBLIC
		//***************************************
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function createChildren():void
		{
			// create elements
			bg = new Flat();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			this.setSkin(Status.NORMAL, ButtonStyleFactory.createNormalStyle(), true);
			this.setSkin(Status.MOUSE_OVER, ButtonStyleFactory.createOverStyle());
			this.setSkin(Status.MOUSE_DOWN, ButtonStyleFactory.createDownStyle());
			this.setSkin(Status.DISABLE, ButtonStyleFactory.createDisableStyle());
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}