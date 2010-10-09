/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	
	import org.finalbug.core.data.Status;
	import org.finalbug.core.events.DataEvent;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.style.stylefactory.TextInputStyleFactory;
	
	/**
	 * text input component
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */
	public class TextInput extends UIObject
	{
		private var _textType:String = "input";
		private var oldText:String ="";
		
		private var normalColor:Number;
		private var activeColor:Number;
		private var disableColor:Number;
		
		private var back:Flat;
		private var txt:TextField;
		
		/**
		 * if current text in textinput display as password.
		 */		
		public function get password():Boolean
		{
			if(txt != null)
			{
				return txt.displayAsPassword;
			}
			return false;
		}
		public function set password(value:Boolean):void
		{
			if(txt != null)
			{
				txt.displayAsPassword = value;
			}
		}
		
		public function get maxChars():Number
		{
			return txt.maxChars;
		}
		public function set maxChars(value:Number):void
		{
			txt.maxChars = value;
		}
		
		/**
		 * text string
		 */		
		public function get text():String
		{
			if(txt != null)
			{
				return txt.text;
			}
			return "";
		}
		public function set text(value:String):void
		{
			if(txt != null)
			{
				txt.text = value;
				oldText = value;
			}
		}
		
		public function get textType():String
		{
			return _textType;
		}
		public function set textType(value:String):void
		{
			_textType = value;
			this.setTextType();
		}
		
		/**
		 * Create a new TextInput object.
		 * 
		 * @param size Size of 
		 * @param style Display style
		 */			
		public function TextInput()
		{
			super();
			//
			back = new Flat();
			txt = new TextField();
			this.addAll(back, txt);
			//
			setTextType();
			//
			this.registerStatus(Status.NORMAL_STATUS, TextInputStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.ACTIVE_STATUS, TextInputStyleFactory.createActiveStyle());
			this.registerStatus(Status.DISABLE_STATUS, TextInputStyleFactory.createDisableStyle());
			//
			txt.addEventListener(FocusEvent.FOCUS_IN, txtFocusInHandler);
			txt.addEventListener(FocusEvent.FOCUS_OUT, txtFocusOutHandler);
			txt.addEventListener(Event.CHANGE, changeTextHandler);
		}
		
		public function focusIn():void
		{
			stage.focus = txt;
		}
		
		override protected function updateView():void
		{
			super.updateView();
			if(currentStyle != null)
			{
				back.fillStyle = currentStyle.fillStyle;
				back.width = this.displayWidth;
				back.height = this.displayHeight;
				txt.defaultTextFormat = currentStyle.textStyle.format;
				txt.setTextFormat(currentStyle.textStyle.format);
				txt.x = txt.y = 1;
				txt.width = this.displayWidth - 2;
				txt.height = this.displayHeight - 2;
			}
		}
		
		private function setTextType():void
		{
			if(txt != null)
			{
				if(!enabled)
				{
					txt.type = "dynamic";
				}
				else
				{
					txt.type = _textType != "dynamic" ? "input" : "dynamic";
				}
				txt.displayAsPassword = _textType == "password";
			}
		}
		
		private function txtFocusInHandler(e:FocusEvent):void
		{
			this.status = Status.ACTIVE_STATUS;
		}
		
		private function txtFocusOutHandler(e:FocusEvent):void
		{
			this.status = Status.NORMAL_STATUS;
		}
		
		private function changeTextHandler(e:Event):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			ee.oldData = oldText;
			ee.newData = txt.text;
			this.dispatchEvent(ee);
			oldText = txt.text;
		}
	}
}
