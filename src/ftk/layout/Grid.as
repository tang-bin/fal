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
	import ftk.style.Style;

	/**
	 * Grid is the container of multi containers arranged as matrix.
	 * Each cell of grid is a GirdCell object.
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class Grid extends Container
	{
		/**
		 * Create an new Grid.
		 */
		public function Grid()
		{
			super();
		}

		override protected function updateSize():void
		{
			super.updateSize();
			rebuild();
		}

		/**
		 * rows contains the size of each row.
		 * each item should be a number(pixel value) or percent string(like "50%").
		 * <strong>Notice</strong>: set <code>rows</code> and <code>columns</code>
		 * will not effect until call <code>rebuild()</code> method.
		 */
		public var rows:Array = new Array();

		/**
		 * columns contains the size of each column.
		 * Each item should be a number(pixel value) or percent string(like "50%").
		 * <strong>Notice</strong>: set <code>rows</code> and <code>columns</code>
		 * will not effect until call <code>rebuild()</code> method.
		 */
		public var columns:Array = new Array();

		public var minCellWidth:Number = 10;

		public var minCellHeight:Number = 10;

		// cells is a 2D array contains all GridCell objects
		// cells[row][column] = GridCell object.
		private var cells:Array = new Array();

		private var cellWidths:Array;

		private var cellHeights:Array;

		public function get rowNumber():uint
		{
			return rows.length;
		}

		public function set rowNumber(value:uint):void
		{
			rows = new Array();
			for (var i:uint = 0 ; i < value ; i++)
			{
				rows.push("");
			}
		}

		public function get columnNumber():uint
		{
			return columns.length;
		}

		public function set columnNumber(value:uint):void
		{
			columns = new Array();
			for (var i:uint = 0 ; i < value ; i++)
			{
				columns.push("");
			}
		}

		/**
		 * Get the cell at given posision.
		 * 
		 * @param row Row of cell
		 * @param column Column of cell.
		 * @return The cell at given position.
		 */
		public function getCell(row:uint, column:uint):GridCell
		{
			return cells[row][column];
		}

		/**
		 * Rebuild cells.
		 * This method should be call after rows and columns value have be set.
		 * 
		 * @param doPack Boolean, run pack() or not when cells are rebuilded.
		 * 		If doPack, the size of grid will be changed to fit the cells size
		 * 		If not doPack, the size fo grid will not be changed, even some cells
		 * 		will be shown outside of grid area.
		 */
		public function rebuild(doPack:Boolean = false):void
		{
			countWidthAndHeight();
			var currentX:Number = 0;
			var currentY:Number = 0;
			var cellWidth:Number = 0;
			var cellHeight:Number = 0;
			//
			var rowNum:uint = rows.length;
			for (var yIndex:uint = 0 ; yIndex < rowNum ; yIndex++)
			{
				if (cells[yIndex] == null)
				{
					cells[yIndex] = new Array();
				}
				cellHeight = cellHeights[yIndex];
				//
				var colNum:uint = columns.length;
				for (var xIndex:uint = 0 ; xIndex < colNum ; xIndex++)
				{
					cellWidth = cellWidths[xIndex];
					// create and add cell into grid if not exist.
					if (cells[yIndex][xIndex] == null)
					{
						cells[yIndex][xIndex] = new GridCell();
						this.addChild(cells[yIndex][xIndex]);
					}
					// set cell's size and position.
					var cell:GridCell = cells[yIndex][xIndex] as GridCell;
					cell.xIndex = xIndex;
					cell.yIndex = yIndex;
					cell.resetPosition(currentX, currentY, cellWidth, cellHeight);
					// Mark cell is changed, so that it will not be remove when clean up.
					cell.updated = true;
					//
					if (xIndex == colNum - 1)
					{
						// if new line...
						currentX = 0;
						currentY += cellHeight;
					}
					else
					{
						// or not an new line...
						currentX += cellWidth;
					}
				}
			}
			// Clean up cells. Remove cell objects that are not exist in grid any more.
			for (var i:uint = 0 ; i < rowNum ; i++)
			{
				for (var j:uint = 0 ; j < rowNum ; j++)
				{
					var checkCell:GridCell = cells[i][j] as GridCell;
					if (checkCell == null) continue;
					if (checkCell.updated)
					{
						checkCell.updated = false;
					}
					else
					{
						this.removeChild(checkCell);
						cells[i][j] = null;
					}
				}
			}
			// doPack means the size of grid will be changed to fit the cells.
			if (doPack) this.pack();
		}

		private function countWidthAndHeight():void
		{
			cellWidths = new Array();
			var cols:uint = columns.length;
			var fixWidth:Number = 0;
			var emptyWidthIndexes:Array = new Array();
			for (var xIndex:uint = 0 ; xIndex < cols ; xIndex++)
			{
				var newWidth:Number = getCellWidth(xIndex);
				cellWidths.push(newWidth);
				if (newWidth > 0)
				{
					fixWidth += newWidth;
				}
				else
				{
					emptyWidthIndexes.push(xIndex);
				}
			}
			var emptyWidthCount:uint = emptyWidthIndexes.length;
			if (emptyWidthCount > 0)
			{
				var remainWidth:Number = this.width - fixWidth;
				var eachWidth:Number = remainWidth / emptyWidthCount;
				if (eachWidth < minCellWidth)
				{
					eachWidth = minCellWidth;
				}
				for (var xIndex2:uint = 0 ; xIndex2 < emptyWidthCount ; xIndex2++)
				{
					var emptyWidthIndex:int = int(emptyWidthIndexes[xIndex2]);
					cellWidths[emptyWidthIndex] = eachWidth;
				}
			}
			//
			cellHeights = new Array();
			var rowCount:uint = rows.length;
			var fixHeight:Number = 0;
			var emptyHeightIndexes:Array = new Array();
			for (var yIndex:uint = 0 ; yIndex < rowCount ; yIndex++)
			{
				var newHeight:Number = getCellHeight(yIndex);
				cellHeights.push(newHeight);
				if (newHeight > 0)
				{
					fixHeight += newHeight;
				}
				else
				{
					emptyHeightIndexes.push(yIndex);
				}
			}
			var emptyHeightCount:uint = emptyHeightIndexes.length;
			if (emptyHeightCount > 0)
			{
				var remainHeight:Number = this.height - fixHeight;
				var eachHeight:Number = remainHeight / emptyHeightCount;
				if (eachHeight < minCellHeight)
				{
					eachHeight = minCellHeight;
				}
				for (var yIndex2:uint = 0 ; yIndex2 < emptyHeightCount ; yIndex2++)
				{
					var emptyHeightIndex:int = int(emptyHeightIndexes[yIndex2]);
					cellHeights[emptyHeightIndex] = eachHeight;
				}
			}
		}

		/**
		 * Get the widht of cell at given column.
		 * 
		 * @param index Given column index.
		 * @return The widht of given column.
		 */
		private function getCellWidth(index:uint):Number
		{
			var val:String = columns[index];
			if (Style.validLayoutValue(val))
			{
				var num:Number = Style.getLayoutValue(val, this.width);
				return num;
			}
			return 0;
		}

		/**
		 * Get the height of cell at given row.
		 * 
		 * @param index Given row index.
		 * @return The height of given row.
		 */
		private function getCellHeight(index:uint):Number
		{
			var val:String = rows[index];
			if (Style.validLayoutValue(val))
			{
				var num:Number = Style.getLayoutValue(val, this.height);
				return num;
			}
			return 0;
		}
	}
}