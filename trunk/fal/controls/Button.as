/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.controls
{
	import fal.data.Status;
	import fal.display.Control;
	import fal.glazes.Flat;
	import fal.glazes.Image;
	import fal.style.stylefactory.ButtonStyleFactory;
	
	import flash.events.MouseEvent;
	
	/******************************************
	 * fal.controls.Button
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 *****************************************/
	public class Button extends Control
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		private var _labelStr:String = "Button";
		
		private var _label:Label;
		private var bg:Flat;
		private var icon:Image;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
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
		
		/****************************************
		 * 
		 * fal.controls.Button constructor.
		 * 
		 ****************************************/
		public function Button(text:String = "Button")
		{
			super();
			this.mouseChildren = false;
			this._labelStr = text;
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		override protected function callAtAdded():void
		{
			// create elements
			bg = new Flat();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			this.registerStatus(Status.NORMAL_STATUS, ButtonStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.MOUSE_OVER_STATUS, ButtonStyleFactory.createOverStyle());
			this.registerStatus(Status.MOUSE_DOWN_STATUS, ButtonStyleFactory.createDownStyle());
			this.registerStatus(Status.DISABLE_STATUS, ButtonStyleFactory.createDisableStyle());
		}
		
		override protected function updateView():void
		{
			super.updateView();
			if(currentStyle != null)
			{
				bg.fillStyle = currentStyle.fillStyle;
				_label.textFormat = currentStyle.textStyle.format;
				bg.resize(displayWidth, displayHeight);
				_label.toCenter();
			}
		}
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}