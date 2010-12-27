/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin;
	
	public class TextAreaStyleFactory
	{
		public static function createNormalStyle():UISkin
		{
			var ds:UISkin = new UISkin();
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
		
		public static function createActiveStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 1;
			ds.fillStyle.glowAlpha = 0.5;
			return ds;
		}
		
		public static function createDisableStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			return ds;
		}
	}
}