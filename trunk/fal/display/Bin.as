/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.display
{
	import fal.data.ErrorCode;
	import fal.events.DisplayEvent;
	import fal.math.Arith;
	import fal.style.CSSFile;
	import fal.style.CSSManager;
	import fal.style.CSSStyle;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.managers.PopUpManager;
	
	public class Bin extends Sprite
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		private const SMOOTH_DELAY:Number = 30;
		
		protected var displayWidth:Number = 0;
		protected var displayHeight:Number = 0;
		
		protected var _style:CSSStyle = new CSSStyle();
		
		private var moveTimer:Timer;
		private var moveStep:Point;
		
		private var zoomTimer:Timer;
		private var zoomStep:Point;
		
		private var _maxWidth:Number = 4000;
		private var _minWidth:Number = 4000;
		private var _maxHeight:Number = 0;
		private var _minHeight:Number = 0;
		
		/****************************************
		 * 
		 * GETTER & SETTER
		 * 
		 ****************************************/
		
		override public function get width():Number
		{
			return displayWidth;
		}
		override public function set width(value:Number):void
		{
			this.displayWidth = Arith.getNumArea(value, minWidth, maxWidth);
			this.updateView();
		}
		
		override public function get height():Number
		{
			return displayHeight;
		}
		override public function set height(value:Number):void
		{
			this.displayHeight = Arith.getNumArea(value, minHeight, maxHeight);
			this.updateView();
		}
		
		public function get style():CSSStyle
		{
			return _style;
		}
		public function set style(value:CSSStyle):void
		{
			if(_style != value)
			{
				_style = value;
				updateView();
			}
		}
		
		public function get maxWidth():Number
		{
			return _maxWidth;
		}
		public function set maxWidth(value:Number):void
		{
			_maxWidth = value;
			if(this.displayWidth > _maxWidth)
			{
				this.displayWidth = _maxWidth;
				this.updateView();
			}
		}
		
		public function get maxHeight():Number
		{
			return _maxHeight;
		}
		public function set maxHeight(value:Number):void
		{
			_maxHeight = value;
			if(this.displayHeight > _maxHeight)
			{
				this.displayHeight = _maxHeight;
				this.updateView();
			}
		}
		
		public function get minWidth():Number
		{
			return _minWidth;
		}
		public function set minWidth(value:Number):void
		{
			_minWidth = Math.max(value, 0);
			if(this.displayWidth < _minWidth)
			{
				this.displayWidth = _minWidth;
				this.updateView();
			}
		}
		
		public function get minHeight():Number
		{
			return _minHeight;
		}
		public function set minHeight(value:Number):void
		{
			_minHeight = Math.max(value, 0);
			if(this.displayHeight < _minHeight)
			{
				this.displayHeight = _minHeight;
				this.updateView();
			}
		}
		
		/****************************************
		 * 
		 * fal.display.Bin Constructor
		 * 
		 ****************************************/
		
		public function Bin()
		{
			super();
		}
		
		/****************************************
		 * OVERRIDE
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		/**
		 * Change Bin's size to target width and height immediately.
		 * run updateView to reisze.
		 */	
		public function resize(width:Number, height:Number):void
		{
			this.displayWidth = Arith.getNumArea(width, this.minWidth, this.maxWidth);
			this.displayHeight = Arith.getNumArea(height, this.minHeight, this.maxHeight);
			this.updateView();
		}
		
		/**
		 * Change Bin's size to target width and height smoothly.
		 * 
		 * @param width Target width.
		 * @param height Target height.
		 * @param during Time spend to change, in millisecond.
		 */	
		public function zoom(width:Number, height:Number, during:uint = 500):void
		{
			if(zoomTimer != null && zoomTimer.running)
			{
				zoomTimer.stop();
				zoomTimer = null;
			}
			var stepCount:uint = Math.floor(during / SMOOTH_DELAY);
			zoomStep = new Point();
			zoomStep.x = (width - displayWidth) / stepCount;
			zoomStep.y = (height - displayHeight) / stepCount;
			//
			zoomTimer = new Timer(SMOOTH_DELAY, stepCount);
			zoomTimer.addEventListener(TimerEvent.TIMER, zoomTimerHandler);
			zoomTimer.addEventListener(TimerEvent.TIMER_COMPLETE, zoomTimerEndHandler);
			zoomTimer.start();
		}
		
		public function move(x:Number, y:Number, during:uint = 500):void
		{
			if(moveTimer != null && moveTimer.running)
			{
				moveTimer.stop();
				moveTimer = null;
			}
			var stepCount:uint = Math.floor(during / SMOOTH_DELAY);
			moveStep = new Point();
			moveStep.x = (x - this.x) / stepCount;
			moveStep.y = (y - this.y) / stepCount;
			//
			moveTimer = new Timer(SMOOTH_DELAY, stepCount);
			moveTimer.addEventListener(TimerEvent.TIMER, moveTimerHandler);
			moveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, moveTimerEndHandler);
			moveTimer.start();
		}
		
		public function toFront():void
		{
			if(this.parent != null)
			{
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
			}
		}
		
		/****************************************
		 * 
		 * PROTECTED
		 * 
		 ****************************************/
		protected function updateView():void
		{
			
		}
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * 
		 * HANDLER
		 * 
		 ****************************************/
		private function zoomTimerHandler(e:TimerEvent):void
		{
			this.displayWidth += zoomStep.x;
			this.displayHeight += zoomStep.y;
			this.updateView();
			e.updateAfterEvent();
		}
		
		private function zoomTimerEndHandler(e:TimerEvent):void
		{
			this.zoomTimer = null;
			this.zoomStep = null;
			this.dispatchEvent(new DisplayEvent(DisplayEvent.END_ZOOM));
		}
		
		private function moveTimerHandler(e:TimerEvent):void
		{
			this.x += moveStep.x;
			this.y += moveStep.y;
			e.updateAfterEvent();
		}
		
		private function moveTimerEndHandler(e:TimerEvent):void
		{
			this.moveTimer = null;
			this.moveStep = null;
			this.dispatchEvent(new DisplayEvent(DisplayEvent.END_MOVE));
		}
	}
}