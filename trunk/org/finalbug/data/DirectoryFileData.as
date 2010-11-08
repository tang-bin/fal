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
		//***************************************/
		
		private var _uid:String = "";
		private var _isDir:Boolean = false;
		private var _name:String = "";
		private var _author:String = "";
		private var _createDate:Date;
		private var _lastModifyDate:Date;
		private var _fileType:String = "";
		private var _ext:String = "";
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
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
		//***************************************/
		
		public function DirectoryFileData()
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