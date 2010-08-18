package fas.utils
{
	import fas.data.FillData;
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * Class Flat is a color filled flat display object.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class Flat extends Sprite
	{
		private var fd:FillData;
		private var _width:Number;
		private var _height:Number;
		// default size
		
		public function get fillData():FillData
		{
			return fd;
		}
		public function set fillData(value:FillData):void
		{
			fd = value;
			drawFlat();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		override public function set height(value:Number):void
		{
			if(_height != value)
			{
				_height = value > 0 ?  value : 0;
				drawFlat();
			}
		}
		
		override public function get width():Number
		{
			return _width;
		}
		override public function set width(value:Number):void
		{
			if(_width != value)
			{
				_width = value > 0 ? value : 0;
				drawFlat();
			}
		}
		
		public function setsize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			drawFlat();
		}
		
		public function Flat(width:Number = 10, height:Number = 10, fillData:FillData = null)
		{
			fd = fillData == null ? new FillData() : fillData;
			_width = width;
			_height = height;
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
		
		/**
		 * method to draw flat.
		 */		
		private function drawFlat():void
		{
			// clear all at first.
			this.graphics.clear();
			// set border style
			this.graphics.lineStyle(fd.borderSize, fd.borderColor, fd.borderAlpha);
			// set fill style
			if(fd.gradient)
			{
				var fillType:String = GradientType.LINEAR;
				var matr:Matrix = new Matrix();
				matr.createGradientBox(_width, _height, Math.PI * fd.rotate / 180, 0, 0);
				this.graphics.beginGradientFill(fillType, fd.bodyColors, fd.bodyAlphas, fd.ratios, matr);
			}
			else
			{
				this.graphics.beginFill(fd.bodyColor, fd.bodyAlpha);
			}
			//
			this.graphics.drawRoundRectComplex(0, 0, _width, _height, 
											fd.topLeft,
											fd.topRight,
											fd.bottomLeft,
											fd.bottomRight);
			this.graphics.endFill();
			//
			// set scale 9 grid
			var scaleSize:Number = Math.max(fd.topLeft, fd.topRight, fd.bottomLeft, fd.bottomRight);
			if(scaleSize > 0 && _width > 2 * scaleSize && _height > 2 * scaleSize)
			{
				this.scale9Grid = new Rectangle(scaleSize, scaleSize,
												_width - 2 * scaleSize,
												_height - 2 * scaleSize);
			}
			else
			{
				this.scale9Grid = null;
			}
			//
			/* set filter */
			if(fd.glowAlpha != 0 && fd.glowBlur != 0)
			{
				var gf:GlowFilter = new GlowFilter(fd.glowColor, fd.glowAlpha,
													fd.glowBlur, fd.glowBlur,
													fd.glowStrength, 3);
				this.filters = [gf];
			}
			else
			{
				this.filters = [];
			}
		}
	}
}