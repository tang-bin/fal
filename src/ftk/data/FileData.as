// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.data
{
	/**
	 * FileData defines the data for one file.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class FileData extends DataModel
	{
		/**
		 * Create an new FileData.
		 * 
		 * @param type File's type.
		 */
		public function FileData(type:FileType)
		{
			super();
			this._type = type;
			_createDate = new Date();
			_lastModifyDate = new Date();
		}

		/**
		 * 
		 * @return 
		 */
		override public function toString():String
		{
			var str:String = "[Dir File :: " + "UID:" + this._uid + ", Name:" + this._name + ", Ext:" + this.ext + "]";
			return str;
		}

		private var _uid:String = "0";

		private var _isDir:Boolean = false;

		private var _name:String = "Directory File Data";

		private var _author:String = "Tang Bin";

		private var _createDate:Date;

		private var _lastModifyDate:Date;

		private var _type:FileType;

		/**
		 * File's extension.
		 */
		public function get ext():String
		{
			return this._type.ext;
		}

		/**
		 * File's name
		 */
		public function get name():String
		{
			return this._name;
		}

		public function set name(value:String):void
		{
			var oldValue:String = this._name;
			this._name = value;
			this.dispatchChangeData("name", oldValue, value);
		}

		public function get isDir():Boolean
		{
			return _isDir;
		}

		public function set isDir(value:Boolean):void
		{
			if (_isDir != value)
			{
				_isDir = value;
				this.dispatchChangeData("isDir", !value, value);
			}
		}

		public function get author():String
		{
			return _author;
		}

		public function set author(value:String):void
		{
			if (value != _author)
			{
				var oldValue:String = _author;
				_author = value;
				this.dispatchChangeData("author", oldValue, value);
			}
		}

		public function get createTime():uint
		{
			return _createDate.time;
		}

		public function set createTime(value:uint):void
		{
			if (_createDate.time != value)
			{
				var oldValue:uint = _createDate.time;
				_createDate.time = value;
				this.dispatchChangeData("createTime", oldValue, value);
			}
		}

		public function get lastModifyTime():uint
		{
			return _lastModifyDate.time;
		}

		public function set lastModifyTime(value:uint):void
		{
			if (_lastModifyDate.time != value)
			{
				var oldValue:uint = _lastModifyDate.time;
				_lastModifyDate.time = value;
				this.dispatchChangeData("lastModifyTime", oldValue, value);
			}
		}
	}
}