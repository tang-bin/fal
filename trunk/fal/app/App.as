package fas.app
{
	import fas.ui.UIObject;
	import fas.utils.Alert;
	import fas.utils.Tooltip;
	
	import flash.events.Event;

	/**
	 * Class App is base class to create Application using FOS .
	 * 
	 * @author Finalbug
	 * @since 0.4
	 */	
	public class App extends UIObject
	{
		public var minWidth:Number = 400;
		public var minHeight:Number = 300;
		
		override public function get width() : Number
		{
			return Math.max(stage.stageWidth, minWidth);
		}
		override public function set width(value:Number) : void
		{
			trace("App's width cannot be set.");
		}
		
		override public function set height(value:Number) : void
		{
			trace("App's height cannot be set.");
		}
		override public function get height() : Number
		{
			return Math.max(stage.stageHeight, minHeight);
		}
		
		public function App()
		{
			super();
			stage.scaleMode = "noScale";
			stage.align = "TL";
			if(this.parent != stage)
			{
				throw new Error("Class App must be used as ROOT object.");
			}
			Alert.stage = stage;
			Tooltip.stage = stage;
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		private function resizeHandler(e:Event):void
		{
			this.resize();
		}
	}
}