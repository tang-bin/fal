// ##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__|     |__|___|__(______/____/_____/____/\___  /
// /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
// ##########################################################
package org.finalbug.ui.style
{
	import org.finalbug.events.UIEvent;

	/**
	 * LayoutStyle
	 *  
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class LayoutStyle extends Style
	{
		// #######################################
		// OVERRIDE
		// #######################################
		/**
		 * 
		 * @return 
		 */
		override public function toString():String
		{
			return "[x = " + this.x + ", y = " + this.y + ", width = " + this.width + ", height = " + this.height + "]";
		}

		// #######################################
		// DEFINE
		// #######################################
		private var _width:String = "";
		private var _height:String = "";
		private var _left:String = "";
		private var _right:String = "";
		private var _top:String = "";
		private var _bottom:String = "";
		private var _horizontal:String = "";
		private var _vertical:String = "";
		private var oldWidth:Number = NaN;
		private var oldHeight:Number = NaN;
		private var oldX:Number = NaN;
		private var oldY:Number = NaN;

		// #######################################
		// GETTER and SETTER
		// #######################################
		/**
		 * The width value count by current layout. 
		 */
		public function get width():Number
		{
			var parentWidth:Number = this.getParentWidth();
			if (validLayoutValue(_width))
			{
				return getLayoutValue(_width, parentWidth);
			}
			else if (validLayoutValue(_left) && validLayoutValue(_right))
			{
				return parentWidth - getLayoutValue(_left, parentWidth) - getLayoutValue(_right, parentWidth);
			}
			else
			{
				return 0;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get height():Number
		{
			var parentHeight:Number = this.getParentHeight();
			if (validLayoutValue(_height))
			{
				return getLayoutValue(_height, parentHeight);
			}
			else if (validLayoutValue(_top) && validLayoutValue(_bottom))
			{
				return parentHeight - getLayoutValue(_top, parentHeight) - getLayoutValue(_bottom, parentHeight);
			}
			else
			{
				return 0;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get x():Number
		{
			var parentWidth:Number = this.getParentWidth();
			if (validLayoutValue(_left))
			{
				return getLayoutValue(_left, parentWidth);
			}
			else if (validLayoutValue(_right) && validLayoutValue(_width))
			{
				return parentWidth - getLayoutValue(_right, parentWidth) - getLayoutValue(_width, parentWidth);
			}
			else if (validLayoutValue(_width) && validLayoutValue(_horizontal))
			{
				return (parentWidth - getLayoutValue(_width, parentWidth)) / 2 + getLayoutValue(_horizontal);
			}
			else
			{
				return 0;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get y():Number
		{
			var parentHeight:Number = this.getParentHeight();
			if (validLayoutValue(_top))
			{
				return getLayoutValue(_top, parentHeight);
			}
			else if (validLayoutValue(_bottom) && validLayoutValue(_height))
			{
				return parentHeight - getLayoutValue(_bottom, parentHeight) - getLayoutValue(_height, parentHeight);
			}
			else if (validLayoutValue(_height) && validLayoutValue(_vertical))
			{
				return (parentHeight - getLayoutValue(_height, parentHeight)) / 2 + getLayoutValue(_vertical);
			}
			else
			{
				return 0;
			}
		}

		// #######################################
		// CONSTRUCTOR
		// #######################################
		/**
		 * 
		 */
		public function LayoutStyle()
		{
			super();
		}

		// #######################################
		// PUBLIC
		// #######################################
		/**
		 * Set layout value.
		 * 
		 * @param name Name of the layout value.
		 * @param value
		 * @param masMore If true, There is(are) more value(s) will be set next, 
		 * 				do not chech changes and dispatch event.
		 */
		public function setValue(name:String, value:*, hasMore:Boolean = false):void
		{
			if (name == "x") name = "left";
			else if (name == "y") name = "top";
			//
			if (this["_" + name] != null)
			{
				this["_" + name] = String(value);
				if (!hasMore)
				{
					checkAndUpdate();
				}
			}
		}

		/**
		 * 
		 * @param name
		 * @param value
		 */
		public function setValueSilent(name:String, value:*):void
		{
			if (name == "x") name = "left";
			else if (name == "y") name = "top";
			//
			if (this["_" + name] != null)
			{
				this["_" + name] = String(value);
				//
				oldWidth = this.width;
				oldHeight = this.height;
				oldX = this.x;
				oldY = this.y;
			}
		}

		/**
		 * 
		 */
		public function checkAndUpdate():void
		{
			var newWidth:Number = this.width;
			var newHeight:Number = this.height;
			var newX:Number = this.x;
			var newY:Number = this.y;
			//
			if (oldWidth != newWidth || oldHeight != newHeight)
			{
				var e1:UIEvent = new UIEvent(UIEvent.RESIZE);
				this.dispatchEvent(e1);
			}
			if (oldX != newX || oldY != newY)
			{
				var e2:UIEvent = new UIEvent(UIEvent.REPOSITION);
				this.dispatchEvent(e2);
			}
			//
			oldWidth = newWidth;
			oldHeight = newHeight;
			oldX = newX;
			oldY = newY;
		}

		/**
		 * 
		 * @param name
		 * @return Return null if value not exist.
		 */
		public function getValue(name:String):*
		{
			if (name == "x") name = "left";
			else if (name == "y") name = "top";
			//
			return this["_" + name];
		}

		/**
		 * 
		 * @param width
		 * @param height
		 */
		public function setSizeStyle(width:*, height:*):void
		{
			this.setValue("width", width, true);
			this.setValue("height", height);
		}

		/**
		 * 
		 * @param top
		 * @param left
		 */
		public function setPositionStyle(top:*, left:*):void
		{
			this.setValue("top", top, true);
			this.setValue("left", left);
		}

		/**
		 * 
		 * @param width
		 * @param height
		 * @param top
		 * @param left
		 */
		public function setNormalStyle(left:*, top:*, width:*, height:*):void
		{
			this.clean();
			this.setValue("width", width, true);
			this.setValue("height", height, true);
			this.setValue("top", top, true);
			this.setValue("left", left);
		}

		/**
		 * 
		 * @param left
		 * @param top
		 * @param right
		 * @param bottom
		 */
		public function setAroundStyle(left:*, top:*, right:*, bottom:*):void
		{
			this.clean();
			this.setValue("left", left, true);
			this.setValue("top", top, true);
			this.setValue("right", right, true);
			this.setValue("bottom", bottom);
		}

		/**
		 * 
		 * @return 
		 */
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

		public function clean():void
		{
			this._width = "";
			this._height = "";
			this._left = "";
			this._right = "";
			this._bottom = "";
			this._top = "";
			this._horizontal = "";
			this._vertical = "";
		}

		// #######################################
		// PROTECTED
		// #######################################
		// #######################################
		// PRIVATE
		// #######################################
		private function getParentWidth():Number
		{
			if (owner != null && owner.parent != null)
			{
				return owner.parent.width;
			}
			else
			{
				return 0;
			}
		}

		private function getParentHeight():Number
		{
			if (owner != null && owner.parent != null)
			{
				return owner.parent.height;
			}
			else
			{
				return 0;
			}
		}
		// #######################################
		// HANDLER
		// #######################################
	}
}