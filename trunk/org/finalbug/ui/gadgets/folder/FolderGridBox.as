/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
	import org.finalbug.data.DirectoryData;
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
		//***************************************/
		
		private var grid:Grid;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
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
		
		override protected function updateView():void
		{
			super.updateView();
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