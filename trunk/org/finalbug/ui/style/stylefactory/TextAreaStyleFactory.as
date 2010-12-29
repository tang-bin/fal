/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin2;
	
	public class TextAreaStyleFactory
	{
		public static function createNormalStyle():UISkin2
		{
			var ds:UISkin2 = new UISkin2();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.borderColor = 0xCCCCCC;
			ds.fillStyle.borderAlpha = 1;
			ds.fillStyle.bgColor = 0xDDDDDD;
			ds.fillStyle.bgAlpha = 1;
			ds.fillStyle.radius = 0;
			ds.fillStyle.glowAlpha = 0;
			ds.textStyle.format.color = 0x333333;
			return ds;
		}
		
		public static function createActiveStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 1;
			ds.fillStyle.glowAlpha = 0.5;
			return ds;
		}
		
		public static function createDisableStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			return ds;
		}
	}
}