package fas.data
{
	/**
	 * This class just defines some style variables.
	 * To apply some styles on display object, please call methods in Class StyleSetter.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 * 
	 * @see fas.draw.style.StyleSetter
	 * @see fas.draw.style.StyleCreator
	 * @see fas.draw.style.StyleParser
	 * @see fas.uistyle.UIStyle
	 */	
	public class Style
	{
		public static const RED:uint = 0xFF0000;
		public static const WHITE:uint = 0xFFFFFF;
		public static const BLACK:uint = 0x000000;
		public static const BLUE:uint = 0x0000FF;
		public static const GREEN:uint = 0x00FF00;
		public static const SILVER:uint = 0xEEEEEE;
		public static const GOLD:uint = 0xFED336;
		public static const YELLOW:uint = 0xFFFF00;
		public static const CYAN:uint = 0x00FFFF;
		public static const PURPLE:uint = 0xFF00FF;
		public static const ORANGE:uint = 0xFF9900;
		public static const GRAY:uint = 0xDBDBDB;
		public static const DARK:uint = 0x333333;
		public static const DARK_RED:uint = 0x990000;
		
		public static const DEFAULT_FONT:String = "Arial";
		
		public static const SMALLEST_TEXT_SIZE:Number = 4;
		public static const SMALLER_TEXT_SIZE:Number = 8;
		public static const SMALL_TEXT_SIZE:Number = 10
		public static const NORMAL_TEXT_SIZE:Number = 12;
		public static const LARGE_TEXT_SIZE:Number = 14;
		public static const LARGER_TEXT_SIZE:Number = 16;
		public static const LARGEST_TEXT_SIZE:Number = 20;
		
		/**
		 * account a new RGB color value by a RGB color and offset
		 * @param color
		 * @param offset From -255 to 255, 0 means no offset, and the lager offset, brighter the color.
		 * @return
		 */
		public static function offsetColor(color:Number, offset:Number):Number
		{
			var colorArray:Array = new Array();
			//	blue color:
			colorArray[2] = color % 256;
			//	red color:
			colorArray[0] = Math.floor(color / 65536);
			//	green color:
			colorArray[1] = Math.floor((color - (colorArray[0] * 65536)) / 256);
			//	add offset	
			for (var i:Number = 0; i < colorArray.length; i++)
			{
				colorArray[i] += offset;
				colorArray[i] = colorArray[i] < 0 ? 0 : colorArray[i];
				colorArray[i] = colorArray[i] > 255 ? 255 : colorArray[i];
			}
			return colorArray[0] * 65536 + colorArray[1] * 256 + colorArray[2];
		}
		
		/**
		 * Unite RGB color.
		 * 
		 * @param red
		 * @param green
		 * @param blue
		 * @return 
		 * 
		 */		
		public static function uniteColor(red:Number, green:Number, blue:Number):Number
		{
			return red * 65536 + green * 256 + blue;
		}
		
		/**
		 * Get a group of gradient colors from one color.
		 * most be used to fill a flat.
		 * 
		 * @param color
		 */
		public static function getGradientColors(color:Number):Array
		{
			var a:Array = new Array();
			a.push(offsetColor(color, 40));
			a.push(offsetColor(color, -40));
			return a;
		}
		
		/**
		 * Get a alpha array from a color array. and the length of alpha array equals to the color array.
		 * most be used to make a gradient fill.
		 * 
		 * @param colorArray
		 * @param alpha
		 * @return
		 */		
		public static function getAlphaArray(colorArray:Array, alpha:Number = 1):Array
		{
			var alphaArray:Array = new Array();
			for(var i:Number = colorArray.length ; --i >= 0 ; )
			{
				alphaArray.push(alpha);
			}
			return alphaArray;
		}
	}
}