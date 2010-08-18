package fal.math
{
	import fal.data.Size;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Geometry
	{
		/**
		 * Get a new Size which is geometric proportion zoom in/out from a given size object.
		 * @param oldSize Given size object.
		 * @param areaSize A area, the new Size is limited in this area after zoom in/out.
		 * @param enableZoomout Zoom out the size or not when the given area is lager than the given size.
		 * @return New Size object.
		 */		
		public static function getLockScaleSize(oldSize:Size, areaSize:Size, enableZoomout:Boolean = true):Size
		{
			var rate:Number = Math.min(areaSize.width / oldSize.width, areaSize.height / oldSize.height);
			if(!enableZoomout && rate > 1)
			{
				rate = 1;
			}
			var s:Size = oldSize.clone();
			s.setScale(rate);
			return s;
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
			if(angle >= 0 && end.x <= start.x && end.y <= start.y)
			{
				angle -= 180;
			}
			else if(angle < 0 && end.x < start.x && end.y > start.y)
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
			if(!Arith.checkNumArea(degree, 0, 180, false, false))
			{
				return new Point((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
			}
			var c:Point = new Point();
			//
			var len:Number = Math.sqrt(Math.pow(p1.x + p2.x, 2) + Math.pow(p1.y + p2.y, 2));
			
			var center:Point = new Point();
			center.x = (p1.x + p2.x) / 2;
			center.y = (p1.y + p2.y) / 2;
			
			var offset:Number = (len / 2) / Math.tan((degree * Math.PI/180) / 2);
			
			var offsetX:Number = (p2.y - p1.y) * offset / len;
			var offsetY:Number = (p2.x - p1.x) * offset / len;
			if(type == "right")
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
			if(list.length > 0)
			{
				var minX:Number = list[0].x;
				var minY:Number = list[0].y;
				var maxX:Number = list[0].x + list[0].width;
				var maxY:Number = list[0].y + list[0].height;
				for(var i:Number = list.length ; --i >= 0 ; )
				{
					var v:* = list[i];
					if(v.x < minX)
					{
						minX = v.x;
					}
					if(v.y < minY)
					{
						minY = v.y;
					}
					if(v.x + v.width > maxX)
					{
						maxX = v.x + v.width;
					}
					if(v.y + v.height > maxY)
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