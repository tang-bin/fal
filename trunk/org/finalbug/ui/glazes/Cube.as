//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.glazes
{
	import org.finalbug.ui.Glaze;
	import org.finalbug.utils.ColorUtil;

	/**
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Cube extends Glaze
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		override public function get width():Number
		{
			return _width + _depth;
		}
		override public function set width(value:Number):void
		{
			_width = value - _depth;
			drawCube();
		}
		
		override public function get height():Number
		{
			return _height + _depth;
		}
		override public function set height(value:Number):void
		{
			_height = value - _depth;
			drawCube();
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var _width:Number;
		private var _height:Number;
		private var _depth:Number;
		private var _color:uint;
		private var _inner:Boolean = false;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get sideHeight():Number
		{
			return _height;
		}
		/**
		 * 
		 * @return 
		 */
		public function get sideWidth():Number
		{
			return _width;
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 * @param width
		 * @param height
		 * @param depth
		 * @param color
		 * @param inner
		 */
		public function Cube(width:Number, height:Number, depth:Number, color:uint, inner:Boolean = false)
		{
			super();
			_width = width;
			_height = height;
			_depth = depth;
			_color = color;
			_inner = inner;
			drawCube();
		}
		
		private function drawCube():void
		{
			this.graphics.clear();
			if(_inner)
			{
				drawBottom();
				drawLeft();
				drawBack();
			}
			else
			{
				drawRight();
				drawFront();
				drawTop();
			}
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function drawBottom():void
		{
			this.graphics.beginFill(ColorUtil.offsetColor(_color, 40), 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(_depth, -_depth);
			this.graphics.lineTo(_depth + _width, -_depth);
			this.graphics.lineTo(_width, 0);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		private function drawLeft():void
		{
			this.graphics.beginFill(ColorUtil.offsetColor(_color, -40), 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(0, -_height);
			this.graphics.lineTo(_depth, -_height - _depth);
			this.graphics.lineTo(_depth, -_depth);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		private function drawRight():void
		{
			this.graphics.beginFill(ColorUtil.offsetColor(_color, 40), 1);
			this.graphics.moveTo(_width, 0);
			this.graphics.lineTo(_width, -_height);
			this.graphics.lineTo(_depth + _width, -_height - _depth);
			this.graphics.lineTo(_depth + _width, -_depth);
			this.graphics.lineTo(_width, 0);
			this.graphics.endFill();
		}
		
		private function drawBack():void
		{
			this.graphics.beginFill(_color, 1);
			this.graphics.moveTo(_depth, -_depth);
			this.graphics.lineTo(_depth, -_height - _depth);
			this.graphics.lineTo(_depth + _width, -_height - _depth);
			this.graphics.lineTo(_depth + _width, -_depth);
			this.graphics.lineTo(_depth, -_depth);
			this.graphics.endFill();
		}
		
		private function drawFront():void
		{
			this.graphics.beginFill(_color, 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(0, -_height);
			this.graphics.lineTo(_width, -_height);
			this.graphics.lineTo(_width, 0);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		private function drawTop():void
		{
			this.graphics.beginFill(ColorUtil.offsetColor(_color, -40), 1);
			this.graphics.moveTo(0, -_height);
			this.graphics.lineTo(_depth, -_depth - _height);
			this.graphics.lineTo(_depth + _width, -_depth - _height);
			this.graphics.lineTo(_width, - _height);
			this.graphics.lineTo(0, - _height);
			this.graphics.endFill();
		}
		
		//#######################################
		// HANDLER
		//#######################################
	}
}