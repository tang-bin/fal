/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.framework.layout
{
	public class GridCell extends Container
	{
		public var xIndex:uint = 0;
		public var yIndex:uint = 0;
		
		public var updated:Boolean = false;
		
		public function GridCell()
		{
			super();
		}
		
		public function resetPosition(x:Number, y:Number, width:Number, height:Number):void
		{
			
		}
	}
}