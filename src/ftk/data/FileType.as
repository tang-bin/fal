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
	import ftk.controls.Icon;

	/**
	 * FileType defines file's type.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class FileType extends DataModel
	{
		/**
		 * Create an new FileType.
		 * 
		 * @param ext File's extantion.
		 * @param des File's type description.
		 * @param icon File's type icon
		 */
		public function FileType(ext:String, des:String = "", icon:Icon = null)
		{
			super();
			this._ext = ext.toLowerCase();
			this.description = des;
			this._icon = icon;
		}

		/**
		 * Description of file type.
		 * 
		 * @default 
		 */
		public var description:String = "";

		// is a dir
		private var _isDir:Boolean = false;

		// ext name.
		private var _ext:String = "";

		// icon
		private var _icon:Icon;

		/**
		 * If this is a directory or file.
		 */
		public function get isDir():Boolean
		{
			return _isDir;
		}

		public function set isDir(value:Boolean):void
		{
			if (value != _isDir)
			{
				_isDir = value;
				// TODO, change view or data. and dispatch event.
			}
		}

		/**
		 * The extension string of file.
		 */
		public function get ext():String
		{
			return _ext;
		}

		/**
		 * file icon.
		 */
		public function get icon():Icon
		{
			return this.isDir ? IconModel.instance.folderIcon : _icon.clone();
		}

		public function set icon(value:Icon):void
		{
			this._icon = value;
		}
	}
}