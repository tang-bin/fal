////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * This class offers some useful method to operate display object.
	 * 
	 * @author		Tang Bin
	 * @since		2012.12-1
	 */
	public class DisplayUtil
	{
		/**
		 * Get target display object's center point.
		 * 
		 * @param target
		 * @return center point.
		 */
		public static function getCenterPoint(target:DisplayObject):Point
		{
			if (target != null)
			{
				var xx:Number = (2 * target.x + target.width) / 2;
				var yy:Number = (2 * target.y + target.height) / 2;
				return new Point(xx, yy);
			}
			return null;
		}

		/**
		 * Exchange target display object to the top in its parent's contain tree.
		 * 
		 * @param target
		 */
		public static function toFront(target:DisplayObject):void
		{
			var p:DisplayObjectContainer = target.parent;
			if (p != null)
			{
				p.setChildIndex(target, p.numChildren - 1);
			}
		}
	}
}