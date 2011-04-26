// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.errors
{
	/**
	 * MotionError
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class MotionError extends Error
	{

		/**
		 * 
		 * @default 
		 */
		public static const START_END_NOT_MATCH:String = "Counts of start values and end values must the same.";

		/**
		 * 
		 * @default 
		 */
		public static const COUNT_VALUE_NOT_NUMBER:String = "Count value mast be number";

		/**
		 * 
		 * @param message
		 * @param id
		 */
		public function MotionError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}