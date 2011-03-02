// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.test.tester
{
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.Container;

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
