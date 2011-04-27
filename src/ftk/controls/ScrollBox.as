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
	import ftk.style.FillStyle;
	import ftk.style.ScrollBoxStyle;
	import ftk.style.UIStyle;

	/**
	 * This class is a container with scroll bar.
	 * In cage object, only create scrollBar, but not set scrollbar events.
	 * Class cage is used as other components' super class.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollBox extends UIControl
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
		public function ScrollBox(xScroll:Boolean = true, yScroll:Boolean = true, style:ScrollBoxStyle = null)
		{
			// save parameters
			super(style == null ? UIStyle.defaultScrollBoxStyle : style);
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
			style = uiStyle as ScrollBoxStyle;
			xBar = new ScrollBar(Position.HORIZONTAL, 100, style.scrollBarStyle);
			yBar = new ScrollBar(Position.VERTICAL, 100, style.scrollBarStyle);
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
			if (enableX)
			{
				xBar.visible = true;
				xBar.length = enableY ? width - yBar.thickness - 2 : width - 2;
				xBar.y = height - xBar.thickness;
				xBar.x = 1;
			}
			else
			{
				xBar.visible = false;
			}
			if (enableY)
			{
				yBar.visible = true;
				yBar.length = enableX ? height - xBar.thickness - 2 : height - 2;
				yBar.x = width - yBar.thickness;
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
		 * Width of container, not the width of scrollContainer.
		 */
		public function get containerWidth():Number
		{
			return enableY ? width - yBar.thickness : width;
		}

		/**
		 * height of container.
		 */
		public function get containerHeight():Number
		{
			return enableX ? height - xBar.thickness : height;
		}

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