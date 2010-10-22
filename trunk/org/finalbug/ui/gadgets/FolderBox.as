/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.gadgets
{
	import org.finalbug.data.DirectoryData;
	import org.finalbug.ui.control.ScrollBox;
	
	
	/**
	 * FolderBox
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class FolderBox extends ScrollBox
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		protected var dd:DirectoryData;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function FolderBox(data:DirectoryData = null)
		{
			super(false, true);
			this.setLayoutValue("width", "100%");
			this.setLayoutValue("height", "100%");
			showDirectory(data);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		public function showDirectory(data:DirectoryData):void
		{
			dd = data;
		}
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}