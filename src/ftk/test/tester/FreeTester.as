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
package ftk.test.tester
{
	import ftk.ui.control.Button;
	import ftk.ui.control.Container;

	/**
	 * FreeTester
	 *
	 * @author Tang Bin
	 * @since 2011-3-2
	 */
	public class FreeTester extends Container
	{

		public function FreeTester()
		{
			super();
			var b:Button = new Button();
			this.addAll(b);
		}
	}
}
