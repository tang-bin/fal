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
	import org.finalbug.ui.skin.SkinElement;
	import org.finalbug.ui.skin.ButtonSkin;
	import org.finalbug.ui.skin.UISkinModel;
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
		private var bg:SkinElement;
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
			if(bg != null)
			{
				bg.status = this.currentStatus;
			}
			if(_label != null)
			{
				//_label.textFormat = currentSkin.textStyle.format;
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
			bg = new SkinElement();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			var uiSkin:ButtonSkin = UISkinModel.instance.buttonSkin;
			uiSkin.setSkin(bg);
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}