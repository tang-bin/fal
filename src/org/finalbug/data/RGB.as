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
package org.finalbug.data
{
	import org.finalbug.utils.MathUtil;

	/**
	 * RGB
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */
	public class RGB extends DataModel
	{
		// #######################################
		// OVERRIDE
		// #######################################
		// #######################################
		// DEFINE
		// #######################################
		private var _r:uint = 0;
		private var _g:uint = 0;
		private var _b:uint = 0;
		private var _alpha:Number = 1;

		// #######################################
		// GETTER and SETTER
		// #######################################
		/**
		 * 
		 * @return 
		 */
		public function get r():uint
		{
			return _r;
		}

		/**
		 * 
		 * @param value
		 */
		public function set r(value:uint):void
		{
			_r = MathUtil.getNumArea(value, 0, 255);
		}

		/**
		 * 
		 * @return 
		 */
		public function get g():uint
		{
			return _g;
		}

		/**
		 * 
		 * @param value
		 */
		public function set g(value:uint):void
		{
			_g = MathUtil.getNumArea(value, 0, 255);
		}

		/**
		 * 
		 * @return 
		 */
		public function get b():uint
		{
			return _b;
		}

		/**
		 * 
		 * @param value
		 */
		public function set b(value:uint):void
		{
			_b = MathUtil.getNumArea(value, 0, 255);
		}

		/**
		 * 
		 * @return 
		 */
		public function get alpha():Number
		{
			return _alpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set alpha(value:Number):void
		{
			_alpha = MathUtil.getNumArea(value, 0, 1);
		}

		/**
		 * 
		 * @return 
		 */
		public function get gray():uint
		{
			return uint((r + g + b) / 3);
		}

		/**
		 * 
		 * @param value
		 */
		public function set gray(value:uint):void
		{
			gray = MathUtil.getNumArea(gray, 0, 255);
			r = g = b = gray;
		}

		/**
		 * 
		 * @return 
		 */
		public function get color():uint
		{
			return r * 65536 + g * 256 + b;
		}

		/**
		 * 
		 * @param value
		 */
		public function set color(value:uint):void
		{
			r = value >> 16 & 0xFF;
			g = value >> 8 & 0xFF;
			b = value & 0xFF;
		}

		// #######################################
		// CONSTRUCTOR.
		// #######################################
		/**
		 * Create an new RGB color.
		 * 
		 * @param red
		 * @param green
		 * @param blue
		 * @param alpha
		 */
		public function RGB(red:uint = 0, green:uint = 0, blue:uint = 0, alpha:Number = 1)
		{
			super();
			setRGB(red, green, blue, alpha);
		}

		// #######################################
		// PUBLIC
		// #######################################
		/**
		 * 
		 * @param red
		 * @param green
		 * @param blue
		 * @param alpha
		 */
		public function setRGB(red:uint = 0, green:uint = 0, blue:uint = 0, alpha:Number = 1):void
		{
			r = red;
			g = green;
			b = blue;
			this.alpha = alpha;
		}
		// #######################################
		// PROTECTED
		// #######################################
		
		// #######################################
		// PRIVATE
		// #######################################
		
		// #######################################
		// HANDLER
		// #######################################
	}
}