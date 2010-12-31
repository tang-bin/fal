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
package org.finalbug.ui.widgets
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.finalbug.ui.Bin;
	import org.finalbug.ui.control.Label;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.style.FillStyle;
	
	/**
	 * app.Tooltip
	 *  
	 * @author Tang Bin
	 * @since old version
	 */	
	public class Tooltip
	{
		/**
		 * 
		 * @default 
		 */
		public static var showDelay:Number = 500;
		/**
		 * 
		 * @default 
		 */
		public static var removeDelay:Number = 0;
		/**
		 * 
		 * @default 
		 */
		public static var container:Bin

		private static var box:Sprite;
		private static var bg:Flat;
		private static var txt:Label;
		
		/**
		 * 
		 * @param str
		 */
		public static function show(str:String):void
		{
			if(box == null)
			{
				createTip();
			}
			showTip(str);
		}
		
		/**
		 * 
		 */
		public static function remove():void
		{
			if(box != null)
			{
				box.visible = false;
				container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMoveHandler);
			}
		}
		
		private static function createTip():void
		{
			if(container != null)
			{
				box = new Sprite();
				container.addChild(box);
				//
				var fs:FillStyle = new FillStyle();
				fs.borderColor = 0x990000;
				fs.bgAlpha = 1;
				fs.bgColor = 0xFFE1E1;
				fs.glowAlpha = 0;
				fs.shadowAlpha = 0.5;
				bg = new Flat(10, 10, fs);
				box.addChild(bg);
				//
				var tf:TextFormat = new TextFormat("Verdana", 12, 0x333333);
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
			setBoxPosition();
			container.stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMoveHandler);
		}
		
		private static function stageMoveHandler(e:MouseEvent):void
		{
			setBoxPosition();
			e.updateAfterEvent();
		}
		
		private static function setBoxPosition():void
		{
			if(box != null && container.contains(box) && box.visible)
			{
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
			}
		}
	}
}