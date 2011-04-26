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
	import ftk.utils.DataUtil;
	
	/**
	 * CheckBoxStyle
	 * 
	 * @author Tang Bin
	 * @since 2011-2-3
	 */	
	public class RadioButtonStyle extends UIStyle
	{
		public function RadioButtonStyle()
		{
			with(this.normalFillStyle)
			{
				bgAlphas = [1, 1];
				bgColors = [0x990000, 0x000000];
				useGradient = true;
				bgRotation = 90;
				radius = 6;
				glowAlpha = 0.5;
				glowColor = 0x000000;
			}
			with(this.normalTextFormat)
			{
				font = "Verdana";
				size = 12;
				color = 0x333333;
			}
			//
			flagFS = new FillStyle(this.normalFillStyle);
			flagFS.bgColors = [0xFFFFFF, 0xCCCCCC];
			flagFS.radius = 3;
			//
			this.selectedFillStyle.copy(this.normalFillStyle);
			this.selectedFillStyle.bgColors = [0x000000, 0x990000];
			//
			DataUtil.textFormatClone(this.normalTextFormat, this.selectedTextFormat);
		}

		private var flagFS:FillStyle;

		public function get flatFillStyle():FillStyle
		{
			if (flagFS == null)
			{
				flagFS = new FillStyle();
			}
			return flagFS;
		}
	}
}