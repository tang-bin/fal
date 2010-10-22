/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.data
{
	import org.finalbug.ui.glazes.Image;
	
	/**
	 * DirectoryData
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class DirectoryData extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private var _folderName:String = "";
		private var _folderPath:String = "";
		private var _folderIcon:Image;
		
		private var _dirFirst:Boolean = true;
		private var _showHide:Boolean = false;
		private var _sortBy:String = "name";
		private var _descOrder:Boolean = false;
		
		private var files:Array = new Array();
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get folderName():String
		{
			return _folderName;
		}
		public function set folderName(value:String):void
		{
			// TODO
		}
		
		public function get folderPath():String
		{
			return _folderPath;
		}
		public function set folderPath(value:String):void
		{
			// TODO
		}
		public function get folderIcon():Image
		{
			return _folderIcon;
		}
		public function set folderIcon(value:Image):void
		{
			// TODO
		}
		
		public function length():uint
		{
			return files.length;
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function DirectoryData()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		public function addFile(file:DirectoryFileData):void
		{
			
		}
		
		public function removeFile(file:DirectoryData):void
		{
			
		}
		
		public function clear():void
		{
			
		}
		
		public function hasFile(file:DirectoryFileData):Boolean
		{
			return false;
		}
		
		public function getFileByName(name:String):DirectoryFileData
		{
			return null;
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