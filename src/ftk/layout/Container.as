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

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;

	import ftk.display.Bin;
	import ftk.events.UIEvent;
	import ftk.style.FillStyle;

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

		private const HRank:String = "hRank";

		private const VRank:String = "vRank";

		private var _autoRank:Boolean = false;

		private var _autoRankSpace:Number = 0;

		private var _autoRankType:String = HRank;

		private var _autoRankCenter:Boolean = false;

		private var _autoRankPack:Boolean = false;

		private var _displayWidth:Number = 0;

		private var _displayHeight:Number = 0;

		private var dragStartX:Number = 0;

		private var dragStartY:Number = 0;

		private var scrollStartX:Number = 0;

		private var scrollStartY:Number = 0;

		private var _align:String = Position.LEFT;

		private var _valign:String = Position.TOP;

		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			if (Position.isAlignValue(value) && value != _align)
			{
				_align = value;
				alignChildren(_autoRankSpace);
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
				valignChildren(_autoRankSpace);
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
					doRank();
				}
			}
		}

		/**
		 * 
		 * @param space
		 * @param center
		 * @param packAfterRank
		 */
		public function horizontalRank(space:Number = 0, center:Boolean = true, packAfterRank:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			var currentX:Number = space;
			var maxHeight:Number = 0;
			for (var i:uint = 0 ; i < totalNum ; i++)
			{
				var target:DisplayObject = this.getChildAt(i);
				target.x = currentX;
				target.y = 0;
				currentX += target.width + space;
				if (target.height > maxHeight) maxHeight = target.height;
			}
			if (center)
			{
				for (var j:uint = 0 ; j < totalNum ; j++)
				{
					var target2:DisplayObject = this.getChildAt(j);
					target2.y = (maxHeight - target2.height) / 2;
				}
			}
			if (packAfterRank)
			{
				pack(space, 0);
			}
			else
			{
				alignChildren(space);
			}
			//
			_autoRankType = HRank;
			_autoRankCenter = center;
			_autoRankPack = packAfterRank;
			_autoRankSpace = space;
		}

		/**
		 * 
		 * @param space
		 * @param center
		 * @param packAfterRank
		 * 
		 */
		public function verticalRank(space:Number = 0, center:Boolean = true, packAfterRank:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			var currentY:Number = space;
			var maxWidth:Number = 0;
			for (var i:uint = 0 ; i < totalNum ; i++)
			{
				var target:DisplayObject = this.getChildAt(i);
				target.y = currentY;
				target.x = 0;
				currentY += target.height + space;
				if (target.width > maxWidth) maxWidth = target.width;
			}
			if (center)
			{
				for (var j:uint = 0 ; j < totalNum ; j++)
				{
					var target2:DisplayObject = this.getChildAt(j);
					target2.y = (maxWidth - target2.width) / 2;
				}
			}
			if (packAfterRank)
			{
				pack(0, space);
			}
			else
			{
				valignChildren(space);
			}
			//
			_autoRankType = VRank;
			_autoRankCenter = center;
			_autoRankPack = packAfterRank;
			_autoRankSpace = space;
		}

		private function childrenChangedHandler(e:UIEvent):void
		{
			if (this._autoRank)
			{
				doRank();
			}
		}

		private function doRank():void
		{
			if (this._autoRankType == HRank)
			{
				this.horizontalRank(_autoRankSpace, _autoRankCenter, _autoRankPack);
			}
			else if (this._autoRankType == VRank)
			{
				this.verticalRank(_autoRankSpace, _autoRankCenter, _autoRankPack);
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

		private function alignChildren(space:Number):void
		{
			var totalNum:uint = this.numChildren;
			if (totalNum == 1)
			{
				var c:DisplayObject = this.getChildAt(0);
				c.x = (this.width - c.width) / 2;
				setChildVAlign(c);
			}
			else if (totalNum > 1)
			{
				var firstChild:DisplayObject = this.getChildAt(0);
				var lastChild:DisplayObject = this.getChildAt(totalNum - 1);
				var xStart:Number = firstChild.x;
				var xEnd:Number = lastChild.x + lastChild.width;
				// offsetX for right align
				var offsetX:Number = this.width - xStart - xEnd;
				if (_align == Position.LEFT)
				{
					offsetX = 0;
				}
				else if (_align == Position.CENTER)
				{
					offsetX = offsetX / 2;
				}
				for (var i:uint = 0 ; i < totalNum; i++)
				{
					var child:DisplayObject = this.getChildAt(i);
					child.x = offsetX;
					setChildVAlign(child);
					offsetX += child.width + space;
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

		private function valignChildren(space:Number):void
		{
			var totalNum:uint = this.numChildren;
			if (totalNum == 1)
			{
				var c:DisplayObject = this.getChildAt(0);
				setChildAlign(c);
				c.y = (this.height - c.height) / 2;
			}
			else if (totalNum > 1)
			{
				var firstChild:DisplayObject = this.getChildAt(0);
				var lastChild:DisplayObject = this.getChildAt(totalNum - 1);
				var yStart:Number = firstChild.y;
				var yEnd:Number = lastChild.y + lastChild.height;
				// offsetY for top valign
				var offsetY:Number = this.height - yStart - yEnd;
				if (_valign == Position.TOP)
				{
					offsetY = 0;
				}
				else if (_valign == Position.MIDDLE)
				{
					offsetY /= 2;
				}
				for (var i:uint = 0 ; i < totalNum; i++)
				{
					var child:DisplayObject = this.getChildAt(i);
					child.y = offsetY;
					setChildAlign(child);
					offsetY += child.height + space;
				}
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