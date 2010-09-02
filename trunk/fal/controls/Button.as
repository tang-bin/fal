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
		
		private var _text:String = "Button";
		
		private var label:Label;
		private var bg:Flat;
		private var icon:Image;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * 
		 * fal.controls.Button constructor.
		 * 
		 ****************************************/
		public function Button(text:String = "Button")
		{
			super();
			this.mouseChildren = false;
			this._text = text;
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
			label = new Label(this._text);
			icon = new Image();
			this.addAll(bg, label, icon);
			//
			this.registerStatus(Status.NORMAL_STATUS, ButtonStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.MOUSE_OVER_STATUS, ButtonStyleFactory.createOverStyle());
			this.registerStatus(Status.MOUSE_DOWN_STATUS, ButtonStyleFactory.createDownStyle());
			this.registerStatus(Status.DISABLE_STATUS, ButtonStyleFactory.createDisableStyle());
			//
			this.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		override protected function updateView():void
		{
			super.updateView();
			if(currentStyle != null)
			{
				bg.fillStyle = currentStyle.fillStyle;
				label.textFormat = currentStyle.textStyle.format;
				bg.resize(displayWidth, displayHeight);
				label.toCenter();
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
		
		private function overHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER_STATUS;
		}
		
		private function outHandler(e:MouseEvent):void
		{
			this.status = Status.NORMAL_STATUS;
		}
		
		private function downHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_DOWN_STATUS;
		}
		
		private function upHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER_STATUS;
		}
	}
}