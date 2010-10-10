/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.glazes
{
	import flash.display.GradientType;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import org.finalbug.core.display.Glaze;
	import org.finalbug.ui.style.FillStyle;
	
	/**
	 * org.finalbug.fal.display.Flat
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	public class Flat extends Glaze
	{
		private var _fillStyle:FillStyle;
		
		public function get fillStyle():FillStyle
		{
			return _fillStyle;
		}
		public function set fillStyle(value:FillStyle):void
		{
			if(_fillStyle != value)
			{
				_fillStyle = value;
				this.updateView();
			}
		}
		
		public function Flat(width:Number = 10, height:Number = 10, style:FillStyle = null)
		{
			super();
			this._fillStyle = style == null ? new FillStyle() : style;
			this.displayWidth = width;
			this.displayHeight = height;
			updateView();
		}
		
		override protected function updateView():void
		{
			var s:FillStyle = _fillStyle;
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
				var fs:Array = new Array();
				if(s.glowAlpha > 0 && s.glowBlur > 0)
				{
					var gf:GlowFilter = new GlowFilter(s.glowColor, s.glowAlpha,
						s.glowBlur, s.glowBlur,
						s.glowStrength, 3);
					fs.push(gf);
				}
				if(s.shadowAlpha > 0 && s.shadowBlur > 0)
				{
					var sf:DropShadowFilter = new DropShadowFilter(s.shadowDistance, 45, 
						s.shadowColor, s.shadowAlpha, 
						s.shadowBlur, s.shadowBlur, s.shadowStrength);
					fs.push(sf);
				}
				this.filters = fs.length == 0 ? null : fs;
			}
		}
	}
}