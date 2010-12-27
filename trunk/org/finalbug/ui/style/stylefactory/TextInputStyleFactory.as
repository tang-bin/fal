/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin;
	
	/**
	 * @author Tang Bin
	 * @since 2010.09
	 */	
	public class TextInputStyleFactory
	{
		public static function createNormalStyle():UISkin
		{
			var ds:UISkin = new UISkin();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 0.8;
			ds.fillStyle.radius = 3;
			ds.textStyle.format.color = 0x333333;
			return ds;
		}
		
		public static function createActiveStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			ds.fillStyle.useGradient = true;
			ds.fillStyle.bgColors = [0xCCCCCC, 0xFFFFFF];
			ds.fillStyle.bgAlphas = [0.8, 0.8];
			ds.fillStyle.bgRatios = [0, 0xFF];
			ds.fillStyle.bgRotation = 90;
			return ds;
		}
		
		public static function createDisableStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			return ds;
		}
	}
}