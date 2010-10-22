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
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
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