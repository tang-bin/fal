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
	import ftk.controls.Button;
	import ftk.controls.CheckBox;
	import ftk.controls.RadioButton;
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
			//
			grid.columnNumber = 3;
			grid.rows = [100, 50, 100, 50, 100, 50];
			//
			grid.rebuild();
			//
			// button
			grid.getCell(0, 0).addChild(new Button());
			grid.getCell(1, 0).text = "Button";
			//
			// checkbox
			grid.getCell(0, 1).addChild(new CheckBox());
			grid.getCell(1, 1).text = "CheckBox";
			//
			// radioButton
			grid.getCell(0, 2).addChild(new RadioButton("btn1", "test"));
			grid.getCell(0, 2).addChild(new RadioButton("btn2", "test"));
			grid.getCell(1, 2).text = "RadioButton";
		}

		private var grid:Grid;
	}
}