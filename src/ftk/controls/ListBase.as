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
	import ftk.events.UIEvent;
	import ftk.layout.Container;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	[Event(name="change", type="ftk.events.UIEvent")]
	/**
	 * Not finished.
	 * 
	 * @author Tang Bin
	 * @since 2011.05
	 */
	public class ListBase extends Container
	{
		public function ListBase()
		{
			super();
			this.autoRank = true;
			this.rankType = Position.VERTICAL;
			this.align = Position.LEFT;
			this.valign = Position.TOP;
		}

		private var _data:Array;

		private var _renderer:Class;

		private var _labelField:String = "label";

		private var _selectedItems:Dictionary = new Dictionary();

		private var _mutilSelected:Boolean = false;

		private var _selectedCount:uint = 0;

		public function get mutilSelected():Boolean
		{
			return _mutilSelected;
		}

		public function set mutilSelected(value:Boolean):void
		{
			if (_mutilSelected != value)
			{
				_mutilSelected = value;
				if (!value)
				{
					clearSelected();
				}
			}
		}

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

		public function get selectedItem():Object
		{
			return null;
			// TODO;
		}

		public function set selectedItem(value:Object):void
		{
			// TODO;
		}

		public function get selectedItems():Array
		{
			return null;
			// TODO
		}

		public function set selectedItems(value:Array):void
		{
			// TODO;
		}

		public function get selectedIndex():uint
		{
			return 0;
			// TODO;
		}

		public function set selectedIndex(value:uint):void
		{
			// TODO
		}

		public function get selectedIndexes():Array
		{
			return null;
			// TODO;
		}

		public function set selectedIndexes(value:Array):void
		{
			// TODO;
		}

		private function clearSelected():void
		{
			for (var item:* in _selectedItems)
			{
				(item as IListItemInterface).selected = false;
			}
			_selectedItems = new Dictionary();
			_selectedCount = 0;
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
					//
					item.addEventListener(MouseEvent.CLICK, clickItemHandler);
				}
			}
		}

		private function dispatchChanged():void
		{
			var ee:UIEvent = new UIEvent(UIEvent.CHANGE);
			this.dispatchEvent(ee);
		}

		private function clickItemHandler(e:MouseEvent):void
		{
			trace("click item");
			var item:IListItemInterface = e.currentTarget as IListItemInterface;
			if (item != null)
			{
				if (e.ctrlKey && _mutilSelected)
				{
					item.selected = !item.selected;
					if (item.selected)
					{
						_selectedItems[item] = true;
						_selectedCount++;
					}
					else
					{
						delete _selectedItems[item];
						_selectedCount--;
					}
					dispatchChanged();
				}
				else
				{
					if (_selectedCount == 1 && _selectedItems[item] == true)
					{
						// do nothing
					}
					else
					{
						clearSelected();
						item.selected = true;
						_selectedCount = 1;
						_selectedItems[item] = true;
						dispatchChanged();
					}
				}
			}
		}
	}
}
