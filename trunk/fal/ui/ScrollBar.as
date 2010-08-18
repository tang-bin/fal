package fas.ui
{
	import fas.data.FillData;
	import fas.data.Status;
	import fas.draw.Track;
	import fas.errors.UIError;
	import fas.events.UIEvent;
	import fas.events.UIMouseEvent;
	import fas.math.Arith;
	import fas.utils.Flat;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * ScrollBar
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class ScrollBar extends UIObject
	{
		/* constants */
		public static const SCROLL_X:String = "xScrollBar";
		public static const SCROLL_Y:String = "yScrollBar";
		
		private var btnFD:FillData;
		private var bgFD:FillData;
		private var sliderFD:FillData;
		private var buttonIconColor:Number = 0xFFFFFF;
		
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
		
		private var _thickness:Number = 16;
		private var _length:Number = 100;
		
		/* display containers */
		private var leftBtn:Flat;
		private var rightBtn:Flat;
		private var upBtn:Flat;
		private var downBtn:Flat;
		private var back:Flat;
		private var slider:Flat;
		private var disableMask:Sprite;
		
		private var _enabled:Boolean = true;
		
		override public function get width() : Number
		{
			return _type == ScrollBar.SCROLL_X ? this._length : this._thickness;
		}
		override public function set width(value:Number) : void{}
		
		override public function get height() : Number
		{
			return _type == ScrollBar.SCROLL_X ? this._thickness : this._length;
		}
		override public function set height(value:Number) : void{}
		
		/**
		 * enabled scrollBar or not.
		 */		
		public function set enabled(value:Boolean):void
		{
			if(enabled != value)
			{
				_enabled = value;
				setEnabled();
			}
		}
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
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
			_scale = Arith.getNumArea(_scale, 0, 1);
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
			_position = Arith.getNumArea(_position, 0, 1);
			this.setSlider();
		}
		
		public function get length():Number
		{
			return this._length;
		}
		public function set length(value:Number):void
		{
			this._length = value;
			setView();
			setSlider();
		}	
		
		public function get thickness():Number
		{
			return this._thickness;
		}
		
		public function get availLength():Number
		{
			return _length - 2 * _thickness;
		}
		
		/**
		 * Constuctor. create and initialize a new scrollBar
		 * 
		 * @param type ScrollType, can be ScrollBar.SCROLL_X or ScrollBar.SCROLL_Y.
		 * 				Once this parameter is set, cannot be changed during runtime.
		 * @param length Length of ScrollBar, in pixel.
		 * @param style Display style.
		 */		
		public function ScrollBar(type:String, length:Number)
		{
			super.uiName = "ScrollBar";
			if(type != ScrollBar.SCROLL_X && type != ScrollBar.SCROLL_Y)
			{
				throw new UIError(UIError.WRONG_SCROLLBAR_TYPE);
			}
			_type = type;
			this._thickness = 16;
			this._length = length;
			//
			btnFD = new FillData(false);
			btnFD.glowAlpha = 0;
			btnFD.borderColor = 0x990000;
			btnFD.gradient = true;
			btnFD.bodyColor = 0x990000;
			btnFD.rotate = 45;
			//
			bgFD = new FillData(false);
			bgFD.glowAlpha = 0;
			bgFD.borderColor = 0x990000;
			bgFD.bodyColor = 0xFAFAFA;
			//
			sliderFD = btnFD.clone();
			sliderFD.rotate = _type == ScrollBar.SCROLL_X ? 90 : 0;
			//
			if(_type == ScrollBar.SCROLL_X)
			{
				createScrollBarX();
			}
			else
			{
				createScrollBarY();
			}
			setView();
			setSlider();
			setEvent();
		}
		
		private function setView():void
		{
			if(_type == ScrollBar.SCROLL_X)
			{
				leftBtn.width = leftBtn.height = _thickness;
				drawLeftBtnAddon();
				rightBtn.x = _length - _thickness;
				rightBtn.width = rightBtn.height = _thickness;
				drawRightBtnAddon();
				//
				back.width = availLength;
				back.height = _thickness;
				back.x = _thickness;
			}
			else
			{
				upBtn.width = upBtn.height = _thickness;
				drawUpBtnAddon();
				downBtn.y = _length - _thickness;
				downBtn.width = downBtn.height = _thickness;
				drawDownBtnAddon();
				//
				back.y = _thickness;
				back.width = _thickness;
				back.height = availLength;
			}
			if(disableMask != null)
			{
				disableMask.width = width;
				disableMask.height = height;
			}
		}
		
		public function changeSlider(position:Number, scale:Number):void
		{
			_position = Arith.getNumArea(position, 0, 1);
			_scale = Arith.getNumArea(scale, 0, 1);
			this.setSlider();
		}
		
		/**
		 * change slider's position and size.
		 */		
		private function setSlider():void
		{
			if(slider != null)
			{
				var len:Number = (_length - 2 * _thickness) * _scale;
				if(_type == ScrollBar.SCROLL_X)
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
			leftBtn = new Flat(10, 10, btnFD);
			rightBtn = new Flat(10, 10, btnFD);
			back = new Flat(10, 10, bgFD);
			slider = new Flat(10, 10, sliderFD);
			leftBtn.name = "leftBtn";
			rightBtn.name = "rightBtn";
			this.addChild(leftBtn);
			this.addChild(rightBtn);
			this.addChild(back);
			this.addChild(slider);
		}
		
		private function createScrollBarY():void
		{
			upBtn = new Flat(10, 10, btnFD);
			downBtn = new Flat(10, 10, btnFD);
			back = new Flat(10, 10, bgFD);
			slider = new Flat(10, 10, sliderFD);
			upBtn.name = "upBtn";
			downBtn.name = "downBtn";
			this.addChild(upBtn);
			this.addChild(downBtn);
			this.addChild(back);
			this.addChild(slider);
		}
		
		private function setEnabled():void
		{
			if(enabled)
			{
				if(disableMask != null)
				{
					disableMask.visible = false;
				}
				slider.visible = true;
			}
			else
			{
				// create and add disable mask flat to stage if its not created yet.
				if(disableMask == null)
				{
					disableMask = new Sprite();
					disableMask.graphics.beginFill(0, 0.7);
					disableMask.graphics.drawRect(0, 0, 10, 10);
					disableMask.graphics.endFill();
					this.addChild(disableMask);
				}
				// set size
				disableMask.width = width;
				disableMask.height = height;
				// set display.
				disableMask.visible = true;
				slider.visible = false;
			}
		}
		
		private function setEvent():void
		{
			if(_type == ScrollBar.SCROLL_X)
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
			if(_type == ScrollBar.SCROLL_X)
			{
				rate = (slider.x - _thickness) / (availLength - slider.width);
			}
			else
			{
				rate = (slider.y - _thickness) / (availLength - slider.height);
			}
			rate = Arith.accountDecimalDigit(rate, -3);
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
			if(enabled)
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
					ee.targetStatus = Status.UP_STATUS;
					break;
				case "down":
					ee.targetStatus = Status.DOWN_STATUS;
					break;
				case "left":
					ee.targetStatus = Status.LEFT_STATUS;
					break;
				case "right":
					ee.targetStatus = Status.RIGHT_STATUS;
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
				if(_type == ScrollBar.SCROLL_X)
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
			var len:Number = _thickness / 2;
			leftBtn.graphics.beginFill(buttonIconColor, 1);
			Track.drawTriangle(leftBtn, new Point(len, len), len, len, "left");
			leftBtn.graphics.endFill();
		}
		
		private function drawRightBtnAddon():void
		{
			var len:Number = _thickness / 2;
			rightBtn.graphics.beginFill(buttonIconColor, 1);
			Track.drawTriangle(rightBtn, new Point(len, len), len, len, "right");
			rightBtn.graphics.endFill();
		}
		
		private function drawUpBtnAddon():void
		{
			var len:Number = _thickness / 2;
			upBtn.graphics.beginFill(buttonIconColor, 1);
			Track.drawTriangle(upBtn, new Point(len, len), len, len, "up");
			upBtn.graphics.endFill();
		}
		
		private function drawDownBtnAddon():void
		{
			var len:Number = _thickness / 2;
			downBtn.graphics.beginFill(buttonIconColor, 1);
			Track.drawTriangle(downBtn, new Point(len, len), len, len, "down");
			downBtn.graphics.endFill();
		}
	}
}