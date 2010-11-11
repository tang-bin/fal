/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.core.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.finalbug.core.motion.MoveMotion;
	import org.finalbug.core.motion.SizeMotion;
	import org.finalbug.data.Position;
	import org.finalbug.events.DisplayEvent;
	import org.finalbug.events.MotionEvent;
	import org.finalbug.utils.MathUtil;
	
	/**
	 * Bin is the basic class for all other display object used in fb-aslib.
	 * 
	 * @author Tang Bin
	 * @since 2010.08
	 */	
	public class Bin extends Sprite
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private const SMOOTH_DELAY:Number = 30;
		
		protected var displayWidth:Number = 0;
		protected var displayHeight:Number = 0;
		
		private var _maxWidth:Number = 4000;
		private var _maxHeight:Number = 4000;
		private var _minWidth:Number = 0;
		private var _minHeight:Number = 0;
		
		private var moveMotion:MoveMotion;
		private var sizeMotion:SizeMotion;
		
		private var _controlPoint:Point = new Point(0, 0);
		private var _controlPointType:String = "";
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		/**
		 * @default 0
		 */		
		override public function get width():Number
		{
			return displayWidth;
		}
		override public function set width(value:Number):void
		{
			this.displayWidth = MathUtil.getNumArea(value, minWidth, maxWidth);
			this.updateView();
		}
		
		/**
		 * @default 0
		 */		
		override public function get height():Number
		{
			return displayHeight;
		}
		override public function set height(value:Number):void
		{
			this.displayHeight = MathUtil.getNumArea(value, minHeight, maxHeight);
			this.updateView();
		}
		
		/**
		 * controlPoint is the point used to control the Bin object.
		 * You can set the position, rotate the object by it's controlPoint.
		 * @default (0, 0)
		 */
		public function get controlPoint():Point
		{
			accountControlPoint();
			return _controlPoint;
		}
		public function set controlPoint(value:Point):void
		{
			_controlPointType = "";
			_controlPoint = value;
		}
		
		/**
		 * The x coordition value of controlPoint from object's parent.
		 */
		public function get controlX():Number
		{
			return this.x + controlPoint.x;
		}
		public function set controlX(value:Number):void
		{
			this.x = value - controlPoint.x;
		}
		
		/**
		 * The y coordition value of controlPoint from object's parent.
		 */
		public function get controlY():Number
		{
			return this.y + controlPoint.y;
		}
		public function set controlY(value:Number):void
		{
			this.y = value - controlPoint.y;
		}
		
		/**
		 * The max width value of object.
		 * @default 4000
		 */
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
		
		/**
		 * The max height value of object.
		 * @default 4000
		 */
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
		
		/**
		 * The min width value of object.
		 * @default 0
		 */
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
		
		/**
		 * The min height value of object.
		 * @default 0
		 */
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
		
		//***************************************
		// Constructor
		//***************************************
		
		public function Bin()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//***************************************
		// OVERRIDE
		//***************************************
		
		//***************************************
		// PUBLIC
		//***************************************
		
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
		 * Zoom object's size to target width and height smoothly.
		 * Using Motion classes.
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
		
		/**
		 * Move object to target position smoothly.
		 * Using Motion classes.
		 * 
		 * @param x Target x coordition
		 * @param y Target y coordition
		 * @param during Move during time in millisecond.
		 */
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
		
		/**
		 * Bring the object to the front of it's parent.
		 */
		public function toFront():void
		{
			if(this.parent != null)
			{
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
			}
		}
		
		/**
		 * Bring the object to the back of it's parent.
		 */
		public function toBack():void
		{
			if(this.parent != null)
			{
				this.parent.setChildIndex(this, 0);
			}
		}
		
		/**
		 * Place the object to the center of it's parent.
		 */
		public function toCenter():void
		{
			if(this.parent != null)
			{
				this.x = (this.parent.width - this.width) / 2;
				this.y = (this.parent.height - this.height) / 2;
			}
		}
		
		/**
		 * Place the object to the specified position
		 * 
		 * @param pos Position string, see Class Position.
		 * @param center Only effect when parameter pos is one of the following values:
		 * 		Position.TOP, Position.LEFT, Position.RIGHT, Position.BOTTOM.
		 */
		public function toPosition(pos:String, center:Boolean = true):void
		{
			if(this.parent != null)
			{
				switch(pos)
				{
					case Position.TOP:
						if(center) this.x = (this.parent.width - this.width) / 2;
						this.y = 0;
						break;
					case Position.TOP_LEFT:
						this.x = this.y = 0;
						break;
					case Position.TOP_RIGHT:
						this.x = this.parent.width - this.width;
						this.y = 0;
						break;
					case Position.LEFT:
						if(center) this.y = (this.parent.height - this.height) / 2;
						this.x = 0;
						break;
					case Position.RIGHT:
						if(center) this.y = (this.parent.height - this.height) / 2;
						this.x = this.parent.width - this.width;
						break;
					case Position.BOTTOM:
						if(center) this.x = (this.parent.width - this.width) / 2;
						this.y = this.parent.height - this.height;
						break;
					case Position.BOTTOM_LEFT:
						this.x = 0;
						this.y = this.parent.height - this.height;
						break;
					case Position.BOTTOM_RIGHT:
						this.x = this.parent.width - this.width;
						this.y = this.parent.height - this.height;
						break;
				}
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
		
		//***************************************
		// PROTECTED
		//***************************************
		protected function updateView():void{}
		
		protected function callAtAdded():void{}
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function accountControlPoint():void
		{
			switch(_controlPointType)
			{
				case Position.TOP_CENTER:
					_controlPoint.x = displayWidth / 2;
					_controlPoint.y = 0;
					break;
				case Position.TOP_LEFT:
					_controlPoint.x = _controlPoint.y = 0;
					break;
				case Position.TOP_RIGHT:
					_controlPoint.x = displayWidth;
					_controlPoint.y = 0;
					break;
				case Position.LEFT_CENTER:
					_controlPoint.x = 0;
					_controlPoint.y = displayHeight / 2;
					break;
				case Position.CENTER:
					_controlPoint.x = displayWidth / 2;
					_controlPoint.y = displayHeight / 2;
					break;
				case Position.RIGHT_CENTER:
					_controlPoint.x = displayWidth;
					_controlPoint.y = displayHeight / 2;
					break;
				case Position.BOTTOM_LEFT:
					_controlPoint.x = 0;
					_controlPoint.y = displayHeight;
					break;
				case Position.BOTTOM_CENTER:
					_controlPoint.x = displayWidth / 2;
					_controlPoint.y = displayHeight;
					break;
				case Position.BOTTOM_RIGHT:
					_controlPoint.x = displayWidth;
					_controlPoint.y = displayHeight;
					break;
				default:
					_controlPoint.x = _controlPoint.y = 0;
					_controlPointType = "";
					break;
			}
		}
		
		//***************************************
		// HANDLER
		//***************************************
		
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
