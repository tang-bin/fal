/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.DisplayStyle;
	
	/**
	 * @author Tang Bin
	 * @since 2010.09
	 */	
	public class TextInputStyleFactory
	{
		public static function createNormalStyle():DisplayStyle
		{
			var ds:DisplayStyle = new DisplayStyle();
			ds.layoutStyle.setValue("width", 160);
			ds.layoutStyle.setValue("height", 20);
			ds.fillStyle.useGradient = false;
			ds.fillStyle.bgColor = 0xEEEEEE;
			ds.fillStyle.bgAlpha = 0.8;
			ds.fillStyle.radius = 3;
			ds.textStyle.format.color = 0x333333;
			return ds;
		}
		
		public static function createActiveStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			ds.fillStyle.useGradient = true;
			ds.fillStyle.bgColors = [0xCCCCCC, 0xFFFFFF];
			ds.fillStyle.bgAlphas = [0.8, 0.8];
			ds.fillStyle.bgRatios = [0, 0xFF];
			ds.fillStyle.bgRotation = 90;
			return ds;
		}
		
		public static function createDisableStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			return ds;
		}
	}
}