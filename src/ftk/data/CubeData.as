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
	import ftk.utils.ColorUtil;

	/**
	 * This class defines the display data for a cube.
	 *
	 * @author Tang Bin
	 * @since old version
	 */
	public class CubeData
	{
		/**
		 * Create a new Cubu data.
		 *
		 * @param color Cube's color
		 * @param width Cube's width
		 * @param height Cube's height
		 * @param thickness Cube's thickness
		 * @param lean Cube's lean type. default value CubeData.LEAN_LEFT
		 * @param border Show Cube's border or not.
		 */
		public function CubeData()
		{
			accountColor();
		}

		/**
		 * cube's shadow lean to left.
		 */
		public static const LEAN_LEFT:String = "leanLeft";

		/**
		 * cube's shadow lean to right.
		 */
		public static const LEAN_RIGHT:String = "leanRight";

		/**
		 * width of cube
		 */
		public var width:Number = 300;

		/**
		 * height of cube
		 */
		public var height:Number = 400;

		/**
		 * thickness of cube
		 */
		public var thickness:Number = 30;

		/**
		 * which side the cube lean to, can be CubuData.LEAN_LEFT or CubuData.LEAN_RIGHT.
		 */
		public var lean:String = "";

		/**
		 * show cube's border or not.
		 */
		public var border:Boolean = false;

		private var _color:uint = 0x990000;

		private var _topColor:uint = 0x990000;

		private var _sideColor:uint = 0x990000;

		private var _frontColor:uint = 0x990000;

		/**
		 * @default 0xFF0000
		 */
		public function get color():uint
		{
			return _color;
		}

		/**
		 * Once cubu's color is set, the color value will changes to 3 values:
		 * topColor, sideColor and frontColor.
		 * 
		 * @param value
		 */
		public function set color(value:uint):void
		{
			_color = value;
			accountColor();
		}

		/**
		 * cube color of top side.
		 */
		public function get topColor():uint
		{
			return _topColor;
		}

		/**
		 * cubu color of side.
		 */
		public function get sideColor():uint
		{
			return _sideColor;
		}

		/**
		 * Cube color of front side.
		 */
		public function get frontColor():uint
		{
			return _frontColor;
		}

		/**
		 * account 3 side color values from one single color.
		 */
		private function accountColor():void
		{
			_topColor = _color;
			_frontColor = ColorUtil.offsetColor(_color, -50);
			_sideColor = ColorUtil.offsetColor(_color, 50);
		}
	}
}
