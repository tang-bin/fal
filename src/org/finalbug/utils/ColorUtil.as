// ##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__|     |__|___|__(______/____/_____/____/\___  /
// /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
// ##########################################################
package org.finalbug.utils
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;

	/**
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ColorUtil
	{
		/**
		 * 
		 * @default 
		 */
		public static const RED:uint = 0xFF0000;
		/**
		 * 
		 * @default 
		 */
		public static const WHITE:uint = 0xFFFFFF;
		/**
		 * 
		 * @default 
		 */
		public static const BLACK:uint = 0x000000;
		/**
		 * 
		 * @default 
		 */
		public static const BLUE:uint = 0x0000FF;
		/**
		 * 
		 * @default 
		 */
		public static const GREEN:uint = 0x00FF00;
		/**
		 * 
		 * @default 
		 */
		public static const SILVER:uint = 0xEEEEEE;
		/**
		 * 
		 * @default 
		 */
		public static const GOLD:uint = 0xFED336;
		/**
		 * 
		 * @default 
		 */
		public static const YELLOW:uint = 0xFFFF00;
		/**
		 * 
		 * @default 
		 */
		public static const CYAN:uint = 0x00FFFF;
		/**
		 * 
		 * @default 
		 */
		public static const PURPLE:uint = 0xFF00FF;
		/**
		 * 
		 * @default 
		 */
		public static const ORANGE:uint = 0xFF9900;
		/**
		 * 
		 * @default 
		 */
		public static const GRAY:uint = 0xDBDBDB;
		/**
		 * 
		 * @default 
		 */
		public static const DARK:uint = 0x333333;
		/**
		 * 
		 * @default 
		 */
		public static const DARK_RED:uint = 0x990000;

		/**
		 * Check out if a 32bit color value is visable.(alpha is not 0).
		 * @param color
		 * @return 
		 * 
		 */
		public static function color32IsViewable(color:uint):Boolean
		{
			return color != 0 && color.toString(16).indexOf("00") != 0;
		}

		/**
		 * Make up a new 32bit color value from a RGB color value and alpha value.
		 * @param color
		 * @param alpha
		 * @return 
		 * 
		 */
		public static function get32Color(color:uint, alpha:Number):uint
		{
			var str:String = "0x" + MathUtil.dec2Hex(Math.round(alpha * 0xFF), 2) + MathUtil.dec2Hex(color, 6);
			return Number(str);
		}

		/**
		 * 
		 * @param target
		 * @param color
		 */
		public static function setColor(target:DisplayObject, color:Number):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			target.transform.colorTransform = ct;
		}

		/**
		 * 
		 * @param color
		 * @return 
		 */
		public static function getRGB(color:Number):Array
		{
			var red:uint = color >> 16 & 0xFF;
			var green:uint = color >> 8 & 0xFF;
			var blue:uint = color & 0xFF;
			return [red, green, blue];
		}

		/**
		 * 
		 * @param target
		 */
		public static function gray(target:DisplayObject):void
		{
			var m:Array = [0.3086, 0.6094, 0.082, 0, 30, 0.3086, 0.6094, 0.082, 0, 30, 0.3086, 0.6094, 0.082, 0, 30, 0, 0, 0, 1, 0];
			var cf:ColorMatrixFilter = new ColorMatrixFilter(m);
			target.filters = [cf];
		}

		/**
		 * 
		 * @param color
		 * @return 
		 */
		public static function color2String(color:uint):String
		{
			return "#" + color.toString(16);
		}

		/**
		 * 
		 * @param str
		 * @return 
		 */
		public static function string2Color(str:String):Number
		{
			if (str.charAt(0) == "#")
			{
				str = "0x" + str.substring(1);
			}
			var value:Number = Number(str);
			if (isNaN(value) || value < 0) return 0;
			else return value;
		}

		/**
		 * 
		 * @param color
		 * @param offset
		 * @return 
		 */
		public static function offsetColor(color:Number, offset:Number):Number
		{
			var colorArray:Array = new Array();
			// blue color:
			colorArray[2] = color % 256;
			// red color:
			colorArray[0] = Math.floor(color / 65536);
			// green color:
			colorArray[1] = Math.floor((color - (colorArray[0] * 65536)) / 256);
			// add offset
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
			for (var i:Number = colorArray.length ; --i >= 0 ; )
			{
				alphaArray.push(alpha);
			}
			return alphaArray;
		}
	}
}