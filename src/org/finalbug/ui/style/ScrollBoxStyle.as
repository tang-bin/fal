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
	 * CheckBoxStyle
	 * 
	 * @author Tang Bin
	 * @since 2011-2-3
	 */
	public class ScrollBoxStyle extends UIStyle
	{

		public function ScrollBoxStyle()
		{
			with(this.normalFillStyle)
			{
				bgColor = 0xFFFFF0;
				bgAlpha = 1;
				borderColor = 0x990000;
				borderAlpha = 1;
			}
			with(this.normalTextFormat)
			{
				font = "Arial";
				color = 0x333333;
				size = 12;
			}
			super.applyStyleToAll(this.normalFillStyle);
			super.applyTextFormatToAll(this.normalTextFormat);
			//
			selectedFillStyle.glowAlpha = 0.5;
			selectedFillStyle.innerGlow = true;
			selectedFillStyle.glowColor = 0x000000;
		}

		private var _scrollBarStyle:ScrollBarStyle;

		public function get scrollBarStyle():ScrollBarStyle
		{
			if (_scrollBarStyle == null)
			{
				_scrollBarStyle = UIStyle.defaultScrollBarStyle;
			}
			return _scrollBarStyle;
		}
	}
}