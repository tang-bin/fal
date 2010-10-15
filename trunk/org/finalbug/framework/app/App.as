/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.framework.app
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.finalbug.core.display.Bin;
	import org.finalbug.debugger.Debug;
	import org.finalbug.debugger.Debugger;
	import org.finalbug.errors.AppError;
	import org.finalbug.framework.layout.Container;
	import org.finalbug.ui.glazes.Flat;
	
	/**
	 * org.finalbug.fal.app.App
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class App extends Bin
	{
		public static var DEBUG:Boolean = false;
		
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
		
		public static function get application():App
		{
			return App._app;
		}
		
		private var bgLayer:Flat; // index 0
		private var container:Container;
		private var alertLayer:Bin; // index 2, 1 is this(app)
		private var tipLayer:Bin; // index 3
		private var debugLayer:Bin; // index 4
		
		private static var _app:App;
		
		public function App(enableDebug:Boolean = false)
		{
			super();
			App.DEBUG = enableDebug
			App._app = this;
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
			container = new Container();
			stage.addChild(container);
			//
			alertLayer = new Bin();
			stage.addChild(alertLayer);
			Alert.container = alertLayer;
			//
			tipLayer = new Bin();
			stage.addChild(tipLayer);
			Tooltip.container = tipLayer;
			//
			if(DEBUG)
			{
				debugLayer = new Bin();
				//debugLayer.mouseChildren = debugLayer.mouseEnabled = false;
				stage.addChild(debugLayer);
				Debug.debugger = new Debugger();
				Debug.debugger.container = debugLayer;
			}
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
			container.refresh();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return container.addChild(child);
		}
		
		override public function addAll(...args):void
		{
			var len:uint = args.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				var obj:DisplayObject = args[i] as DisplayObject;
				container.addChild(obj);
			}
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return container.addChildAt(child, index);
		}
		
		override public function removeAll():void
		{
			container.removeAll();
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return container.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			return container.removeChildAt(index);
		}
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			container.setChildIndex(child, index);
		}
		
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			container.swapChildren(child1, child2);
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			container.swapChildrenAt(index1, index1);
		}
	}
}