/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 ******************************************/
package org.finalbug.data
{
	import org.finalbug.utils.ColorUtil;
	import org.finalbug.utils.MathUtil;
	import org.finalbug.data.DataModel;
	
	/**
	 * RGB
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class RGB extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private var _r:uint = 0;
		private var _g:uint = 0;
		private var _b:uint = 0;
		private var _alpha:Number = 1;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get r():uint
		{
			return _r;
		}
		public function set r(value:uint):void
		{
			_r = MathUtil.getNumArea(value, 0, 255);
		}
		
		public function get g():uint
		{
			return _g;
		}
		public function set g(value:uint):void
		{
			_g = MathUtil.getNumArea(value, 0, 255);
		}
		
		public function get b():uint
		{
			return _b;
		}
		public function set b(value:uint):void
		{
			_b = MathUtil.getNumArea(value, 0, 255);
		}
		
		public function get alpha():Number
		{
			return _alpha;
		}
		public function set alpha(value:Number):void
		{
			_alpha = MathUtil.getNumArea(value, 0, 1);
		}
		
		public function get gray():uint
		{
			return uint((r + g + b) / 3);
		}
		public function set gray(value:uint):void
		{
			gray = MathUtil.getNumArea(gray, 0, 255);
			r = g = b = gray;
		}
		
		public function get color():uint
		{
			return r * 65536 + g * 256 + b;
		}
		public function set color(value:uint):void
		{
			r = value >> 16 & 0xFF;
			g = value >> 8 & 0xFF;
			b = value & 0xFF;
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function RGB(red:uint = 0, green:uint = 0, blue:uint = 0, alpha:Number = 1)
		{
			super();
			setRGB(red, green, blue, alpha);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		public function setRGB(red:uint = 0, green:uint = 0, blue:uint = 0, alpha:Number = 1):void
		{
			r = red;
			g = green;
			b = blue;
			this.alpha = alpha;
		}
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}