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
	import flash.display.Shape;
	import flash.events.MouseEvent;

	import org.finalbug.data.Position;
	import org.finalbug.data.Status;
	import org.finalbug.events.DataEvent;
	import org.finalbug.ui.skin.CheckBoxSkinData;
	import org.finalbug.ui.skin.Skin;
	import org.finalbug.ui.skin.UISkinDataAbstract;

	/**
	 * CheckBox component.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class CheckBox extends UIObject
	{

		/******************* OVERRIDE **************************************************/
		/**
		 * 
		 * @param value
		 */
		override public function set status(value:String):void
		{
			super.status = this.getCurrentStatus(value);
		}

		/**
		 * set elements position.
		 */
		override protected function updatePosition():void
		{
			var ww:Number = Math.max(txt.width, BOX_SIZE);
			var hh:Number = Math.max(txt.height, BOX_SIZE);
			//
			if (_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				box.x = txt.width + OFFSET;
				box.y = (hh - BOX_SIZE) / 2;
				back.width = ww + OFFSET + BOX_SIZE;
				back.height = hh;
			}
			else if (_labelPosition == Position.TOP)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				box.x = (ww - BOX_SIZE) / 2;
				box.y = txt.height + OFFSET;
				back.width = ww;
				back.height = hh + OFFSET + BOX_SIZE;
			}
			else if (_labelPosition == Position.BOTTOM)
			{
				box.x = (ww - BOX_SIZE) / 2;
				box.y = 0;
				txt.x = (ww - txt.height) / 2;
				txt.y = BOX_SIZE + OFFSET;
				back.width = ww;
				back.height = hh + OFFSET + BOX_SIZE;
			}
			else
			{
				box.x = 0;
				box.y = (hh - BOX_SIZE) / 2;
				txt.x = BOX_SIZE + OFFSET;
				txt.y = (hh - txt.height) / 2;
				back.width = ww + OFFSET + BOX_SIZE;
				back.height = hh;
			}
			//
			if (_autoSize)
			{
				this.pack();
			}
		}

		/******************* DEFINE ****************************************************/
		private const BOX_SIZE:Number = 16;

		private const OFFSET:Number = 3;

		private var _selected:Boolean = false;

		private var _label:String = "CheckBox";

		private var _labelPosition:String;

		private var box:Skin;

		private var txt:Label;

		private var back:Shape;

		private var _autoSize:Boolean = true;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * 
		 * @return 
		 */
		public function get autoSize():Boolean
		{
			return _autoSize;
		}

		/**
		 * 
		 * @param value
		 */
		public function set autoSize(value:Boolean):void
		{
			if (value != _autoSize)
			{
				_autoSize = value;
				if (value)
				{
					pack();
				}
			}
		}

		/**
		 * If is checked of not.
		 */
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * 
		 * @param value
		 */
		public function set selected(value:Boolean):void
		{
			if (value != _selected)
			{
				_selected = value;
				this.status = getCurrentStatus(_selected ? Status.SELECTED : Status.NORMAL);
			}
		}

		/**
		 * Label text beside box.
		 */
		public function get label():String
		{
			return _label;
		}

		/**
		 * 
		 * @param value
		 */
		public function set label(value:String):void
		{
			_label = value;
			txt.text = value;
			updatePosition();
		}

		/**
		 * 
		 * @return 
		 */
		public function get labelPosition():String
		{
			return _labelPosition;
		}

		/**
		 * 
		 * @param value
		 */
		public function set labelPosition(value:String):void
		{
			_labelPosition = value;
			updatePosition();
		}

		/**
		 * 
		 * @param value
		 */
		public function set labelColor(value:Number):void
		{
			if (txt != null)
			{
				txt.textColor = value;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get labelColor():Number
		{
			return txt.textColor;
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create a new CheckBox object.
		 * 
		 * @param label
		 * @param style
		 */
		public function CheckBox(label:String = "checkBox", skin:UISkinDataAbstract = null)
		{
			super(skin);
			//
			this._label = label;
			// create children
			box = new Skin();
			box.resize(BOX_SIZE, BOX_SIZE);
			txt = new Label(_label);
			back = new Shape();
			this.addAll(box, txt, back);
			//
			// set events
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			//
			// set skin data
			if (uiSkinData == null)
			{
				uiSkinData = new CheckBoxSkinData();
			}
			uiSkinData.bindChildren(box, txt);
		}

		/******************* PUBLIC ****************************************************/
		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function getCurrentStatus(status:String):String
		{
			if (enabled)
			{
				if (this._selected)
				{
					switch(status)
					{
						case Status.NORMAL:
							status = Status.SELECTED;
							break;
						case Status.MOUSE_OVER:
							status = Status.SELECTED_MOUSE_OVER;
							break;
						case Status.MOUSE_DOWN:
							status = Status.SELECTED_MOUSE_DOWN;
							break;
					}
				}
			}
			else
			{
				if (this._selected)
				{
					status = Status.SELECTED_DISABLED;
				}
			}
			return status;
		}

		/******************* PRIVATE ***************************************************/
		/**
		 * invoked when click checkbox.
		 * 
		 * @param e
		 */
		private function clickHandler(e:MouseEvent):void
		{
			this.selected = !this.selected;
			this.dispatchEvent(new DataEvent(DataEvent.CHANGE_DATA));
		}
	}
}
