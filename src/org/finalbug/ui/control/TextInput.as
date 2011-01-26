// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.ui.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	import org.finalbug.data.Status;
	import org.finalbug.events.DataEvent;
	import org.finalbug.ui.skin.Skin;
	import org.finalbug.ui.skin.TextSkinData;
	import org.finalbug.ui.skin.UISkinDataAbstract;

	/**
	 * text input component
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class TextInput extends UIObject
	{

		// ******************* OVERRIDE *****************************
		override public function set status(value:String):void
		{
			if (this.enabled)
			{
				if (stage.focus == txt)
				{
					value = Status.ACTIVE;
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

		// ******************* DEFINE *******************************
		private var _textType:String = "input";

		private var oldText:String = "";

		private var back:Skin;

		private var txt:TextField;

		// ******************* GETTER and SETTER ********************
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

		// ******************* CONSTRUCTOR **************************
		/**
		 * Create a new TextInput object.
		 * 
		 * @param size Size of 
		 * @param style Display style
		 */
		public function TextInput(skin:UISkinDataAbstract = null)
		{
			super(skin);
			this.initSize(100, 22);
			//
			// create children.
			back = new Skin();
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
			if (uiSkinData == null)
			{
				uiSkinData = new TextSkinData();
			}
			uiSkinData.bindChildren(back, txt);
		}

		// ******************* PUBLIC *******************************
		/**
		 * 
		 */
		public function focusIn():void
		{
			stage.focus = txt;
		}

		// ******************* PROTECTED ****************************
		// ******************* PRIVATE ******************************
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

		// ******************* HANDLER ******************************
		private function txtFocusInHandler(e:FocusEvent):void
		{
			this.status = Status.ACTIVE;
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
