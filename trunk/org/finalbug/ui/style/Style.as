//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.style
{
	import flash.display.DisplayObject;
	
	import org.finalbug.data.DataModel;
	
	/**
	 * css.styles.Style
	 *  
	 * @author Tang Bin
	 * @since 2010.08
	 */	
	public class Style extends DataModel
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public static const NUM_REG:RegExp = /^(-?\d*\.?\d*)$/;
		/**
		 * 
		 * @default 
		 */
		public static const PERCENT_REG:RegExp = /^(-?\d*\.?\d*)%$/;
		
		/**
		 * 
		 * @default 
		 */
		public static const defaultFont:String = "Verdana";
		
		/**
		 * 
		 * @default 
		 */
		public static const SMALLEST_TEXT_SIZE:Number = 4;
		/**
		 * 
		 * @default 
		 */
		public static const SMALLER_TEXT_SIZE:Number = 8;
		/**
		 * 
		 * @default 
		 */
		public static const SMALL_TEXT_SIZE:Number = 10
		/**
		 * 
		 * @default 
		 */
		public static const NORMAL_TEXT_SIZE:Number = 12;
		/**
		 * 
		 * @default 
		 */
		public static const LARGE_TEXT_SIZE:Number = 14;
		/**
		 * 
		 * @default 
		 */
		public static const LARGER_TEXT_SIZE:Number = 16;
		/**
		 * 
		 * @default 
		 */
		public static const LARGEST_TEXT_SIZE:Number = 20;
		
		/**
		 * 
		 * @default 
		 */
		protected var filters:Array = new Array();
		
		private var _owner:DisplayObject;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get owner():DisplayObject
		{
			return _owner;
		}
		/**
		 * 
		 * @param value
		 */
		public function set owner(value:DisplayObject):void
		{
			if(_owner != value)
			{
				_owner = value;
			}
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 */
		public function Style()
		{
			super();
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param str
		 * @return 
		 */
		public function validLayoutValue(str:String):Boolean
		{
			return (Style.NUM_REG.exec(str) || Style.PERCENT_REG.exec(str)) && str != "";
		}
		
		/**
		 * 
		 * @param valueStr
		 * @param parentValue
		 * @return 
		 */
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
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}