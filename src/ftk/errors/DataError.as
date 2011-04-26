// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.errors
{
	/**
	 * DataError
	 * 
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class DataError extends Error
	{
		public static const SINGLETON:String = "Class using singleton pattern cannot be instanced.";

		public static const ABSTRACT:String = "Abstract class cannot be instanced.";

		public static const NAME_EXIST:String = "The name of this data already exist.";

		public static const NAME_NOT_EXIST:String = "Object not exist.";

		public static const TYPE_ERROR:String = "Data type error.";

		public static const SIZE_ERROR:String = "Size error.";

		public static const NOT_POSITIVE_NUMBER:String = "This number must lager than 0.";

		public static const DATA_NULL:String = "Data is null.";

		public static const DATA_EXIST:String = "Data is exist.";

		public static const SET_SHARED_DATA_ERROR:String = "To set data for SharedData, please use setData() method.";

		public static const SHARED_DATA_TYPE_ERROR:String = "Data type error, expect number, string, boolean, bytearray, treeModel and sharedData.";

		public static const CANNOT_REMOVE_NONEXISTENT_DATA:String = "Cannot remove nonexistent Data.";

		public static const LABEL_TEXT_TOO_LARGE:String = "Label's text too wide or high to display.";

		public static const STATIC_CLASS:String = "Static class cannot be instanced";

		public static const INVALID_INDEX:String = "Invalid index number";

		public function DataError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}