/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import org.finalbug.data.DirectoryData;
	import org.finalbug.data.DirectoryFileData;
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.control.ScrollPanel;
	
	
	/**
	 * FolderBox
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class FolderBox extends ScrollPanel
	{
		//***************************************
		// DEFINE
		//***************************************
		
		protected var item_width:Number = 64;
		protected var item_height:Number = 64;
		
		protected var dd:DirectoryData;
		protected var items:Dictionary = new Dictionary();
		
		private var forEachItemFunc:Function;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FolderBox(data:DirectoryData = null)
		{
			super(false, true);
			this.dragable = false;
			this.setLayoutValue("width", "100%");
			this.setLayoutValue("height", "100%");
			if(data == null) data = new DirectoryData();
			showDirectory(data);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function updateView():void
		{
			if(dd == null) return;
			// step1, set all exist item is not updated
			for each(var itemData:Object in items)
			{
				itemData.update = false;
			}
			// step2, update items
			dd.forEachFile(createAndShowFiles);
			// step3, after update items, the items whose update is false will be removed.
			for each(var itemData2:Object in items)
			{
				var item:FolderItem = itemData2.item as FolderItem;
				if(!itemData2.update)
				{
					items[item.data.name] = null;
					delete items[item.data.name];
					this.container.removeChild(item);
				}
			}
			// step 4, set position
			beforeSetItemPosition();
			dd.forEachFile(doForEachItem);
			// step 5, refresh scroll panel
			super.updateView();
		}
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function showDirectory(data:DirectoryData):void
		{
			dd = data;
			this.updateView();
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		protected function createAndShowFiles(file:DirectoryFileData, index:uint, length:uint):void
		{
			var itemData:ItemData = items[file.name] as ItemData;
			if(itemData == null)
			{
				var item:FolderItem = new FolderItem(file);
				this.container.addChild(item);
				itemData = new ItemData();
				itemData.item = item;
				items[file.name] = itemData;
				//
				item.addEventListener(MouseEvent.CLICK, clickItemHandler);
			}
			itemData.update = true;
		}
		
		protected function beforeSetItemPosition():void
		{
			// should be overrided in grid/list/tree boxes.
		}
		
		protected function setItemPosition(item:FolderItem, index:uint, length:uint):void
		{
			// should be overrided in grid/list/tree boxes.
		}
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function doForEachItem(file:DirectoryFileData, index:uint, length:uint):void
		{
			var item:FolderItem = items[file.name].item as FolderItem;
			if(item == null)
			{
				throw new DataError(DataError.DATA_NULL);
			}
			else
			{
				setItemPosition(item, index, length);
			}
		}
		
		//***************************************
		// HANDLER
		//***************************************
		
		private function clickItemHandler(e:MouseEvent):void
		{
			var data:DirectoryFileData = (e.currentTarget as FolderItem).data;
			if(e.ctrlKey)
			{
				// select more
				if(dd.currentSelected[data.name] == null)
				{
					this.selectedItem(data, true);
					dd.currentSelected[data.name] = data;
				}
				else
				{
					this.selectedItem(data, false);
					dd.currentSelected[data.name] = null;
					delete dd.currentSelected[data.name];
				}
			}
			else
			{
				// select one
				for each(var oldData:DirectoryFileData in dd.currentSelected)
				{
					this.selectedItem(oldData, false);
				}
				this.selectedItem(data, true);
				dd.currentSelected = new Dictionary();
				dd.currentSelected[data.name] = data;
			}
		}
		
		private function selectedItem(data:DirectoryFileData, selected:Boolean):void
		{
			var item:FolderItem = items[data.name].item as FolderItem;
			if(item != null)
			{
				item.selected = selected;
			}
		}
	}
}
import org.finalbug.ui.gadgets.folder.FolderItem;

class ItemData
{
	public var update:Boolean = false;
	public var item:FolderItem;
}