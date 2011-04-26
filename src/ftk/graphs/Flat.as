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
package ftk.graphs
{
	import ftk.core.Glaze;
	import ftk.style.FillStyle;

	/**
	 * display.Flat
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Flat extends Glaze
	{
		/**
		 * 
		 * @param width
		 * @param height
		 * @param style
		 */
		public function Flat(width:Number = 10, height:Number = 10, style:FillStyle = null)
		{
			super();
			this._fillStyle = style == null ? new FillStyle() : style;
			this.width = width;
			this.height = height;
			updateSize();
		}

		/**
		 * 
		 */
		public function refresh():void
		{
			this.updateSize();
		}
	}
}