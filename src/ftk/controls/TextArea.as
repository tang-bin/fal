// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.controls
{
	import ftk.events.DataEvent;
	import ftk.events.UIEvent;
	import ftk.style.Style;

	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @eventType events.DataEvent.CHANGE_DATA
	 */
	[Event(name="ChangeData", type="ftk.events.DataEvent")]
	/**
	 * Text area component.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class TextArea extends ScrollBox
	{
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
			this.initSize(200, 200);
			//
			txt = new TextField();
			txt.wordWrap = !enableX;
			txt.multiline = true;
			this.addAll(txt);
			txt.defaultTextFormat = new TextFormat(Style.defaultFont, Style.NORMAL_TEXT_SIZE, 0);
			this.setChildIndex(txt, 0);
			txt.type = "input";
			//
			setEvent();
			//
			setScrollView();
		}

		/**
		 * in Class TextArea, if x scrollbar is disabled, the text input will auto warp.
		 */
		override public function set xScrollEnabled(value:Boolean):void
		{
			super.xScrollEnabled = value;
			txt.wordWrap = !value;
		}

		override protected function updateSize():void
		{
			super.updateSize();
			if (txt != null)
			{
				txt.width = this.width;
				txt.height = this.height;
			}
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

		private var txt:TextField;

		private var scrollManual:Boolean = false;

		private var _editable:Boolean = true;

		private var _enabled:Boolean = true;

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(value:Boolean):void
		{
			if (value != _enabled)
			{
				_enabled = value;
				setScrollView();
				setTextType();
			}
		}

		/**
		 * If this text area can input in or not.
		 */
		public function get editable():Boolean
		{
			return this._editable;
		}

		/**
		 * 
		 * @param value
		 */
		public function set editable(value:Boolean):void
		{
			if (value != this._editable)
			{
				this._editable = value;
				setTextType();
			}
		}

		/**
		 * text string
		 */
		public function get text():String
		{
			return txt.text;
		}

		/**
		 * 
		 * @param value
		 */
		public function set text(value:String):void
		{
			txt.text = value;
		}

		public function get textFormat():TextFormat
		{
			return txt.defaultTextFormat;
		}

		public function set textFormat(textFormat:TextFormat):void
		{
			txt.defaultTextFormat = textFormat;
			txt.setTextFormat(textFormat);
		}

		private function setTextType():void
		{
			txt.type = _editable && _enabled ? "input" : "dynamic";
		}

		private function setEvent():void
		{
			txt.addEventListener(Event.CHANGE, changeTextHandler);
			txt.addEventListener(Event.SCROLL, scrollTextHandler);
		}

		private function scrollTextHandler(e:Event):void
		{
			if (!scrollManual)
			{
				setScrollView();
			}
		}

		private function setScrollView():void
		{
			trace(enableY, enabled, txt.maxScrollV, yBar.enabled);
			if (enableY && enabled)
			{
				if (txt.maxScrollV > 1)
				{
					yBar.enabled = yBar.visible = true;
					yBar.scale = txt.numLines / (txt.numLines + txt.maxScrollV);
					yBar.position = txt.scrollV / txt.maxScrollV;
				}
				else if (yBar != null && yBar.enabled)
				{
					yBar.enabled = yBar.visible = false;
					trace(yBar.visible);
				}
			}
			else
			{
				yBar.enabled = yBar.visible = false;
			}
			if (enableX && enabled)
			{
				if (txt.maxScrollH > 1)
				{
					xBar.enabled = xBar.visible = true;
					xBar.scale = txt.width / (txt.width + txt.maxScrollH);
					xBar.position = txt.scrollH / txt.maxScrollH;
				}
				else if (xBar != null && xBar.enabled)
				{
					xBar.enabled = xBar.visible = false;
				}
			}
			else
			{
				xBar.enabled = xBar.visible = false;
			}
		}

		private function changeTextHandler(e:Event):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			// ee.oldData = oldText;
			// ee.newData = txt.text;
			this.dispatchEvent(ee);
			// oldText = txt.text;
		}
	}
}
