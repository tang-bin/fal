// ##########################################################
// # __________.__              .__ ___.
// # \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// #  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// #  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// #  \__|     |__|___|__(______/____/_____/____/\___  /
// #                                            /_____/
// # Flex ToolKits by Finalbug
// # http://www.finalbug.org
// ##########################################################
package ftk.errors
{
	/**
	 * NetError
	 *
	 * @author Tang Bin
	 * @since 2011-1-27
	 */
	public class ConnError extends Error
	{

		public static const CHANGE_NAME_CONNECTED:String = "Cannot change name after connected.";

		public static const CNANGE_KEY_CONNECTED:String = "Cannot change key afater connected.";
		
		public static const NO_CONN_AND_VERIFY:String = "Cannot send data until connected to server and verified.";

		public function ConnError(message:* = "", id:* = 0)
		{
			super(message, id);
		}
	}
}
