/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.framework.layout
{
	import flash.display.DisplayObject;
	
	import flashx.textLayout.formats.BaselineOffset;
	
	import org.finalbug.core.data.Position;
	import org.finalbug.core.utils.DataUtil;
	import org.finalbug.ui.control.UIObject;
	import org.finalbug.ui.errors.UIError;
	import org.finalbug.ui.style.LayoutStyle;
	
	/**
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since 2010.10
	 */	
	public class Container extends UIObject
	{
		public function Container()
		{
			super();
			this.setLayout(new LayoutStyle());
			this.setLayoutValue("width", "100%");
			this.setLayoutValue("height", "100%");
		}
		
		/**
		 * 
		 * @param space
		 * @param center
		 * @param measureAfterRank
		 */
		public function horizontalRank(space:Number = 0,
									   center:Boolean = true,
									   measureAfterRank:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			var currentX:Number = space;
			var maxHeight:Number = 0;
			for(var i:uint = 0 ; i < totalNum ; i++)
			{
				var target:DisplayObject = this.getChildAt(i);
				target.x = currentX;
				target.y = 0;
				currentX += target.width + space;
				if(target.height > maxHeight) maxHeight = target.height;
			}
			if(center)
			{
				for(var j:uint = 0 ; j < totalNum ; j++)
				{
					var target2:DisplayObject = this.getChildAt(j);
					target2.y = (maxHeight - target2.height) / 2;
				}
			}
			if(measureAfterRank)
			{
				measure(space, 0);
			}
		}
		
		/**
		 * 
		 * @param space
		 * @param center
		 * @param measureAfterRank
		 * 
		 */		
		public function verticalRank(space:Number = 0,
									 center:Boolean = true,
									 measureAfterRank:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			var currentY:Number = space;
			var maxWidth:Number = 0;
			for(var i:uint = 0 ; i < totalNum ; i++)
			{
				var target:DisplayObject = this.getChildAt(i);
				target.y = currentY;
				target.x = 0;
				currentY += target.height + space;
				if(target.width > maxWidth) maxWidth = target.width;
			}
			if(center)
			{
				for(var j:uint = 0 ; j < totalNum ; j++)
				{
					var target2:DisplayObject = this.getChildAt(j);
					target2.y = (maxWidth - target2.width) / 2;
				}
			}
			if(measureAfterRank)
			{
				measure(0, space);
			}
		}
		
		/**
		 * 
		 * @param xSpace
		 * @param ySpace
		 * @param updateViewAfterMeasure
		 * 
		 */		
		public function measure(xSpace:Number = 0, ySpace:Number = 0, updateViewAfterMeasure:Boolean = false):void
		{
			var maxWidth:Number = 0;
			var maxHeight:Number = 0;
			for(var i:uint = this.numChildren ; --i >= 0 ;)
			{
				var obj:DisplayObject = this.getChildAt(i);
				maxWidth = Math.max(maxWidth, obj.x + obj.width);
				maxHeight = Math.max(maxHeight, obj.y + obj.height);
			}
			maxWidth += xSpace;
			maxHeight += ySpace;
			this.displayWidth = maxWidth;
			this.displayHeight = maxHeight;
			//
			if(updateViewAfterMeasure)
			{
				this.updateView();
			}
		}
	}
}