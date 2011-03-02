// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.utils
{
	import flash.text.TextFormat;

	/**
	 * DataUtil
	 *
	 * @author Tang Bin
	 * @since old version
	 */
	public class DataUtil
	{

		/**
		 * Check out if the given parameter's value is contained in a group of values.
		 * 
		 * @param value Given parameter.
		 * @param arg A group of values.
		 * @return 
		 */
		public static function included(value:*, ...arg):Boolean
		{
			for (var i:Number = arg.length ; --i >= 0 ;)
			{
				if (value == arg[i])
				{
					return true;
				}
				else if (arg[i] is Array)
				{
					for each (var subValue:* in arg[i])
					{
						if (subValue == value) return true;
					}
				}
			}
			return false;
		}

		/**
		 * check if the value target is in the list of values.
		 * 
		 * @param target
		 * @param args
		 * @return Return the index of values in array list if target is found, or -1 if is not found
		 * 
		 */
		public static function match(target:*, values:Array):int
		{
			for (var i:uint = values.length ; --i >= 0 ; )
			{
				if (values[i] == target) return i;
			}
			return -1;
		}

		/**
		 * Using for each to get the number of object's variables.
		 * 
		 * @param obj
		 */
		public static function getObjectCount(obj:Object):uint
		{
			var count:uint = 0;
			for each (var v:* in obj)
			{
				if (v != null)
				{
					count++;
				}
			}
			return count;
		}

		public static function arrayClone(arr:Array):Array
		{
			var newArr:Array = new Array();
			var len:uint = arr.length;
			for (var i:uint = 0 ; i < len ; i++)
			{
				if (arr[i] is Array)
				{
					newArr.push(DataUtil.arrayClone(arr[i]));
				}
				else
				{
					newArr.push(arr[i]);
				}
			}
			return newArr;
		}

		public static function textFormatClone(from:TextFormat, to:TextFormat):void
		{
			var values:Array = ["font", "color", "size", "align", "blockIndent"];
			values.push("bold", "bullet", "indent", "italic", "leading");
			values.push("leftMargin", "rightMargin", "tabStops");
			values.push("target", "underline", "url");
			for (var i:uint = values.length ; --i >= 0 ; )
			{
				to[values[i]] = from[values[i]];
			}
		}
	}
}