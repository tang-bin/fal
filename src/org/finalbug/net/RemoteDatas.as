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
package org.finalbug.net
{
	import org.finalbug.data.SharedData;

	/**
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class RemoteDatas
	{
		/**
		 * 
		 */
		public function RemoteDatas()
		{
		}

		/**
		 * 
		 * @param host
		 * @param port
		 * @param application
		 */
		public function connect(host:String, port:uint, application:String):void
		{
		}

		/**
		 * 
		 * @param dataName
		 * @param data
		 */
		public function listen(dataName:String, data:SharedData):void
		{
		}

		/**
		 * 
		 * @param dataName
		 * @param data
		 */
		public function stopListen(dataName:String, data:SharedData):void
		{
		}
	}
}