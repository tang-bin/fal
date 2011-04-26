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
package ftk.core
{
	/**
	 * Glaze is the basic class for all static graphic classes.
	 * 
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class Glaze extends Bin
	{
		public function Glaze()
		{
			super();
			this.mouseChildren = this.mouseEnabled = false;
			this.cacheAsBitmap = true;
		}
	}
}