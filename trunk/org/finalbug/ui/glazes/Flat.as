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
			_fillStyle.fill(this, displayWidth, displayHeight);
		}
	}
}