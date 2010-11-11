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
		
		override protected function createAndShowFiles(file:DirectoryFileData, index:uint, length:uint):void
		{
			super.createAndShowFiles(file, index, length);
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