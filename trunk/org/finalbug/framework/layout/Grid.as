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
		
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		public function get autoSize(value:Boolean):void
		{
			if(_autoSize != value)
			{
				_autoSize = value;
			}
		}
		
		public function Grid()
		{
			super();
		}
		
		public function setRow(...args):void
		{
			
		}
		
		public function setColumn(...args):void
		{
			
		}
		
		public function addRow(size:*):void
		{
			
		}
		
		public function addColumn(size:*):void
		{
			
		}
		
		public function addRowAt(size:*, index:uint):void
		{
			
		}
		
		public function addColumnAt(size:*, index:uint):void
		{
			
		}
		
		public function removeRowAt(index:uint):void
		{
			
		}
		
		public function removeColumnAt(index:uint):void
		{
			
		}
		
		public function moveRow(fromIndex:uint, toIndex:uint):void
		{
			
		}
		
		public function moveColumn(fromIndex:uint, toIndex:uint):void
		{
			
		}
		
		public function getCell(row:uint, column:uint):Container
		{
			return null;
		}
		
		public function refresh():void
		{
			
		}
	}
}