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
package ftk.controls
{
	import ftk.events.UIEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * This class create a panel with scrollbar x and y.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollPanel extends ScrollBox
	{
		/**
		 * Create a new ScrollPanel object.
		 */
		public function ScrollPanel(xScroll:Boolean = true, yScroll:Boolean = true)
		{
			super(xScroll, yScroll);
			box = new Sprite();
			// draw a invisible point at (0, 0) to make box count size for (0, 0) point.
			box.graphics.beginFill(0, 0);
			box.graphics.drawRect(0, 0, 1, 1);
			box.graphics.endFill();
			//
			this.addAll(box);
			//
			box.addEventListener(MouseEvent.MOUSE_DOWN, pressContainerHandler);
		}

		override public function set xScrollEnabled(value:Boolean):void
		{
			super.xScrollEnabled = value;
			this.updateSize();
		}

		override public function set yScrollEnabled(value:Boolean):void
		{
			super.yScrollEnabled = value;
			this.updateSize();
		}

		override protected function updateSize():void
		{
			super.updateSize();
			//
			if (box != null)
			{
				if (box.x > 0)
				{
					box.x = 0;
				}
				else if (box.x < this.width - box.width)
				{
					box.x = this.width - box.width;
				}
				//
				if (box.y > 0)
				{
					box.y = 0;
				}
				else if (box.y < this.height - box.height)
				{
					box.y = this.height - box.height;
				}
				//
				resetScroll();
			}
		}

		/**
		 * invoked when change x coordinate scroll.
		 * @param e
		 */
		override protected function xScrollHandler(e:UIEvent):void
		{
			var pos:Number = xBar.position;
			box.x = - pos * (box.width - this.width);
		}

		/**
		 * handler of scroll scrollBarY
		 */
		override protected function yScrollHandler(e:UIEvent):void
		{
			var pos:Number = yBar.position;
			box.y = - pos * (box.height - this.height);
		}

		public var dragable:Boolean = true;

		private var box:Sprite;

		/**
		 * 
		 * @return 
		 */
		public function get container():Sprite
		{
			return box;
		}

		public function refresh():void
		{
			updateSize();
		}

		private function resetScroll():void
		{
			if (box.width <= this.width)
			{
				xBar.enabled = false;
			}
			else if (enableX)
			{
				xBar.enabled = true;
				xBar.scale = this.width / box.width;
				xBar.position = box.x / (this.width - box.width);
			}
			//
			if (box.height <= this.height)
			{
				yBar.enabled = false;
			}
			else if (enableY)
			{
				yBar.enabled = true;
				yBar.scale = this.height / box.height;
				yBar.position = box.y / (this.height - box.height);
			}
		}

		/**
		 * invoked when press container.
		 * if enable drag container, set drag events here.
		 * 
		 * @param e
		 */
		private function pressContainerHandler(e:MouseEvent):void
		{
			if (dragable)
			{
				var rec:Rectangle = new Rectangle(0, 0, this.width - box.width, this.height - box.height);
				box.startDrag(false, rec);
				stage.addEventListener(MouseEvent.MOUSE_UP, releaseContainerHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, dragContainerHandler);
				box.addEventListener(MouseEvent.MOUSE_UP, releaseContainerHandler);
			}
		}

		private function releaseContainerHandler(e:MouseEvent):void
		{
			box.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseContainerHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragContainerHandler);
			box.removeEventListener(MouseEvent.MOUSE_UP, releaseContainerHandler);
		}

		private function dragContainerHandler(e:MouseEvent):void
		{
			if (enableX || enableY)
			{
				resetScroll();
			}
			e.updateAfterEvent();
		}
	}
}