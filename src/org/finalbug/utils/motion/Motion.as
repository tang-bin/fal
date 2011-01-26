// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.utils.motion
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.finalbug.data.DataModel;
	import org.finalbug.events.MotionEvent;

	/**
	 * Class Motion is the superclass of all motion classes such as move and fade.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Motion extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		/**
		 * 
		 * @default 
		 */
		public static const INTERVAL:Number = 30;

		/**
		 * 
		 * @default 
		 */
		public var during:uint = 300;

		// motion will be done during this time, in millisecond.
		/**
		 * 
		 * @default 
		 */
		public var delayTime:Number = 0;

		/**
		 * 
		 * @default 
		 */
		protected var targetList:Array;

		// list of display objects
		/**
		 * 
		 * @default 
		 */
		protected var times:uint = 1;

		/**
		 * 
		 * @default 
		 */
		protected var getBack:Boolean = false;

		/**
		 * 
		 * @default 
		 */
		protected var registeredMotions:Array;

		/**
		 * 
		 * @default 
		 */
		protected var counter:MotionCounter;

		internal var _running:Boolean = false;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * 
		 * @return 
		 */
		public function get running():Boolean
		{
			return _running;
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 * @param target
		 */
		public function Motion(target:Object = null)
		{
			if (target != null)
			{
				targetList = [target];
			}
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Start motion play.
		 * 
		 * @param targets List of display objects which will run the motion.
		 * @param back Play back after motion end.
		 * @param time Play times.
		 */
		public function start(targets:Array = null, counter:MotionCounter = null, getBack:Boolean = false, times:uint = 1):void
		{
			if (targets != null)
			{
				targetList = targets;
			}
			this.counter = counter == null ? new MotionCounter() : counter;
			if (targetList != null && targetList.length > 0)
			{
				this.getBack = getBack;
				this.times = times;
				registeredMotions = new Array();
				//
				if (delayTime > 0)
				{
					var delayTimer:Timer = new Timer(delayTime, 1);
					delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startAccount);
					delayTimer.start();
				}
				else
				{
					startAccount();
				}
			}
		}

		/**
		 * Stop motion(s).
		 */
		public function stop():void
		{
			registeredMotions.forEach(stopMotion);
		}

		/******************* PROTECTED *************************************************/
		/**
		 * account method dont need complete in Class Motion
		 * @param target
		 */
		protected function count(target:Object):void
		{
		}

		/**
		 * 
		 * @param steps
		 * @return 
		 */
		protected function repeatSteps(steps:Array):Array
		{
			if (times != 1)
			{
				var back:Boolean = false;
				var s1:Array = steps.concat();
				var s2:Array = steps.concat().reverse();
				for (var i:Number = (times == 0 ? 2 : times) ; --i > 0 ;)
				{
					back = getBack ? !back : false;
					steps = steps.concat(back ? s2 : s1);
				}
			}
			return steps;
		}

		/******************* PRIVATE ***************************************************/
		private function startAccount(e:* = null):void
		{
			for (var i:Number = 0 ; i < targetList.length ; i++)
			{
				count(targetList[i]);
				this._running = true;
				var startEvent:MotionEvent = new MotionEvent(MotionEvent.MOTION_START);
				startEvent.motionTarget = targetList[i];
				this.dispatchEvent(startEvent);
			}
		}

		private function stopMotion(element:*, index:int, arr:Array):void
		{
			MotionRunner.instance.stopAndRemoveMotion(element);
			this._running = false;
		}
		/******************* PRIVATE ***************************************************/
	}
}