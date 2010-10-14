/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.faltester.tester
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import org.finalbug.core.data.SetType;
	import org.finalbug.core.display.Bin;
	import org.finalbug.core.events.MotionEvent;
	import org.finalbug.core.motion.FadeMotion;
	import org.finalbug.core.motion.MotionQueue;
	import org.finalbug.core.motion.MoveMotion;
	import org.finalbug.debugger.Debug;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.UIObject;
	
	
	/******************************************
	 * org.finalbug.faltester.tester.MotionTester
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 *****************************************/
	public class MotionTester extends UIObject
	{
		/****************************************
		 *
		 * DEFINE
		 *
		 ****************************************/
		
		private var container:Bin;
		
		/****************************************
		 *
		 * GETTER & SETTER
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * org.finalbug.faltester.tester.MotionTester constructor.
		 *
		 ****************************************/
		public function MotionTester()
		{
			super();
		}
		
		/****************************************
		 *
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 *
		 ****************************************/
		
		override protected function callAtAdded():void
		{
			var btn:Button = new Button("start");
			this.addAll(btn);
			btn.tooltip = "test";
			btn.addEventListener(MouseEvent.CLICK, clickBtnHandler);
			//
			var mq:MotionQueue = new MotionQueue();
			var m:MoveMotion = new MoveMotion(btn);
			m.xTo = 200;
			m.yTo = 300;
			//
			var f:FadeMotion = new FadeMotion(btn);
			f.alphaTo = 0;
			//
			mq.addMotion(m);
			mq.addMotion(f);
			//
			mq.start(SetType.CONCURRENT);
			mq.addEventListener(MotionEvent.MOTION_STOP, stopHandler);
		}
		
		/****************************************
		 *
		 * PUBLIC
		 *
		 ****************************************/
		
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
		
		private function startTest(total:uint):void
		{
			var t:int = flash.utils.getTimer();
			var list:Object = new Object();
			for(var i:uint = 0 ; i < total ; i++)
			{
				var bin:Bin = new Bin();
				bin.graphics.beginFill(0, 0.8);
				bin.graphics.drawRect(0, 0, 2, 2);
				bin.graphics.endFill();
				container.addAll(bin);
				bin.moveTo(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
			}
			Debug.log(total, flash.utils.getTimer() - t);
		}
		
		/****************************************
		 *
		 * HANDLER
		 *
		 ****************************************/
		
		private function clickBtnHandler(e:MouseEvent):void
		{
			if(container == null)
			{
				container = new Bin();
				this.addAll(container);
			}
			else
			{
				container.removeAll();
			}
			startTest(1000);
		}
		
		private function stopHandler(e:MotionEvent):void
		{
			trace("enddd");
		}
	}
}