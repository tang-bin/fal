/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.utils
{
	/**
	 * DateUtil
	 * 
	 * @author Tang Bin
	 * @since 2010
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
		
		public static function dateClone(date:Date):Date
		{
			return new Date(date.time);
		}
	}
}