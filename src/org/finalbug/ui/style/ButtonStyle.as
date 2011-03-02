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
package org.finalbug.ui.style
{
	/**
	 * ButtonStyle
	 *
	 * @author Tang Bin
	 * @since 2011-3-2
	 */
	public class ButtonStyle extends UIStyle
	{

		public function ButtonStyle()
		{
			with(this.normalFillStyle)
			{
				bgAlphas = [1, 1];
				bgColors = [0x990000, 0x000000];
				useGradient = true;
				bgRotation = 90;
				radius = 4;
				glowAlpha = 0.5;
				glowColor = 0x000000;
			}
			with(this.normalTextFormat)
			{
				font = "Verdana";
				size = 12;
				color = 0xCCCCCC;
			}
			applyStyleToAll(this.normalFillStyle);
			applyTextFormatToAll(this.normalTextFormat);
			//
			this.overFillStyle.bgColors = [0xCC0000, 0x660000];
			this.overTextFormat.color = 0xFFFFFF;
			this.selectedOverFillStyle.bgColors = [0xCC0000, 0x660000];
			this.selectedOverTextFormat.color = 0xFFFFFF;
			//
			this.selectedFillStyle.borderAlpha = 1;
			this.selectedFillStyle.borderColor = 0xFFFFFF;
			this.selectedFillStyle.borderSize = 2;
			this.selectedOverFillStyle.borderAlpha = 1;
			this.selectedOverFillStyle.borderColor = 0xFFFFFF;
			this.selectedOverFillStyle.borderSize = 2;
			this.selectedDownFillStyle.borderAlpha = 1;
			this.selectedDownFillStyle.borderColor = 0xFFFFFF;
			this.selectedDownFillStyle.borderSize = 2;
		}
	}
}
