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
package org.finalbug.ui.control
{
	import flash.display.Bitmap;
	
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.ui.skin.ButtonSkinData;
	import org.finalbug.ui.skin.SkinElement;
	import org.finalbug.ui.skin.UISkinDataBase;
	
	/**
	 * Button
	 * 
	 * @author Tang Bin
	 * @since old version
	 */  
	public class Button extends UIObject
	{
		//#######################################
		// DEFINE
		//#######################################
		
		private var _labelStr:String = "Button";
		
		private var _label:Label;
		private var bg:SkinElement;
		private var imgBg:Bitmap;
		private var icon:Image;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get label():String
		{
			return _labelStr;
		}
		/**
		 * 
		 * @param value
		 */
		public function set label(value:String):void
		{
			if(_labelStr != value)
			{
				_labelStr = value;
				this.updateView();
			}
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @param text
		 * @param skin
		 */
		public function Button(text:String = "Button", skin:UISkinDataBase = null)
		{
			super(skin);
			// save and init paramters.
			this.mouseChildren = false;
			this._labelStr = text;
			this.initSize(80, 24);
			//
			// create elements
			bg = new SkinElement();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			// set skin data.
			if(uiSkinData == null) uiSkinData = new ButtonSkinData();
			uiSkinData.setSkin(bg, _label);
		}
		
		//#######################################
		// OVERRIDE
		// Whit out getter, setter and handler
		// include public, protected and private.
		//#######################################
		
		override protected function updateView():void
		{
			super.updateView();
			if(bg != null)
			{
				bg.width = this.displayWidth;
				bg.height = this.displayHeight;
			}
			if(_label != null)
			{
				_label.text = _labelStr;
				_label.toCenter();
			}
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}