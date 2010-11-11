/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.gadgets.folder
{
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
		
		protected var dd:DirectoryData;
		
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
			if(dd != null) dd.forEachFile(createAndShowFiles);
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
			// should be overrided in grid/list/tree boxes
		}
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
	}
}