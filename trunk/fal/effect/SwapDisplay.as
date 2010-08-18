package fal.effect
{
	import fal.effect.swapdata.SwapData;
	import fal.utils.AdvancedObject;
	
	import flash.display.DisplayObject;
	
	public class SwapDisplay extends AdvancedObject
	{
		private static var sd:SwapDisplay;
		private static var instanceable:Boolean = false;
		
		public static function get instance():SwapDisplay
		{
			if(sd == null)
			{
				instanceable = true;
				sd = new SwapDisplay();
				instanceable = false;
			}
			return sd;
		}
		
		public function SwapDisplay()
		{
			if(!instanceable)
			{
				throw new Error("Cannot be instanced");
			}
		}
		
		public function swap(showObject:DisplayObject,
							 hideObject:DisplayObject = null,
							 swapData:SwapData = null):void
		{
			if(hideObject != null)
			{
				
			}
		}
	}
}