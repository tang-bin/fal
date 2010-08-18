package fal.data
{
	import fal.errors.UIError;
	
	/**
	 * This class defines a size object which is maked up by width and height.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class Size
	{
		private var w:Number = 100;
		private var h:Number = 100;
		
		/**
		 * size's width, in pels.
		 * 
		 * @throws fal.errors.DisplayError When the width is less than 0, throw WIDTH_LESS_THAN_ZERO error.
		 */		
		public function get width():Number
		{
			return w;
		}
		public function set width(value:Number):void
		{
			if(value < 0)
			{
				throw new UIError(UIError.WIDTH_LESS_THAN_ZERO);
			}
			w = value;
		}
		
		/**
		 * size's height,in pels.
		 * 
		 * @throws fal.errors.DisplayError When the height is less than 0, throw HEIGHT_LESS_THAN_ZERO error.
		 */	
		public function get height():Number
		{
			return h;
		}
		public function set height(value:Number):void
		{
			if(value < 0)
			{
				throw new UIError(UIError.HEIGHT_LESS_THAN_ZERO);
			}
			h = value;
		}
		
		/**
		 * The area of this size.
		 */		
		public function get area():Number
		{
			return w * h;
		}
		
		/**
		 * create a new Size objcet whit a new width and height.
		 * 
		 * @param width 
		 * @param height 
		 * 
		 * @throws fal.errors.DisplayError If width is less than 0, throw WIDTH_LESS_THAN_ZERO error.
		 * @throws fal.errors.DisplayError if height is less than 0, throw HEIGHT_LESS_THAN_ZERO error.
		 */		
		public function Size(width:Number = 0, height:Number = 0):void
		{
			if(width < 0)
			{
				throw new UIError(UIError.WIDTH_LESS_THAN_ZERO);
			}
			if(height < 0)
			{
				throw new UIError(UIError.HEIGHT_LESS_THAN_ZERO);
			}
			w = width;
			h = height;
		}
		
		/**
		 * @param width
		 * @param height
		 */		
		public function setSize(width:Number, height:Number):void
		{
			this.width = width;
			this.height = height;
		}
		
		/**
		 * @param size
		 */		
		public function applySize(size:Size):void
		{
			this.width = size.width;
			this.height = size.height;
		}
		
		public function setScale(rate:Number):void
		{
			if(rate > 0)
			{
				w *= rate;
				h *= rate;
			}
		}
		
		/**
		 * clone a new size with the same width and height as current one.
		 * @return A new Size.
		 */		
		public function clone():Size
		{
			return new Size(w, h);
		}
		
		public function toString():String
		{
			return "(width=" + w + ", height=" + h + ")";
		}
		
		public function equalTo(newSize:Size):Boolean
		{
			return w == newSize.width && h == newSize.height;
		}
	}
}