/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 ******************************************/
package org.finalbug.framework.layout
{
	/**
	 * GridCell is the cell used in class Grid.
	 *  
	 * @author Tang Bin
	 * @since 2010.10
	 */	
	public class GridCell extends Container
	{
		public var xIndex:uint = 0;
		public var yIndex:uint = 0;
		
		public var updated:Boolean = false;
		
		public function GridCell()
		{
			super();
			this.backgroundColor = 0xFF9900;
			this.backgroundAlpha = 1;
			this.borderColor = 0;
			this.borderAlpha = 1;
		}
		
		public function resetPosition(x:Number, y:Number, width:Number, height:Number):void
		{
			this.setLayoutValue("x", x, true, false);
			this.setLayoutValue("y", y, true, false);
			this.setLayoutValue("width", width, true, false);
			this.setLayoutValue("height", height, true, true);
		}
	}
}