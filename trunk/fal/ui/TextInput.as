package fal.ui
{
	import fal.data.FillData;
	import fal.data.Status;
	import fal.events.DataEvent;
	import fal.utils.Flat;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * text input component
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class TextInput extends UIObject
	{
		private var _textType:String = "input";
		private var oldText:String ="";
		private var currentStatus:String;
		
		private var normalFD:FillData;
		private var activeFD:FillData;
		private var disableFD:FillData;
		private var normalColor:Number;
		private var activeColor:Number;
		private var disableColor:Number;
		
		private var back:Flat;
		private var txt:TextField;
		private var _enabled:Boolean = true;
		
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
		
		public function set enabled(value:Boolean):void
		{
			if(value != _enabled)
			{
				_enabled = value;
				currentStatus = _enabled ? Status.NORMAL_STATUS : Status.DISABLE_STATUS;
				setTextType();
				resetView();
			}
		}
		public function get enabled():Boolean
		{
			return _enabled;
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
		
		override public function resize() : void
		{
			if(back != null)
			{
				back.width = width; 
				back.height = height;
				txt.width = width - 4;
				txt.height = height - 4;
			}
		}
		
		/**
		 * Create a new TextInput object.
		 * 
		 * @param size Size of 
		 * @param style Display style
		 */			
		public function TextInput(width:Number = 160, height:Number = 22)
		{
			super.uiName = "TextInput";
			currentStatus = Status.NORMAL_STATUS;
			this.changeLayoutValue("width", width);
			this.changeLayoutValue("height", height);
			//
			createTextInput();
			setTextType();
			setEvent();
			resetView();
			this.resize();
		}
		
		public function resetView():void
		{
			switch(currentStatus)
			{
				case Status.NORMAL_STATUS:
					back.fillData = normalFD;
					txt.textColor = normalColor;
					break;
				case Status.ACTIVE_STATUS:
					back.fillData = activeFD;
					txt.textColor = activeColor;
					break;
				case Status.DISABLE_STATUS:
					back.fillData = disableFD;
					txt.textColor = disableColor;
					break;
			}
		}
		
		public function focusIn():void
		{
			stage.focus = txt;
		}
		
		private function createTextInput():void
		{
			normalFD = new FillData(false);
			normalFD.borderColor = 0x990000;
			normalFD.bodyColor = 0xFFFFFF;
			normalFD.borderSize = 2;
			normalFD.glowAlpha = 0;
			normalFD.radius = 3;
			back = new Flat(10, 10, normalFD);
			this.addChild(back);
			//
			activeFD = normalFD.clone();
			activeFD.glowAlpha = 0.8;
			activeFD.glowBlur = 2;
			activeFD.bodyColor = 0x990000;
			activeColor = 0xFFFFFF;
			//
			disableFD = normalFD.clone();
			disableFD.borderColor = 0x999999;
			disableFD.bodyColor = 0xCCCCCC;
			disableColor = 0xAAAAAA;
			//
			normalColor = 0x333333;
			var tf:TextFormat = new TextFormat("Arial", 12, normalColor);
			txt = new TextField();
			this.addChild(txt);
			txt.defaultTextFormat = tf;
			txt.x = txt.y = 2;
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
		
		private function setEvent():void
		{
			txt.addEventListener(FocusEvent.FOCUS_IN, getFocusHandler);
			txt.addEventListener(FocusEvent.FOCUS_OUT, killFocusHandler);
			txt.addEventListener(Event.CHANGE, changeTextHandler);
		}
		
		private function getFocusHandler(e:FocusEvent):void
		{
			if(enabled)
			{
				currentStatus = Status.ACTIVE_STATUS;
				resetView();
			}
		}
		
		private function killFocusHandler(e:FocusEvent):void
		{
			if(enabled)
			{
				currentStatus = Status.NORMAL_STATUS;
				resetView();
			}
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
