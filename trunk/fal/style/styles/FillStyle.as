/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.style.styles
{
	import fal.math.Arith;
	import fal.math.Color;
	import fal.style.CSSStyle;
	import fal.utils.Chars;
	
	import flash.net.drm.VoucherAccessInfo;

	public class FillStyle extends Style
	{
		private var _borderSize:String = "1";
		private var _borderColor:String = "#333333";
		private var _borderAlpha:String = "0.1";
		private var _bgColor:String = "#FFFFFF";
		private var _bgAlpha:String = "0.1";
		
		private var _topLeftRadius:String = "0";
		private var _topRightRadius:String = "0";
		private var _bottomLeftRadius:String = "0";
		private var _bottomRightRadius:String = "0";
		private var _radius:String = "0";
		private var uniformRadius:Boolean = true;
		
		private var _bgColors:String = "#333, #FFF";
		private var _bgAlphas:String = "1, 1";
		private var _bgRotation:String = "0";
		private var _bgRatios:String = "0, 1";
		public var useGradient:Boolean = false;
		
		private var _glowColor:String = "#000";
		private var _glowAlpha:String = "1";
		private var _glowBlur:String = "3";
		private var _glowStrength:String = "3";
		
		public function get borderSize():Number
		{
			return Number(_borderSize);
		}
		public function set borderSize(value:Number):void
		{
			value = Arith.getNumArea(value, 0, 20);
			_borderSize = value.toString();
		}
		
		public function get borderColor():Number
		{
			return Color.string2Color(_borderColor);
		}
		public function set borderColor(value:Number):void
		{
			_borderColor = Color.color2String(value);
		}
		
		public function get borderAlpha():Number
		{
			return Number(_borderAlpha);
		}
		public function set borderAlpha(value:Number):void
		{
			value = Arith.getNumArea(value, 0, 1);
			_borderAlpha = value.toString();
		}
		
		public function get bgColor():Number
		{
			return Color.string2Color(_bgColor);
		}
		public function set bgColor(value:Number):void
		{
			_bgColor = Color.color2String(value);
		}
		
		public function get bgAlpha():Number
		{
			return Number(_bgAlpha);
		}
		
		public function set bgAlpha(value:Number):void
		{
			value = Arith.getNumArea(value, 0, 1);
			_bgAlpha = value.toString();
		}
		
		public function get radius():Number
		{
			return Number(_radius);
		}
		public function set radius(value:Number):void
		{
			if(value >= 0)
			{
				this._radius = value.toString();
				this.uniformRadius = true;
			}
		}
		
		public function get topLeftRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return Number(_topLeftRadius);
		}
		public function set topLeftRadius(value:Number):void
		{
			if(value >= 0)
			{
				_topLeftRadius = value.toString();
				this.uniformRadius = false;
			}
		}
		
		public function get topRightRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return Number(_topRightRadius);
		}
		public function set topRightRadius(value:Number):void
		{
			if(value >= 0)
			{
				_topRightRadius = value.toString();
				this.uniformRadius = false;
			}
		}
		
		public function get bottomLeftRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return Number(_bottomLeftRadius);
		}
		public function set bottomLeftRadius(value:Number):void
		{
			if(value >= 0)
			{
				_bottomLeftRadius = value.toString();
				this.uniformRadius = false;
			}
		}
		
		public function get bottomRightRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return Number(_bottomRightRadius);
		}
		public function set bottomRightRadius(value:Number):void
		{
			if(value >= 0)
			{
				_bottomRightRadius = value.toString();
				this.uniformRadius = false;
			}
		}
		
		public function get bgColors():Array
		{
			var arr:Array = _bgColors.split(",");
			for(var i:uint = arr.length ; --i >= 0 ;)
			{
				var str:String = arr[i].toString();
				str = Chars.trimAll(str);
				if(str != "")
				{
					arr[i] = Color.string2Color(str);
				}
				else
				{
					arr.splice(i, 1);
				}
			}
			return arr;
		}
		public function set bgColors(value:Array):void
		{
			for(var i:uint = value.length ; --i >= 0 ;)
			{
				value[i] = Color.color2String(value[i]);
			}
			_bgColors = value.join(",");
		}
		
		public function get bgAlphas():Array
		{
			var arr:Array = _bgAlphas.split(",");
			for(var i:uint = arr.length ; --i >= 0 ;)
			{
				arr[i] = Number(arr[i]);
				if(isNaN(arr[i]))
				{
					arr.splice(i, 1);
				}
			}
			return arr;
		}
		public function set bgAlphas(value:Array):void
		{
			_bgAlphas = value.join(",");
		}
		
		public function get bgRotation():Number
		{
			return Number(_bgRotation);
		}
		public function set bgRotation(value:Number):void
		{
			_bgRotation = value.toString();
		}
		
		public function get glowColor():Number
		{
			return Color.string2Color(_glowColor);
		}
		public function set glowColor(value:Number):void
		{
			_glowColor = Color.color2String(value);
		}
		
		public function get glowAlpha():Number
		{
			return Number(_glowAlpha);
		}
		public function set glowAlpha(value:Number):void
		{
			value = Arith.getNumArea(value, 0, 1);
			_glowAlpha = value.toString();
		}
		
		public function get glowBlur():Number
		{
			return Number(_glowBlur);
		}
		public function set glowBlur(value:Number):void
		{
			value = Arith.getNumArea(value, 0, 100);
			_glowBlur = value.toString();
		}
		
		public function get glowStrength():int
		{
			return int(_glowStrength);
		}
		public function set glowStrength(value:int):void
		{
			value = Arith.getNumArea(value, 1, 3);
			_glowStrength = value.toString();
		}
		
		public function get bgRatios():Array
		{
			var arr:Array = _bgRatios.split(",");
			for(var i:uint = arr.length ; --i >= 0 ; )
			{
				arr[i] = Number(arr[i]);
				if(isNaN(arr[i]))
				{
					arr.splice(i, 1);
				}
				else
				{
					arr[i] *= 0xFF;
				}
			}
			return arr;
		}
		public function set bgRatios(value:Array):void
		{
			_bgRatios = value.join(",");
		}
		
		public function FillStyle()
		{
			super();
		}
		
		public function createCSSSTyle():CSSStyle
		{
			var style:CSSStyle = new CSSStyle();
			style.fillStyle = this.clone();
			return style;
		}
		
		public function clone():FillStyle
		{
			var style:FillStyle = new FillStyle();
			//
			style.borderSize = this.borderSize;
			style.borderAlpha = this.borderAlpha;
			style.borderColor = this.borderColor;
			style.bgAlpha = this.bgAlpha;
			style.bgColor = this.bgColor;
			//
			if(this.uniformRadius)
			{
				style.radius = this.radius;
			}
			else
			{
				style.radius = this.radius;
				style.topLeftRadius = this.topLeftRadius;
				style.topRightRadius = this.topRightRadius;
				style.bottomLeftRadius = this.bottomLeftRadius;
				style.bottomRightRadius = this.bottomRightRadius;
			}
			//
			style.bgColors = this.bgColors;
			style.bgAlphas = this.bgAlphas;
			style.bgRatios = this.bgRatios;
			style.bgRotation = this.bgRotation;
			style.useGradient = this.useGradient;
			//
			style.glowColor = this.glowColor;
			style.glowAlpha = this.glowAlpha;
			style.glowBlur = this.glowBlur;
			style.glowStrength = this.glowStrength;
			//
			return style;
		}
	}
}