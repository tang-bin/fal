/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.display
{
	import fal.css.CSSStyle;
	import fal.css.styles.FillStyle;
	
	import flash.display.GradientType;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	/**
	 * fal.display.Flat
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	public class Flat extends Glaze
	{
		public function Flat(width:Number = 10, height:Number = 10, style:CSSStyle = null)
		{
			super();
			this.style = style == null ? new CSSStyle() : style;
			this.displayWidth = width;
			this.displayHeight = height;
			updateView();
		}
		
		override protected function updateView():void
		{
			var s:FillStyle = style.fillStyle;
			this.graphics.clear();
			if(displayWidth != 0 && displayHeight != 0)
			{
				// set border style
				this.graphics.lineStyle(s.borderSize, s.borderColor, s.borderAlpha);
				// set fill style
				if(s.useGradient)
				{
					var fillType:String = GradientType.LINEAR;
					var matr:Matrix = new Matrix();
					matr.createGradientBox(displayWidth, displayHeight, Math.PI * s.bgRotation / 180, 0, 0);
					this.graphics.beginGradientFill(fillType, s.bgColors, s.bgAlphas, s.bgRatios, matr);
				}
				else
				{
					this.graphics.beginFill(s.bgColor, s.bgAlpha);
				}
				//
				this.graphics.drawRoundRectComplex(0, 0, displayWidth, displayHeight, 
					s.topLeftRadius,
					s.topRightRadius,
					s.bottomLeftRadius,
					s.bottomRightRadius);
				this.graphics.endFill();
				//
				// set filter 
				if(s.glowAlpha != 0 && s.glowBlur != 0)
				{
					var gf:GlowFilter = new GlowFilter(s.glowColor, s.glowAlpha,
						s.glowBlur, s.glowBlur,
						s.glowStrength, 3);
					this.filters = [gf];
				}
				else
				{
					this.filters = [];
				}
			}
		}
	}
}