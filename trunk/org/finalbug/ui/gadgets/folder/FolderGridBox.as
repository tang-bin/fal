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
		
		private var grid:Grid;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FolderGridBox(data:DirectoryData = null)
		{
			super(data);
			grid = new Grid();
			this.container.addChild(grid);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function createAndShowFiles(file:DirectoryFileData, index:uint, length:uint):void
		{
			trace(file);
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