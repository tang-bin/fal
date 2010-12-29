/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin2;
	

	public class ScrollBarStyleFactory
	{
		public static function createNormalStyle():UISkin2
		{
			var ds:UISkin2 = new UISkin2();
			ds.fillStyle.useGradient = true;
			ds.fillStyle.bgColors = [0x999999, 0xCCCCCC];
			ds.fillStyle.bgAlphas = [0.8, 0.8];
			ds.fillStyle.bgRatios = [0, 0xFF];
			ds.fillStyle.bgRotation = 90;
			ds.fillStyle.glowBlur = 2;
			ds.fillStyle.glowAlpha = 0.3;
			//
			ds.fillStyle.bgAlpha = 0.4;
			ds.fillStyle.bgColor = 0xCCCCCC;
			ds.fillStyle.glowAlpha = 0.5;
			//
			ds.textStyle.format.color = 0xEEEEEE;
			return ds;
		}
		
		public static function createDisableStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 0.8;
			ds.fillStyle.glowAlpha = 0;
			return ds;
		}
	}
}