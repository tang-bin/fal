//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.layout
{
	import org.finalbug.ui.control.Container;

	/**
	 * @author Tang Bin
	 * @since 2010.10
	 */	
	public class Grid extends Container
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var cells:Array = new Array();
		private var _rows:Array = new Array();
		private var _columns:Array = new Array(); 
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get rows():Array
		{
			return _rows;
		}
		/**
		 * 
		 * @param value
		 */
		public function set rows(value:Array):void
		{
			_rows = value;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get columns():Array
		{
			return _columns;
		}
		/**
		 * 
		 * @param value
		 */
		public function set columns(value:Array):void
		{
			_columns = value;
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 */
		public function Grid()
		{
			super();
		}
		
		/**
		 * 
		 * @param row
		 * @param column
		 * @return 
		 */
		public function getCell(row:uint, column:uint):Container
		{
			return cells[row][column];
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 */
		public function rebuild():void
		{
			var currentX:Number = 0;
			var currentY:Number = 0;
			var cellWidth:Number = 0;
			var cellHeight:Number = 0;
			//
			var rowNum:uint = rows.length;
			for(var yIndex:uint = 0 ; yIndex < rowNum ; yIndex++)
			{
				if(cells[yIndex] == null) cells[yIndex] = new Array();
				cellHeight = getCellHeight(yIndex);
				//
				var colNum:uint = columns.length;
				for(var xIndex:uint = 0 ; xIndex < colNum ; xIndex++)
				{
					cellWidth = getCellWidth(xIndex);
					if(cells[yIndex][xIndex] == null)
					{
						cells[yIndex][xIndex] = new GridCell();
						this.addChild(cells[yIndex][xIndex]);
					}
					var cell:GridCell = cells[yIndex][xIndex] as GridCell;
					cell.xIndex = xIndex;
					cell.yIndex = yIndex;
					cell.resetPosition(currentX, currentY, cellWidth, cellHeight);
					cell.updated = true;
					//
					if(xIndex == colNum - 1)
					{
						currentX = 0;
						currentY += cellHeight;
					}
					else
					{
						currentX += cellWidth;
					}
				}
			}
			// remove cells
			for(var i:uint = 0 ; i < rowNum ; i++)
			{
				for(var j:uint = 0 ; j < rowNum ; j++)
				{
					var checkCell:GridCell = cells[i][j] as GridCell;
					if(checkCell == null) continue;
					if(checkCell.updated)
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
			this.measure();
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function getCellWidth(index:uint):Number
		{
			return Number(columns[index]);
		}
		
		private function getCellHeight(index:uint):Number
		{
			return Number(rows[index]);
		}
		
		//#######################################
		// HANDLER
		//#######################################
	}
}