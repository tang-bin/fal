/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.style.styles
{
	import fal.style.styles.Style;
	
	import flash.display.DisplayObject;
	
	public class LayoutStyle extends Style
	{
		private var _width:String = "";
		private var _height:String = "";
		private var _left:String = "";
		private var _right:String = "";
		private var _top:String = "";
		private var _bottom:String = "";
		
		private var _horizontal:String = "";
		private var _vertical:String = "";
		
		public function LayoutStyle()
		{
			super();
		}
		
		public function getWidth(parent:DisplayObject):Number
		{
			return getWidthBySize(parent.width);
		}
		
		public function getWidthBySize(parentWidth:Number):Number
		{
			if(validLayoutValue(_width))
			{
				return getLayoutValue(_width, parentWidth);
			}
			else if(validLayoutValue(_left) && validLayoutValue(_right))
			{
				return parentWidth - getLayoutValue(_left, parentWidth) - getLayoutValue(_right, parentWidth);
			}
			else
			{
				return 0;
			}
		}
		
		public function getHeight(parent:DisplayObject):Number
		{
			return getHeightBySize(parent.height);
		}
		
		public function getHeightBySize(parentHeight:Number):Number
		{
			if(validLayoutValue(_height))
			{
				return getLayoutValue(_height, parentHeight);
			}
			else if(validLayoutValue(_top) && validLayoutValue(_bottom))
			{
				return parentHeight - getLayoutValue(_top, parentHeight) - getLayoutValue(_bottom, parentHeight);
			}
			else
			{
				return 0;
			}
		}
		
		public function getX(parent:DisplayObject):Number
		{
			return getXBySize(parent.width);
		}
		
		public function getXBySize(parentWidth:Number):Number
		{
			if(validLayoutValue(_left))
			{
				return getLayoutValue(_left, parentWidth);
			}
			else if(validLayoutValue(_right) && validLayoutValue(_width))
			{
				return parentWidth - getLayoutValue(_right, parentWidth) - getLayoutValue(_width, parentWidth);
			}
			else if(validLayoutValue(_width) && validLayoutValue(_horizontal))
			{
				return (parentWidth - getLayoutValue(_width, parentWidth)) / 2 + getLayoutValue(_horizontal);
			}
			else
			{
				return 0;
			}
		}
		
		public function getY(parent:DisplayObject):Number
		{
			return getYBySize(parent.width);
		}
		
		public function getYBySize(parentHeight:Number):Number
		{
			if(validLayoutValue(_top))
			{
				return getLayoutValue(_top, parentHeight);
			}
			else if(validLayoutValue(_bottom) && validLayoutValue(_height))
			{
				return parentHeight - getLayoutValue(_bottom, parentHeight) - getLayoutValue(_height, parentHeight);
			}
			else if(validLayoutValue(_height) && validLayoutValue(_vertical))
			{
				return (parentHeight - getLayoutValue(_height, parentHeight)) / 2 + getLayoutValue(_vertical);
			}
			else
			{
				return 0;
			}
		}
	}
}