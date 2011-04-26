// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.utils
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import ftk.data.CubeData;


	/**
	 * DrawUtil
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class DrawUtil
	{

		/**
		 * Draw a cube in target display object.
		 * 
		 * @param sp
		 * @param cubeData
		 */
		public static function drawCube(g:Graphics, cubeData:CubeData):void
		{
			g.clear();
			var xOffset:Number = 0;
			var yOffset:Number = 0;
			//
			if (cubeData.lean == CubeData.LEAN_RIGHT)
			{
				// draw top
				xOffset = 0;
				yOffset = -cubeData.height;
				g.beginFill(cubeData.topColor, 1);
				g.moveTo(0 + xOffset, 0 + yOffset);
				g.lineTo(cubeData.width + xOffset, 0 + yOffset);
				g.lineTo(cubeData.width - cubeData.thickness + xOffset, cubeData.thickness + yOffset);
				g.lineTo(-cubeData.thickness + xOffset, cubeData.thickness + yOffset);
				g.lineTo(0 + xOffset, 0 + yOffset);
				g.endFill();
				// draw front
				xOffset = -cubeData.thickness;
				yOffset = -cubeData.height + cubeData.thickness;
				g.beginFill(cubeData.frontColor, 1);
				g.drawRect(0 + xOffset, 0 + yOffset, cubeData.width, cubeData.height);
				g.endFill();
				// draw side
				xOffset = cubeData.width;
				yOffset = 0;
				g.beginFill(cubeData.sideColor, 1);
				g.moveTo(0 + xOffset, 0 + yOffset);
				g.lineTo(0 + xOffset, -cubeData.height + yOffset);
				g.lineTo(-cubeData.thickness + xOffset, -cubeData.height + cubeData.thickness + yOffset);
				g.lineTo(-cubeData.thickness + xOffset, cubeData.thickness + yOffset);
				g.lineTo(0 + xOffset, 0 + yOffset);
				g.endFill();
			}
			else
			{
				// draw top
				xOffset = 0;
				yOffset = -cubeData.height;
				g.beginFill(cubeData.topColor, 1);
				g.moveTo(0 + xOffset, 0 + yOffset);
				g.lineTo(cubeData.width + xOffset, 0);
				g.lineTo(cubeData.width + cubeData.thickness + xOffset, cubeData.thickness + yOffset);
				g.lineTo(cubeData.thickness + xOffset, cubeData.thickness + yOffset);
				g.lineTo(0 + xOffset, 0 + yOffset);
				g.endFill();
				// draw front
				xOffset = cubeData.thickness;
				yOffset = -cubeData.height + cubeData.thickness;
				g.beginFill(cubeData.frontColor, 1);
				g.drawRect(0 + xOffset, 0 + yOffset, cubeData.width, cubeData.height);
				g.endFill();
				// draw side
				xOffset = 0;
				yOffset = 0;
				g.beginFill(cubeData.sideColor, 1);
				g.moveTo(0 + xOffset, 0 + yOffset);
				g.lineTo(0 + xOffset, -cubeData.height + yOffset);
				g.lineTo(cubeData.thickness + xOffset, -cubeData.height + cubeData.thickness + yOffset);
				g.lineTo(cubeData.thickness + xOffset, cubeData.thickness + yOffset);
				g.lineTo(0 + xOffset, 0 + yOffset);
				g.endFill();
			}
		}

		/**
		 * 
		 * @param g
		 * @param size
		 * @param color
		 * @param alpha
		 */
		public static function drawBlock(g:Graphics, size:Number = 10, color:uint = 0, alpha:Number = 0):void
		{
			g.clear();
			g.beginFill(color, alpha);
			g.drawRect(0, 0, size, size);
			g.endFill();
		}

		/**
		 * Draw a triangle.
		 * First, there will be a rectangle with center point and width and height.
		 * Then, draw a triangle, take top side center point,
		 * bottom left and bottom right point as triangle's 3 points.
		 * So, this method draw a isoscelestriangle.
		 * 
		 * @param target
		 * @param center
		 * @param width
		 * @param height
		 * @param point
		 */
		public static function drawTriangle(g:Graphics, center:Point, width:Number, height:Number, point:String = "right"):void
		{
			var x:Number = center.x;
			var y:Number = center.y;
			if (point == "up")
			{
				g.moveTo(x, y - height / 2);
				g.lineTo(x - width / 2, y + height / 2);
				g.lineTo(x + width / 2, y + height / 2);
			}
			else if (point == "down")
			{
				g.moveTo(x - width / 2, y - height / 2);
				g.lineTo(x + width / 2, y - height / 2);
				g.lineTo(x, y + height / 2);
			}
			else if (point == "left")
			{
				g.moveTo(x - width / 2, y);
				g.lineTo(x + width / 2, y - height / 2);
				g.lineTo(x + width / 2, y + height / 2);
			}
			else
			{
				g.moveTo(x - width / 2, y - height / 2);
				g.lineTo(x + width / 2, y);
				g.lineTo(x - width / 2, y + height / 2);
			}
		}

		/**
		 * Draw a crose.
		 * 
		 * @param target
		 * @param center
		 * @param radius
		 * 
		 */
		public static function drawCrose(g:Graphics, center:Point, radius:Number):void
		{
			g.moveTo(center.x - radius / 2, center.y - radius / 2);
			g.lineTo(center.x + radius / 2, center.y + radius / 2);
			g.moveTo(center.x + radius / 2, center.y - radius / 2);
			g.lineTo(center.x - radius / 2, center.y + radius / 2);
		}

		/**
		 * Draw a ring
		 * 
		 * @param sp
		 * @param center
		 * @param innerRadius
		 * @param outerRadius
		 * 
		 */
		public static function drawFillRing(g:Graphics, center:Point, innerRadius:Number, outerRadius:Number):void
		{
			var x:Number = center.x;
			var y:Number = center.y;
			var ir:Number = innerRadius;
			var or:Number = outerRadius;
			//
			g.moveTo(x, y - ir);
			g.curveTo(x - ir, y - ir, x - ir, y);
			g.curveTo(x - ir, y + ir, x, y + ir);
			g.lineTo(x, y + or);
			g.curveTo(x - or, y + or, x - or, y);
			g.curveTo(x - or, y - or, x, y - or);
			g.curveTo(x + or, y - or, x + or, y);
			g.curveTo(x + or, y + or, x, y + or);
			g.lineTo(x, y + ir);
			g.curveTo(x + ir, y + ir, x + ir, y);
			g.curveTo(x + ir, y - ir, x, y - ir);
		}

		/**
		 * Draw a tick.
		 * this tick will be drawn in a foursquare area.
		 * point parameter defines the top left point of the foursquare area.
		 * and size is the side length of the area.
		 * 
		 * @param target
		 * @param point
		 * @param size
		 * 
		 */
		public static function drawTick(g:Graphics, point:Point, size:Number):void
		{
			g.moveTo(point.x - 1, point.y + size / 2 + 1);
			g.lineTo(point.x, point.y + size / 2);
			g.lineTo(point.x + size / 2, point.y + size - 1);
			g.lineTo(point.x + size + 1, point.y);
		}

		/**
		 * Draw a big arrow.
		 * 
		 * @param target
		 * @param width
		 * @param height
		 * 
		 */
		public static function drawBigArrow(g:Graphics, width:Number, height:Number):void
		{
			g.moveTo(width / 2 - height, - height / 2);
			g.lineTo(width / 2, 0);
			g.lineTo(width / 2 - height, height / 2);
			g.lineTo(width / 2 - height, height / 4);
			g.lineTo(- width / 2, height / 4);
			g.lineTo(- width / 2, - height / 4);
			g.lineTo(width / 2 - height, - height / 4);
		}

		/**
		 * 
		 * @param g
		 * @param fromAngle
		 * @param toAngle
		 * @param radius
		 */
		public static function drawSector(g:Graphics, fromAngle:Number, toAngle:Number, radius:Number):void
		{
			if (fromAngle > toAngle)
			{
				var tmp:Number = fromAngle;
				fromAngle = toAngle;
				toAngle = tmp;
			}
			g.moveTo(0, 0);
			for ( ; fromAngle <= toAngle ; fromAngle += 1)
			{
				var xx:Number = Math.cos(fromAngle * Math.PI / 180) * radius;
				var yy:Number = Math.sin(fromAngle * Math.PI / 180) * radius;
				g.lineTo(xx, yy);
			}
			g.lineTo(0, 0);
		}
	}
}