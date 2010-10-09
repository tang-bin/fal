/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.framework.container
{
	import flash.display.DisplayObject;
	
	import org.finalbug.core.data.Position;
	import org.finalbug.core.display.Bin;
	import org.finalbug.framework.layout.Layout;

	public class Case extends org.finalbug.core.display.Bin
	{
		private var _layout:Layout;
		
		public function get layout():Layout
		{
			return _layout;
		}
		public function set layout(value:Layout):void
		{
			if(_layout != value)
			{
				_layout = value;
				this.updateView();
			}
		}
		
		public function Case()
		{
			super();
		}
		
		public function float(type:String = "topLeft"):void
		{
			var num:uint = this.numChildren;
			var i:uint = 0;
			var obj:DisplayObject;
			var currentX:Number, currentY:Number, offsetX:Number, offsetY:Number;
			//
			switch(type)
			{
				case Position.TOP_LEFT:
					currentX = currentY = offsetX = offsetY = 0;
					for(i = 0 ; i < num ; i++)
					{
						obj = this.getChildAt(i);
						if(!obj.hasOwnProperty("position") || obj["position"] == Layout.STATIC)
						{
							obj.x = currentX;
							obj.y = currentY;
						}
					}
					break;
				case Position.TOP_RIGHT:
					break;
				case Position.BOTTOM_LEFT:
					break;
				case Position.BOTTOM_RIGHT:
					break;
			}
		}
	}
}