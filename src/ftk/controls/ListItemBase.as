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
	import ftk.data.Position;
	import ftk.style.Style;

	import flash.text.TextFormat;

	import ftk.layout.Container;

	/**
	 * @author Tang Bin
	 * @since 2011.05
	 */
	public class ListItemBase extends Container implements IListItemInterface
	{
		public function ListItemBase()
		{
			super();
			this.initSize("100%", DEFAULT_ITEM_HEIGHT);
			this.backgroundColor = NORMAL_BG_COLOR;
			this.backgroundAlpha = 1;
			//
			this.autoRank = true;
			this.align = Position.LEFT;
			this.valign = Position.MIDDLE;
			var format:TextFormat = new TextFormat(Style.defaultFont, Style.NORMAL_TEXT_SIZE, 0);
			_label = new Label("", format);
			this.addChild(_label);
		}

		public static const DEFAULT_ITEM_HEIGHT:Number = 20;

		protected var NORMAL_BG_COLOR:Number = 0xFFFFFF;

		protected var SELECTED_BG_COLOR:Number = 0xFFCC00;

		private var _data:Object;

		private var _labelField:String = "label";

		private var _label:Label;

		private var _selected:Boolean = false;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			if (_selected != value)
			{
				_selected = value;
				this.backgroundColor = _selected ? SELECTED_BG_COLOR : NORMAL_BG_COLOR;
			}
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			if (value != _data)
			{
				_data = value;
				resetView();
			}
		}

		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			if (value != "" && value != _labelField)
			{
				_labelField = value;
				resetView();
			}
		}

		private function resetView():void
		{
			if (_label != null)
			{
				if (_data != null && _data.hasOwnProperty(_labelField))
				{
					_label.text = String(_data[_labelField]);
				}
				else
				{
					_label.text = "";
				}
			}
		}
	}
}
