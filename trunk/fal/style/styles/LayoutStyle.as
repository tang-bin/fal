/****************************
 * fal.style.styles.LayoutStyle
 *
 * @author Tang Bin
 * @since 2010-8-20
 ****************************/
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
			if(validValue(_width))
			{
				return getValue(_width, parentWidth);
			}
			else if(validValue(_left) && validValue(_right))
			{
				return parentWidth - getValue(_left, parentWidth) - getValue(_right, parentWidth);
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
			if(validValue(_height))
			{
				return getValue(_height, parentHeight);
			}
			else if(validValue(_top) && validValue(_bottom))
			{
				return parentHeight - getValue(_top, parentHeight) - getValue(_bottom, parentHeight);
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
			if(validValue(_left))
			{
				return getValue(_left, parentWidth);
			}
			else if(validValue(_right) && validValue(_width))
			{
				return parentWidth - getValue(_right, parentWidth) - getValue(_width, parentWidth);
			}
			else if(validValue(_width) && validValue(_horizontal))
			{
				return (parentWidth - getValue(_width, parentWidth)) / 2 + getValue(_horizontal);
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
			if(validValue(_top))
			{
				return getValue(_top, parentHeight);
			}
			else if(validValue(_bottom) && validValue(_height))
			{
				return parentHeight - getValue(_bottom, parentHeight) - getValue(_height, parentHeight);
			}
			else if(validValue(_height) && validValue(_vertical))
			{
				return (parentHeight - getValue(_height, parentHeight)) / 2 + getValue(_vertical);
			}
			else
			{
				return 0;
			}
		}
	}
}