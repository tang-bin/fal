/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/ 
package org.finalbug.ui.style.stylefactory
{
	import org.finalbug.ui.style.UISkin;
	
	public class ButtonStyleFactory
	{
		public static const DEFAULT_WIDTH:Number = 80;
		public static const DEFAULT_HEIGHT:Number = 20;
		
		public static function createNormalStyle():UISkin
		{
			var ds:UISkin = new UISkin();
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
		
		public static function createOverStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			ds.fillStyle.bgColors = [0xF90000, 0x990000];
			
			return ds;
		}
		
		public static function createDownStyle():UISkin
		{
			var ds:UISkin = createNormalStyle();
			ds.fillStyle.bgColors = [0xF90000, 0x990000];
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