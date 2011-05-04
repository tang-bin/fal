// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.layout
{
	import ftk.data.Position;
	import ftk.display.Bin;
	import ftk.events.UIEvent;
	import ftk.style.FillStyle;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * Class Container is the basic class of the display object used to layout.
	 * Container contains basic method to position its children.
	 * 
	 * To learn more about the differents around Bin, Container and UIControl, see
	 * ftk.core.Bin.
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class Container extends Bin
	{
		/**
		 * Create new Container.
		 */
		public function Container()
		{
			super();
			_fillStyle = new FillStyle();
			this.initSize("100%", "100%");
			this.addEventListener(UIEvent.CHILDREN_CHANGED, childrenChangedHandler);
			this.addEventListener(UIEvent.CHILDREN_RESIZE, childrenChangedHandler);
			this.addEventListener(UIEvent.RESIZE, childrenChangedHandler);
		}

		override protected function updateSize():void
		{
			super.updateSize();
			updateDisplaySize();
		}

		private var _autoRank:Boolean = false;

		private var _rankGap:Number = 0;

		private var _rankType:String = Position.HORIZONTAL;

		private var _align:String = Position.LEFT;

		private var _valign:String = Position.TOP;

		private var _displayWidth:Number = 0;

		private var _displayHeight:Number = 0;

		private var dragStartX:Number = 0;

		private var dragStartY:Number = 0;

		private var scrollStartX:Number = 0;

		private var scrollStartY:Number = 0;

		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			if (Position.isAlignValue(value) && value != _align)
			{
				_align = value;
				rank();
			}
		}

		public function get valign():String
		{
			return _valign;
		}

		public function set valign(value:String):void
		{
			if (Position.isVAlignValue(value) && value != _valign)
			{
				_valign = value;
				rank();
			}
		}

		public function get rankType():String
		{
			return _rankType;
		}

		/**
		 * rankType should be Position.HORIZONTAL or Position.VERTICAL.
		 * or the container will do nothing during rank.
		 */
		public function set rankType(value:String):void
		{
			if (value != _rankType)
			{
				_rankType = value;
				rank();
			}
		}

		public function get rankGap():Number
		{
			return _rankGap;
		}

		public function set rankGap(value:Number):void
		{
			if (_rankGap != value)
			{
				_rankGap = value;
				rank();
			}
		}

		public function get displayWidth():Number
		{
			return _displayWidth;
		}

		public function set displayWidth(value:Number):void
		{
			if (value >= 0 && value != _displayWidth)
			{
				_displayWidth = value;
				updateDisplaySize();
			}
		}

		public function get displayHeight():Number
		{
			return _displayHeight;
		}

		public function set displayHeight(value:Number):void
		{
			if (value >= 0 && value != _displayHeight)
			{
				_displayHeight = value;
				updateDisplaySize();
			}
		}

		public function get autoRank():Boolean
		{
			return _autoRank;
		}

		public function set autoRank(value:Boolean):void
		{
			if (value != _autoRank)
			{
				_autoRank = value;
				if (value)
				{
					rank();
				}
			}
		}

		public function rank(isauto:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			if (totalNum == 0)
			{
				return;
			}
			else if (totalNum == 1)
			{
				var child:DisplayObject = this.getChildAt(0);
				setChildAlign(child);
				setChildVAlign(child);
			}
			else if (_rankType == Position.HORIZONTAL)
			{
				var currentX:Number = 0;
				for (var i:uint = 0 ; i < totalNum ; i++)
				{
					var target:DisplayObject = this.getChildAt(i);
					target.x = currentX;
					setChildVAlign(target);
					currentX += (target.width + _rankGap);
				}
				if (_align != Position.LEFT)
				{
					var leftChild:DisplayObject = this.getChildAt(0);
					var rightChild:DisplayObject = this.getChildAt(totalNum - 1);
					var xStart:Number = leftChild.x;
					var xEnd:Number = rightChild.x + rightChild.width;
					var offsetX:Number = this.width - xStart - xEnd;
					if (_align == Position.CENTER)
					{
						offsetX = offsetX / 2;
					}
					for (var j:uint = 0 ; j < totalNum ; j++)
					{
						var target2:DisplayObject = this.getChildAt(j);
						target2.x += offsetX;
					}
				}
			}
			else if (_rankType == Position.VERTICAL)
			{
				var currentY:Number = 0;
				for (var k:uint = 0 ; k < totalNum ; k++)
				{
					var target3:DisplayObject = this.getChildAt(k);
					target3.y = currentY;
					currentY += 50;
					if (!isauto)
					{
						setChildAlign(target3);
						currentY += (target3.height + _rankGap);
					}
				}
				if (_valign != Position.TOP)
				{
					var topChild:DisplayObject = this.getChildAt(0);
					var bottomChild:DisplayObject = this.getChildAt(totalNum - 1);
					var yStart:Number = topChild.x;
					var yEnd:Number = bottomChild.x + bottomChild.height;
					var offsetY:Number = this.height - yStart - yEnd;
					if (_valign == Position.MIDDLE)
					{
						offsetY = offsetY / 2;
					}
					for (var n:uint = 0 ; n < totalNum ; n++)
					{
						var target4:DisplayObject = this.getChildAt(n);
						target4.x += offsetY;
					}
				}
			}
		}

		private function childrenChangedHandler(e:UIEvent):void
		{
			if (this._autoRank)
			{
				rank(true);
			}
		}

		private function updateDisplaySize():void
		{
			if (_displayWidth == 0 || _displayHeight == 0)
			{
				this.scrollRect = new Rectangle(0, 0, this.width, this.height);
				if (this.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					this.removeEventListener(MouseEvent.MOUSE_DOWN, dragMouseDownHandler);
				}
			}
			else
			{
				this.scrollRect = new Rectangle(0, 0, _displayWidth, _displayHeight);
				if (!this.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					this.addEventListener(MouseEvent.MOUSE_DOWN, dragMouseDownHandler);
				}
			}
		}

		private function setChildVAlign(child:DisplayObject):void
		{
			if (_valign == Position.TOP)
			{
				child.y = 0;
			}
			else if (_valign == Position.MIDDLE)
			{
				child.y = (this.height - child.height) / 2;
			}
			else
			{
				child.y = this.height - child.height;
			}
		}

		private function setChildAlign(child:DisplayObject):void
		{
			if (_align == Position.LEFT)
			{
				child.x = 0;
			}
			else if (_align == Position.CENTER)
			{
				child.x = (this.width - child.width) / 2;
			}
			else
			{
				child.x = this.width - child.width;
			}
		}

		private function dragMouseDownHandler(e:MouseEvent):void
		{
			if (_displayWidth > 0 && _displayHeight > 0)
			{
				dragStartX = stage.mouseX;
				dragStartY = stage.mouseY;
				scrollStartX = this.scrollRect.x;
				scrollStartY = this.scrollRect.y;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, dragStageMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, dragStageUpHandler);
			}
		}

		private function dragStageMoveHandler(e:MouseEvent):void
		{
			var offsetX:Number = stage.mouseX - dragStartX;
			var offsetY:Number = stage.mouseY - dragStartY;
			var xx:Number = scrollStartX - offsetX;
			var yy:Number = scrollStartY - offsetY;
			if (xx < 0)
			{
				xx = 0;
			}
			else if (xx > this.width - _displayWidth)
			{
				xx = this.width - _displayWidth;
			}
			if (yy < 0)
			{
				yy = 0;
			}
			else if (yy > this.height - _displayHeight)
			{
				yy = this.height - _displayHeight;
			}
			var rect:Rectangle = this.scrollRect;
			rect.x = xx;
			rect.y = yy;
			this.scrollRect = rect;
			//
			e.updateAfterEvent();
		}

		private function dragStageUpHandler(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragStageMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, dragStageUpHandler);
		}
	}
}