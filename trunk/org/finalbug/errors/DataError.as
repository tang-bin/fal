/******************************************
 * [fb-aslib] Finalbug ActionScript Library 
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.errors
{
	public class DataError extends Error
	{
		public static const INDEX_FLOOD:String = "Data flood, not in valid area.";
		public static const TYPE_ERROR:String = "Data type error.";
		public static const NOT_POSITIVE_NUMBER:String = "This number must lager than 0.";
		public static const DATA_NULL:String = "Data is null.";
		public static const SET_SHARED_DATA_ERROR:String = "To set data for SharedData, please use setData() method.";
		
		public function DataError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}