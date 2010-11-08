/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
	import org.finalbug.data.DirectoryFileData;
	import org.finalbug.data.FileType;
	import org.finalbug.data.FileTypes;
	import org.finalbug.data.Icons;
	import org.finalbug.data.Position;
	import org.finalbug.errors.DataError;
	import org.finalbug.framework.layout.Container;
	import org.finalbug.ui.control.Icon;
	import org.finalbug.ui.control.Label;
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
		
		private var data:DirectoryFileData;
		private var icon:Icon;
		private var txt:Label;
		
		private var _position:String = Position.BOTTOM;
		private var _extraLabel:String = "";
		private var _showExtra:Boolean = false;
		
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
		
		public function get showExtra():Boolean
		{
			return _showExtra;
		}
		public function set showExtra(value:Boolean):void
		{
			if(_showExtra != value)
			{
				_showExtra = value;
				this.updateView();
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
				txt = new Label(data.name);
				this.addChild(txt);
			}
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