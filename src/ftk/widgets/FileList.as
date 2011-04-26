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
package ftk.widgets
{
	import ftk.controls.ScrollPanel;
	import ftk.data.FileData;
	import ftk.data.FolderData;
	import ftk.errors.DataError;

	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	/**
	 * FileList
	 * 
	 * @author Tang Bin
	 * @since 2010.11
	 */
	public class FileList extends ScrollPanel
	{
		/******************* OVERRIDE **************************************************/
		override protected function updateSize():void
		{
			// if folderData is not set, do nothing.
			if (folderData == null) return;
			// STEP 1, set all exist item is not updated
			for each (var itemData:ItemData in items)
			{
				itemData.update = false;
			}
			// STEP 2, update items
			folderData.forEachFile(createAndShowFiles);
			// STEP 3, after update items, the items whose update is false will be removed.
			for each (var itemData2:ItemData in items)
			{
				var item:FileListItem = itemData2.item as FileListItem;
				if (!itemData2.update)
				{
					items[item.data.name] = null;
					delete items[item.data.name];
					this.container.removeChild(item);
				}
			}
			// STEP 4, set position
			beforeSetItemPosition();
			folderData.forEachFile(doForEachItem);
			// STEP 5, refresh scroll panel
			super.updateSize();
		}

		/******************* DEFINE ****************************************************/
		/**
		 * 
		 * @default 
		 */
		protected var item_height:Number = 32;

		/**
		 * 
		 * @default 
		 */
		protected var folderData:FolderData;

		/**
		 * 
		 * @default 
		 */
		protected var items:Dictionary = new Dictionary();

		private var forEachItemFunc:Function;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 * @param data
		 */
		public function FileList(data:FolderData = null)
		{
			super(false, true);
			this.dragable = false;
			if (data == null) data = new FolderData();
			showDirectory(data);
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 * @param data
		 */
		public function showDirectory(data:FolderData):void
		{
			folderData = data;
			this.updateSize();
		}

		/******************* PROTECTED *************************************************/
		/**
		 * 
		 * @param file
		 */
		protected function createAndShowFiles(file:FileData):void
		{
			var itemData:ItemData = getItemData(file.name);
			if (itemData == null)
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

		/******************* PRIVATE ***************************************************/
		private function doForEachItem(file:FileData, index:uint, length:uint):void
		{
			var item:FileListItem = getItemData(file.name).item as FileListItem;
			if (item == null)
			{
				throw new DataError(DataError.DATA_NULL);
			}
			else
			{
				setItemPosition(item, index, length);
			}
		}

		private function getItemData(name:String):ItemData
		{
			return items[name] as ItemData;
		}

		/******************* HANDLER ***************************************************/
		private function clickItemHandler(e:MouseEvent):void
		{
			var data:FileData = (e.currentTarget as FileListItem).data;
			if (e.ctrlKey)
			{
				// select more
				if (folderData.currentSelected[data.name] == null)
				{
					this.selectedItem(data, true);
					folderData.currentSelected[data.name] = data;
				}
				else
				{
					this.selectedItem(data, false);
					folderData.currentSelected[data.name] = null;
					delete folderData.currentSelected[data.name];
				}
			}
			else
			{
				// select one
				for each (var oldData:FileData in folderData.currentSelected)
				{
					this.selectedItem(oldData, false);
				}
				this.selectedItem(data, true);
				folderData.currentSelected = new Dictionary();
				folderData.currentSelected[data.name] = data;
			}
		}

		private function selectedItem(data:FileData, selected:Boolean):void
		{
			var item:FileListItem = getItemData(data.name).item as FileListItem;
			if (item != null)
			{
				item.selected = selected;
			}
		}
	}
}
import ftk.widgets.FileListItem;

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