/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.framework.layout
{
	import org.finalbug.core.data.SetType;
	import org.finalbug.core.utils.DataUtil;

	/**
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since 2010.10
	 */	
	public class Grid extends Container
	{
		private var _autoSize:Boolean = false;
		private var cells:Array = new Array();
		private var _rows:Array = new Array();
		private var _columns:Array = new Array(); 
		
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		public function set autoSize(value:Boolean):void
		{
			if(_autoSize != value)
			{
				_autoSize = value;
			}
		}
		
		public function get rows():Array
		{
			return _rows;
		}
		public function set rows(value:Array):void
		{
			_rows = value;
		}
		
		public function get columns():Array
		{
			return _columns;
		}
		public function set columns(value:Array):void
		{
			_columns = value;
		}
		
		public function Grid()
		{
			super();
		}
		
		public function getCell(row:uint, column:uint):Container
		{
			return null;
		}
		
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
		}
		
		private function getCellWidth(index:uint):Number
		{
			return 0;
		}
		
		private function getCellHeight(index:uint):Number
		{
			return 0;
		}
	}
}