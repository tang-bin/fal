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
	public class ScrollBoxStyleFactory
	{
		public static function createNormalStyle():UISkin
		{
			var ds:UISkin = new UISkin();
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 0.8;
			ds.fillStyle.radius = 0;
			return ds;
		}
		
		public static function createDisableStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			return ds;
		}
	}
}