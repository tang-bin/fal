/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.data
{
	import org.finalbug.ui.control.Icon;
	
	/**
	 * FileType
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class FileType extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************
		
		public var description:String = "";
		
		private var _isDir:Boolean = false;
		private var _ext:String = "";
		private var _icon:Icon;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get isDir():Boolean
		{
			return _isDir;
		}
		public function set isDir(value:Boolean):void
		{
			if(value != _isDir)
			{
				_isDir = value;
				// TODO, change view or data. and dispatch event.
			}
		}
		
		public function get ext():String
		{
			return _ext;
		}
		
		public function get icon():Icon
		{
			return this.isDir ? Icons.instance.folderIcon : _icon;
		}
		public function set icon(value:Icon):void
		{
			this._icon = value;
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FileType(ext:String, des:String = "", icon:Icon = null)
		{
			super();
			this._ext = ext.toLowerCase();
			this.description = des;
			this._icon = icon;
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