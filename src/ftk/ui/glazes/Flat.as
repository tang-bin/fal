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
package ftk.ui.glazes
{
	import ftk.ui.Glaze;
	import ftk.ui.style.FillStyle;

	/**
	 * display.Flat
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Flat extends Glaze
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
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

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 */
		public function refresh():void
		{
			this.updateSize();
		}
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}