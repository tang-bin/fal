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
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * This class offers some useful method to operate display object.
	 * 
	 * @author Tang Bin
	 * @since old version
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