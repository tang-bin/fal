/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.DisplayStyle;
	

	public class CheckBoxStyleFactory
	{
		public static function createNormalStyle():DisplayStyle
		{
			var ds:DisplayStyle = new DisplayStyle();
			ds.fillStyle.bgAlpha = 1;
			ds.fillStyle.bgColor = 0x333333;
			ds.fillStyle.glowAlpha = 0.5;
			ds.fillStyle.borderAlpha = 0;
			ds.fillStyle.borderColor = 0xFF9900;
			return ds;
		}
		
		public static function createOverStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			ds.fillStyle.bgColor = 0x990000;
			ds.textStyle.format.color = 0x990000;
			return ds;
		}
		
		public static function createDownStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			return ds;
		}
		
		public static function createDisableStyle():DisplayStyle
		{
			var ds:DisplayStyle = createNormalStyle();
			return ds;
		}
	}
}