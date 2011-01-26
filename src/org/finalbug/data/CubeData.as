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
package org.finalbug.data
{
	import org.finalbug.utils.ColorUtil;

	/**
	 * This class defines the display data for a cube.
	 *
	 * @author Tang Bin
	 * @since old version
	 */
	public class CubeData
	{

		// ******************* OVERRIDE *****************************
		// ******************* DEFINE *******************************
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
		public var width:Number;

		/**
		 * height of cube
		 */
		public var height:Number;

		/**
		 * thickness of cube
		 */
		public var thickness:Number;

		/**
		 * which side the cube lean to, can be CubuData.LEAN_LEFT or CubuData.LEAN_RIGHT.
		 */
		public var lean:String;

		/**
		 * show cube's border or not.
		 */
		public var border:Boolean = false;

		private var _color:uint;

		private var _topColor:uint;

		private var _sideColor:uint;

		private var _frontColor:uint;

		// ******************* GETTER and SETTER ********************
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

		// ******************* CONSTRUCTOR **************************
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
		public function CubeData(color:uint = 0xFF0000,
									width:Number = 300,
									height:Number = 400,
									thickness:Number = 30,
									lean:String = "",
									border:Boolean = false)
		{
			this._color = color;
			this.width = width;
			this.height = height;
			this.thickness = thickness;
			this.lean = lean == LEAN_RIGHT ? LEAN_RIGHT : LEAN_LEFT;
			this.border = border;
			//
			accountColor();
		}

		// ******************* PUBLIC *******************************
		// ******************* PROTECTED ****************************
		// ******************* PRIVATE ******************************
		/**
		 * account 3 side color values from one single color.
		 */
		private function accountColor():void
		{
			_topColor = _color;
			_frontColor = ColorUtil.offsetColor(_color, -50);
			_sideColor = ColorUtil.offsetColor(_color, 50);
		}
		// ******************* HANDLER ******************************
	}
}
