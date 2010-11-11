/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.DirectoryData;
	import org.finalbug.data.DirectoryFileData;
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
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FolderBox(data:DirectoryData = null)
		{
			super(false, true);
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
			super.updateView();
			// step1, set all exist item is not updated
			for each(var obj:Object in items)
			{
				items.update = false;
			}
			// step2, update items
			if(dd != null) dd.forEachFile(createAndShowFiles);
			// step3, after update items, the items whose update is false will be removed.
			for each(var obj2:Object in items)
			{
				var item:FolderItem = obj2.item as FolderItem;
				if(!items.update)
				{
					items[item.data.name] = null;
					delete items[item.data.name];
					this.container.removeChild(item);
				}
			}
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
			var item:FolderItem = items[file.name] as FolderItem;
			if(item == null)
			{
				item = new FolderItem(file);
				this.container.addChild(item);
				items[file.name] = {update:true, item:item};
			}
			items[file.name].update = true;
		}
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
	}
}