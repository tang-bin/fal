package fal.ui
{
	import fal.data.Status;
	import fal.events.DataEvent;
	import fal.events.UIEvent;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @eventType fal.events.DataEvent.CHANGE_DATA
	 */	
	[Event(name="FOSChangeData", type="fal.events.DataEvent")]
	
	/**
	 * Text area component.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 */
	public class TextArea extends Cage
	{
		private var txt:TextField;
		private var _embed:Boolean = false;
		private var scrollManual:Boolean = false;
		private var currentStatus:String;
		private var _editable:Boolean = true;
		private var _enabled:Boolean = true;
		
		/**
		 * If this text area can input in or not.
		 */		
		public function get editable():Boolean
		{
			return this._editable;
		}
		public function set editable(value:Boolean):void
		{
			if(value != this._editable)
			{
				this._editable = value;
				txt.type = value && enabled ? "input" : "dynamic";
			}
		}
		
		/**
		 * text string
		 */		
		public function get text():String
		{
			return txt.text;
		}
		public function set text(value:String):void
		{
			txt.text = value;
		}
		
		/**
		 * enable textarea or not.
		 */	
		public function set enabled(value:Boolean):void
		{
			if(value != _enabled)
			{
				_enabled = value;
				currentStatus = _enabled ? Status.NORMAL_STATUS : Status.DISABLE_STATUS;
				xBar.enabled = _enabled && (txt.maxScrollH > 1);
				yBar.enabled = _enabled && (txt.maxScrollV > 1);
				txt.selectable = _enabled;
				txt.type = _enabled && editable ? "input" : "dynamic";
				resetView();
			}
		}
		public function get enabled():Boolean
		{
			return this._enabled;
		}
		
		/**
		 * embed font or not.
		 */
		public function get embed():Boolean
		{
			return _embed;
		}
		public function set embed(b:Boolean):void
		{
			_embed=b;
			txt.embedFonts = _embed;
		}
		
		/**
		 * in Class TextArea, if x scrollbar is disabled, the text input will auto warp.
		 */		
		override public function set xScrollEnabled(value:Boolean):void
		{
			super.xScrollEnabled = value;
			txt.wordWrap = !value;
		}
		
		/**
		 * create a new TextArea.
		 * 
		 * @param size
		 * @param wordwrap wrap word
		 * @param style DipslayStyle
		 */		
		public function TextArea(width:Number = 200, height:Number = 160)
		{
			super(width, height);
			this.uiName = "TextArea";
			//
			var tf:TextFormat = new TextFormat("Arial", 12, 0x333333);
			txt = new TextField();
			txt.wordWrap = !enableX;
			txt.multiline = true;
			txt.defaultTextFormat = tf;
			this.addChild(txt);
			txt.type = "input";
			//
			currentStatus = Status.NORMAL_STATUS;
			//
			resetView();
			setEvent();
		}
		
		private function resetView():void
		{
			txt.width = this.containerWidth;
			txt.height = this.containerHeight;
			switch(currentStatus)
			{
				case Status.NORMAL_STATUS:
					//back.fillData = _style.fillData;
					//txt.setTextFormat(_style.textFormat);
					//txt.defaultTextFormat = _style.textFormat;
					break;
				case Status.ACTIVE_STATUS:
					//back.fillData = _style.activeFillData;
					//txt.setTextFormat(_style.activeTextFormat);
					//txt.defaultTextFormat = _style.activeTextFormat;
					break;
				case Status.DISABLE_STATUS:
					//back.fillData = _style.disableFillData;
					//txt.setTextFormat(_style.disableTextFormat);
					//txt.defaultTextFormat = _style.disableTextFormat;
					break;
			}
		}
		
		private function setEvent():void
		{
			txt.addEventListener(FocusEvent.FOCUS_IN, getFocusHandler);
			txt.addEventListener(FocusEvent.FOCUS_OUT, killFocusHandler);
			txt.addEventListener(Event.CHANGE, changeTextHandler);
			txt.addEventListener(Event.SCROLL, scrollTextHandler);
		}
		
		override protected function xScrollHandler(e:UIEvent):void
		{
			scrollManual = true;
			txt.scrollH = e.position * txt.maxScrollH;
			scrollManual = false;
		}
		
		override protected function yScrollHandler(e:UIEvent):void
		{
			scrollManual = true;
			txt.scrollV = e.position * txt.maxScrollV;
			scrollManual = false;
		}
		
		private function scrollTextHandler(e:Event):void
		{
			if(!scrollManual)
			{
				setScrollView();
			}
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
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA)
			ee.newData = txt.text;
			this.dispatchEvent(ee);
		}
		
		private function setScrollView():void
		{
			if(enableY && enabled)
			{
				if(txt.maxScrollV > 1)
				{
					yBar.enabled = true;
					yBar.scale = txt.numLines / (txt.numLines + txt.maxScrollV);
					yBar.position = txt.scrollV / txt.maxScrollV;
				}
				else if(yBar != null && yBar.enabled)
				{
					yBar.enabled = false;
				}
			}
			if(enableX && enabled)
			{
				if(txt.maxScrollH > 1)
				{
					xBar.enabled = true;
					xBar.scale = txt.width / (txt.width + txt.maxScrollH);
					xBar.position = txt.scrollH / txt.maxScrollH;
				}
				else if(xBar != null && xBar.enabled)
				{
					xBar.enabled = false;
				}
			}
		}
	}
}
