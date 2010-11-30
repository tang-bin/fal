/******************************************
 * [fb-aslib] Finalbug ActionScript Library 
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.errors
{
	public class DataError extends Error
	{
		public static const SINGLETON:String = "Class using singleton pattern cannot be instanced.";
		public static const NAME_EXIST:String = "The name of this data already exist.";
		public static const NAME_NOT_EXIST:String = "Object not exist.";
		
		public static const INDEX_FLOOD:String = "Data flood, not in valid area.";
		public static const TYPE_ERROR:String = "Data type error.";
		public static const SIZE_ERROR:String = "Size error.";
		public static const NOT_POSITIVE_NUMBER:String = "This number must lager than 0.";
		public static const DATA_NULL:String = "Data is null.";
		public static const DATA_EXIST:String = "Data is exist.";
		public static const SET_SHARED_DATA_ERROR:String = "To set data for SharedData, please use setData() method.";
		
		public static const SHARED_DATA_TYPE_ERROR:String = "Data type error, expect number, string, boolean, bytearray, treeModel and sharedData.";
		
		public static const CANNOT_REMOVE_NONEXISTENT_DATA:String = "Cannot remove nonexistent Data.";
		
		public function DataError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}