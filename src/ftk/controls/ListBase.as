package ftk.controls
{
	import ftk.data.Position;

	import flash.display.DisplayObject;

	import ftk.layout.Container;

	/**
	 * @author Tang Bin
	 * @since 2011.05
	 */
	public class ListBase extends Container
	{
		public function ListBase()
		{
			super();
			// this.autoRank = true;
			this.rankType = Position.VERTICAL;
			this.align = Position.LEFT;
			this.valign = Position.TOP;
		}

		private var _data:Array;

		private var _renderer:Class;

		private var _labelField:String = "label";

		public function get data():Array
		{
			return _data;
		}

		public function set data(value:Array):void
		{
			if (_data != value)
			{
				_data = value;
				rebuildList();
			}
		}

		public function get renderer():Class
		{
			return _renderer;
		}

		public function set renderer(value:Class):void
		{
			if (value != _renderer)
			{
				_renderer = value;
				rebuildList();
			}
		}

		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			if (value != _labelField && value != "")
			{
				_labelField = value;
				rebuildList();
			}
		}

		private function rebuildList():void
		{
			this.removeAll();
			//
			var cls:Class = _renderer == null ? ftk.controls.ListItemBase : _renderer;
			var num:uint = _data.length;
			for (var i:uint = 0 ; i < num ; i++)
			{
				var item:DisplayObject = new cls() as DisplayObject;
				if (item != null && item is IListItemInterface)
				{
					item["labelField"] = this._labelField;
					item["data"] = _data[i];
					this.addChild(item);
				}
			}
			this.rank();
		}
	}
}
