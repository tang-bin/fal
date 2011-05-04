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
package ftk.controls
{
	import ftk.data.TreeData;

	/**
	 * Tree
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class Tree extends ScrollBox
	{
		/**
		 * 
		 * @param xScroll
		 * @param yScroll
		 */
		public function Tree(xScroll:Boolean = true, yScroll:Boolean = true)
		{
			super(xScroll, yScroll);
		}

		private var _data:TreeData;

		public function get data():TreeData
		{
			return _data;
		}

		public function set data(value:TreeData):void
		{
			if (_data != value)
			{
				_data = value;
			}
		}
	}
}