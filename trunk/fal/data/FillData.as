package fas.data
{
	import fas.events.DataEvent;
	import fas.math.Arith;
	import fas.utils.AdvancedObject;
	
	/**
	 * Class FOSFillData contains all datas for draw a flat or fill area.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class FillData extends AdvancedObject
	{
		/**
		 * dispatch change data event when any variate is changed or not.
		 */		
		public var dispatchAfterChange:Boolean = true;
		
		// for corner radius
		private var _radius:Number = 0;
		private var _radiusTL:Number = 0;
		private var _radiusTR:Number = 0;
		private var _radiusBL:Number = 0;
		private var _radiusBR:Number = 0;
		// for border
		private var _borderSize:Number = 0;
		private var _borderColor:uint = 0;
		private var _borderAlpha:Number = 1;
		// for glow
		private var _glowColor:uint = 0;
		private var _glowBlur:Number = 6;
		private var _glowStrength:Number = 3;
		private var _glowAlpha:Number = 0.6;
		// for single color fill
		private var _bodyColor:uint = 0xFFFFFF;
		private var _bodyAlpha:Number = 1;
		// for gradient fill
		private var _gradient:Boolean = false;
		private var _ratios:Array = new Array();
		private var _rotate:Number = 0; // rotate for gradient fill.
		private var _bodyColors:Array;
		private var _bodyAlphas:Array;
		
		/**
		 * corner radius, in pixel.<br>
		 * by setting this value, 4 corers' radius will be changed at same time to this value.
		 * If you want to set one corner's radius, please use topLeft, topRight, bottomLeft or bottomRight.
		 */		
		public function get radius():Number
		{
			return _radius;
		}
		public function set radius(value:Number):void
		{
			_radius = value < 0 ? 0 : value;
			_radiusTL = _radius
			_radiusTR = _radius;
			_radiusBL = _radius;
			_radiusBR = _radius;
			dispatchChangeData();
		}
		
		/**
		 * top left corner radius. in pixel.
		 */		
		public function get topLeft():Number
		{
			return _radiusTL;
		}
		public function set topLeft(value:Number):void
		{
			_radiusTL = value < 0 ? 0 : value;
			dispatchChangeData();
		}
		
		/**
		 * top right corner radius, in pixel.
		 */		
		public function get topRight():Number
		{
			return _radiusTR;
		}
		public function set topRight(value:Number):void
		{
			_radiusTR = value < 0 ? 0 : value;
			dispatchChangeData();
		}
		
		/**
		 * bottom left corner radius, in pixel.
		 */		
		public function get bottomLeft():Number
		{
			return _radiusBL;
		}
		public function set bottomLeft(value:Number):void
		{
			_radiusBL = value < 0 ? 0 : value;
			dispatchChangeData();
		}
		
		/**
		 * bottom right corner radius, in pixel.
		 */		
		public function get bottomRight():Number
		{
			return _radiusBR;
		}
		public function set bottomRight(value:Number):void
		{
			_radiusBR = value < 0 ? 0 : value;
			dispatchChangeData();
		}
		
		/**
		 * border's thickless. in pixel.<br>
		 * this value can be set as 0 to use hair-line border.
		 * If you dont want draw border, please set borderAlpha's value to 0.
		 */		
		public function get borderSize():Number
		{
			return _borderSize
		}
		public function set borderSize(value:Number):void
		{
			if(value >= 0)
			{
				_borderSize = value;
				dispatchChangeData();
			}
		}
		
		/**
		 * Color value of border.
		 */		
		public function get borderColor():uint
		{
			return _borderColor;
		}
		public function set borderColor(value:uint):void
		{
			_borderColor = value;
			dispatchChangeData();
		}
		
		/**
		 * alpha value of border. if you want to hide border, set this value to 0.
		 * (means border will be draw anyway, but you can set it to invisible).
		 */		
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = Arith.getNumArea(value, 0, 100);
			dispatchChangeData();
		}
		
		/**
		 * gradient rotate. in degree.
		 */		
		public function get rotate():Number
		{
			return _rotate;
		}
		public function set rotate(value:Number):void
		{
			_rotate = value;
			dispatchChangeData();
		}
		
		/**
		 * glow color.
		 */		
		public function get glowColor():uint
		{
			return _glowColor;
		}
		public function set glowColor(value:uint):void
		{
			_glowColor = value;
			dispatchChangeData();
		}
		
		/**
		 * glow blur size. if you dont want the flat with glow filter, please set this value to 0.
		 * you can also set glowAlpha value to 0 do disable the glow filter.
		 */		
		public function get glowBlur():Number
		{
			return _glowBlur;
		}
		public function set glowBlur(value:Number):void
		{
			_glowBlur = value;
			dispatchChangeData();
		}
		
		/**
		 * glowStrength, default value is 3.
		 */		
		public function get glowStrength():Number
		{
			return _glowStrength;
		}
		public function set glowStrength(value:Number):void
		{
			_glowStrength = value;
			dispatchChangeData();
		}
		
		/**
		 * Alpha of glow. you can set this value to 0 to disable glow filter for flat.
		 * you can set glowBlur value to 0 do disable the glow filter, too.
		 */		
		public function get glowAlpha():Number
		{
			return _glowAlpha;
		}
		public function set glowAlpha(value:Number):void
		{
			_glowAlpha = value;
			dispatchChangeData();
		}
		
		/**
		 * use gradient fill or not. default is true.
		 */		
		public function get gradient():Boolean
		{
			return _gradient;
		}
		public function set gradient(value:Boolean):void
		{
			_gradient = value;
			if(value && _bodyColors == null)
			{
				accountColors();
			}
			dispatchChangeData();
		}
		
		/**
		 * body color, for single color fill.
		 */		
		public function get bodyColor():uint
		{
			return _bodyColor;
		}
		public function set bodyColor(value:uint):void
		{
			_bodyColor = value;
			if(_gradient)
			{
				accountColors();
			}
			dispatchChangeData();
		}
		
		/**
		 * ratios array for gradient fill.
		 */		
		public function get ratios():Array
		{
			return _ratios;
		}
		public function set ratios(value:Array):void
		{
			_ratios = value;
			dispatchChangeData();
		}
		
		/**
		 * alpha
		 */		
		public function get bodyAlpha():Number
		{
			return _bodyAlpha;
		}
		public function set bodyAlpha(value:Number):void
		{
			_bodyAlpha = value;
			if(_gradient)
			{
				accountColors();
			}
			dispatchChangeData();
		}
		
		/**
		 * body color array for gradient fill.
		 * this value is computed by using bodyColor value.
		 */		
		public function get bodyColors():Array
		{
			return _bodyColors;
		}
		public function set bodyColors(value:Array):void
		{
			_bodyColors = value;
		}
		
		/**
		 * body alpha array for gradient fill.
		 * this value is computed by using bodyColor and bodyAlpha value.
		 */		
		public function get bodyAlphas():Array
		{
			return _bodyAlphas;
		}
		public function set bodyAlphas(value:Array):void
		{
			_bodyAlphas = value;
		}
		
		public function FillData(dispatchAfterChange:Boolean = true)
		{
			this.dispatchAfterChange = dispatchAfterChange;
		}
		
		private function dispatchChangeData():void
		{
			if(dispatchAfterChange)
			{
				this.dispatcher.dispatchEvent(new DataEvent(DataEvent.CHANGE_DATA));
			}
		}
		
		/**
		 * this method is used to working-out color/alpha/ratios array for gradient fill.
		 */		
		private function accountColors():void
		{
			_bodyColors = Style.getGradientColors(_bodyColor);
			_bodyAlphas = Style.getAlphaArray(_bodyColors, _bodyAlpha);
			_ratios = new Array();
			for(var i:Number = 0 ; i < _bodyColors.length ; i++)
			{
				_ratios.push((i / _bodyColors.length) * 0xFF);
			}
		}
		
		public function clone():FillData
		{
			var fd:FillData = new FillData(this.dispatchAfterChange);
			// for corner radius
			fd.radius = this._radius;
			fd.topLeft = this._radiusTL;
			fd.topRight = this._radiusTR;
			fd.bottomLeft = this._radiusBL;
			fd.bottomRight = this._radiusBR;
			// for border
			fd.borderSize = this._borderSize;
			fd.borderColor = this._bodyColor;
			fd.borderAlpha = this._borderAlpha;
			// for glow
			fd.glowColor = this._glowColor;
			fd.glowBlur = this._glowBlur;
			fd.glowStrength = this._glowStrength;
			fd.glowAlpha = this._glowAlpha;
			// for single color fill
			fd.bodyColor = this._bodyColor;
			fd.bodyAlpha = this._bodyAlpha;
			fd.bodyColors = this._bodyColors;
			fd.bodyAlphas = this._bodyAlphas;
			// for gradient fill
			fd.gradient = this._gradient;
			fd.ratios = this._ratios.concat();
			fd.rotate = this._rotate;
			//
			return fd;
		}
	}
}