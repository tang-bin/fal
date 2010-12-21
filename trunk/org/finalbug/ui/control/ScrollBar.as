/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.control
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import org.finalbug.data.Position;
	import org.finalbug.data.Status;
	import org.finalbug.errors.UIError;
	import org.finalbug.events.UIEvent;
	import org.finalbug.events.UIMouseEvent;
	import org.finalbug.ui.control.UIObject;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.style.FillStyle;
	import org.finalbug.ui.style.stylefactory.ScrollBarStyleFactory;
	import org.finalbug.utils.DrawUtil;
	import org.finalbug.utils.MathUtil;
	
	/**
	 * ScrollBar
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollBar extends UIObject
	{
		public static const DEFAULT_THICKNESS:Number = 14;
		
		/* variates */
		private var moveStep:Number;
		private var moveTimer:Timer;
		private var clickTimer:Timer;
		private var currentMoveType:String = "";
		private var _type:String;
		private var _defineClickOutside:Boolean = false;
		private var _scale:Number = 0.5;
		private var _position:Number = 0.5;
		private var _speed:Number = 3;
		
		private var _thickness:Number = 10;
		private var _length:Number = 100;
		
		/* display containers */
		private var leftBtn:Flat;
		private var rightBtn:Flat;
		private var upBtn:Flat;
		private var downBtn:Flat;
		private var back:Flat;
		private var slider:Flat;
		
		private var _enabled:Boolean = true;
		
		override public function get width():Number
		{
			return _type == Position.HORIZONTAL ? this._length : this._thickness;
		}
		override public function set width(value:Number) : void{}
		
		override public function get height():Number
		{
			return _type == Position.HORIZONTAL ? this._thickness : this._length;
		}
		override public function set height(value:Number) : void{}
		
		/**
		 * scale value of slider in percent. from 0 to 1.
		 */		
		public function get scale():Number
		{
			return _scale;
		}
		public function set scale(value:Number):void
		{
			_scale = value;
			_scale = MathUtil.getNumArea(_scale, 0, 1);
			setSlider();
		}
		
		/**
		 * current position of slider. from 0 to 1.
		 */		
		public function get position():Number
		{
			return _position;
		}
		public function set position(value:Number):void
		{
			_position = value;
			_position = MathUtil.getNumArea(_position, 0, 1);
			this.setSlider();
		}
		
		public function get length():Number
		{
			return this._length;
		}
		public function set length(value:Number):void
		{
			this._length = value;
			this.updateView();
		}	
		
		public function get thickness():Number
		{
			return this._thickness;
		}
		
		public function get availLength():Number
		{
			return _length - 2 * _thickness;
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			this.slider.visible = value;
			this.mouseChildren = this.mouseEnabled = value;
		}
		
		/**
		 * Constuctor. create and initialize a new scrollBar
		 * 
		 * @param type ScrollType, can be Position.HORIZONTAL or Position.VERTICAL.
		 * 				Once this parameter is set, cannot be changed during runtime.
		 * @param length Length of ScrollBar, in pixel.
		 * @param style Display style.
		 */		
		public function ScrollBar(type:String, length:Number = 100)
		{
			super();
			if(type != Position.HORIZONTAL && type != Position.VERTICAL)
			{
				throw new UIError(UIError.WRONG_SCROLLBAR_TYPE);
			}
			_type = type;
			this._thickness = DEFAULT_THICKNESS;
			this._length = length;
			createChildren();
		}
		
		override protected function updateView():void
		{
			super.updateView();
			var fs:FillStyle = currentStyle.fillStyle;
			if(_type == Position.HORIZONTAL)
			{
				leftBtn.fillStyle = fs;
				leftBtn.width = leftBtn.height = _thickness;
				drawLeftBtnAddon();
				//
				rightBtn.fillStyle = fs;
				rightBtn.x = _length - _thickness;
				rightBtn.width = rightBtn.height = _thickness;
				drawRightBtnAddon();
				//
				back.fillStyle = fs;
				back.alpha = 0.5;
				back.width = availLength;
				back.height = _thickness;
				back.x = _thickness;
			}
			else
			{
				upBtn.fillStyle = fs;
				upBtn.width = upBtn.height = _thickness;
				drawUpBtnAddon();
				//
				downBtn.fillStyle = fs;
				downBtn.y = _length - _thickness;
				downBtn.width = downBtn.height = _thickness;
				drawDownBtnAddon();
				//
				back.fillStyle = fs;
				back.alpha = 0.5;
				back.y = _thickness;
				back.width = _thickness;
				back.height = availLength;
			}
			fs = fs.clone();
			fs.useGradient = false;
			slider.fillStyle = fs;
			this.setSlider();
		}
		
		public function changeSlider(position:Number, scale:Number):void
		{
			_position = MathUtil.getNumArea(position, 0, 1);
			_scale = MathUtil.getNumArea(scale, 0, 1);
			this.setSlider();
		}
		
		private function createChildren():void
		{
			if(_type == Position.HORIZONTAL)
			{
				createScrollBarX();
			}
			else
			{
				createScrollBarY();
			}
			//
			this.registerStatus(Status.NORMAL, ScrollBarStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.DISABLE, ScrollBarStyleFactory.createDisableStyle());
			//
			if(_type == Position.HORIZONTAL)
			{
				leftBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				rightBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				slider.addEventListener(MouseEvent.MOUSE_DOWN, pressSliderHandler);
			}
			else
			{
				upBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				downBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				slider.addEventListener(MouseEvent.MOUSE_DOWN, pressSliderHandler);
			}
		}
		
		/**
		 * change slider's position and size.
		 */		
		private function setSlider():void
		{
			if(slider != null)
			{
				var len:Number = (_length - 2 * _thickness) * _scale;
				if(_type == Position.HORIZONTAL)
				{
					slider.width = len;
					slider.height = _thickness;
					slider.x = (availLength - slider.width) * _position + _thickness;;
					slider.y = 0;
				}
				else
				{
					slider.width = _thickness;
					slider.height = len;
					slider.x = 0;
					slider.y = (availLength - slider.height) * _position + _thickness;;
				}
			}
		}
		
		private function createScrollBarX():void
		{
			leftBtn = new Flat();
			rightBtn = new Flat();
			back = new Flat();
			slider = new Flat();
			leftBtn.name = "leftBtn";
			rightBtn.name = "rightBtn";
			//
			leftBtn.mouseEnabled = rightBtn.mouseEnabled = slider.mouseEnabled = true;
			//
			this.addAll(back, leftBtn, rightBtn, slider);
		}
		
		private function createScrollBarY():void
		{
			upBtn = new Flat();
			downBtn = new Flat();
			back = new Flat();
			slider = new Flat();
			upBtn.name = "upBtn";
			downBtn.name = "downBtn";
			//
			upBtn.mouseEnabled = downBtn.mouseEnabled = slider.mouseEnabled = true;
			//
			this.addAll(back, upBtn, downBtn, slider);
		}
		
		private function stopMove():void
		{
			if(_defineClickOutside)
			{
				clickTimer.stop();
			}
			else
			{
				moveTimer.stop();
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			if(currentMoveType == "left")
			{
				leftBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
			else if(currentMoveType == "right")
			{
				rightBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
			else if(currentMoveType == "up")
			{
				upBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
			else if(currentMoveType == "down")
			{
				downBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
		}
		
		private function accountSlider():void
		{
			var rate:Number;
			if(_type == Position.HORIZONTAL)
			{
				rate = (slider.x - _thickness) / (availLength - slider.width);
			}
			else
			{
				rate = (slider.y - _thickness) / (availLength - slider.height);
			}
			rate = MathUtil.accountDecimalDigit(rate, -3);
			rate = rate > 0.95 ? 1 : rate;
			rate = rate < 0.05 ? 0 : rate;
			var ee:UIEvent = new UIEvent(UIEvent.SCROLL);
			this._position = ee.position = rate;
			this.dispatchEvent(ee);
		}
		
		//////////////////////////////////////////////////////////////////////////////////
		// event handlers
		
		private function pressBtnHandler(e:MouseEvent):void
		{
			if(_enabled)
			{
				moveStep = (this.availLength - slider.width) * _speed / 100;
				//
				if(e.target.name == "leftBtn")
				{
					currentMoveType = "left";
					leftBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				else if(e.target.name == "rightBtn")
				{
					currentMoveType = "right";
					rightBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				else if(e.target.name == "upBtn")
				{
					currentMoveType = "up";
					upBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				else if(e.target.name == "downBtn")
				{
					currentMoveType = "down";
					downBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				if(_defineClickOutside)
				{
					clickTimer = new Timer(100, 0);
					clickTimer.addEventListener(TimerEvent.TIMER, holdBtnHandler);
					clickTimer.start();
				}
				else
				{
					moveTimer = new Timer(10, 0);
					moveTimer.addEventListener(TimerEvent.TIMER, moveSliderHandler);
					moveTimer.start();
				}
			}
		}
		
		private function holdBtnHandler(e:TimerEvent):void
		{
			var ee:UIMouseEvent = new UIMouseEvent(UIMouseEvent.FE_CLICK);
			switch(currentMoveType)
			{
				case "up":
					ee.targetStatus = Status.UP;
					break;
				case "down":
					ee.targetStatus = Status.DOWN;
					break;
				case "left":
					ee.targetStatus = Status.LEFT;
					break;
				case "right":
					ee.targetStatus = Status.RIGHT;
					break;
			}
			this.dispatchEvent(ee);
		}
		
		private function releaseBtnHandler(evt:MouseEvent):void
		{
			stopMove();
		}
		
		private function pressSliderHandler(evt:MouseEvent):void
		{
			if(enabled)
			{
				var dragArea:Rectangle;
				if(_type == Position.HORIZONTAL)
				{
					dragArea = new Rectangle(_thickness, slider.y, availLength - slider.width, 0);
				}
				else
				{
					dragArea = new Rectangle(slider.x, _thickness, 0, availLength - slider.height);
				}
				slider.startDrag(false, dragArea);
				//
				slider.addEventListener(MouseEvent.MOUSE_MOVE, dragSliderHandler);
				slider.addEventListener(MouseEvent.MOUSE_UP, stopDragSliderHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, stopDragSliderHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, dragSliderHandler);
			}
		}
		
		private function dragSliderHandler(evt:MouseEvent):void
		{
			accountSlider();
			evt.updateAfterEvent();
		}
		
		private function stopDragSliderHandler(evt:MouseEvent):void
		{
			slider.stopDrag();
			slider.removeEventListener(MouseEvent.MOUSE_MOVE, dragSliderHandler);
			slider.removeEventListener(MouseEvent.MOUSE_UP, stopDragSliderHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragSliderHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragSliderHandler);
		}
		
		private function moveSliderHandler(evt:TimerEvent):void
		{
			if(currentMoveType == "left")
			{
				slider.x -= moveStep;
				if(slider.x < _thickness)
				{
					slider.x = _thickness;
					stopMove();
				}
			}
			else if(currentMoveType == "right")
			{
				slider.x += moveStep;
				var maxX:Number = _length - slider.width - _thickness;
				if(slider.x > maxX)
				{
					slider.x = maxX;
					stopMove();
				}
			}
			else if(currentMoveType == "up")
			{
				slider.y -= moveStep;
				if(slider.y < _thickness)
				{
					slider.y = _thickness;
					stopMove();
				}
			}
			else if(currentMoveType == "down")
			{
				slider.y += moveStep;
				var maxY:Number = _length - slider.height - _thickness;
				if(slider.y > maxY)
				{
					slider.y = maxY;
					stopMove();
				}
			}
			accountSlider();
			evt.updateAfterEvent();
		}
		
		/* ****************************************************** */
		/* builder */
		
		private function drawLeftBtnAddon():void
		{
			var color:Number = Number(currentStyle.textStyle.format.color);
			var len:Number = _thickness / 2;
			leftBtn.graphics.beginFill(color, 1);
			DrawUtil.drawTriangle(leftBtn.graphics, new Point(len, len), len, len, "left");
			leftBtn.graphics.endFill();
		}
		
		private function drawRightBtnAddon():void
		{
			var color:Number = Number(currentStyle.textStyle.format.color);
			var len:Number = _thickness / 2;
			rightBtn.graphics.beginFill(color, 1);
			DrawUtil.drawTriangle(rightBtn.graphics, new Point(len, len), len, len, "right");
			rightBtn.graphics.endFill();
		}
		
		private function drawUpBtnAddon():void
		{
			var color:Number = Number(currentStyle.textStyle.format.color);
			var len:Number = _thickness / 2;
			upBtn.graphics.beginFill(color, 1);
			DrawUtil.drawTriangle(upBtn.graphics, new Point(len, len), len, len, "up");
			upBtn.graphics.endFill();
		}
		
		private function drawDownBtnAddon():void
		{
			var color:Number = Number(currentStyle.textStyle.format.color);
			var len:Number = _thickness / 2;
			downBtn.graphics.beginFill(color, 1);
			DrawUtil.drawTriangle(downBtn.graphics, new Point(len, len), len, len, "down");
			downBtn.graphics.endFill();
		}
	}
}