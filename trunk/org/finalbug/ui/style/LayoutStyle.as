/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.style
{
	
	/**
	 * org.finalbug.fal.css.styles.LayoutStyle
	 *  
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class LayoutStyle extends org.finalbug.ui.style.Style	
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
		
		public function get width():Number
		{
			var parentWidth:Number = owner != null && owner.parent != null ? owner.parent.width : 0;
			trace("b", _width);
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
		
		public function get height():Number
		{
			var parentHeight:Number = owner != null && owner.parent != null ? owner.parent.height : 0;
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
		
		public function get x():Number
		{
			var parentWidth:Number = owner != null && owner.parent != null ? owner.parent.width : 0;
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
		
		public function get y():Number
		{
			var parentHeight:Number = owner != null && owner.parent != null ? owner.parent.height : 0;
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
		
		public function setValue(name:String, value:*):void
		{
			if(this["_" + name] != null)
			{
				this["_" + name] = String(value);
			}
		}
		
		public function clone():LayoutStyle
		{
			var ls:LayoutStyle = new LayoutStyle();
			ls.filters = this.filters;
			ls._width = this._width;
			ls._height = this._height;
			ls._left = this._left;
			ls._right = this._right;
			ls._bottom = this._bottom;
			ls._top = this._top;
			ls._horizontal = this._horizontal;
			ls._vertical = this._vertical;
			return ls;
		}
	}
}