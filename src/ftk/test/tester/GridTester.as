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

	public class GridTester extends Container
	{
		private var gd:Grid;

		public function GridTester()
		{
			super();
			gd = new Grid();
			this.addAll(gd);

			gd.rows = [100, 90, 80, 200];
			gd.columns = [100, 50, 100, 40, 200];
			gd.rebuild();
		}
	}
}