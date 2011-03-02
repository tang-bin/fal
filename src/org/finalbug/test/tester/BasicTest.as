// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.test.tester
{
	import org.finalbug.ui.control.Container;
	import org.finalbug.ui.layout.Grid;

	/**
	 * BasicTest
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class BasicTest extends Container
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		private var grid:Grid;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
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
		/******************* PUBLIC ****************************************************/
		
		
		
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}