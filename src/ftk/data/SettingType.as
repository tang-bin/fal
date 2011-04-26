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
package ftk.data
{
	/**
	 * SettingType defines some types for settings or run tasks.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class SettingType
	{
		/**
		 * Always means the setting is for globel.
		 * 
		 * @default global
		 */
		public static const GLOBAL:String = "global";

		/**
		 * Always means the setting is for current only.
		 * 
		 * @default current
		 */
		public static const CURRENT:String = "current";

		/**
		 * Always means the setting is for all.
		 * 
		 * @default ALL
		 */
		public static const ALL:String = "ALL";

		/**
		 * Always measn the tasks are running one by one.
		 * 
		 * @default 
		 */
		public static const ORDERLY:String = "orderly";

		/**
		 * Always means the tasks are running together.
		 * 
		 * @default 
		 */
		public static const CONCURRENT:String = "concurrent";
	}
}