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
			//
			this.autoRank = true;
			this.align = Position.LEFT;
			this.valign = Position.MIDDLE;
			//
			var format:TextFormat = new TextFormat(Style.defaultFont, Style.NORMAL_TEXT_SIZE, 0);
			_label = new Label("", format);
			this.addChild(_label);
			//
			this.borderAlpha = 1;
		}

		override protected function updateSize():void
		{
			super.updateSize();
		}

		public static const DEFAULT_ITEM_HEIGHT:Number = 20;

		private var _data:Object;

		private var _labelField:String = "label";

		private var _label:Label;

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
