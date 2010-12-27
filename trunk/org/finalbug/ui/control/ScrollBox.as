/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.control
{
	import org.finalbug.data.Position;
	import org.finalbug.data.Status;
	import org.finalbug.events.UIEvent;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.style.stylefactory.ScrollBoxStyleFactory;
	import org.finalbug.ui.control.ScrollBar;
	import org.finalbug.ui.control.UIObject;
	
	/**
	 * This class is a container with scroll bar.
	 * In cage object, only create scrollBar, but not set scrollbar events.
	 * Class cage is used as other components' super class.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollBox extends UIObject
	{
		protected var back:Flat; // background
		protected var xBar:ScrollBar; // scroll bar X
		protected var yBar:ScrollBar; // scroll bar Y
		protected var enableX:Boolean; // enable scrollbar x or not
		protected var enableY:Boolean; // enable scrollbar y or not
		
		/**
		 * Width of container, not the width of scrollContainer.
		 */		
		public function get containerWidth():Number
		{
			return enableY ? displayWidth - yBar.thickness : displayWidth;
		}
		
		/**
		 * height of container.
		 */		
		public function get containerHeight():Number
		{
			return enableX ? displayHeight - xBar.thickness : displayHeight;
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
				updateView();
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
				updateView();
			}
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
		public function ScrollBox(xScroll:Boolean = true, yScroll:Boolean = true)
		{
			/* save parameters */
			enableX = xScroll;
			enableY = yScroll;
			createChildren();
		}
		
		override protected function updateView():void
		{
			super.updateView();
			//
			back.fillStyle = currentSkin.fillStyle;
			back.width = this.displayWidth;
			back.height = this.displayHeight;
			//
			if(enableX)
			{
				xBar.visible = true;
				xBar.length = enableY ? displayWidth - yBar.thickness - 2 : displayWidth - 2;
				xBar.y = displayHeight - xBar.thickness;
				xBar.x = 1;
			}
			else
			{
				xBar.visible = false;
			}
			if(enableY)
			{
				yBar.visible = true;
				yBar.length = enableX ? displayHeight - xBar.thickness - 2 : displayHeight - 2;
				yBar.x = displayWidth - yBar.thickness;
				yBar.y = 1;
			}
			else
			{
				yBar.visible = false;
			}
		}
		
		protected function xScrollHandler(e:UIEvent):void{}
		protected function yScrollHandler(e:UIEvent):void{}
		
		private function createChildren():void
		{
			back = new Flat();
			xBar = new ScrollBar(Position.HORIZONTAL);
			yBar = new ScrollBar(Position.VERTICAL);
			this.addAll(back, xBar, yBar);
			//
			xBar.enabled = xBar.visible = false;
			yBar.enabled = yBar.visible = false;
			//
			this.setSkin(Status.NORMAL, ScrollBoxStyleFactory.createNormalStyle(), true);
			this.setSkin(Status.DISABLE, ScrollBoxStyleFactory.createDisableStyle());
			//
			xBar.addEventListener(UIEvent.SCROLL, xScrollHandler);
			yBar.addEventListener(UIEvent.SCROLL, yScrollHandler);
		}
	}
}