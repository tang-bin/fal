/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.draw
{
	import fal.errors.UIError;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * This class offers some methods to draw a track.
	 * Draw track means no fill and line style will be set here, there are "lineTo" and "moveTo" only.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	public class Track
	{
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
		public static function drawTriangle(target:Sprite, 
											center:Point,
											width:Number,
											height:Number,
											point:String = "right"):void
		{
			var x:Number = center.x;
			var y:Number = center.y;
			if(point == "up")
			{
				with(target.graphics)
				{
					moveTo(x, y - height / 2);
					lineTo(x - width / 2, y + height / 2);
					lineTo(x + width / 2, y + height / 2);
				}
			}
			else if(point == "down")
			{
				with(target.graphics)
				{
					moveTo(x - width / 2, y - height / 2);
					lineTo(x + width / 2, y - height / 2);
					lineTo(x, y + height / 2);
				}
			}
			else if(point == "left")
			{
				with(target.graphics)
				{
					moveTo(x - width / 2, y);
					lineTo(x + width / 2, y - height / 2);
					lineTo(x + width / 2, y + height / 2);
				}
			}
			else
			{
				target.graphics.moveTo(x - width / 2, y - height / 2);
				target.graphics.lineTo(x + width / 2, y);
				target.graphics.lineTo(x - width / 2, y + height / 2);
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
		public static function drawCrose(target:Sprite, center:Point, radius:Number):void
		{
			if(target != null)
			{
				target.graphics.moveTo(center.x - radius / 2, center.y - radius / 2);
				target.graphics.lineTo(center.x + radius / 2, center.y + radius / 2);
				target.graphics.moveTo(center.x + radius / 2, center.y - radius / 2);
				target.graphics.lineTo(center.x - radius / 2, center.y + radius / 2);
			}
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
		public static function drawFillRing(target:Sprite, center:Point, innerRadius:Number, outerRadius:Number):void
		{
			if(target != null)
			{
				if(innerRadius >= outerRadius)
				{
					throw new UIError(UIError.OUT_LESS_THAN_INNER);
				}
				var x:Number = center.x;
				var y:Number = center.y;
				var ir:Number = innerRadius;
				var or:Number = outerRadius;
				//
				target.graphics.moveTo(x, y - ir);
				target.graphics.curveTo(x - ir, y - ir, x - ir, y);
				target.graphics.curveTo(x - ir, y + ir, x, y + ir);
				target.graphics.lineTo(x, y + or);
				target.graphics.curveTo(x - or, y + or, x - or, y);
				target.graphics.curveTo(x - or, y - or, x, y - or);
				target.graphics.curveTo(x + or, y - or, x + or, y);
				target.graphics.curveTo(x + or, y + or, x, y + or);
				target.graphics.lineTo(x, y + ir);
				target.graphics.curveTo(x + ir, y + ir, x + ir, y);
				target.graphics.curveTo(x + ir, y - ir, x, y - ir);
			}
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
		public static function drawTick(target:Sprite, point:Point, size:Number):void
		{
			if(target != null)
			{
				target.graphics.moveTo(point.x - 1, point.y + size / 2 +1);
				target.graphics.lineTo(point.x, point.y + size / 2);
				target.graphics.lineTo(point.x + size / 2, point.y + size - 1);
				target.graphics.lineTo(point.x + size + 1, point.y);
			}
		}
		
		/**
		 * Draw a big arrow.
		 * 
		 * @param target
		 * @param width
		 * @param height
		 * 
		 */		
		public static function drawBigArrow(target:Sprite, width:Number, height:Number):void
		{
			if(target != null)
			{
				with(target.graphics)
				{
					moveTo(width / 2 - height, - height / 2);
					lineTo(width / 2, 0);
					lineTo(width / 2 - height, height / 2);
					lineTo(width / 2 - height , height / 4);
					lineTo(- width / 2, height / 4);
					lineTo(- width / 2, - height / 4);
					lineTo(width / 2 - height, - height / 4);
				}
			}
		}
		
		public static function drawSector(target:Sprite, fromAngle:Number, toAngle:Number, radius:Number):void
		{
			if(target != null)
			{
				if(fromAngle > toAngle)
				{
					var tmp:Number = fromAngle;
					fromAngle = toAngle;
					toAngle = tmp;
				}
				target.graphics.moveTo(0, 0);
				for( ; fromAngle <= toAngle ; fromAngle += 1)
				{
					var xx:Number = Math.cos(fromAngle * Math.PI / 180) * radius;
					var yy:Number = Math.sin(fromAngle * Math.PI / 180) * radius;
					target.graphics.lineTo(xx, yy);
				}
				target.graphics.lineTo(0, 0);
			}
		}
	}
}