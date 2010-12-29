/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin2;
	

	/**
	 * @author Tang Bin
	 * @since 2010.09
	 */	
	public class ScrollBoxStyleFactory
	{
		public static function createNormalStyle():UISkin2
		{
			var ds:UISkin2 = new UISkin2();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 0.8;
			ds.fillStyle.radius = 0;
			return ds;
		}
		
		public static function createDisableStyle():UISkin2
		{
			var ds:UISkin2 = createNormalStyle();
			return ds;
		}
	}
}