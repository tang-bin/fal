// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.ui.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import ftk.data.Status;
	import ftk.events.DataEvent;
	import ftk.ui.glazes.Flat;
	import ftk.ui.style.TextInputStyle;
	import ftk.ui.style.UIStyle;



	/**
	 * text input component
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class TextInput extends UIObject
	{

		/**
		 * Create a new TextInput object.
		 * 
		 * @param size Size of 
		 * @param style Display style
		 */
		public function TextInput(style:TextInputStyle = null)
		{
			super(style == null ? UIStyle.defaultTextInputStyle : style);
			this.initSize(100, 22);
			//
			// create children.
			back = new Flat();
			back.resize(this.width, this.height);
			txt = new TextField();
			setTextType();
			this.addAll(back, txt);
			//
			// set events
			txt.addEventListener(FocusEvent.FOCUS_IN, txtFocusInHandler);
			txt.addEventListener(FocusEvent.FOCUS_OUT, txtFocusOutHandler);
			txt.addEventListener(Event.CHANGE, changeTextHandler);
			//
			// set skin data.
			this.status = Status.NORMAL;
		}

		/******************* OVERRIDE **************************************************/
		override public function set status(value:String):void
		{
			if (this.enabled)
			{
				if (this.stage != null && stage.focus == txt)
				{
					value = Status.SELECTED;
				}
				else
				{
					value = Status.NORMAL;
				}
			}
			else
			{
				value = Status.DISABLED;
			}
			if (value != this.status) super.status = value;
		}

		override protected function updateSize():void
		{
			super.updateSize();
			back.width = this.width;
			back.height = this.height;
			txt.x = txt.y = 1;
			txt.width = this.width - 2;
			txt.height = this.height - 2;
		}

		override protected function updateStyle():void
		{
			if (this.currentStatus == Status.SELECTED)
			{
				back.fillStyle = uiStyle.selectedFillStyle;
				txt.setTextFormat(uiStyle.selectedTextFormat);
				txt.defaultTextFormat = uiStyle.selectedTextFormat;
			}
			else
			{
				back.fillStyle = uiStyle.normalFillStyle;
				txt.setTextFormat(uiStyle.normalTextFormat);
				txt.defaultTextFormat = uiStyle.normalTextFormat;
			}
		}

		/******************* DEFINE ****************************************************/
		private var _textType:String = "input";

		private var oldText:String = "";

		private var back:Flat;

		private var txt:TextField;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * if current text in textinput display as password.
		 */
		public function get password():Boolean
		{
			if (txt != null)
			{
				return txt.displayAsPassword;
			}
			return false;
		}

		/**
		 * 
		 * @param value
		 */
		public function set password(value:Boolean):void
		{
			if (txt != null)
			{
				txt.displayAsPassword = value;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get maxChars():Number
		{
			return txt.maxChars;
		}

		/**
		 * 
		 * @param value
		 */
		public function set maxChars(value:Number):void
		{
			txt.maxChars = value;
		}

		/**
		 * text string
		 */
		public function get text():String
		{
			if (txt != null)
			{
				return txt.text;
			}
			return "";
		}

		/**
		 * 
		 * @param value
		 */
		public function set text(value:String):void
		{
			if (txt != null)
			{
				txt.text = value;
				oldText = value;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get textType():String
		{
			return _textType;
		}

		/**
		 * 
		 * @param value
		 */
		public function set textType(value:String):void
		{
			_textType = value;
			this.setTextType();
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 */
		public function focusIn():void
		{
			stage.focus = txt;
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function setTextType():void
		{
			if (txt != null)
			{
				if (!enabled)
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

		/******************* HANDLER ***************************************************/
		private function txtFocusInHandler(e:FocusEvent):void
		{
			this.status = Status.SELECTED;
		}

		private function txtFocusOutHandler(e:FocusEvent):void
		{
			this.status = Status.NORMAL;
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
