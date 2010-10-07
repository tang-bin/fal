/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.fal.app
{
	import flash.events.Event;
	
	import org.finalbug.fal.debugger.Debug;
	import org.finalbug.fal.debugger.Debugger;
	import org.finalbug.fal.display.Bin;
	import org.finalbug.fal.errors.AppError;
	import org.finalbug.fal.glazes.Flat;
	
	/**
	 * org.finalbug.fal.app.FALApp
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class FALApp extends Bin
	{
		override public function get width() : Number
		{
			return Math.max(stage.stageWidth, minWidth);
		}
		override public function set width(value:Number) : void
		{
		}
		
		override public function set height(value:Number) : void
		{
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
				throw new Error(AppError.APP_NOT_ROOT);
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
			//debugLayer.mouseChildren = debugLayer.mouseEnabled = false;
			stage.addChild(debugLayer);
			//
			Debug.debugger = new Debugger();
			Debug.debugger.container = debugLayer;
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