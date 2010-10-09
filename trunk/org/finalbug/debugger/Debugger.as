/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.debugger
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import org.finalbug.core.display.Bin;
	import org.finalbug.ui.control.Label;
	
	/**
	 * org.finalbug.fal.debugger.Debugger
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class Debugger
	{
		/****************************************
		 * 
		 * DEFINE
		 * 
		 ****************************************/
		private const SHOW_HEIGHT:Number = 200;
		private const HIDE_HEIGHT:Number = 20;
		
		private var _container:Bin;
		
		private var bg:Shape;
		private var showIcon:Label;
		private var title:Label;
		
		private var shown:Boolean = false;
		
		/****************************************
		 * 
		 * GETTER & SETTER
		 * 
		 ****************************************/
		
		public function set container(value:Bin):void
		{
			_container = value;
			init();
		}
		
		/****************************************
		 * 
		 * OVERRIDE METHODS
		 * 
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 * 
		 ****************************************/
		
		/****************************************
		 * 
		 * PUBLIC
		 * 
		 ****************************************/
		
		public function log(...args):void
		{
		}
		
		/****************************************
		 * 
		 * PROTECTED
		 * 
		 ****************************************/
		
		/****************************************
		 * 
		 * PRIVATE
		 * 
		 ****************************************/
		
		private function init():void
		{
			if(_container != null)
			{
				bg = new Shape();
				bg.graphics.beginFill(0, 1);
				bg.graphics.drawRect(0, 0, 10, 10);
				bg.graphics.endFill();
				bg.width = _container.stage.stageWidth;
				bg.height = HIDE_HEIGHT;
				bg.alpha = 0.1
				//
				showIcon = new Label("↑");
				showIcon.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 3, 3)];
				showIcon.x = 10;
				showIcon.y = (HIDE_HEIGHT - showIcon.height) / 2;
				showIcon.addEventListener(MouseEvent.CLICK, clickShowHandler);
				//
				title = new Label("Debugger");
				title.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 3, 3)];
				//
				_container.addAll(bg, showIcon, title);
				_container.stage.addEventListener(Event.RESIZE, resizeStageHandler);
				//
				resetPosition();
			}
		}
		
		private function resetPosition():void
		{
			var sw:Number = _container.stage.stageWidth;
			var sh:Number = _container.stage.stageHeight;
			if(shown)
			{
				bg.height = SHOW_HEIGHT;
			}
			else
			{
				bg.height = HIDE_HEIGHT;
			}
			bg.width = sw;
			title.x = (sw - title.width) / 2;
			title.y = (HIDE_HEIGHT - title.height) / 2;
			_container.moveTo(0, shown ? sh - SHOW_HEIGHT : sh - HIDE_HEIGHT);
		}
		
		/****************************************
		 * 
		 * HANDLER
		 * 
		 ****************************************/
		
		private function resizeStageHandler(e:Event):void
		{
			resetPosition();
		}
		
		private function clickShowHandler(e:MouseEvent):void
		{
			this.shown = !this.shown;
			showIcon.text = shown ? "↓" : "↑";
			bg.alpha = shown ? 0.4 : 0.1;
			resetPosition();
		}
	}
}