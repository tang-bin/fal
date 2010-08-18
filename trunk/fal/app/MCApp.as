package fal.app 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * @author Finalbug
	 * @since 1.0
	 */
	public class MCApp extends MovieClip
	{
		
		private var ww:Number;
		private var hh:Number;
		
		public function MCApp() 
		{
			super();
			ww = stage.stageWidth;
			hh = stage.stageHeight;
			stage.addEventListener(Event.RESIZE, resizeStageHandler);
		}
		
		private function resizeStageHandler(e:Event):void
		{
		
		}
	}
}