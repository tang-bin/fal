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
package ftk.widgets
{
	import ftk.controls.Label;
	import ftk.errors.DataError;
	import ftk.graphs.Flat;
	import ftk.style.FillStyle;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	/**
	 * Tooltip
	 *  
	 * @author Tang Bin
	 * @since old version
	 */
	public class Tooltip
	{
		/**
		 * 
		 * @throws DataError
		 */
		public function Tooltip()
		{
			throw new DataError(DataError.STATIC_CLASS);
		}

		/**
		 * time delay before show tooltip. in millisecond.
		 * 
		 * @default 500
		 */
		public static var showDelay:Number = 1000;

		/**
		 * Remove tooltip after shown time, in millisecond.
		 * 0 means do not remove automatically.
		 * 
		 * @default 0.
		 */
		public static var removeDelay:Number = 0;

		/**
		 * border color of tooltip.
		 */
		public static var borderColor:uint = 0x000000;

		/**
		 * border alpha of tooltip.
		 */
		public static var borderAlpha:Number = 1;

		/**
		 * background color of tooltip.
		 */
		public static var bgColor:uint = 0xFFFFE1;

		/**
		 * background alpha of tooltip.
		 */
		public static var bgAlpha:Number = 1;

		/**
		 * text font of tooltip.
		 */
		public static var textFont:String = "Arial";

		/**
		 * text size of tooltip in pixel.
		 */
		public static var textSize:Number = 12;

		/**
		 * text color of tooltip.
		 */
		public static var textColor:uint = 0x333333;

		/**
		 * text bold or not of tooltip.
		 */
		public static var textBold:Boolean = false;

		// container of tooltip, will be added to stage when shown.
		private static var box:Sprite;

		// background
		private static var bg:Flat;

		// text label.
		private static var txt:Label;

		// owner's stage will be used to add tooltip.
		private static var owner:DisplayObject;

		// text string to shown.
		private static var text:String;

		// timer of show delay.
		private static var showTimer:Timer;

		// timer of remove delay.
		private static var removeTimer:Timer;

		private static function get bgFillStyle():FillStyle
		{
			var fs:FillStyle = new FillStyle();
			fs.borderColor = borderColor;
			fs.bgAlpha = bgAlpha;
			fs.bgColor = bgColor;
			fs.borderAlpha = borderAlpha;
			fs.glowAlpha = 0;
			fs.shadowAlpha = 0.1;
			return fs;
		}

		private static function get textFormat():TextFormat
		{
			var tf:TextFormat = new TextFormat(Tooltip.textFont, textSize, textColor, textBold);
			return tf;
		}

		/**
		 * 
		 * @param owner Owner's stage will be used to add tooltip in.
		 * @param str Text string will be shown.
		 */
		public static function show(owner:DisplayObject, str:String):void
		{
			Tooltip.owner = owner;
			Tooltip.text = str;
			//
			cleanTimer();
			//
			if (Tooltip.showDelay > 0)
			{
				showTimer = new Timer(Tooltip.showDelay, 1);
				showTimer.addEventListener(TimerEvent.TIMER, showDelayTimerHandler);
				showTimer.start();
			}
			else
			{
				runShowTip();
			}
		}

		/**
		 * Remove tooltip.
		 */
		public static function remove():void
		{
			cleanTimer();
			if (box != null && box.stage != null && box.stage.contains(box))
			{
				owner.stage.removeChild(box);
				owner.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMoveHandler);
			}
			box = null;
		}

		private static function runShowTip():void
		{
			if (owner != null && owner.stage != null)
			{
				owner = owner;
				createTip();
				showTip(text);
				if (removeDelay > 0)
				{
					removeTimer = new Timer(removeDelay, 1);
					removeTimer.addEventListener(TimerEvent.TIMER, removeDelayTimerHandler);
					removeTimer.start();
				}
			}
		}

		private static function cleanTimer():void
		{
			if (showTimer != null && showTimer.running)
			{
				showTimer.stop();
			}
			if (removeTimer != null && removeTimer.running)
			{
				removeTimer.stop();
			}
			showTimer = null;
			removeTimer = null;
		}

		private static function createTip():void
		{
			// remove tip if exist.
			if (box != null && owner.stage.contains(box))
			{
				owner.stage.removeChild(box);
				box = null;
			}
			// create tip box.
			box = new Sprite();
			owner.stage.addChild(box);
			//
			bg = new Flat(10, 10, bgFillStyle);
			box.addChild(bg);
			//
			txt = new Label("", textFormat);
			box.addChild(txt);
			txt.x = 2;
			//
			box.visible = false;
		}

		private static function showTip(str:String):void
		{
			if (box != null)
			{
				txt.text = str;
				bg.width = txt.width + 4;
				bg.height = txt.height;
				box.visible = true;
				setBoxPosition();
				owner.stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMoveHandler);
			}
		}

		private static function setBoxPosition():void
		{
			if (box != null && box.stage != null && box.stage.contains(box))
			{
				box.x = box.stage.mouseX + 10;
				box.y = box.stage.mouseY + 20;
				//
				if (box.x + box.width > box.stage.stageWidth)
				{
					box.x = box.stage.stageWidth - box.width;
				}
				if (box.y + box.height > box.stage.stageHeight)
				{
					box.y = box.stage.stageHeight - box.height;
				}
			}
		}

		private static function stageMoveHandler(e:MouseEvent):void
		{
			setBoxPosition();
			e.updateAfterEvent();
		}

		private static function showDelayTimerHandler(e:TimerEvent):void
		{
			runShowTip();
		}

		private static function removeDelayTimerHandler(e:TimerEvent):void
		{
			remove();
		}
	}
}