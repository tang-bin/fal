package fal.utils
{
	import fal.data.FillData;
	import fal.display.Bin;
	import fal.display.Flat;
	import fal.style.styles.FillStyle;
	import fal.ui.Label;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;

	public class Tooltip
	{
		public static var showDelay:Number = 500;
		public static var removeDelay:Number = 0;
		public static var container:Bin;

		private static var box:Sprite;
		private static var bg:Flat;
		private static var txt:Label;
		
		public static function show(str:String):void
		{
			if(box == null)
			{
				createTip();
			}
			showTip(str);
		}
		
		public static function remove():void
		{
			if(box != null)
			{
				box.visible = false;
			}
		}
		
		private static function createTip():void
		{
			if(container != null)
			{
				box = new Sprite();
				container.addChild(box);
				//
				var style:FillStyle = new FillStyle();
				style.borderColor = 0x990000;
				style.bgColor = 0xFFE1E1;
				style.glowAlpha = 0;
				bg = new Flat(10, 10, style);
				box.addChild(bg);
				//
				var tf:TextFormat = new TextFormat("Arial", 12, 0x333333);
				txt = new Label("", tf);
				box.addChild(txt);
				txt.x = 2;
				//
				box.visible = false;
			}
		}
		
		private static function showTip(str:String):void
		{
			txt.text = str;
			bg.width = txt.width + 4;
			bg.height = txt.height;
			box.visible = true;
			//
			box.x = container.stage.mouseX + 10;
			box.y = container.stage.mouseY + 20;
			//
			if(box.x + box.width > container.stage.stageWidth)
			{
				box.x = container.stage.stageWidth - box.width;
			}
			if(box.y + box.height > container.stage.stageHeight)
			{
				box.y = container.stage.stageHeight - box.height;
			}
			//container.toFront();
		}
	}
}