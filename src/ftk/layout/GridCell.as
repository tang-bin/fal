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
package ftk.layout
{
	/**
	 * GridCell is the cell used in class Grid.
	 *  
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class GridCell extends Container
	{
		/**
		 * Create an new GridCell.
		 */
		public function GridCell()
		{
			super();
			this.backgroundColor = 0xFFFFFF;
			this.backgroundAlpha = 1;
			this.borderColor = 0x333333;
			this.borderAlpha = 0;
		}

		/**
		 * The column index of cell.
		 * 
		 * @default 0
		 */
		public var xIndex:uint = 0;

		/**
		 * the row index of cell.
		 * 
		 * @default 0
		 */
		public var yIndex:uint = 0;

		/**
		 * Cell is updated or not when run rebuild() method in Grid object.
		 * 
		 * @default false
		 */
		internal var updated:Boolean = false;

		/**
		 * Reset cell's position by x, y, width and height values.
		 * 
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 */
		public function resetPosition(x:Number, y:Number, width:Number, height:Number):void
		{
			this.layoutStyle.setRetangleStyle(x, y, width, height);
		}
	}
}