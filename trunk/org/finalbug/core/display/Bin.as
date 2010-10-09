/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.core.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.finalbug.core.events.DisplayEvent;
	import org.finalbug.core.events.MotionEvent;
	import org.finalbug.core.motion.MoveMotion;
	import org.finalbug.core.motion.SizeMotion;
	import org.finalbug.core.utils.MathUtil;
	
	/**
	 * org.finalbug.fal.display.Bin
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class Bin extends Sprite
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		private const SMOOTH_DELAY:Number = 30;
		
		protected var displayWidth:Number = 0;
		protected var displayHeight:Number = 0;
		
		private var _maxWidth:Number = 4000;
		private var _maxHeight:Number = 4000;
		private var _minWidth:Number = 0;
		private var _minHeight:Number = 0;
		
		private var moveMotion:MoveMotion;
		private var sizeMotion:SizeMotion;
		
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
			this.displayWidth = MathUtil.getNumArea(value, minWidth, maxWidth);
			this.updateView();
		}
		
		override public function get height():Number
		{
			return displayHeight;
		}
		override public function set height(value:Number):void
		{
			this.displayHeight = MathUtil.getNumArea(value, minHeight, maxHeight);
			this.updateView();
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
		 * org.finalbug.fal.display.Bin Constructor
		 * 
		 ****************************************/
		
		public function Bin()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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
			this.displayWidth = MathUtil.getNumArea(width, this.minWidth, this.maxWidth);
			this.displayHeight = MathUtil.getNumArea(height, this.minHeight, this.maxHeight);
			this.updateView();
		}
		
		/**
		 * Change Bin's size to target width and height smoothly.
		 * 
		 * @param width Target width.
		 * @param height Target height.
		 * @param during Time spend to change, in millisecond.
		 */	
		public function zoomTo(width:Number, height:Number, during:uint = 500):void
		{
			if(this.sizeMotion == null)
			{
				this.sizeMotion = new SizeMotion(this);
				this.sizeMotion.addEventListener(MotionEvent.MOTION_STOP, stopZoomHandler);
			}
			else if(this.sizeMotion.running)
			{
				this.sizeMotion.stop();
			}
			this.sizeMotion.widthFrom = this.displayWidth;
			this.sizeMotion.heightFrom = this.displayHeight;
			this.sizeMotion.widthTo = width;
			this.sizeMotion.heightTo = height;
			this.sizeMotion.during = during;
			this.sizeMotion.start();
		}
		
		public function moveTo(x:Number, y:Number, during:uint = 500):void
		{
			if(this.moveMotion == null)
			{
				this.moveMotion = new MoveMotion(this);
				moveMotion.addEventListener(MotionEvent.MOTION_STOP, stopMoveHandler);
			}
			else if(this.moveMotion.running)
			{
				this.moveMotion.stop();
			}
			moveMotion.xFrom = this.x;
			moveMotion.yFrom = this.y;
			moveMotion.xTo = x;
			moveMotion.yTo = y;
			moveMotion.during = during;
			moveMotion.start();
		}
		
		public function toFront():void
		{
			if(this.parent != null)
			{
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
			}
		}
		
		public function toCenter():void
		{
			if(this.parent != null)
			{
				this.x = (this.parent.width - this.width) / 2;
				this.y = (this.parent.height - this.height) / 2;
			}
		}
		
		public function addAll(...args):void
		{
			var len:uint = args.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				if(args[i] is DisplayObject)
				{
					this.addChild(args[i]);
				}
			}
		}
		
		public function removeAll():void
		{
			this.graphics.clear();
			for(var i:uint = this.numChildren ; --i >= 0 ; )
			{
				this.removeChildAt(i);
			}
		}
		
		/****************************************
		 * 
		 * PROTECTED
		 * 
		 ****************************************/
		protected function updateView():void{}
		
		protected function callAtAdded():void{}
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * 
		 * HANDLER
		 * 
		 ****************************************/
		private function stopZoomHandler(e:MotionEvent):void
		{
			this.dispatchEvent(new DisplayEvent(DisplayEvent.END_ZOOM));
		}
		
		private function stopMoveHandler(e:MotionEvent):void
		{
			this.dispatchEvent(new DisplayEvent(DisplayEvent.END_MOVE));
		}
		
		private function addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.callAtAdded();
		}
	}
}