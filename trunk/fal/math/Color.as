package fal.math
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;

	public class Color
	{
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
			var str:String = "0x" + Arith.dec2Hex(Math.round(alpha * 0xFF), 2) + Arith.dec2Hex(color, 6);
			return Number(str);
		}
		
		public static function setColor(target:DisplayObject, color:Number):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			target.transform.colorTransform = ct;
		}
		
		public static function getRGB(color:Number):Array
		{
			var r:Number = Math.floor(color / 65536);
			color = color - (r * 65536);
			var g:Number = Math.floor(color / 256);
			color = color - (g * 256);
			var b:Number = color;
			return [r, g, b];
		}
		
		public static function gray(target:DisplayObject):void
		{
			var m:Array = [0.3086,0.6094,0.082,0,30,0.3086,0.6094,0.082,0,30,0.3086,0.6094,0.082,0,30,0,0,0,1,0];
			var cf:ColorMatrixFilter = new ColorMatrixFilter(m);
			target.filters = [cf];
		}
		
		public static function color2String(color:uint):String
		{
			return "#" + color.toString(16);
		}
		
		public static function string2Color(str:String):Number
		{
			if(str.charAt(0) == "#")
			{
				str = "0x" + str.substring(1);
			}
			var value:Number = Number(str);
			if(isNaN(value) || value < 0) return 0;
			else return value;
		}
	}
}