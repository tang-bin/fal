/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin2;
	

	public class CheckBoxStyleFactory
	{
		public static function createNormalStyle():UISkin2
		{
			var ds:UISkin2 = new UISkin2();
			ds.fillStyle.bgAlpha = 1;
			ds.fillStyle.bgColor = 0x333333;
			ds.fillStyle.glowAlpha = 0.5;
			ds.fillStyle.borderAlpha = 0;
			ds.fillStyle.borderColor = 0xFF9900;
			return ds;
		}
		
		public static function createOverStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			ds.fillStyle.bgColor = 0x990000;
			ds.textStyle.format.color = 0x990000;
			return ds;
		}
		
		public static function createDownStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			return ds;
		}
		
		public static function createDisableStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			return ds;
		}
	}
}