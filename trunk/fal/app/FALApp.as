/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.app
{
	import fal.debuger.Debugger;
	import fal.display.Bin;
	import fal.display.Flat;
	import fal.errors.FALError;
	import fal.utils.Alert;
	import fal.utils.Tooltip;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class FALApp extends Bin
	{
		override public function get width() : Number
		{
			return Math.max(stage.stageWidth, minWidth);
		}
		override public function set width(value:Number) : void
		{
			debug(FALError.APP_WIDTH_UNCHANGEABLE);
		}
		
		override public function set height(value:Number) : void
		{
			debug(FALError.APP_HEIGHT_UNCHANGEABLE);
		}
		override public function get height() : Number
		{
			return Math.max(stage.stageHeight, minHeight);
		}
		
		public static function get application():FALApp
		{
			return FALApp._app;
		}
		
		private var bgLayer:Flat; // index 0
		private var alertLayer:Bin; // index 2, 1 is this(app)
		private var tipLayer:Bin; // index 3
		private var debugLayer:Bin; // index 4
		
		private static var _app:FALApp;
		
		public function FALApp()
		{
			super();
			FALApp._app = this;
			//
			stage.scaleMode = "noScale";
			stage.align = "TL";
			if(this.stage == null || this.parent != stage)
			{
				throw new Error(FALError.APP_NOT_ROOT);
			}
			//
			bgLayer = new Flat(this.width, this.height);
			stage.addChild(bgLayer);
			stage.setChildIndex(bgLayer, 0);
			//
			alertLayer = new Bin();
			stage.addChild(alertLayer);
			Alert.container = alertLayer;
			//
			tipLayer = new Bin();
			stage.addChild(tipLayer);
			Tooltip.container = tipLayer;
			//
			debugLayer = new Bin();
			stage.addChild(debugLayer);
			Debugger.container = debugLayer;
			//
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		override protected function updateView():void
		{
			bgLayer.width = this.displayWidth;
			bgLayer.height = this.displayHeight;
		}
		
		private function resizeHandler(e:Event):void
		{
			this.resize(stage.stageWidth, stage.stageHeight);
		}
	}
}