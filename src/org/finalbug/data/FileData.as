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
	import org.finalbug.data.DataModel;

	/**
	 * FileData defines the data for on file.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class FileData extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/**
		 * 
		 * @return 
		 */
		override public function toString():String
		{
			var str:String = "[Dir File :: " + "UID:" + this._uid + ", Name:" + this._name + ", Ext:" + this.ext + "]";
			return str;
		}

		/******************* DEFINE ****************************************************/
		private var _uid:String = "0";

		private var _isDir:Boolean = false;

		private var _name:String = "Directory File Data";

		private var _author:String = "Tang Bin";

		private var _createDate:Date;

		private var _lastModifyDate:Date;

		private var _fileType:String = "";

		private var _type:FileType;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * 
		 * @return File's extension.
		 */
		public function get ext():String
		{
			return this._type.ext;
		}

		/**
		 * 
		 * @return File's name
		 */
		public function get name():String
		{
			return this._name;
		}

		/**
		 * 
		 * @param value
		 */
		public function set name(value:String):void
		{
			var oldValue:String = this._name;
			this._name = value;
			this.dispatchChangeData("name", oldValue, value);
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new FileData.
		 * 
		 * @param type File's type.
		 */
		public function FileData(type:FileType)
		{
			super();
			this._type = type;
		}
		/******************* PUBLIC ****************************************************/
		
		
		
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}