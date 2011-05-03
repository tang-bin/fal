// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.controls
{
	import ftk.data.Position;
	import ftk.display.Bin;
	import ftk.errors.UIError;
	import ftk.events.UIEvent;
	import ftk.graphs.Flat;
	import ftk.style.FillStyle;
	import ftk.utils.MathUtil;

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * ScrollBar
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ScrollBar extends Bin
	{
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
			if (type != Position.HORIZONTAL && type != Position.VERTICAL)
			{
				throw new UIError(UIError.WRONG_SCROLLBAR_TYPE);
			}
			_type = type;
			this._thickness = DEFAULT_THICKNESS;
			this._length = length;
			//
			bgStyle = new FillStyle();
			bgStyle.bgAlpha = 1;
			bgStyle.bgColor = 0xFFFFFF;
			bgStyle.radius = 1;
			//
			sliderStyle = new FillStyle();
			sliderStyle.bgAlpha = 1;
			sliderStyle.bgColor = 0x333333;
			sliderStyle.radius = 1;
			// create children and set events.
			back = new Flat();
			back.fillStyle = bgStyle;
			//
			slider = new Flat();
			slider.fillStyle = sliderStyle;
			slider.addEventListener(MouseEvent.MOUSE_DOWN, pressSliderHandler);
			slider.mouseEnabled = true;
			//
			this.addAll(back, slider);
			this.alpha = DEFAULT_ALPHA;
			this.addEventListener(MouseEvent.ROLL_OVER, overScrollBarHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outScrollBarHandler);
		}

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

		override protected function updateSize():void
		{
			super.updateSize();
			if (_type == Position.HORIZONTAL)
			{
				back.width = _length;
				back.height = _thickness;
				back.x = _thickness;
				back.y = -_thickness;
			}
			else
			{
				back.y = _thickness;
				back.x = -_thickness;
				back.width = _thickness;
				back.height = _length;
			}
			this.setSlider();
		}

		/**
		 * 
		 * @default 
		 */
		public static const DEFAULT_THICKNESS:Number = 3;

		public static const DEFAULT_ALPHA:Number = 0.3;

		public static const NORMAL_THICKNESS:Number = 10;

		private var _type:String;

		private var _scale:Number = 0.5;

		private var _position:Number = 0.5;

		private var _thickness:Number = 10;

		private var _length:Number = 100;

		private var back:Flat;

		private var slider:Flat;

		private var _enabled:Boolean = true;

		private var bgStyle:FillStyle;

		private var sliderStyle:FillStyle;

		private var isDragging:Boolean = false;

		public function set enabled(value:Boolean):void
		{
			this._enabled = value;
			this.mouseChildren = this.mouseEnabled = value;
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
		 * @param position
		 * @param scale
		 */
		public function changeSlider(position:Number, scale:Number):void
		{
			_position = MathUtil.getNumArea(position, 0, 1);
			_scale = MathUtil.getNumArea(scale, 0, 1);
			this.setSlider();
		}

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
					slider.x = (_length - slider.width) * _position + _thickness;
					slider.y = -_thickness;
				}
				else
				{
					slider.width = _thickness;
					slider.height = len;
					slider.x = -_thickness;
					slider.y = (_length - slider.height) * _position + _thickness;
				}
			}
		}

		private function accountSlider():void
		{
			var rate:Number;
			if (_type == Position.HORIZONTAL)
			{
				rate = (slider.x - _thickness) / (_length - slider.width);
			}
			else
			{
				rate = (slider.y - _thickness) / (_length - slider.height);
			}
			rate = MathUtil.accountDecimalDigit(rate, -3);
			rate = rate > 0.95 ? 1 : rate;
			rate = rate < 0.05 ? 0 : rate;
			var ee:UIEvent = new UIEvent(UIEvent.SCROLL);
			this._position = ee.position = rate;
			this.dispatchEvent(ee);
		}

		private function setSliderView(show:Boolean):void
		{
			if (show)
			{
				if (this._type == Position.HORIZONTAL)
				{
					slider.height = NORMAL_THICKNESS;
					slider.y = -NORMAL_THICKNESS;
				}
				else
				{
					slider.width = NORMAL_THICKNESS;
					slider.x = -NORMAL_THICKNESS;
				}
			}
			else
			{
				if (this._type == Position.HORIZONTAL)
				{
					slider.height = DEFAULT_THICKNESS;
					slider.y = -DEFAULT_THICKNESS;
				}
				else
				{
					slider.width = DEFAULT_THICKNESS;
					slider.x = -DEFAULT_THICKNESS;
				}
			}
		}

		private function pressSliderHandler(evt:MouseEvent):void
		{
			if (enabled)
			{
				var dragArea:Rectangle;
				if (_type == Position.HORIZONTAL)
				{
					dragArea = new Rectangle(0, slider.y, _length - slider.width, 0);
				}
				else
				{
					dragArea = new Rectangle(slider.x, 0, 0, _length - slider.height);
				}
				slider.startDrag(false, dragArea);
				isDragging = true;
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
			isDragging = false;
			setSliderView(false);
			//
			slider.removeEventListener(MouseEvent.MOUSE_MOVE, dragSliderHandler);
			slider.removeEventListener(MouseEvent.MOUSE_UP, stopDragSliderHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragSliderHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragSliderHandler);
		}

		private function overScrollBarHandler(e:MouseEvent):void
		{
			this.alpha = 1;
			setSliderView(true);
		}

		private function outScrollBarHandler(e:MouseEvent):void
		{
			this.alpha = DEFAULT_ALPHA;
			if (!isDragging)
			{
				setSliderView(false);
			}
		}
	}
}