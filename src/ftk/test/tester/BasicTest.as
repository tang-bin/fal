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
	public class BasicTest extends Container
	{
		public function BasicTest()
		{
			super();
			//
			grid = new Grid();
			grid.percentHeight = grid.percentWidth = 1;
			this.addAll(grid);
			grid.rows = ["30%", "30%", "40%"];
			grid.columns = ["30%", "30%", "40%"];
			grid.rebuild();
			trace(grid.width, grid.height);
		}

		private var grid:Grid;
	}
}