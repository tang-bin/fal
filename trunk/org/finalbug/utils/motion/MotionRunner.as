//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.utils.motion
{
	import org.finalbug.errors.DataError;
	import org.finalbug.events.MotionEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Class MotionRunner carry out in singular mode to hand all motions.
	 * during runtime, MotionRunner will create only one timer to do the motion effect.
	 * each motion will be register here to take effect. 
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class MotionRunner
	{
		private static var mr:MotionRunner;
		private static var instanceable:Boolean = false;
		
		private var motionList:Object = new Object();
		
		/**
		 * 
		 * @return 
		 */
		public static function get instance():MotionRunner
		{
			if(mr == null)
			{
				instanceable = true;
				mr = new MotionRunner();
				instanceable = false;
			}
			return mr;
		}
		
		/**
		 * 
		 * @throws DataError
		 */
		public function MotionRunner()
		{
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
			else
			{
				var timer:Timer = new Timer(Motion.INTERVAL);
				timer.addEventListener(TimerEvent.TIMER, motionTimerHandler);
				timer.start();
			}
		}
		
		/**
		 * Register a new moting.
		 * 
		 * @param target Motion object.
		 * @param value Motion value, specific parameter which will be changed during moting.
		 * @param steps Motion steps array.
		 * 
		 * @return The name of new moting event. 
		 */		
		public function register(target:*, value:String, steps:Array, times:uint = 1, motionClass:Motion = null):String
		{
			var data:MotionData = new MotionData(target, value, steps, times, motionClass);
			motionList[data.name] = data;
			//
			target[value] = steps[0];
			//
			return data.name;
		}
		
		/**
		 * 
		 * @param motionName
		 */
		public function stopAndRemoveMotion(motionName:String):void
		{
			if(motionList[motionName] != null)
			{
				motionList[motionName] = null;
				delete motionList[motionName];
			}
		}
		
		/**
		 * core method of motion. All displayObject's attributes are modified at here.
		 * 
		 * @param e
		 */		
		private function motionTimerHandler(e:TimerEvent):void
		{
			for each(var d:MotionData in motionList)
			{
				if(d.steps.length != 0)
				{
					// get next step value
					var val:* = d.steps.shift();
					// copySteps save the array of step. for re-motion.
					d.copySteps.push(val);
					d.target[d.value] = val;
					// dispath motion running event
					if(d.motionClass != null)
					{
						var runningEvent:MotionEvent = new MotionEvent(MotionEvent.MOTION_RUNNING);
						runningEvent.motionTarget = d.target;
						d.motionClass.dispatchEvent(runningEvent);
					}
				}
				else
				{
					// one loop is end.
					if(d.times == 0)
					{
						// if motion continues 
						d.steps = d.copySteps;
						d.copySteps = new Array();
					}
					else
					{
						var n:String = d.name;
						if(d.motionClass != null)
						{
							d.motionClass._running = false;
							var stopEvent:MotionEvent = new MotionEvent(MotionEvent.MOTION_STOP);
							stopEvent.motionTarget = d.target;
							stopEvent.motion = d.motionClass;
							d.motionClass.dispatchEvent(stopEvent);
						}
						motionList[n] = null;
						delete motionList[n];
					}
				}
			}
			e.updateAfterEvent();
		}
	}
}

	import org.finalbug.utils.motion.Motion;
	
class MotionData
{
	/**
	 * 
	 * @default 
	 */
	public static var nameCount:uint = 0;
	
	/**
	 * 
	 * @default 
	 */
	public var name:String;
	/**
	 * 
	 * @default 
	 */
	public var target:*;
	/**
	 * 
	 * @default 
	 */
	public var value:String;
	/**
	 * 
	 * @default 
	 */
	public var steps:Array;
	/**
	 * 
	 * @default 
	 */
	public var copySteps:Array;
	/**
	 * 
	 * @default 
	 */
	public var times:uint;
	
	/**
	 * 
	 * @default 
	 */
	public var motionClass:Motion;
	
	/**
	 * 
	 * @param target
	 * @param value
	 * @param steps
	 * @param times
	 * @param cls
	 */
	public function MotionData(target:*, value:String, steps:Array, times:uint = 1, cls:Motion = null)
	{
		this.target = target;
		this.value = value;
		this.steps = steps;
		this.name = "_motion" + (nameCount++).toString();
		this.times = times;
		this.motionClass = cls;
		this.copySteps = new Array();
	}
}