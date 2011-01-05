//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.widgets
{
	import flash.text.TextFormat;
	
	import org.finalbug.data.FileData;
	import org.finalbug.data.FileType;
	import org.finalbug.data.FileTypeModel;
	import org.finalbug.data.IconModel;
	import org.finalbug.data.Position;
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.control.Container;
	import org.finalbug.ui.control.Icon;
	import org.finalbug.ui.control.Label;
	import org.finalbug.ui.style.Style;
	import org.finalbug.utils.DataUtil;
	
	
	/**
	 * FolderItem
	 * 
	 * @author Tang Bin
	 * @since 2010.11
	 */	
	public class FileListItem extends Container
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
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
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get labelPosition():String
		{
			return _position;
		}
		/**
		 * 
		 * @param value
		 * @throws DataError
		 */
		public function set labelPosition(value:String):void
		{
			if(value != _position)
			{
				if(!DataUtil.included(value, Position.BOTTOM, Position.LEFT, Position.RIGHT, Position.TOP))
				{
					throw new DataError(DataError.TYPE_ERROR);
				}
				_position = value;
				this.updateView();
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
		/**
		 * 
		 * @param value
		 */
		public function set extraLabel(value:String):void
		{
			if(value != _extraLabel)
			{
				_extraLabel = value;
				this.updateView();
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
		/**
		 * 
		 * @param value
		 */
		public function set selected(value:Boolean):void
		{
			if(value != _selected)
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
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @param data
		 */
		public function FileListItem(data:FileData)
		{
			super();
			this._data = data;
			createElements();
			updateView();
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		override protected function updateView():void
		{
			super.updateView();
			if(icon == null && txt == null) return;
			if(this.displayWidth >0 && this.displayHeight > 0)
			{
				if(icon != null)
				{
					icon.visible = true;
					var iconSize:Number = 0;
					if(_position == Position.TOP || _position == Position.BOTTOM)
					{
						if(this.displayHeight < HIDE_LABEL_HEIGHT)
						{
							// it is too small to display the labels
							txt.visible = extra.visible = false;
							iconSize = Math.min(this.displayHeight, this.displayWidth);
							iconSize -= 2 * SPACE;
							icon.resize(iconSize, iconSize);
							icon.toCenter();
						}
						else
						{
							txt.visible = true;
							extra.visible = false;
							//
							iconSize = Math.min(this.displayHeight - LABEL_HEIGHT, this.displayWidth);
							iconSize -= 2 * SPACE;
							icon.resize(iconSize, iconSize);
							icon.x = (this.displayWidth - icon.width) / 2;
							icon.y = (this.displayHeight - LABEL_HEIGHT - icon.height) / 2;
							//
							txt.width = this.displayWidth - 2 * SPACE;
							txt.x = SPACE;
							txt.y = this.displayHeight - txt.height - SPACE;
						}
					}
				}
			}
			else
			{
				if(icon != null) icon.visible = false;
				txt.visible = false;
				extra.visible = false;
			}
		}
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function createElements():void
		{
			if(icon != null && this.contains(icon))
			{
				this.removeChild(icon);
			}
			icon = getIcon();
			this.addChild(icon);
			//
			if(txt == null)
			{
				txt = new Label(_data.name, new TextFormat(Style.defaultFont, LABEL_SIZE, LABEL_COLOR, true));
				this.addChild(txt);
			}
			//
			if(extra == null)
			{
				extra = new Label("");
				this.addAll(extra);
			}
			this.backgroundColor = SELECTED_COLOR;
			this.backgroundAlpha = 0;
			this.borderColor = SELECTED_BORDER;
			this.borderAlpha = 0;
		}
		
		private function getIcon():Icon
		{
			if(FileTypeModel.instance.registered(_data.ext))
			{
				var fileType:FileType = FileTypeModel.instance.getFileType(_data.ext);
				return fileType.icon;
			}
			else
			{
				return IconModel.instance.unknowIcon;
			}
		}
		
		//#######################################
		// HANDLER
		//#######################################
	}
}