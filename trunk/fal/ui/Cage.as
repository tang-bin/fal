package fas.ui
{
	import fas.data.FillData;
	import fas.events.UIEvent;
	import fas.utils.Flat;
	
	/**
	 * This class is a container with scroll bar.
	 * In cage object, only create scrollBar, but not set scrollbar events.
	 * Class cage is used as other components' super class.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class Cage extends UIObject
	{
		protected var back:Flat; // background
		protected var xBar:ScrollBar; // scroll bar X
		protected var yBar:ScrollBar; // scroll bar Y
		protected var enableX:Boolean; // enable scrollbar x or not
		protected var enableY:Boolean; // enable scrollbar y or not
		
		private var _width:Number;
		private var _height:Number;

		/**
		 * Width of container, not the width of scrollContainer.
		 */		
		public function get containerWidth():Number
		{
			return enableY ? _width - yBar.thickness : _width;
		}
		
		/**
		 * height of container.
		 */		
		public function get containerHeight():Number
		{
			return enableX ? _height - xBar.thickness : _height;
		}
		
		public function get xScrollEnabled():Boolean
		{
			return enableX;
		}
		public function set xScrollEnabled(value:Boolean):void
		{
			if(enableX != value)
			{
				enableX = value;
				resetView();
			}
		}
		
		public function get yScrollEnabled():Boolean
		{
			return enableY;
		}
		public function set yScrollEnabled(value:Boolean):void
		{
			if(enableY != value)
			{
				enableY = value;
				resetView();
			}
		}
		
		override public function set width(value:Number) : void
		{
			_width = value;
			resetView();
		}
		override public function set height(value:Number) : void
		{
			_height = value;
			resetView();
		}
		
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
		public function Cage(width:Number = 400, height:Number = 300,
							 xScroll:Boolean = true, yScroll:Boolean = true)
		{
			this.uiName = "Cage";
			/* save parameters */
			enableX = xScroll;
			enableY = yScroll;
			_width = width;
			_height = height;
			//
			/* create elements. */
			var bgFD:FillData = new FillData(false);
			bgFD.borderColor = 0x990000;
			bgFD.bodyColor = 0xFFFFFF;
			bgFD.glowAlpha = 0;
			back = new Flat(width, height, bgFD);
			this.addChild(back);
			//
			xBar = new ScrollBar(ScrollBar.SCROLL_X, 100);
			this.addChild(xBar);
			xBar.enabled = xBar.visible = false;
			xBar.addEventListener(UIEvent.SCROLL, xScrollHandler);
			//
			yBar = new ScrollBar(ScrollBar.SCROLL_Y, 100);
			this.addChild(yBar);
			yBar.enabled = yBar.visible = false;
			yBar.addEventListener(UIEvent.SCROLL, yScrollHandler);
			//
			// init.
			xBar.length = enableY ? width - yBar.thickness : width;
			yBar.length = enableX ? height - xBar.thickness : height;
			xBar.y = height - xBar.thickness;
			yBar.x = width - yBar.thickness;
			xBar.visible = enableX;
			yBar.visible = enableY;
		}
		
		private function resetView():void
		{
			back.width = _width;
			back.height = _height;
			if(enableX)
			{
				xBar.visible = true;
				xBar.length = enableY ? _width - yBar.thickness : _width;
				xBar.y = _height - xBar.thickness;
			}
			else
			{
				xBar.visible = false;
			}
			if(enableY)
			{
				yBar.visible = true;
				yBar.length = enableX ? _height - xBar.thickness : _height;
				yBar.x = _width - yBar.thickness;
			}
			else
			{
				yBar.visible = false;
			}
		}
		
		protected function xScrollHandler(e:UIEvent):void
		{
			
		}
		
		protected function yScrollHandler(e:UIEvent):void
		{
			
		}
	}
}