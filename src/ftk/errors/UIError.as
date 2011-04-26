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
	 * UIError
	 * 
	 * @author Tang Bin
	 * @since 2010.8
	 */
	public class UIError extends Error
	{
		public static const WRONG_SCROLLBAR_TYPE:String = "ScrollBar component type error.";

		public static const CONTROL_NULL:String = "Must register status before effect.";

		public static const DISPLAY_OBJECT_NULL:String = "Target displayObject not exist.";

		public static const WRONG_TYPE:String = "Type Error.";

		public function UIError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}