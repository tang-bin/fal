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
	 * Position defines position values.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Position
	{
		/**
		 * 
		 * @default left
		 */
		public static const LEFT:String = "left";

		/**
		 * 
		 * @default right
		 */
		public static const RIGHT:String = "right";

		/**
		 * 
		 * @default top
		 */
		public static const TOP:String = "top";

		/**
		 * 
		 * @default bottom
		 */
		public static const BOTTOM:String = "bottom";

		/**
		 * 
		 * @default up
		 */
		public static const UP:String = "up";

		/**
		 * 
		 * @default down
		 */
		public static const DOWN:String = "down";

		/**
		 * 
		 * @default topLeft
		 */
		public static const TOP_LEFT:String = "topLeft";

		/**
		 * 
		 * @default topRight
		 */
		public static const TOP_RIGHT:String = "topRight";

		/**
		 * 
		 * @default bottomLeft
		 */
		public static const BOTTOM_LEFT:String = "bottomLeft";

		/**
		 * 
		 * @default bottomRight
		 */
		public static const BOTTOM_RIGHT:String = "bottomRight";

		/**
		 * 
		 * @default topCenter
		 */
		public static const TOP_CENTER:String = "topCenter";

		/**
		 * 
		 * @default leftCenter
		 */
		public static const LEFT_CENTER:String = "leftCenter";

		/**
		 * 
		 * @default bottomCenter
		 */
		public static const BOTTOM_CENTER:String = "bottomCenter";

		/**
		 * 
		 * @default rightCenter
		 */
		public static const RIGHT_CENTER:String = "rightCenter";

		/**
		 * 
		 * @default center
		 */
		public static const CENTER:String = "center";

		public static const MIDDLE:String = "middle";

		/**
		 * 
		 * @default horizontal
		 */
		public static const HORIZONTAL:String = "horizontal";

		/**
		 * 
		 * @default vertical
		 */
		public static const VERTICAL:String = "vertical";

		public static function isAlignValue(value:String):Boolean
		{
			return value == LEFT || value == CENTER || value == RIGHT;
		}

		public static function isVAlignValue(value:String):Boolean
		{
			return value == TOP || value == MIDDLE || value == BOTTOM;
		}
	}
}