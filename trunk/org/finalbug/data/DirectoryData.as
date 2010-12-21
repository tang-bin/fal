/******************************************************
 * Tang Bin
  *****************************************************/  
package org.finalbug.data
{
	import flash.utils.Dictionary;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.data.DataModel;
	import org.finalbug.data.DirectoryFileData;
	
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
		//***************************************
		
		private var _folderName:String = "";
		private var _folderPath:String = "";
		private var _folderIcon:Image;
		
		private var _dirFirst:Boolean = true;
		private var _showHide:Boolean = false;
		private var _sortBy:String = "name";
		private var _descOrder:Boolean = false;
		
		private var files:Dictionary = new Dictionary();
		private var fileNames:Array = new Array();
		
		public var currentSelected:Dictionary = new Dictionary();
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
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
			return fileNames.length;
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function DirectoryData()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function addFile(file:DirectoryFileData):void
		{
			var fileName:String = file.name;
			if(files[fileName] != null)
			{
				throw new DataError(DataError.DATA_EXIST);
			}
			files[fileName] = file;
			fileNames.push(fileName);
			fileNames.sort();
		}
		
		public function removeFile(file:DirectoryFileData):void
		{
			var fileName:String = file.name;
			var thisFile:DirectoryFileData = files[fileName] as DirectoryFileData;
			if(thisFile != null && thisFile == file)
			{
				files[fileName] = null;
				delete files[fileName];
				removeFileName(fileName);
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		public function clear():void
		{
			files = new Dictionary();
			fileNames = new Array();
			currentSelected = new Dictionary();
		}
		
		public function hasFile(file:DirectoryFileData):Boolean
		{
			var thisFile:DirectoryFileData = files[file.name] as DirectoryFileData;
			return thisFile != null && thisFile == file;
		}
		
		public function getFileByName(name:String):DirectoryFileData
		{
			return files[name] as DirectoryFileData;;
		}
		
		/**
		 * function(file:DirectoryFileData, index:uint, length:uint):void
		 * 
		 * @param func
		 */		
		public function forEachFile(func:Function):void
		{
			var len:uint = fileNames.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				func.call(this, files[fileNames[i]] as DirectoryFileData, i, len);
			}
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function removeFileName(fileName:String):void
		{
			for(var i:uint = fileNames.length ; --i >= 0 ; )
			{
				if(fileNames[i] == fileName)
				{
					fileNames.splice(i, 1);
					break;
				}
			}
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}