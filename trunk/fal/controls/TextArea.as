/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.controls
{
	import fal.data.Status;
	import fal.events.DataEvent;
	import fal.events.UIEvent;
	import fal.style.stylefactory.TextAreaStyleFactory;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	
	/**
	 * @eventType fal.events.DataEvent.CHANGE_DATA
	 */	
	[Event(name="ChangeData", type="fal.events.DataEvent")]
	
	/**
	 * Text area component.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */
	public class TextArea extends ScrollBox
	{
		private var txt:TextField;
		private var _embed:Boolean = false;
		private var scrollManual:Boolean = false;
		private var _editable:Boolean = true;
		
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
		public function TextArea()
		{
			super(true, true);
			//
			txt = new TextField();
			txt.wordWrap = !enableX;
			txt.multiline = true;
			this.addChild(txt);
			txt.type = "input";
			//
			this.registerStatus(Status.NORMAL_STATUS, TextAreaStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.ACTIVE_STATUS, TextAreaStyleFactory.createActiveStyle());
			this.registerStatus(Status.DISABLE_STATUS, TextAreaStyleFactory.createDisableStyle());
			//
			txt.addEventListener(FocusEvent.FOCUS_IN, txtFocusInHandler);
			txt.addEventListener(FocusEvent.FOCUS_OUT, txtFocusOutHandler);
			txt.addEventListener(Event.CHANGE, changeTextHandler);
			//
			updateView();
			setEvent();
		}
		
		override protected function updateView():void
		{
			if(txt != null)
			{
				super.updateView();
				txt.width = containerWidth;
				txt.height = containerHeight;
				txt.defaultTextFormat = currentStyle.textStyle.format;
				txt.setTextFormat(currentStyle.textStyle.format);
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
				updateView();
			}
		}
		
		private function killFocusHandler(e:FocusEvent):void
		{
			if(enabled)
			{
				currentStatus = Status.NORMAL_STATUS;
				updateView();
			}
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
			//ee.oldData = oldText;
			//ee.newData = txt.text;
			this.dispatchEvent(ee);
			//oldText = txt.text;
		}
	}
}
