//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
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
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public var description:String = "";
		
		private var _isDir:Boolean = false;
		private var _ext:String = "";
		private var _icon:Icon;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get isDir():Boolean
		{
			return _isDir;
		}
		/**
		 * 
		 * @param value
		 */
		public function set isDir(value:Boolean):void
		{
			if(value != _isDir)
			{
				_isDir = value;
				// TODO, change view or data. and dispatch event.
			}
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get ext():String
		{
			return _ext;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get icon():Icon
		{
			return this.isDir ? Icons.instance.folderIcon : _icon.clone();
		}
		/**
		 * 
		 * @param value
		 */
		public function set icon(value:Icon):void
		{
			this._icon = value;
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @param ext
		 * @param des
		 * @param icon
		 */
		public function FileType(ext:String, des:String = "", icon:Icon = null)
		{
			super();
			this._ext = ext.toLowerCase();
			this.description = des;
			this._icon = icon;
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}