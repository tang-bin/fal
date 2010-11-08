/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
	import flash.text.TextFormat;
	
	import org.finalbug.data.DirectoryFileData;
	import org.finalbug.data.FileType;
	import org.finalbug.data.FileTypes;
	import org.finalbug.data.Icons;
	import org.finalbug.data.Position;
	import org.finalbug.errors.DataError;
	import org.finalbug.framework.layout.Container;
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
	public class FolderItem extends Container
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private static const HIDE_LABEL_HEIGHT:Number = 30;
		private static const SPACE:Number = 2;
		private static const LABEL_HEIGHT:Number = 20;
		private static const LABEL_COLOR:uint = 0x333333;
		private static const LABEL_SIZE:uint = 12;
		
		private static const SELECTED_COLOR:uint = 0xFF0000;
		
		private var data:DirectoryFileData;
		private var icon:Icon;
		private var txt:Label;
		private var extra:Label;
		
		private var _position:String = Position.BOTTOM;
		private var _extraLabel:String = "";
		private var _selected:Boolean = false;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get labelPosition():String
		{
			return _position;
		}
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
		
		public function get extraLabel():String
		{
			return _extraLabel;
		}
		public function set extraLabel(value:String):void
		{
			if(value != _extraLabel)
			{
				_extraLabel = value;
				this.updateView();
			}
		}
		
		public function get selected():Boolean
		{
			return this._selected;
		}
		public function set selected(value:Boolean):void
		{
			if(value != _selected)
			{
				_selected = value;
				this.backgroundAlpha = _selected ? 1 : 0;
			}
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function FolderItem(data:DirectoryFileData)
		{
			super();
			this.data = data;
			createElements();
			updateView();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		//***************************************
		// PROTECTED
		//***************************************/
		
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
		
		//***************************************
		// PRIVATE
		//***************************************/
		
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
				txt = new Label(data.name, new TextFormat(Style.DEFAULT_FONT, LABEL_SIZE, LABEL_COLOR, true));
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
		}
		
		private function getIcon():Icon
		{
			if(FileTypes.instance.registered(data.ext))
			{
				var fileType:FileType = FileTypes.instance.getFileType(data.ext);
				return fileType.icon;
			}
			else
			{
				return Icons.instance.unknowIcon;
			}
		}
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}