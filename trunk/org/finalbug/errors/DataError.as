/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************************/
package org.finalbug.errors
{
	/**
	 * DataError
	 * 
	 * @author Tang Bin
	 * @since 2010.8
	 */	
	public class DataError extends Error
	{
		/**
		 * 
		 * @default 
		 */
		public static const SINGLETON:String = "Class using singleton pattern cannot be instanced.";
		/**
		 * 
		 * @default 
		 */
		public static const NAME_EXIST:String = "The name of this data already exist.";
		/**
		 * 
		 * @default 
		 */
		public static const NAME_NOT_EXIST:String = "Object not exist.";
		
		/**
		 * 
		 * @default 
		 */
		public static const INDEX_FLOOD:String = "Data flood, not in valid area.";
		/**
		 * 
		 * @default 
		 */
		public static const TYPE_ERROR:String = "Data type error.";
		/**
		 * 
		 * @default 
		 */
		public static const SIZE_ERROR:String = "Size error.";
		/**
		 * 
		 * @default 
		 */
		public static const NOT_POSITIVE_NUMBER:String = "This number must lager than 0.";
		/**
		 * 
		 * @default 
		 */
		public static const DATA_NULL:String = "Data is null.";
		/**
		 * 
		 * @default 
		 */
		public static const DATA_EXIST:String = "Data is exist.";
		/**
		 * 
		 * @default 
		 */
		public static const SET_SHARED_DATA_ERROR:String = "To set data for SharedData, please use setData() method.";
		
		/**
		 * 
		 * @default 
		 */
		public static const SHARED_DATA_TYPE_ERROR:String = "Data type error, expect number, string, boolean, bytearray, treeModel and sharedData.";
		
		/**
		 * 
		 * @default 
		 */
		public static const CANNOT_REMOVE_NONEXISTENT_DATA:String = "Cannot remove nonexistent Data.";
		
		/**
		 * 
		 * @default 
		 */
		public static const LABEL_TEXT_TOO_LARGE:String = "Label's text too wide or high to display.";
		
		/**
		 * 
		 * @param message
		 * @param id
		 */
		public function DataError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}