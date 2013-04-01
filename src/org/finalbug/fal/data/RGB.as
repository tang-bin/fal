////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.data
{
	import org.finalbug.fal.utils.MathUtil;

	/**
	 * RGB
	 * 
	 * @author		Tang Bin
	 * @since		2012.12-1
	 */
	public class RGB extends DataModel
	{
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

		private var _r:uint = 0;

		private var _g:uint = 0;

		private var _b:uint = 0;

		private var _alpha:Number = 1;

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
			gray = MathUtil.getNumArea(value, 0, 255);
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
	}
}