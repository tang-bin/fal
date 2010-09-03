/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.style.styles
{
	import fal.style.CSSFilter;
	import fal.style.Style;
	import fal.utils.ColorUtil;
	import fal.utils.MathUtil;
	import fal.utils.StringUtil;
	
	import flash.filters.GlowFilter;
	
	/**
	 * fal.css.styles.FillStyle
	 *  
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class FillStyle extends Style
	{
		private var _borderSize:Number = 1;
		private var _borderColor:Number = 0x333333;
		private var _borderAlpha:Number = 0.1;
		private var _bgColor:Number = 0xFFFFFF;
		private var _bgAlpha:Number = 0.1;
		
		private var _topLeftRadius:Number = 0;
		private var _topRightRadius:Number = 0;
		private var _bottomLeftRadius:Number = 0;
		private var _bottomRightRadius:Number = 0;
		private var _radius:Number = 0;
		private var uniformRadius:Boolean = true;
		
		private var _bgColors:Array = [0x333, 0xFFF];
		private var _bgAlphas:Array = [1, 1];
		private var _bgRotation:Number = 0;
		private var _bgRatios:Array = [0, 0xFF];
		public var useGradient:Boolean = false;
		
		private var _glowColor:Number = 0;
		private var _glowAlpha:Number = 1;
		private var _glowBlur:Number = 3;
		private var _glowStrength:int = 3;
		
		public function get borderSize():Number
		{
			return _borderSize;
		}
		public function set borderSize(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 20);
			_borderSize = value;
		}
		
		public function get borderColor():Number
		{
			return _borderColor;
		}
		public function set borderColor(value:Number):void
		{
			_borderColor = value;
		}
		
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		public function set borderAlpha(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 1);
			_borderAlpha = value;
		}
		
		public function get bgColor():Number
		{
			return _bgColor;
		}
		public function set bgColor(value:Number):void
		{
			_bgColor = value;
		}
		
		public function get bgAlpha():Number
		{
			return _bgAlpha;
		}
		
		public function set bgAlpha(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 1);
			_bgAlpha = value;
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		public function set radius(value:Number):void
		{
			if(value >= 0)
			{
				this._radius = value;
				this.uniformRadius = true;
			}
		}
		
		public function get topLeftRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return _topLeftRadius;
		}
		public function set topLeftRadius(value:Number):void
		{
			if(value >= 0)
			{
				_topLeftRadius = value;
				this.uniformRadius = false;
			}
		}
		
		public function get topRightRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return _topRightRadius;
		}
		public function set topRightRadius(value:Number):void
		{
			if(value >= 0)
			{
				_topRightRadius = value;
				this.uniformRadius = false;
			}
		}
		
		public function get bottomLeftRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return _bottomLeftRadius;
		}
		public function set bottomLeftRadius(value:Number):void
		{
			if(value >= 0)
			{
				_bottomLeftRadius = value;
				this.uniformRadius = false;
			}
		}
		
		public function get bottomRightRadius():Number
		{
			if(this.uniformRadius) return radius;
			else return _bottomRightRadius;
		}
		public function set bottomRightRadius(value:Number):void
		{
			if(value >= 0)
			{
				_bottomRightRadius = value;
				this.uniformRadius = false;
			}
		}
		
		public function get bgColors():Array
		{
			return _bgColors;
		}
		public function set bgColors(value:Array):void
		{
			_bgColors = value;
		}
		
		public function get bgAlphas():Array
		{
			return _bgAlphas;
		}
		public function set bgAlphas(value:Array):void
		{
			_bgAlphas = value;
		}
		
		public function get bgRotation():Number
		{
			return _bgRotation;
		}
		public function set bgRotation(value:Number):void
		{
			_bgRotation = value;
		}
		
		public function get glowColor():Number
		{
			return _glowColor;
		}
		public function set glowColor(value:Number):void
		{
			_glowColor = value;
		}
		
		public function get glowAlpha():Number
		{
			return _glowAlpha;
		}
		public function set glowAlpha(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 1);
			_glowAlpha = value;
		}
		
		public function get glowBlur():Number
		{
			return _glowBlur;
		}
		public function set glowBlur(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 100);
			_glowBlur = value;
		}
		
		public function get glowStrength():int
		{
			return _glowStrength;
		}
		public function set glowStrength(value:int):void
		{
			value = MathUtil.getNumArea(value, 1, 3);
			_glowStrength = value;
		}
		
		public function get bgRatios():Array
		{
			return _bgRatios;
		}
		public function set bgRatios(value:Array):void
		{
			_bgRatios = value;
		}
		
		public function FillStyle()
		{
			super();
		}
		
		public function createGlowFilter():GlowFilter
		{
			var gf:GlowFilter = new GlowFilter(this._glowColor, 
				this._glowAlpha, 
				this._glowBlur, 
				this._glowBlur, 
				this._glowStrength, 
				3);
			return gf;
		}
		
		public function clone():FillStyle
		{
			var style:FillStyle = new FillStyle();
			style.filters = this.filters;
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