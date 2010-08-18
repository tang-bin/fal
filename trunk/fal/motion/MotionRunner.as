package fas.motion
{
	import fas.errors.FOSError;
	import fas.events.MotionEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Class MotionRunner carry out in singular mode to hand all motions.
	 * during runtime, MotionRunner will create only one timer to do the motion effect.
	 * each motion will be register here to take effect. 
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class MotionRunner
	{
		private static var mr:MotionRunner;
		private static var instanceable:Boolean = false;
		
		private var motionList:Object = new Object();
		
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
		
		public function MotionRunner()
		{
			if(!instanceable)
			{
				throw new FOSError(FOSError.canNotInstance);
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
		public function register(target:*, value:String, steps:Array, time:uint = 1, motionClass:Motion = null):String
		{
			var data:RegMotionData = new RegMotionData(target, value, steps);
			data.time = time;
			data.motionClass = motionClass;
			motionList[data.name] = data;
			return data.name;
		}
		
		public function stopAndRemoveMotion(motionName:String):void
		{
			if(motionList[motionName] != null)
			{
				motionList[motionName] = null;
				delete motionList[motionName];
			}
		}
		
		private function motionTimerHandler(e:TimerEvent):void
		{
			for each(var d:RegMotionData in motionList)
			{
				var str:String = "[" + d.name + "]";
				if(d.steps.length != 0)
				{
					str += " " + d.steps.length;
					var val:* = d.steps.shift();
					d.copySteps.push(val);
					d.target[d.value] = val;
				}
				else
				{
					str += " end time = " + d.time;
					if(d.time == 0)
					{
						d.steps = d.copySteps;
						d.copySteps = new Array();
					}
					else
					{
						var n:String = d.name;
						var data:RegMotionData = motionList[n] as RegMotionData;
						if(data.motionClass != null)
						{
							var ee:MotionEvent = new MotionEvent(MotionEvent.MOTION_STOP);
							data.motionClass.dispatchEvent(ee);
						}
						motionList[n] = null;
						delete motionList[n];
					}
				}
				trace(str, motionList[d.name] == null);
			}
			e.updateAfterEvent();
		}
	}
}

	import fas.utils.Charset;
	import fas.motion.Motion;
	
class RegMotionData
{
	public var name:String;
	public var target:*;
	public var value:String;
	public var steps:Array;
	public var copySteps:Array;
	public var time:uint;
	
	public var motionClass:Motion;
	
	public function RegMotionData(target:*, value:String, steps:Array)
	{
		this.target = target;
		this.value = value;
		this.steps = steps;
		this.name = "motion_" + this.target + "_" + value + "_"+ Charset.getRandomString();
		this.copySteps = new Array();
	}
}