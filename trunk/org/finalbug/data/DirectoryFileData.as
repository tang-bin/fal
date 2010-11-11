/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.data
{
	
	/**
	 * DirectoryFileData
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class DirectoryFileData extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private var _uid:String = "0";
		private var _isDir:Boolean = false;
		private var _name:String = "Directory File Data";
		private var _author:String = "Tang Bin";
		private var _createDate:Date;
		private var _lastModifyDate:Date;
		private var _fileType:String = "";
		private var _ext:String = "txt";
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get ext():String
		{
			return this._ext;
		}
		public function set ext(value:String):void
		{
			var oldValue:String = this._ext;
			this._ext = value;
			this.dispatchChangeData("ext", oldValue, value);
		}
		
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
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function DirectoryFileData()
		{
			super();
		}
		
		override public function toString():String
		{
			var str:String = "[Dir File :: " +
				"UID:" + this._uid +
				", Name:" + this._name +
				", Ext:" + this._ext + 
				"]";
			return str;
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
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