////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.utils
{
	/**
	 * DateUtil
	 * 
	 * @author		Tang Bin
	 * @since		2012.12-1
	 */
	public class DateUtil
	{

		/**
		 * similar with DateFormmatter. create this method beacuse DateFormmatter
		 * cannot be used in ActionScript projects.
		 *  
		 * not compelet yet.
		 * @param date
		 * @param formatString
		 * @return 
		 */
		public static function format(date:Date, formatString:String = "YYYY-MM-DD"):String
		{
			var str:String = formatString;
			str = str.replace(/YYYY/gi, date.fullYear);
			str = str.replace(/MM/gi, StringUtil.fillString((date.month + 1).toString(), 2));
			str = str.replace(/DD/gi, StringUtil.fillString(date.date.toString(), 2));
			return str;
		}

		/**
		 * 
		 * @param date
		 * @return 
		 */
		public static function dateClone(date:Date):Date
		{
			return new Date(date.time);
		}
	}
}