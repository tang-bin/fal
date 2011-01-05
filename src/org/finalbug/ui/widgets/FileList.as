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
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import org.finalbug.data.FolderData;
	import org.finalbug.data.FileData;
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.control.ScrollPanel;
	
	/**
	 * FileList
	 * 
	 * @author Tang Bin
	 * @since 2010.11
	 */	
	public class FileList extends ScrollPanel
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
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
				var item:FileListItem = itemData2.item as FileListItem;
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
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		protected var item_height:Number = 32;
		
		/**
		 * 
		 * @default 
		 */
		protected var dd:FolderData;
		/**
		 * 
		 * @default 
		 */
		protected var items:Dictionary = new Dictionary();
		
		private var forEachItemFunc:Function;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @param data
		 */
		public function FileList(data:FolderData = null)
		{
			super(false, true);
			this.dragable = false;
			if(data == null) data = new FolderData();
			showDirectory(data);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param data
		 */
		public function showDirectory(data:FolderData):void
		{
			dd = data;
			this.updateView();
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		/**
		 * 
		 * @param file
		 * @param index
		 * @param length
		 */
		protected function createAndShowFiles(file:FileData, index:uint, length:uint):void
		{
			var itemData:ItemData = items[file.name] as ItemData;
			if(itemData == null)
			{
				var item:FileListItem = new FileListItem(file);
				this.container.addChild(item);
				itemData = new ItemData();
				itemData.item = item;
				items[file.name] = itemData;
				//
				item.addEventListener(MouseEvent.CLICK, clickItemHandler);
			}
			itemData.update = true;
		}
		
		/**
		 * 
		 */
		protected function beforeSetItemPosition():void
		{
			// should be overrided in grid/list/tree boxes.
		}
		
		/**
		 * 
		 * @param item
		 * @param index
		 * @param length
		 */
		protected function setItemPosition(item:FileListItem, index:uint, length:uint):void
		{
			// should be overrided in grid/list/tree boxes.
		}
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function doForEachItem(file:FileData, index:uint, length:uint):void
		{
			var item:FileListItem = items[file.name].item as FileListItem;
			if(item == null)
			{
				throw new DataError(DataError.DATA_NULL);
			}
			else
			{
				setItemPosition(item, index, length);
			}
		}
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function clickItemHandler(e:MouseEvent):void
		{
			var data:FileData = (e.currentTarget as FileListItem).data;
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
				for each(var oldData:FileData in dd.currentSelected)
				{
					this.selectedItem(oldData, false);
				}
				this.selectedItem(data, true);
				dd.currentSelected = new Dictionary();
				dd.currentSelected[data.name] = data;
			}
		}
		
		private function selectedItem(data:FileData, selected:Boolean):void
		{
			var item:FileListItem = items[data.name].item as FileListItem;
			if(item != null)
			{
				item.selected = selected;
			}
		}
	}
}
import org.finalbug.ui.widgets.FileListItem;


class ItemData
{
	/**
	 * 
	 * @default 
	 */
	public var update:Boolean = false;
	/**
	 * 
	 * @default 
	 */
	public var item:FileListItem;
}