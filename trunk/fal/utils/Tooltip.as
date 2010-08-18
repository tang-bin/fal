package fal.utils
{
	import fal.data.FillData;
	import fal.ui.Label;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextFormat;

	public class Tooltip
	{
		public static var showDelay:Number = 500;
		public static var removeDelay:Number = 0;
		public static var stage:Stage;

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
			if(stage != null)
			{
				box = new Sprite();
				stage.addChild(box);
				//
				var fd:FillData = new FillData(false);
				fd.borderColor = 0x990000;
				fd.bodyColor = 0xFFE1E1;
				fd.glowAlpha = 0;
				bg = new Flat(10, 10, fd);
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
			stage.setChildIndex(box, stage.numChildren - 1);
			//
			box.x = stage.mouseX + 10;
			box.y = stage.mouseY + 20;
			//
			if(box.x + box.width > stage.stageWidth)
			{
				box.x = stage.stageWidth - box.width;
			}
			if(box.y + box.height > stage.stageHeight)
			{
				box.y = stage.stageHeight - box.height;
			}
		}
	}
}