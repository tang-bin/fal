package fal.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import fal.events.UIEvent;
	
	/**
	 * This class create a panel with scrollbar x and y.
	 * 
	 * @author	Finalbug
	 * @since	old version
	 */
	public class ScrollPanel extends Cage
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
		
		override public function set width(value:Number) : void
		{
			super.width = value;
			masker.width = super.containerWidth;
			refresh();
		}
		override public function set height(value:Number) : void
		{
			super.height = value;
			masker.height = super.containerHeight;
			refresh();
		}
		
		override public function set xScrollEnabled(value:Boolean) : void
		{
			super.xScrollEnabled = value;
			refresh();
		}
		
		override public function set yScrollEnabled(value:Boolean) : void
		{
			super.yScrollEnabled = value;
			refresh();
		}
		
		/**
		 * Create a new ScrollPanel object.
		 */
		public function ScrollPanel(width:Number = 400, height:Number = 300,
									xScroll:Boolean = true, yScroll:Boolean = true)
		{
			super(width, height, xScroll, yScroll);
			this.uiName = "ScrollPanel";
			//
			masker = new Sprite();
			masker.graphics.beginFill(0, 0);
			masker.graphics.drawRect(0, 0, 10, 10);
			masker.graphics.endFill();
			this.addChild(masker);
			masker.width = super.containerWidth;
			masker.height = super.containerHeight;
			//
			box = new Sprite();
			this.addChild(box);
			box.mask = masker;
			box.x = box.y = 0;
			//
			setEvent();
		}
		
		public function refresh():void
		{
			resetView();
			resetScroll();
		}
		
		private function resetView():void
		{
			if(masker != null)
			{
				masker.width = super.containerWidth;
				masker.height = super.containerHeight;
			}
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
		
		private function setEvent():void
		{
			box.addEventListener(MouseEvent.MOUSE_DOWN, pressContainerHandler);
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