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
package ftk.test.tester
{
	import ftk.layout.Container;
	import ftk.layout.Grid;

	/**
	 * BasicTest
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class ControlsTest extends Container
	{
		public function ControlsTest()
		{
			super();
			//
			grid = new Grid();
			grid.cellBorderAlpha = 1;
			grid.percentHeight = grid.percentWidth = 1;
			this.addAll(grid);
			grid.rowNumber = grid.columnNumber = 5;
			grid.rebuild();
		}

		private var grid:Grid;
	}
}