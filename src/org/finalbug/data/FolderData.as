// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.data
{
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.glazes.Image;

	import flash.utils.Dictionary;

	/**
	 * FolderData defines the data for one folder.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class FolderData extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		private var _name:String = "";

		private var _path:String = "";

		private var _icon:Image;

		private var _dirFirst:Boolean = true;

		private var _showHide:Boolean = false;

		private var _sortBy:String = "name";

		private var _descOrder:Boolean = false;

		private var files:Dictionary = new Dictionary();

		private var fileNames:Array = new Array();

		private var _currentSelected:Dictionary = new Dictionary();

		/******************* GETTER and SETTER *****************************************/
		/**
		 * folder's name
		 */
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			// TODO
		}

		/**
		 * 
		 */
		public function get dirFirst():Boolean
		{
			return _dirFirst;
		}

		public function set dirFirst(value:Boolean):void
		{
			// TODO
		}

		/**
		 * 
		 */
		public function get showHide():Boolean
		{
			return _showHide;
		}

		public function set showHide(value:Boolean):void
		{
			// TODO
		}

		/**
		 * 
		 */
		public function get sortBy():String
		{
			return _sortBy;
		}

		public function set sortBy(value:String):void
		{
			// TODO
		}

		/**
		 * 
		 */
		public function get descOrder():Boolean
		{
			return _descOrder;
		}

		public function set descOrder(value:Boolean):void
		{
			// TODO
		}

		/**
		 * 
		 * @return 
		 */
		public function get path():String
		{
			return _path;
		}

		/**
		 * 
		 * @param value
		 */
		public function set path(value:String):void
		{
			// TODO
		}

		/**
		 * 
		 * @return 
		 */
		public function get icon():Image
		{
			return _icon;
		}

		/**
		 * 
		 * @param value
		 */
		public function set icon(value:Image):void
		{
			// TODO
		}

		/**
		 * Number of files in folder.
		 * 
		 * @return 
		 */
		public function get numFiles():uint
		{
			return fileNames.length;
		}

		/**
		 * @return Selected files in folder.
		 */
		public function get currentSelected():Dictionary
		{
			return _currentSelected;
		}

		/**
		 * 
		 * @param value
		 */
		public function set currentSelected(value:Dictionary):void
		{
			// TODO:
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new FolderData.
		 */
		public function FolderData()
		{
			super();
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Add a file into folder.(data operate)
		 * 
		 * @param file Data of added file.
		 * @throws DataError Throw DataError.Data_EXIST error if file exist.
		 */
		public function addFile(file:FileData):void
		{
			var fileName:String = file.name;
			if (files[fileName] != null)
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
		public function removeFile(file:FileData):void
		{
			var fileName:String = file.name;
			var thisFile:FileData = files[fileName] as FileData;
			if (thisFile != null && thisFile == file)
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
		 * Remove all files in folder.(data operate)
		 */
		public function clear():void
		{
			files = new Dictionary();
			fileNames = new Array();
			currentSelected = new Dictionary();
		}

		/**
		 * Check if one file is include in folder.
		 * 
		 * @param file
		 * @return 
		 */
		public function hasFile(file:FileData):Boolean
		{
			var thisFile:FileData = files[file.name] as FileData;
			return thisFile != null && thisFile == file;
		}

		/**
		 * Get file data by file's name.
		 * 
		 * @param name File's name
		 * @return File data. If file not exist, return null.
		 */
		public function getFileByName(name:String):FileData
		{
			return files[name] as FileData;
			;
		}

		/**
		 * Looping run the function for each files in folder.
		 * 
		 * @param func Function(file:DirectoryFileData, index:uint, length:uint):void
		 */
		public function forEachFile(func:Function):void
		{
			var len:uint = fileNames.length;
			for (var i:uint = 0 ; i < len ; i++)
			{
				func.call(this, files[fileNames[i]] as FileData, i, len);
			}
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function removeFileName(fileName:String):void
		{
			for (var i:uint = fileNames.length ; --i >= 0 ; )
			{
				if (fileNames[i] == fileName)
				{
					fileNames.splice(i, 1);
					break;
				}
			}
		}
		/******************* PRIVATE ***************************************************/
	}
}