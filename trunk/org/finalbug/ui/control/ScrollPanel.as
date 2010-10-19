/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.control
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.finalbug.core.draw.Graph;
	import org.finalbug.events.UIEvent;
	
	/**
	 * This class create a panel with scrollbar x and y.
	 * 
	 * @author	Finalbug
	 * @since	old version
	 */
	public class ScrollPanel extends ScrollBox
	{
		private var masker:Sprite;
		private var _dragable:Boolean = true;
		private var box:Sprite;
		
		/**
		 * if the container can be dragged and moved.
		 */		
		public function get dragable():Boolean
		{
			return _dragable;
		}
		public function set dragable(val:Boolean):void
		{
			_dragable = val;
		}
		
		public function get container():Sprite
		{
			return box;
		}
		
		override public function set xScrollEnabled(value:Boolean) : void
		{
			super.xScrollEnabled = value;
			this.updateView();
		}
		
		override public function set yScrollEnabled(value:Boolean) : void
		{
			super.yScrollEnabled = value;
			this.updateView();
		}
		
		/**
		 * Create a new ScrollPanel object.
		 */
		public function ScrollPanel(xScroll:Boolean = true, yScroll:Boolean = true)
		{
			super(xScroll, yScroll);
			createChildren();
		}
		
		override protected function updateView():void
		{
			super.updateView();
			//
			masker.width = super.containerWidth;
			masker.height = super.containerHeight;
			//
			if(box.x > 0)
			{
				box.x = 0;
			}
			else if(box.x < masker.width - box.width)
			{
				box.x = masker.width - box.width;
			}
			//
			if(box.y > 0)
			{
				box.y = 0;
			}
			else if (box.y < masker.height - box.height)
			{
				box.y = masker.height - box.height;
			}
			//
			resetScroll();
		}
		
		private function createChildren():void
		{
			masker = new Sprite();
			masker.mouseChildren = masker.mouseChildren = false;
			Graph.drawLucidRectangle(masker);
			box = new Sprite();
			box.mask = masker;
			this.addAll(box, masker);
			//
			box.addEventListener(MouseEvent.MOUSE_DOWN, pressContainerHandler);
		}
		
		private function resetScroll():void
		{
			//
			if(box.width <= masker.width)
			{
				xBar.enabled = false;
			}
			else if(enableX)
			{
				xBar.enabled = true;
				xBar.scale = masker.width / box.width;
				xBar.position = box.x / (masker.width - box.width);
			}
			//
			if(box.height <= masker.height)
			{
				yBar.enabled = false;
			}
			else if(enableY)
			{
				yBar.enabled = true;
				yBar.scale = masker.height / box.height;
				yBar.position = box.y / (masker.height - box.height);
			}
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		// event handlers.
		
		/**
		 * invoked when change x coordinate scroll.
		 * @param e
		 */		
		override protected function xScrollHandler(e:UIEvent):void
		{
			var pos:Number = xBar.position;
			box.x = - pos * (box.width - masker.width);
		}
		
		/**
		 * handler of scroll scrollBarY
		 */
		override protected function yScrollHandler(e:UIEvent):void
		{
			var pos:Number = yBar.position;
			box.y = - pos * (box.height - masker.height);
		}
		
		/**
		 * invoked when press container.
		 * if enable drag container, set drag events here.
		 * 
		 * @param e
		 */		
		private function pressContainerHandler(e:MouseEvent):void
		{
			if(_dragable)
			{
				var rec:Rectangle = new Rectangle(0, 0, masker.width - box.width, masker.height - box.height);
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
			if(enableX || enableY)
			{
				resetScroll();
			}
			e.updateAfterEvent();
		}
	}
}