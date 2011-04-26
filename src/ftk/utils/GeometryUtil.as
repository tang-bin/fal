// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.utils
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * GeometryUtil
	 *
	 * @author Tang Bin
	 * @since old version
	 */
	public class GeometryUtil
	{

		/**
		 * Get a new Size which is geometric proportion zoom in/out from a given size object.
		 * @param oldSize Given size object.
		 * @param areaSize A area, the new Size is limited in this area after zoom in/out.
		 * @param enableZoomout Zoom out the size or not when the given area is lager than the given size.
		 * @return Array object.
		 */
		public static function getLockScaleSize(oldWidth:Number, oldHeight:Number, areaWidth:Number, areaHeight:Number, enableZoomout:Boolean = true):Array
		{
			var rate:Number = Math.min(areaWidth / oldWidth, areaHeight / oldHeight);
			if (!enableZoomout && rate > 1)
			{
				rate = 1;
			}
			return [oldWidth * rate, oldHeight * rate];
		}

		/**
		 * Get the slope from one point to another point.
		 * @param start
		 * @param end
		 * @return
		 */
		public static function getSlope(start:Point, end:Point):Number
		{
			var angle:Number = Math.atan((end.y - start.y) / (end.x - start.x));
			angle = 180 * angle / Math.PI;
			if (angle >= 0 && end.x <= start.x && end.y <= start.y)
			{
				angle -= 180;
			}
			else if (angle < 0 && end.x < start.x && end.y > start.y)
			{
				angle += 180;
			}
			return angle;
		}

		/**
		 * Get a new control point of 2 points.
		 * @param p1 One point, start point.
		 * @param p2 Another point, end point.
		 * @param type The position of the control, at the left/right of vector p1p2.
		 * @param degress The degree of (p1, control point) and (p2, control point).
		 * @return
		 */
		public static function accountControlPoint(p1:Point, p2:Point, type:String, degree:Number):Point
		{
			if (!MathUtil.checkNumArea(degree, 0, 180, false, false))
			{
				return new Point((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
			}
			var c:Point = new Point();
			//
			var len:Number = Math.sqrt(Math.pow(p1.x + p2.x, 2) + Math.pow(p1.y + p2.y, 2));

			var center:Point = new Point();
			center.x = (p1.x + p2.x) / 2;
			center.y = (p1.y + p2.y) / 2;

			var offset:Number = (len / 2) / Math.tan((degree * Math.PI / 180) / 2);

			var offsetX:Number = (p2.y - p1.y) * offset / len;
			var offsetY:Number = (p2.x - p1.x) * offset / len;
			if (type == "right")
			{
				c.x = center.x - offsetX;
				c.y = center.y + offsetY;
			}
			else
			{
				c.x = center.x + offsetX;
				c.y = center.y - offsetY;
			}
			return c;
		}

		/**
		 * Given one or more rectangle(s), find a rectangle than contains all the given rectangle(s).
		 * 
		 * @param list A array in which each item is a rectangle.
		 * @return 
		 * 
		 */
		public static function accountArea(list:Array):Rectangle
		{
			if (list.length > 0)
			{
				var rect:Rectangle = list[0] as Rectangle;
				var minX:Number = rect.x;
				var minY:Number = rect.y;
				var maxX:Number = rect.x + rect.width;
				var maxY:Number = rect.y + rect.height;
				for (var i:Number = list.length ; --i >= 0 ; )
				{
					var v:Rectangle = list[i] as Rectangle;
					if (v.x < minX)
					{
						minX = v.x;
					}
					if (v.y < minY)
					{
						minY = v.y;
					}
					if (v.x + v.width > maxX)
					{
						maxX = v.x + v.width;
					}
					if (v.y + v.height > maxY)
					{
						maxY = v.y + v.height;
					}
				}
				var r:Rectangle = new Rectangle(minX, minY, maxX - minX, maxY - minY);
				return r;
			}
			else
			{
				return null;
			}
		}

		/**
		 * Account distance between 2 points.
		 * @param p1
		 * @param p2
		 * @return 
		 */
		public static function getDistance(p1:Point, p2:Point):Number
		{
			var n:Number = Math.pow((p1.x - p2.x), 2) + Math.pow((p1.y - p2.y), 2);
			return Math.sqrt(n);
		}
	}
}