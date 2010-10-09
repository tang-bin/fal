/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.style
{
	import flash.display.DisplayObject;
	
	import org.finalbug.core.data.DataModel;
	
	/**
	 * org.finalbug.fal.css.styles.Style
	 *  
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class Style extends DataModel
	{
		public static const NUM_REG:RegExp = /^(-?\d*\.?\d*)$/;
		public static const PERCENT_REG:RegExp = /^(-?\d*\.?\d*)%$/;
		
		public static const DEFAULT_FONT:String = "Verdana";
		
		public static const SMALLEST_TEXT_SIZE:Number = 4;
		public static const SMALLER_TEXT_SIZE:Number = 8;
		public static const SMALL_TEXT_SIZE:Number = 10
		public static const NORMAL_TEXT_SIZE:Number = 12;
		public static const LARGE_TEXT_SIZE:Number = 14;
		public static const LARGER_TEXT_SIZE:Number = 16;
		public static const LARGEST_TEXT_SIZE:Number = 20;
		
		protected var filters:Array = new Array();
		
		private var _owner:DisplayObject;
		
		public function Style()
		{
			super();
		}
		
		public function get owner():DisplayObject
		{
			return _owner;
		}
		public function set owner(value:DisplayObject):void
		{
			if(_owner != value)
			{
				_owner = value;
			}
		}
		
		public function validLayoutValue(str:String):Boolean
		{
			return (Style.NUM_REG.exec(str) || Style.PERCENT_REG.exec(str));
		}
		
		public function getLayoutValue(valueStr:String, parentValue:Number = 0):Number
		{
			if(Style.NUM_REG.exec(valueStr))
			{
				return Number(valueStr);
			}
			else if(Style.PERCENT_REG.exec(valueStr))
			{
				var p:Number = Number(valueStr.replace(Style.PERCENT_REG, "$1"));
				p = p / 100;
				return parentValue * p;
			}
			else
			{
				return 0;
			}
		}
	}
}