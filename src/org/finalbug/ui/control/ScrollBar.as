// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.ui.control
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	import org.finalbug.data.Position;
	import org.finalbug.data.Status;
	import org.finalbug.errors.UIError;
	import org.finalbug.events.UIEvent;
	import org.finalbug.events.UIMouseEvent;
	import org.finalbug.ui.skin.ScrollBarSkinData;
	import org.finalbug.ui.skin.Skin;
	import org.finalbug.ui.skin.UISkinDataAbstract;
	import org.finalbug.utils.MathUtil;

	/**
	 * ScrollBar
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollBar extends UIObject
	{

		/******************* OVERRIDE **************************************************/
		override public function get width():Number
		{
			return _type == Position.HORIZONTAL ? this._length : this._thickness;
		}

		override public function set width(value:Number):void
		{
		}

		override public function get height():Number
		{
			return _type == Position.HORIZONTAL ? this._thickness : this._length;
		}

		override public function set height(value:Number):void
		{
		}

		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			this.slider.visible = value;
			this.mouseChildren = this.mouseEnabled = value;
		}

		override protected function updateSize():void
		{
			super.updateSize();
			if (_type == Position.HORIZONTAL)
			{
				leftBtn.width = leftBtn.height = _thickness;
				//
				rightBtn.x = _length - _thickness;
				rightBtn.width = rightBtn.height = _thickness;
				//
				back.width = availLength;
				back.height = _thickness;
				back.x = _thickness;
			}
			else
			{
				upBtn.width = upBtn.height = _thickness;
				//
				downBtn.y = _length - _thickness;
				downBtn.width = downBtn.height = _thickness;
				//
				back.y = _thickness;
				back.width = _thickness;
				back.height = availLength;
			}
			this.setSlider();
		}

		/******************* DEFINE ****************************************************/
		/**
		 * 
		 * @default 
		 */
		public static const DEFAULT_THICKNESS:Number = 16;

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
		private var leftBtn:Skin;

		private var rightBtn:Skin;

		private var upBtn:Skin;

		private var downBtn:Skin;

		private var back:Skin;

		private var slider:Skin;

		private var _enabled:Boolean = true;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * scale value of slider in percent. from 0 to 1.
		 */
		public function get scale():Number
		{
			return _scale;
		}

		/**
		 * 
		 * @param value
		 */
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

		/**
		 * 
		 * @param value
		 */
		public function set position(value:Number):void
		{
			_position = value;
			_position = MathUtil.getNumArea(_position, 0, 1);
			this.setSlider();
		}

		/**
		 * 
		 * @return 
		 */
		public function get length():Number
		{
			return this._length;
		}

		/**
		 * 
		 * @param value
		 */
		public function set length(value:Number):void
		{
			this._length = value;
			this.updateSize();
		}

		/**
		 * 
		 * @return 
		 */
		public function get thickness():Number
		{
			return this._thickness;
		}

		/**
		 * 
		 * @return 
		 */
		public function get availLength():Number
		{
			return _length - 2 * _thickness;
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Constuctor. create and initialize a new scrollBar
		 * 
		 * @param type ScrollType, can be Position.HORIZONTAL or Position.VERTICAL.
		 * 				Once this parameter is set, cannot be changed during runtime.
		 * @param length Length of ScrollBar, in pixel.
		 * @param style Display style.
		 */
		public function ScrollBar(type:String, length:Number = 100, skin:UISkinDataAbstract = null)
		{
			super(skin);
			if (type != Position.HORIZONTAL && type != Position.VERTICAL)
			{
				throw new UIError(UIError.WRONG_SCROLLBAR_TYPE);
			}
			_type = type;
			this._thickness = DEFAULT_THICKNESS;
			this._length = length;
			//
			// create children and set events.
			if (_type == Position.HORIZONTAL)
			{
				createScrollBarX();
				leftBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				rightBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				slider.addEventListener(MouseEvent.MOUSE_DOWN, pressSliderHandler);
			}
			else
			{
				createScrollBarY();
				upBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				downBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtnHandler);
				slider.addEventListener(MouseEvent.MOUSE_DOWN, pressSliderHandler);
			}
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 * @param position
		 * @param scale
		 */
		public function changeSlider(position:Number, scale:Number):void
		{
			_position = MathUtil.getNumArea(position, 0, 1);
			_scale = MathUtil.getNumArea(scale, 0, 1);
			this.setSlider();
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		/**
		 * change slider's position and size.
		 */
		private function setSlider():void
		{
			if (slider != null)
			{
				var len:Number = (_length - 2 * _thickness) * _scale;
				if (_type == Position.HORIZONTAL)
				{
					slider.width = len;
					slider.height = _thickness;
					slider.x = (availLength - slider.width) * _position + _thickness;
					;
					slider.y = 0;
				}
				else
				{
					slider.width = _thickness;
					slider.height = len;
					slider.x = 0;
					slider.y = (availLength - slider.height) * _position + _thickness;
					;
				}
			}
		}

		private function createScrollBarX():void
		{
			leftBtn = new Skin();
			rightBtn = new Skin();
			back = new Skin();
			slider = new Skin();
			leftBtn.name = "leftBtn";
			rightBtn.name = "rightBtn";
			leftBtn.autoMouseEvent = true;
			rightBtn.autoMouseEvent = true;
			//
			leftBtn.mouseEnabled = rightBtn.mouseEnabled = slider.mouseEnabled = true;
			//
			this.addAll(back, leftBtn, rightBtn, slider);
			//
			if (uiSkinData == null)
			{
				uiSkinData = new ScrollBarSkinData();
			}
			uiSkinData.bindChildren(leftBtn, rightBtn, null, null, back, slider);
		}

		private function createScrollBarY():void
		{
			upBtn = new Skin();
			downBtn = new Skin();
			back = new Skin();
			slider = new Skin();
			upBtn.name = "upBtn";
			downBtn.name = "downBtn";
			upBtn.autoMouseEvent = true;
			downBtn.autoMouseEvent = true;
			//
			upBtn.mouseEnabled = downBtn.mouseEnabled = slider.mouseEnabled = true;
			//
			this.addAll(back, upBtn, downBtn, slider);
			//
			if (uiSkinData == null)
			{
				uiSkinData = new ScrollBarSkinData();
			}
			uiSkinData.bindChildren(null, null, upBtn, downBtn, back, slider);
		}

		private function stopMove():void
		{
			if (_defineClickOutside)
			{
				clickTimer.stop();
			}
			else
			{
				moveTimer.stop();
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			if (currentMoveType == "left")
			{
				leftBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
			else if (currentMoveType == "right")
			{
				rightBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
			else if (currentMoveType == "up")
			{
				upBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
			else if (currentMoveType == "down")
			{
				downBtn.removeEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
			}
		}

		private function accountSlider():void
		{
			var rate:Number;
			if (_type == Position.HORIZONTAL)
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

		/******************* PRIVATE ***************************************************/
		private function pressBtnHandler(e:MouseEvent):void
		{
			if (_enabled)
			{
				moveStep = (this.availLength - slider.width) * _speed / 100;
				var btnName:String = (e.target as Skin).name;
				//
				if (btnName == "leftBtn")
				{
					currentMoveType = "left";
					leftBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				else if (btnName == "rightBtn")
				{
					currentMoveType = "right";
					rightBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				else if (btnName == "upBtn")
				{
					currentMoveType = "up";
					upBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				else if (btnName == "downBtn")
				{
					currentMoveType = "down";
					downBtn.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, releaseBtnHandler);
				if (_defineClickOutside)
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
			var ee:UIMouseEvent = new UIMouseEvent(UIMouseEvent.MOUSE_CLICK);
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
			if (enabled)
			{
				var dragArea:Rectangle;
				if (_type == Position.HORIZONTAL)
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
			if (currentMoveType == "left")
			{
				slider.x -= moveStep;
				if (slider.x < _thickness)
				{
					slider.x = _thickness;
					stopMove();
				}
			}
			else if (currentMoveType == "right")
			{
				slider.x += moveStep;
				var maxX:Number = _length - slider.width - _thickness;
				if (slider.x > maxX)
				{
					slider.x = maxX;
					stopMove();
				}
			}
			else if (currentMoveType == "up")
			{
				slider.y -= moveStep;
				if (slider.y < _thickness)
				{
					slider.y = _thickness;
					stopMove();
				}
			}
			else if (currentMoveType == "down")
			{
				slider.y += moveStep;
				var maxY:Number = _length - slider.height - _thickness;
				if (slider.y > maxY)
				{
					slider.y = maxY;
					stopMove();
				}
			}
			accountSlider();
			evt.updateAfterEvent();
		}
	}
}