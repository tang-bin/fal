/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.fal.uistyle.stylefactory
{
	import org.finalbug.fal.uistyle.DisplayStyle;
	

	/**
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.09
	 */	
	public class ScrollBoxStyleFactory
	{
		public static function createNormalStyle():DisplayStyle
		{
			var ds:DisplayStyle = new DisplayStyle();
			ds.layoutStyle.setValue("width", 400);
			ds.layoutStyle.setValue("height", 300);
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 0.8;
			ds.fillStyle.radius = 0;
			return ds;
		}
		
		public static function createDisableStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			return ds;
		}
	}
}