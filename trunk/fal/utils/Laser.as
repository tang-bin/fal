package fas.utils
{
	import fas.math.Color;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Laser extends Sprite
	{
		private var lines:Sprite;
		private var img:Bitmap;
		private var xx:Number;
		private var yy:Number;
		private var flashTimer:Timer;
		
		public function Laser(bitmap:Bitmap, offsetX:Number, offsetY:Number)
		{
			super();
			img = bitmap;
			xx = offsetX;
			yy = offsetY;
			//
			lines = new Sprite();
			this.addChild(lines);
			//
			this.addChild(img);
			img.x = xx;
			img.y = yy;
			//
			drawLines();
		}
		
		private function drawLines():void
		{
			removeLines();
			//
			var bd:BitmapData = img.bitmapData;
			for(var i:uint = 0 ; i < bd.width ; i+=2)
			{
				for(var j:uint = 0 ; j < bd.height ; j+=2)
				{
					if(Color.color32IsViewable(bd.getPixel32(i, j)))
					{
						var line:Shape = new Shape();
						line.graphics.lineStyle(0, bd.getPixel(i, j), 0.2);
						line.graphics.moveTo(0, 0);
						line.graphics.lineTo( - i - xx, - j - yy);
						line.x = i + xx;
						line.y = j + yy;
						lines.addChild(line);
					}
				}
			}
			if(flashTimer == null)
			{
				flashTimer = new Timer(50);
				flashTimer.addEventListener(TimerEvent.TIMER, flashHandler);
				flashTimer.start();
			}
		}
		
		private function flashHandler(e:TimerEvent):void
		{
			for(var i:Number = lines.numChildren - 1 ; --i >= 0 ;)
			{
				var line:Shape = lines.getChildAt(i) as Shape;
				line.alpha += ((Math.random() - 0.5) * 0.2);
				//
				if(line.alpha > 0.5)line.alpha = 0.4;
				else if(line.alpha < 0)line.alpha = 0.1;
			}
		}
		
		private function removeLines():void
		{
			for(var i:Number = lines.numChildren - 1 ; --i >= 0 ;)
			{
				lines.removeChild(lines.getChildAt(i));
			}
		}
	}
}