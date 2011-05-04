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
package ftk.layout
{
	import ftk.data.Position;
	import ftk.style.Style;
	import ftk.controls.Label;

	import flash.text.TextFormat;

	/**
	 * GridCell is the cell used in class Grid.
	 *  
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class GridCell extends Container
	{
		/**
		 * Create an new GridCell.
		 */
		public function GridCell()
		{
			super();
			this.backgroundColor = 0xFFFFFF;
			this.backgroundAlpha = 1;
			this.borderColor = 0x333333;
			this.borderAlpha = 0;
			//
			this.autoRank = true;
			this.align = Position.CENTER;
			this.valign = Position.MIDDLE;
			this.rankGap = 5;
		}

		/**
		 * The column index of cell.
		 * 
		 * @default 0
		 */
		public var xIndex:uint = 0;

		/**
		 * the row index of cell.
		 * 
		 * @default 0
		 */
		public var yIndex:uint = 0;

		/**
		 * Cell is updated or not when run rebuild() method in Grid object.
		 * 
		 * @default false
		 */
		internal var updated:Boolean = false;

		private var _textFormat:TextFormat;

		private var _label:Label;

		public function get textFormat():TextFormat
		{
			return _textFormat;
		}

		public function set textFormat(value:TextFormat):void
		{
			_textFormat = value;
			if (_label != null)
			{
				_label.textFormat = _textFormat;
			}
		}

		public function set text(value:String):void
		{
			if (_label == null)
			{
				if (_textFormat == null)
				{
					_textFormat = new TextFormat(Style.defaultFont, Style.NORMAL_TEXT_SIZE, 0);
				}
				_label = new Label(value, _textFormat);
				this.removeAll();
				this.addChild(_label);
				_label.toCenter();
			}
			else
			{
				_label.text = value;
				_label.toCenter();
			}
		}

		public function get text():String
		{
			if (_label != null)
			{
				return _label.text;
			}
			else
			{
				return null;
			}
		}

		/**
		 * Reset cell's position by x, y, width and height values.
		 * 
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 */
		public function resetPosition(x:Number, y:Number, width:Number, height:Number):void
		{
			this.layoutStyle.setRetangleStyle(x, y, width, height);
		}
	}
}