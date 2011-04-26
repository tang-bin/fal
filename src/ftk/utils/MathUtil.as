// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.utils
{
	/**
	 * MathUtil class offers some mathematic methods to extends Math class.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class MathUtil
	{

		/**
		 * Change a decimal number to a hex string.
		 * @param dec
		 * @param length The length of the hex string after change.
		 * If the given length is longer than the hex string, put "0" as a prefix.
		 * @return
		 */
		public static function dec2Hex(dec:Number, length:Number = 6):String
		{
			var decStr:String = dec.toString(16);
			while (decStr.length < length)
			{
				decStr = "0" + decStr;
			}
			return decStr;
		}

		/**
		 * Check if the given number is between the max value and min vlaue.
		 * @param num
		 * @param min
		 * @param max
		 * @param includeMin Return true or false when num equal to the min value.
		 * @param includeMax Return true or false when num equal to the max value.
		 * @return
		 */
		public static function checkNumArea(num:Number, min:Number, max:Number, includeMin:Boolean = true, includeMax:Boolean = true):Boolean
		{
			if (includeMin && num < min)
			{
				return false;
			}
			else if (!includeMin && num <= min)
			{
				return false;
			}
			else if (includeMax && num > max)
			{
				return false;
			}
			else if (!includeMax && num >= max)
			{
				return false;
			}
			else
			{
				return true;
			}
		}

		/**
		 * Check if the given number is between the max value and min value.
		 * If so, return the given number, 
		 * or return a number between max value and min value which is the most close to the given number.
		 * @param num
		 * @param min
		 * @param max
		 * @return
		 */
		public static function getNumArea(num:Number, min:Number, max:Number):Number
		{
			if (num < min)
			{
				return min;
			}
			else if (num > max)
			{
				return max;
			}
			else
			{
				return num;
			}
		}

		/**
		 * Round a number to a given digit.
		 * 
		 * @param num
		 * @param digit If digit is less than 0, it means a decimal digits.
		 * @return
		 */
		public static function accountDecimalDigit(num:Number, digit:int):Number
		{
			var rate:Number;
			var n:int;
			if (digit > 0)
			{
				rate = Math.pow(10, digit);
				n = Math.round(num / rate);
				return n * rate;
			}
			else
			{
				rate = Math.pow(10, -digit);
				n = Math.round(num * rate);
				return n / rate;
			}
		}

		/**
		 * Format a degree into [-180, 180].
		 * @param degree
		 * @return 
		 */
		public static function formatDegree(degree:Number):Number
		{
			degree = degree % 360;
			if (degree > 180)
			{
				degree = degree - 360;
			}
			else if (degree < -180)
			{
				degree += 360;
			}
			return degree;
		}

		/**
		 * Format a degree into [-90, 90].
		 * @param degree
		 * @return 
		 */
		public static function reduceDegree(degree:Number):Number
		{
			degree = formatDegree(degree);
			if (degree > 90)
			{
				degree = -(180 - degree);
			}
			else if (degree < -90)
			{
				degree += 180;
			}
			return degree;
		}

		/**
		 * find roots of a quadratic equation with one unknown such as:
		 * ax^2 + bx + c = 0
		 * 
		 * @param a
		 * @param b
		 * @param c
		 * @return 
		 */
		public static function computeU1E2(a:Number, b:Number, c:Number):Array
		{
			if (b * b < 4 * a * c)
			{
				// Cannot find root.
				return null;
			}
			else
			{
				var rs:Array = new Array();
				rs.push((-b + Math.sqrt(b * b - 4 * a * c)) / (2 * a));
				rs.push((-b - Math.sqrt(b * b - 4 * a * c)) / (2 * a));
				return rs;
			}
		}

		/**
		 * Get a Random integer between 2 given integers.
		 * 
		 * @param start
		 * @param end
		 * @return 
		 * 
		 */
		public static function getRandomInt(start:int, end:int):int
		{
			var n:Number = Math.random();
			n = start + (end - start) * n;
			return Math.round(n);
		}
	}
}