/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.core.draw
{
	import org.finalbug.data.CubeData;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * Class Graph offers the methods to draw a graph.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class Graph
	{
		/**
		 * Draw a cube in target display object.
		 * 
		 * @param sp
		 * @param cubeData
		 */		
		public static function drawCube(target:Sprite, cubeData:CubeData):void
		{
			var top:Sprite = new Sprite();
			target.addChild(top);
			var front:Sprite = new Sprite();
			target.addChild(front);
			var side:Sprite = new Sprite();
			target.addChild(side);
			//
			// draw front
			front.graphics.beginFill(cubeData.frontColor, 1);
			front.graphics.drawRect(0, 0, cubeData.width, cubeData.height);
			front.graphics.endFill();
			//
			// set top and side.
			top.graphics.clear();
			top.graphics.beginFill(cubeData.topColor, 1);
			top.graphics.moveTo(0, 0);
			side.graphics.clear();
			side.graphics.beginFill(cubeData.sideColor, 1);
			side.graphics.lineTo(0, 0);
			//
			if(cubeData.lean == CubeData.LEAN_RIGHT)
			{
				// draw top
				top.graphics.lineTo(cubeData.width, 0);
				top.graphics.lineTo(cubeData.width - cubeData.thickness, cubeData.thickness);
				top.graphics.lineTo(-cubeData.thickness, cubeData.thickness);
				top.graphics.lineTo(0, 0);
				top.graphics.endFill();
				// draw side
				side.graphics.lineTo(0, -cubeData.height);
				side.graphics.lineTo(-cubeData.thickness, -cubeData.height + cubeData.thickness);
				side.graphics.lineTo(-cubeData.thickness, cubeData.thickness);
				side.graphics.lineTo(0, 0);
				side.graphics.endFill();
				// set position
				top.x = 0;
				top.y = -cubeData.height;
				front.x = -cubeData.thickness;
				front.y = -cubeData.height + cubeData.thickness;
				side.x = cubeData.width;
				side.y = 0;
			}
			else
			{
				// draw top
				top.graphics.lineTo(cubeData.width, 0);
				top.graphics.lineTo(cubeData.width + cubeData.thickness, cubeData.thickness);
				top.graphics.lineTo(cubeData.thickness, cubeData.thickness);
				top.graphics.lineTo(0, 0);
				top.graphics.endFill();
				// draw side
				side.graphics.lineTo(0, -cubeData.height);
				side.graphics.lineTo(cubeData.thickness, -cubeData.height + cubeData.thickness);
				side.graphics.lineTo(cubeData.thickness, cubeData.thickness);
				side.graphics.lineTo(0, 0);
				side.graphics.endFill();
				// set position
				top.x = 0;
				top.y = -cubeData.height;
				front.x = cubeData.thickness;
				front.y = -cubeData.height + cubeData.thickness;
				side.x = side.y = 0;
			}
		}
		
		public static function drawLucidRectangle(target:DisplayObject):void
		{
			if(target.hasOwnProperty("graphics"))
			{
				target["graphics"].clear();
				target["graphics"].beginFill(0, 0);
				target["graphics"].drawRect(0, 0, 10, 10);
				target["graphics"].endFill();
			}
		}
	}
}