//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.control
{
	import org.finalbug.data.Position;
	import org.finalbug.events.UIEvent;
	import org.finalbug.ui.skin.UISkinDataBase;
	import org.finalbug.ui.style.FillStyle;
	
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
		//#######################################
		// OVERRIDE
		//#######################################
		
		override protected function updateView():void
		{
			super.updateView();
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
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		protected var xBar:ScrollBar; // scroll bar X
		/**
		 * 
		 * @default 
		 */
		protected var yBar:ScrollBar; // scroll bar Y
		/**
		 * 
		 * @default 
		 */
		protected var enableX:Boolean; // enable scrollbar x or not
		/**
		 * 
		 * @default 
		 */
		protected var enableY:Boolean; // enable scrollbar y or not
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
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
			if(enableX != value)
			{
				enableX = value;
				updateView();
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
			if(enableY != value)
			{
				enableY = value;
				updateView();
			}
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
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
		public function ScrollBox(xScroll:Boolean = true, yScroll:Boolean = true, skin:UISkinDataBase = null)
		{
			// save parameters
			super(skin);
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
			xBar = new ScrollBar(Position.HORIZONTAL);
			yBar = new ScrollBar(Position.VERTICAL);
			this.addAll(xBar, yBar);
			//
			xBar.enabled = xBar.visible = false;
			yBar.enabled = yBar.visible = false;
			//
			xBar.addEventListener(UIEvent.SCROLL, xScrollHandler);
			yBar.addEventListener(UIEvent.SCROLL, yScrollHandler);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		/**
		 * 
		 * @param e
		 */
		protected function xScrollHandler(e:UIEvent):void{}
		/**
		 * 
		 * @param e
		 */
		protected function yScrollHandler(e:UIEvent):void{}
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}