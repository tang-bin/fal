/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.DisplayStyle;
	
	public class ButtonStyleFactory
	{
		public static const DEFAULT_WIDTH:Number = 80;
		public static const DEFAULT_HEIGHT:Number = 20;
		
		public static function createNormalStyle():DisplayStyle
		{
			var ds:DisplayStyle = new DisplayStyle();
			ds.layoutStyle.setValue("width", DEFAULT_WIDTH);
			ds.layoutStyle.setValue("height", DEFAULT_HEIGHT);
			ds.fillStyle.useGradient = true;
			ds.fillStyle.bgColors = [0x999999, 0];
			ds.fillStyle.bgAlphas = [0.8, 0.8];
			ds.fillStyle.bgRatios = [0, 0xFF];
			ds.fillStyle.bgRotation = 90;
			ds.fillStyle.radius = 3;
			ds.fillStyle.glowAlpha = 0.3;
			ds.textStyle.format.color = 0xEEEEEE;
			return ds;
		}
		
		public static function createOverStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			ds.fillStyle.bgColors = [0xF90000, 0x990000];
			return ds;
		}
		
		public static function createDownStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			ds.fillStyle.bgColors = [0xF90000, 0x990000];
			ds.fillStyle.glowAlpha = 0.5;
			return ds;
		}
		
		public static function createDisableStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			return ds;
		}
	}
}