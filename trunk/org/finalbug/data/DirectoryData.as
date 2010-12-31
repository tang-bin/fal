//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
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
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var _folderName:String = "";
		private var _folderPath:String = "";
		private var _folderIcon:Image;
		
		private var _dirFirst:Boolean = true;
		private var _showHide:Boolean = false;
		private var _sortBy:String = "name";
		private var _descOrder:Boolean = false;
		
		private var files:Dictionary = new Dictionary();
		private var fileNames:Array = new Array();
		
		/**
		 * 
		 * @default 
		 */
		public var currentSelected:Dictionary = new Dictionary();
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get folderName():String
		{
			return _folderName;
		}
		/**
		 * 
		 * @param value
		 */
		public function set folderName(value:String):void
		{
			// TODO
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get folderPath():String
		{
			return _folderPath;
		}
		/**
		 * 
		 * @param value
		 */
		public function set folderPath(value:String):void
		{
			// TODO
		}
		/**
		 * 
		 * @return 
		 */
		public function get folderIcon():Image
		{
			return _folderIcon;
		}
		/**
		 * 
		 * @param value
		 */
		public function set folderIcon(value:Image):void
		{
			// TODO
		}
		
		/**
		 * 
		 * @return 
		 */
		public function length():uint
		{
			return fileNames.length;
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function DirectoryData()
		{
			super();
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param file
		 * @throws DataError
		 */
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
		
		/**
		 * 
		 * @param file
		 * @throws DataError
		 */
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
		
		/**
		 * 
		 */
		public function clear():void
		{
			files = new Dictionary();
			fileNames = new Array();
			currentSelected = new Dictionary();
		}
		
		/**
		 * 
		 * @param file
		 * @return 
		 */
		public function hasFile(file:DirectoryFileData):Boolean
		{
			var thisFile:DirectoryFileData = files[file.name] as DirectoryFileData;
			return thisFile != null && thisFile == file;
		}
		
		/**
		 * 
		 * @param name
		 * @return 
		 */
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
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
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
		
		//#######################################
		// HANDLER
		//#######################################
	}
}