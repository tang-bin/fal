/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
	import org.finalbug.data.DirectoryData;
	import org.finalbug.data.DirectoryFileData;
	import org.finalbug.framework.layout.Grid;

	/**
	 * FolderBox
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */	
	public class FolderGridBox extends FolderBox
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private const DEFAULT_SIZE:Number = 64;
		private const ITEM_SPACE:Number = 8;
		
		// x and y index for set position.
		private var posx:uint = 0;
		private var posy:uint = 0;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FolderGridBox(data:DirectoryData = null)
		{
			super(data);
			this.item_width = this.item_height = DEFAULT_SIZE;
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function beforeSetItemPosition():void
		{
			posx = posy = 0;
		}
		
		override protected function setItemPosition(item:FolderItem, index:uint, length:uint):void
		{
			super.setItemPosition(item, index, length);
			item.width = this.item_width;
			item.height = this.item_height;
			var targetX:Number = ITEM_SPACE + posx * (this.item_width + ITEM_SPACE);
			var targetY:Number = ITEM_SPACE + posy * (this.item_height + ITEM_SPACE);
			item.x = targetX;
			item.y = targetY;
			//
			if(targetX + 2 * (this.item_width + ITEM_SPACE) > this.containerWidth)
			{
				posy += 1;
				posx = 0;
			}
			else
			{
				posx += 1;
			}
		}
		
		//***************************************
		// PUBLIC
		//***************************************
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
	}
}