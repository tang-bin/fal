// ##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__|     |__|___|__(______/____/_____/____/\___  /
// /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
// ##########################################################
package org.finalbug.errors
{
	/**
	 * FSDASClientError
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class FSDASClientError extends Error
	{
		/**
		 * 
		 * @default 
		 */
		public static const ALREADY_LISTEN:String = "alreadyListen";

		/**
		 * 
		 * @param message
		 * @param id
		 */
		public function FSDASClientError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}