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
	import ftk.data.Status;
	import ftk.graphs.Flat;
	import ftk.graphs.Image;
	import ftk.style.ButtonStyle;
	import ftk.style.UIStyle;

	import flash.events.MouseEvent;

	/**
	 * Button
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Button extends UIControl
	{
		/**
		 * 
		 * @param text
		 * @param skin
		 */
		public function Button(text:String = "Button", style:ButtonStyle = null)
		{
			super(style == null ? UIStyle.defaultButtonStyle : style);
			// save and init paramters.
			this.autoMouseEvent = true;
			this.mouseChildren = false;
			this._labelStr = text;
			this.initSize(ButtonStyle.DEFAULT_WIDTH, ButtonStyle.DEFAULT_HEIGHT);
			//
			// create elements
			bg = new Flat();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			// set skin data.
			this.status = Status.NORMAL;
		}

		/**
		 * 
		 */
		override protected function updateSize():void
		{
			super.updateSize();
			//
			if (_autoWidth)
			{
				var newWidth:Number = _label.width + AUTO_SPACE;
				if (newWidth != this.width)
				{
					this.width = newWidth;
					return;
				}
			}
			if (_autoHeight)
			{
				var newHeight:Number = _label.height + AUTO_SPACE;
				if (newHeight != this.height)
				{
					this.height = newHeight;
					return;
				}
			}
			//
			if (_label != null)
			{
				_label.toCenter();
			}
			if (bg != null)
			{
				bg.width = this.width;
				bg.height = this.height;
			}
		}

		/**
		 * 
		 * @param value
		 */
		override public function set status(value:String):void
		{
			if (_selectedable)
			{
				if (value == Status.NORMAL)
				{
					value = _selected ? Status.SELECTED : Status.NORMAL;
				}
				else if (value == Status.MOUSE_DOWN)
				{
					value = _selected ? Status.SELECTED_MOUSE_DOWN : Status.MOUSE_DOWN;
				}
				else if (value == Status.MOUSE_OVER)
				{
					value = _selected ? Status.SELECTED_MOUSE_OVER : Status.MOUSE_OVER;
				}
			}
			super.status = value;
		}

		override protected function updateStyle():void
		{
			switch(currentStatus)
			{
				case Status.NORMAL:
					bg.fillStyle = uiStyle.normalFillStyle;
					_label.textFormat = uiStyle.normalTextFormat;
					break;
				case Status.SELECTED:
					bg.fillStyle = uiStyle.selectedFillStyle;
					_label.textFormat = uiStyle.selectedTextFormat;
					break;
				case Status.MOUSE_OVER:
					bg.fillStyle = uiStyle.overFillStyle;
					_label.textFormat = uiStyle.overTextFormat;
					break;
				case Status.SELECTED_MOUSE_OVER:
					bg.fillStyle = uiStyle.selectedOverFillStyle;
					_label.textFormat = uiStyle.selectedOverTextFormat;
					break;
				case Status.MOUSE_DOWN:
					bg.fillStyle = uiStyle.downFillStyle;
					_label.textFormat = uiStyle.downTextFormat;
					break;
				case Status.SELECTED_MOUSE_DOWN:
					bg.fillStyle = uiStyle.selectedDownFillStyle;
					_label.textFormat = uiStyle.selectedDownTextFormat;
					break;
				case Status.DISABLED:
					bg.fillStyle = uiStyle.disabledFillStyle;
					_label.textFormat = uiStyle.disabledTextFormat;
					break;
				case Status.SELECTED_DISABLED:
					bg.fillStyle = uiStyle.selectedDisabledFillStyle;
					_label.textFormat = uiStyle.selectedDisabledTextFormat;
					break;
			}
		}

		/**
		 * 
		 * @param e
		 */
		override protected function mouseDownHandler(e:MouseEvent):void
		{
			super.mouseDownHandler(e);
			if (_selectedable)
			{
				_selected = !_selected;
			}
		}

		private const AUTO_SPACE:Number = 12;

		// lable string
		private var _labelStr:String = "Button";

		// children
		private var _label:Label;

		private var bg:Flat;

		private var icon:Image;

		// variables
		private var _selectedable:Boolean = false;

		private var _selected:Boolean = false;

		private var _autoWidth:Boolean = false;

		private var _autoHeight:Boolean = false;

		/**
		 * 
		 * @return 
		 */
		public function get autoWidth():Boolean
		{
			return _autoWidth;
		}

		/**
		 * 
		 * @param value
		 */
		public function set autoWidth(value:Boolean):void
		{
			if (_autoWidth != value)
			{
				_autoWidth = value;
				if (value)
				{
					var newWidth:Number = _label.width + AUTO_SPACE;
					if (newWidth != this.width)
					{
						this.width = newWidth;
					}
				}
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get autoHeight():Boolean
		{
			return _autoHeight;
		}

		/**
		 * 
		 * @param value
		 */
		public function set autoHeight(value:Boolean):void
		{
			if (_autoHeight != value)
			{
				_autoHeight = value;
				if (value)
				{
					var newHeight:Number = _label.height + AUTO_SPACE;
					if (newHeight != this.height)
					{
						this.height = newHeight;
					}
				}
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get label():String
		{
			return _labelStr;
		}

		/**
		 * 
		 * @param value
		 */
		public function set label(value:String):void
		{
			if (_labelStr != value)
			{
				_labelStr = value;
				_label.text = value;
				_label.toCenter();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get selecteable():Boolean
		{
			return _selectedable;
		}

		/**
		 * 
		 * @param value
		 */
		public function set selecteable(value:Boolean):void
		{
			_selectedable = value;
			if (!_selectedable)
			{
				_selected = false;
			}
		}

		/**
		 * 
		 * @return 
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
			if (_selectedable && this._selected != value)
			{
				_selected = value;
				this.status = _selected ? Status.SELECTED : Status.NORMAL;
			}
		}
	}
}