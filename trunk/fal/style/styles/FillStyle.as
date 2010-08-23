/****************************
 * fal.style.styles.FillStyle
 *
 * @author Tang Bin
 * @since 2010-8-20
 ****************************/
package fal.style.styles
{
	import fal.math.Arith;
	import fal.math.Color;
	
	import flash.net.drm.VoucherAccessInfo;

	public class FillStyle extends Style
	{
		private var _borderColor:String = "#333333";
		private var _borderAlpha:String = "0.1";
		private var _backgroundColor:String = "#FFFFFF";
		private var _backgroundAlpha:String = "0.1";
		
		private var _topLeftRadius:String = "0";
		private var _topRightRadius:String = "0";
		private var _bottomLeftRadius:String = "0";
		private var _bottomRightRadius:String = "0";
		private var _radius:String = "0";
		private var uniformRadius:Boolean = true;
		
		private var _gradientBackgroundColors:String = "#333, #FFF";
		private var _gradientBackgroundAlphas:String = "1, 1";
		
		private var _gradientBackgroundRotation:String = "0";
		
		public var useGradient:Boolean = false;
		
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
		
		public function get backgroundColor():Number
		{
			return Color.string2Color(_backgroundColor);
		}
		public function set backgroundColor(value:Number):void
		{
			_backgroundColor = Color.color2String(value);
		}
		
		public function get backgroundAlpha():Number
		{
			return Number(_backgroundAlpha);
		}
		
		public function set backgroundAlpha(value:Number):void
		{
			value = Arith.getNumArea(value, 0, 1);
			_backgroundAlpha = value.toString();
		}
		
		public function get radius():Number
		{
			return Number(radius);
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
			else return Number(_topLeftRadius);
		}
		public function set topLeftRaidus(value:Number):void
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
		
		public function get bottomLeftRaidus():Number
		{
			if(this.uniformRadius) return radius;
			else return Number(_bottomLeftRadius);
		}
		public function set bottomLeftRaidus(value:Number):void
		{
			if(value >= 0)
			{
				_bottomLeftRaidus = value.toString();
				this.uniformRadius = false;
			}
		}
		
		public function get bottomRightRaidus():Number
		{
			if(this.uniformRadius) return radius;
			else return Number(_bottomRightRaidus);
		}
		public function set bottomRightRaidus(value:Number):void
		{
			if(value >= 0)
			{
				_bottomRightRaidus = value.toString();
				this.uniformRadius = false;
			}
		}
		
		public function 
		
		public function FillStyle()
		{
			super();
		}
	}
}