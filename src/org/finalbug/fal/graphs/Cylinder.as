////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.graphs
{
	import flash.display.GradientType;
	
	import org.finalbug.fal.utils.ColorUtil;
	
	import spark.primitives.Graphic;


	/**
	 * 
	 * @author		Tang Bin
	 * @since		2012.12-1
	 */
	public class Cylinder extends Graphic
	{
		/**
		 * 
		 * @param width
		 * @param height
		 * @param radius
		 * @param color
		 */
		public function Cylinder(width:Number, height:Number, radius:Number, color:uint)
		{
			super();
			ww = width;
			hh = height;
			rr = radius;
			cc = color;
			//
			drawCylinder();
		}

		private var ww:Number;

		private var hh:Number;

		private var rr:Number;

		private var cc:uint;

		private function drawCylinder():void
		{
			this.graphics.clear();
			this.graphics.beginGradientFill(GradientType.LINEAR, [ColorUtil.offsetColor(cc, -20), ColorUtil.offsetColor(cc, 20)], [1, 1], [0, 0xFF]);
			// this.graphics.beginFill(cc, 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(0, -hh);
			this.graphics.lineTo(ww, -hh);
			this.graphics.lineTo(ww, 0);
			this.graphics.curveTo(ww * 4 / 5, rr, ww / 2, rr);
			this.graphics.curveTo(ww / 5, rr, 0, 0);
			// this.graphics.curveTo(ww / 2, rr * 2, 0, 0);
			this.graphics.endFill();
			//
			this.graphics.beginFill(ColorUtil.offsetColor(cc, 40), 1);
			this.graphics.drawEllipse(0, -hh - rr, ww, rr * 2);
			this.graphics.endFill();
		}
	}
}