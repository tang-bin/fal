/****************************
 * fal.display.Flat
 *
 * @author Tang Bin
 * @since 2010-8-19
 ****************************/
package fal.display
{
	import fal.data.FillData;
	import fal.style.styles.FillStyle;
	
	import flash.display.GradientType;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class Flat extends Glaze
	{
		private var _style:FillStyle
		private var _width:Number;
		private var _height:Number;
		// default size
		
		public function get style():FillStyle
		{
			return _style;
		}
		public function set style(value:FillStyle):void
		{
			_style = value;
			drawFlat();
		}
		
		public function setsize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			drawFlat();
		}
		
		public function Flat(width:Number = 10, height:Number = 10, style:FillStyle = null)
		{
			super();
			this._style = style == null ? new FillStyle() : style;
			this.displayWidth = width;
			this.displayHeight = height;
			drawFlat();
		}
		
		/**
		 * Redraw flat. if dont use auto draw function(by default), you need to call the mothed to make flat
		 * redraw using new datas.
		 * 
		 * if autoRedraw is true, once a new display data is set, flat will auto redraw.
		 */		
		public function refresh():void
		{
			drawFlat();
		}
		
		override protected function doResize():void
		{
			drawFlat();
		}
		
		/**
		 * method to draw flat.
		 */		
		private function drawFlat():void
		{
			// clear all at first.
			this.graphics.clear();
			// set border style
			this.graphics.lineStyle(_style.borderSize, _style.borderColor, _style.borderAlpha);
			// set fill style
			if(_style.useGradient)
			{
				var fillType:String = GradientType.LINEAR;
				var matr:Matrix = new Matrix();
				matr.createGradientBox(displayWidth, displayHeight, Math.PI * _style.bgRotation / 180, 0, 0);
				this.graphics.beginGradientFill(fillType, _style.bgColors, _style.bgAlphas, _style.bgRatios, matr);
			}
			else
			{
				this.graphics.beginFill(_style.bgColor, _style.bgAlpha);
			}
			//
			this.graphics.drawRoundRectComplex(0, 0, displayWidth, displayHeight, 
											_style.topLeftRadius,
											_style.topRightRadius,
											_style.bottomLeftRadius,
											_style.bottomRightRadius);
			this.graphics.endFill();
			//
			// set scale 9 grid
			var scaleSize:Number = Math.max(_style.topLeftRadius, _style.topRightRadius, _style.bottomLeftRadius, _style.bottomRightRadius);
			if(scaleSize > 0 && displayWidth > 2 * scaleSize && displayHeight > 2 * scaleSize)
			{
				this.scale9Grid = new Rectangle(scaleSize, scaleSize,
												displayWidth - 2 * scaleSize,
												displayHeight - 2 * scaleSize);
			}
			else
			{
				this.scale9Grid = null;
			}
			//
			/* set filter */
			if(_style.glowAlpha != 0 && _style.glowBlur != 0)
			{
				var gf:GlowFilter = new GlowFilter(_style.glowColor, _style.glowAlpha,
													_style.glowBlur, _style.glowBlur,
													_style.glowStrength, 3);
				this.filters = [gf];
			}
			else
			{
				this.filters = [];
			}
		}
	}
}