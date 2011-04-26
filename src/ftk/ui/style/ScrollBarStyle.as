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
package ftk.ui.style
{
	/**
	 * CheckBoxStyle
	 * 
	 * @author Tang Bin
	 * @since 2011-2-3
	 */
	public class ScrollBarStyle extends UIStyle
	{

		public function ScrollBarStyle()
		{
			with(this.buttonFillStyle)
			{
				useGradient = true;
				bgColors = [0x999999, 0x000000];
				bgAlphas = [1, 1];
				bgRotation = 45;
				borderAlpha = 1;
				radius = 0;
				borderColor = 0x333333;
			}
			with(this.backFillStyle)
			{
				bgColor = 0xCCCCCC;
				bgAlpha = 1;
				borderAlpha = 1;
				borderColor = 0x333333;
			}
			with(this.sliderFillStyle)
			{
				bgColor = 0x333333;
				bgAlpha = 1;
			}
		}

		public var arrowColor:uint = 0xFFFFFF;

		private var buttonFS:FillStyle;

		private var backFS:FillStyle;

		private var sliderFS:FillStyle;

		public function get buttonFillStyle():FillStyle
		{
			if (buttonFS == null)
			{
				buttonFS = new FillStyle();
			}
			return buttonFS;
		}

		public function get backFillStyle():FillStyle
		{
			if (backFS == null)
			{
				backFS = new FillStyle();
			}
			return backFS;
		}

		public function get sliderFillStyle():FillStyle
		{
			if (sliderFS == null)
			{
				sliderFS = new FillStyle();
			}
			return sliderFS;
		}
	}
}