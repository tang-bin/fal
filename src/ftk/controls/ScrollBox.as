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
	import ftk.data.Position;
	import ftk.events.UIEvent;
	import ftk.layout.Container;
	import ftk.style.FillStyle;

	/**
	 * This class is a container with scroll bar.
	 * In this object, only create scrollBar, but not set scrollbar events.
	 * Class cage is used as other components' super class.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollBox extends Container
	{
		/**
		 * Create a new ScrollBarContainer object.
		 * 
		 * @param size Default value is (100, 100).
		 * @param enableScrollBarX
		 * @param enableScrollBarY
		 * @param scrollBarStyle
		 * @return 
		 * 
		 */
		public function ScrollBox(xScroll:Boolean = true, yScroll:Boolean = true)
		{
			// save parameters
			super();
			enableX = xScroll;
			enableY = yScroll;
			//
			var defaultFillStyle:FillStyle = new FillStyle();
			defaultFillStyle.bgAlpha = 1;
			defaultFillStyle.bgColor = 0xFFFFFF;
			defaultFillStyle.borderAlpha = 1;
			defaultFillStyle.borderColor = 0xCCCCCC;
			this.fillStyle = defaultFillStyle;
			//
			// create children.
			xBar = new ScrollBar(Position.HORIZONTAL, 100);
			yBar = new ScrollBar(Position.VERTICAL, 100);
			this.addAll(xBar, yBar);
			//
			xBar.enabled = xBar.visible = false;
			yBar.enabled = yBar.visible = false;
			//
			xBar.addEventListener(UIEvent.SCROLL, xScrollHandler);
			yBar.addEventListener(UIEvent.SCROLL, yScrollHandler);
		}

		override protected function updateSize():void
		{
			super.updateSize();
			//
			trace("xxxxxxxxxxxxxxxx", enableY, yBar.enabled);
			if (enableX)
			{
				xBar.visible = xBar.enabled;
				xBar.length = width - 2;
				xBar.y = height - 1;
				xBar.x = 1;
			}
			else
			{
				xBar.visible = false;
			}
			if (enableY)
			{
				yBar.visible = yBar.enabled;
				yBar.length = height - 2;
				yBar.x = width - 1;
				yBar.y = 1;
			}
			else
			{
				yBar.visible = false;
			}
		}

		/**
		 * scroll bar X
		 * @default 
		 */
		protected var xBar:ScrollBar;

		/**
		 * scroll bar Y
		 * @default 
		 */
		protected var yBar:ScrollBar;

		/**
		 * enable scrollbar x or not
		 * @default 
		 */
		protected var enableX:Boolean;

		/**
		 * enable scrollbar y or not
		 * @default 
		 */
		protected var enableY:Boolean;

		/**
		 * 
		 * @return 
		 */
		public function get xScrollEnabled():Boolean
		{
			return enableX;
		}

		/**
		 * 
		 * @param value
		 */
		public function set xScrollEnabled(value:Boolean):void
		{
			if (enableX != value)
			{
				enableX = value;
				updateSize();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get yScrollEnabled():Boolean
		{
			return enableY;
		}

		/**
		 * 
		 * @param value
		 */
		public function set yScrollEnabled(value:Boolean):void
		{
			if (enableY != value)
			{
				enableY = value;
				updateSize();
			}
		}

		/**
		 * 
		 * @param e
		 */
		protected function xScrollHandler(e:UIEvent):void
		{
		}

		/**
		 * 
		 * @param e
		 */
		protected function yScrollHandler(e:UIEvent):void
		{
		}
	}
}