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
package ftk.style
{
	/**
	 * ButtonStyle
	 *
	 * @author Tang Bin
	 * @since 2011-3-2
	 */
	public class ButtonStyle extends UIStyle
	{
		public static const DEFAULT_HEIGHT:Number = 19;

		public static const DEFAULT_WIDTH:Number = 80;

		public function ButtonStyle()
		{
			with(this.normalFillStyle)
			{
				bgAlphas = [1, 1];
				bgColors = [0x990000, 0x660000];
				useGradient = true;
				bgRotation = 90;
				radius = 3;
				glowAlpha = 0.4;
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
			this.selectedFillStyle.bgColors = [0xCC0000, 0xCC0000];
			/*
			this.selectedFillStyle.borderAlpha = 1;
			this.selectedFillStyle.borderColor = 0x000000;
			this.selectedFillStyle.borderSize = 2;
			this.selectedOverFillStyle.borderAlpha = 1;
			this.selectedOverFillStyle.borderColor = 0x000000;
			this.selectedOverFillStyle.borderSize = 2;
			this.selectedDownFillStyle.borderAlpha = 1;
			this.selectedDownFillStyle.borderColor = 0x000000;
			this.selectedDownFillStyle.borderSize = 2;
			 * 
			 */
		}

		public function setAsNavigateLeftButton():void
		{
			this.setStyleToAll("topLeftRadius", 4);
			this.setStyleToAll("bottomLeftRadius", 4);
			this.setStyleToAll("topRightRadius", 0);
			this.setStyleToAll("bottomRightRadius", 0);
			this.setStyleToAll("glowAlpha", 0);
			this.dispatchStyleChanged();
		}

		public function setAsNavigateRightButton():void
		{
			this.setStyleToAll("topLeftRadius", 0);
			this.setStyleToAll("bottomLeftRadius", 0);
			this.setStyleToAll("topRightRadius", 4);
			this.setStyleToAll("bottomRightRadius", 4);
			this.setStyleToAll("glowAlpha", 0);
			this.dispatchStyleChanged();
		}

		public function setAsNavigateNormalButton():void
		{
			this.setStyleToAll("topLeftRadius", 0);
			this.setStyleToAll("bottomLeftRadius", 0);
			this.setStyleToAll("topRightRadius", 0);
			this.setStyleToAll("bottomRightRadius", 0);
			this.setStyleToAll("glowAlpha", 0);
			this.dispatchStyleChanged();
		}
	}
}
