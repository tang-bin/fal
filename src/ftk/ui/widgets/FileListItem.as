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
package ftk.ui.widgets
{
	import flash.text.TextFormat;
	import ftk.data.FileData;
	import ftk.data.FileType;
	import ftk.data.FileTypeModel;
	import ftk.data.IconModel;
	import ftk.data.Position;
	import ftk.errors.DataError;
	import ftk.ui.control.Container;
	import ftk.ui.control.Icon;
	import ftk.ui.control.Label;
	import ftk.ui.style.Style;
	import ftk.utils.DataUtil;


	/**
	 * FolderItem
	 * 
	 * @author Tang Bin
	 * @since 2010.11
	 */
	public class FileListItem extends Container
	{

		/******************* OVERRIDE **************************************************/
		override protected function updateSize():void
		{
			super.updateSize();
			// if no icon and txt, do nothing.
			if (icon == null && txt == null) return;
			// set position.
			if (this.width > 0 && this.height > 0)
			{
				if (icon != null)
				{
					icon.visible = true;
					var iconSize:Number = 0;
					if (_position == Position.RIGHT)
					{
						if (this.width < this.height * 1.5)
						{
							// width is too small to show text.
							txt.visible = extra.visible = false;
							iconSize = Math.min(this.height, this.width);
							iconSize -= 2 * SPACE;
							icon.resize(iconSize, iconSize);
							icon.toCenter();
						}
						else
						{
							// show text beside icon.
							txt.visible = extra.visible = true;
							//
							iconSize = Math.min(this.height, this.width);
							iconSize -= 2 * SPACE;
							icon.resize(iconSize, iconSize);
							icon.x = icon.y = SPACE;
							//
							txt.width = this.width - 3 * SPACE - iconSize;
							trace(this.width, iconSize, txt.width);
							txt.x = 2 * SPACE + iconSize;
							txt.y = SPACE;
							//
							extra.width = txt.width;
							extra.x = txt.x;
							extra.y = txt.y + txt.height + SPACE;
						}
					}
					else
					{
						if (this.height < HIDE_LABEL_HEIGHT)
						{
							// it is too small to display the label, txt and extra will not be shown.
							txt.visible = extra.visible = false;
							iconSize = Math.min(this.height, this.width);
							iconSize -= 2 * SPACE;
							icon.resize(iconSize, iconSize);
							icon.toCenter();
						}
						else
						{
							txt.visible = true;
							extra.visible = false;
							//
							iconSize = Math.min(this.height - LABEL_HEIGHT, this.width);
							iconSize -= 2 * SPACE;
							icon.resize(iconSize, iconSize);
							icon.x = (this.width - icon.width) / 2;
							icon.y = (this.height - LABEL_HEIGHT - icon.height) / 2;
							//
							txt.width = this.width - 2 * SPACE;
							txt.x = SPACE;
							txt.y = this.height - txt.height - SPACE;
						}
					}
				}
				else
				{
					// icon must not be null here, if null, the code logic is breaken.
				}
			}
			else
			{
				if (icon != null) icon.visible = false;
				txt.visible = false;
				extra.visible = false;
			}
		}

		/******************* DEFINE ****************************************************/
		public static const SIZE_MEDIUM:Number = 64;

		public static const SIZE_SMALL:Number = 32;

		public static const SIZE_TINY:Number = 20;

		public static const SIZE_BIG:Number = 88;

		public static const SIZE_LARGE:Number = 128;

		private static const HIDE_LABEL_HEIGHT:Number = 30;

		private static const SPACE:Number = 2;

		private static const LABEL_HEIGHT:Number = 20;

		private static const LABEL_COLOR:uint = 0x333333;

		private static const LABEL_SIZE:uint = 12;

		private static const SELECTED_COLOR:uint = 0xDDDDDD;

		private static const SELECTED_BORDER:uint = 0x999999;

		private var _data:FileData;

		private var icon:Icon;

		private var txt:Label;

		private var extra:Label;

		private var _position:String = Position.BOTTOM;

		private var _extraLabel:String = "";

		private var _selected:Boolean = false;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * 
		 * @throws DataError
		 */
		public function get labelPosition():String
		{
			return _position;
		}

		public function set labelPosition(value:String):void
		{
			if (value != _position)
			{
				if (!DataUtil.included(value, Position.BOTTOM, Position.RIGHT))
				{
					throw new DataError(DataError.TYPE_ERROR);
				}
				_position = value;
				this.updateSize();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get extraLabel():String
		{
			return _extraLabel;
		}

		public function set extraLabel(value:String):void
		{
			if (value != _extraLabel)
			{
				_extraLabel = value;
				this.updateSize();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get selected():Boolean
		{
			return this._selected;
		}

		public function set selected(value:Boolean):void
		{
			if (value != _selected)
			{
				_selected = value;
				this.backgroundAlpha = _selected ? 1 : 0;
				this.borderAlpha = _selected ? 1 : 0;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get data():FileData
		{
			return _data;
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 * @param data
		 */
		public function FileListItem(data:FileData)
		{
			super();
			// init and save data.
			this.initSize(SIZE_MEDIUM, SIZE_MEDIUM);
			this._data = data;
			// create children.
			if (icon != null && this.contains(icon))
			{
				this.removeChild(icon);
			}
			icon = getIcon();
			this.addChild(icon);
			//
			if (txt == null)
			{
				txt = new Label(_data.name, new TextFormat(Style.defaultFont, LABEL_SIZE, LABEL_COLOR, false));
				this.addChild(txt);
			}
			//
			if (extra == null)
			{
				extra = new Label("");
				this.addAll(extra);
			}
			this.backgroundColor = SELECTED_COLOR;
			this.backgroundAlpha = 0;
			this.borderColor = SELECTED_BORDER;
			this.borderAlpha = 0;
		}

		/******************* PUBLIC ****************************************************/
		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function getIcon():Icon
		{
			if (FileTypeModel.instance.registered(_data.ext))
			{
				var fileType:FileType = FileTypeModel.instance.getFileType(_data.ext);
				return fileType.icon;
			}
			else
			{
				return IconModel.instance.unknowIcon;
			}
		}
		/******************* HANDLER ***************************************************/
	}
}