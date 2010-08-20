/****************************
 * fal.style.styles.FillStyle
 *
 * @author Tang Bin
 * @since 2010-8-20
 ****************************/
package fal.style.styles
{
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
		
		private var _gradientBackgroundColors:String = "#333, #FFF";
		private var _gradientBackgroundAlphas:String = "1, 1";
		private var _gradientBackgroundRotation:String = "0";
		
		public function get borderColor():Number
		{
			var str:String = _borderColor;
			if(str.charAt(0) == "#")
			{
				str = "0x" + _borderColor.substring(1);
			}
			var value:Number = Number(str);
			if(isNaN(value) || value < 0) return 0;
			else return value;
		}
		public function set borderColor(value:Number):void
		{
			_borderColor = "#" + value.toString(16);
		}
		
		public function FillStyle()
		{
			super();
		}
	}
}