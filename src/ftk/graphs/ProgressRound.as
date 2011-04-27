// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.graphs
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import ftk.display.Graph;
	import ftk.utils.DrawUtil;


	/**
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class ProgressRound extends Graph
	{
		/**
		 * 
		 */
		public function ProgressRound()
		{
			super();
			bg = new Sprite();
			this.addChild(bg);
			front = new Sprite();
			this.addChild(front);
			drawRound();
		}

		private var radius:Number = 20;

		private var backColor:Number = 0x990000;

		private var frontColor:Number = 0x333333;

		private var glowColor:Number = 0;

		private var whitRate:Boolean = true;

		private var rate:Number = 0;

		private var runTimer:Timer;

		private var bg:Sprite;

		private var front:Sprite;

		/**
		 * 
		 * @param radius
		 * @param backColor
		 * @param frontColor
		 * @param glowColor
		 */
		public function setRoundStyle(radius:Number, backColor:Number, frontColor:Number, glowColor:Number):void
		{
			this.radius = radius;
			this.backColor = backColor;
			this.frontColor = frontColor;
			this.glowColor = glowColor;
			drawRound();
		}

		/**
		 * 
		 * @param rate
		 */
		public function showProgress(rate:Number):void
		{
			whitRate = true;
			this.rate = rate;
			setRate();
		}

		/**
		 * 
		 */
		public function showRun():void
		{
			whitRate = false;
			if (runTimer != null)
			{
				runTimer.stop();
			}
			rate = 0;
			runTimer = new Timer(20);
			runTimer.addEventListener(TimerEvent.TIMER, runTimerHandler);
			runTimer.start();
			drawRound();
		}

		private function runTimerHandler(e:TimerEvent):void
		{
			rate += 0.02;
			setRate();
			if (rate >= 1)
			{
				var tmp:Number = backColor;
				backColor = frontColor;
				frontColor = tmp;
				rate = 0;
				drawRound();
			}
			e.updateAfterEvent();
		}

		private function setRate():void
		{
			front.graphics.clear();
			front.graphics.beginFill(frontColor, 1);
			DrawUtil.drawSector(front.graphics, -90, 360 * rate - 90, radius);
			front.graphics.endFill();
			//
			var blur:Number = 20 * (1 - Math.abs(rate - 0.5));
			var gf:GlowFilter = new GlowFilter(glowColor, 0.5, blur, blur);
			bg.filters = [gf];
		}

		private function drawRound():void
		{
			bg.graphics.clear();
			bg.graphics.beginFill(backColor, 1);
			bg.graphics.drawCircle(0, 0, radius);
			bg.graphics.endFill();
		}
	}
}