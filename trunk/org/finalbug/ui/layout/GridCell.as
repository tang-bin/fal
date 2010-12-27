/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 ******************************************/
package org.finalbug.ui.layout
{
	import org.finalbug.ui.control.Container;

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
			this.layoutStyle.setValue("x", x);
			this.layoutStyle.setValue("y", y);
			this.layoutStyle.setValue("width", width);
			this.layoutStyle.setValue("height", height);
		}
	}
}