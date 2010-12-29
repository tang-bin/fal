/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/
package org.finalbug.ui.widgets
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.finalbug.data.AlertData;
	import org.finalbug.errors.UIError;
	import org.finalbug.ui.Bin;
	import org.finalbug.ui.control.ButtonOld;
	import org.finalbug.ui.control.Label;
	
	/**
	 * Alert
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Alert
	{
		public static var alertList:Array = new Array();
		public static var container:Bin
		
		private static var alertSP:Sprite;
		private static var bg:Sprite;
		private static var txt:Label;
		private static var yesBtn:ButtonOld;
		private static var noBtn:ButtonOld;
		private static var cancelBtn:ButtonOld;
		
		private static var currentData:AlertData;
		
		public static function show(owner:DisplayObject, data:AlertData):void
		{
			if(container == null)
			{
				throw new UIError(UIError.DISPLAY_OBJECT_NULL);
			}
			//
			if(currentData != null)
			{
				Alert.alertList.push(data);
			}
			else
			{
				currentData = data;
				if(alertSP != null && container.contains(alertSP))
				{
					Alert.setAlertView();
				}
				else
				{
					Alert.createAlert();
				}
			}
		}
		
		public static function remove():void
		{
			if(currentData.yesFunction != null)
			{
				yesBtn.removeEventListener(MouseEvent.CLICK, currentData.yesFunction);
			}
			if(currentData.noFunction != null)
			{
				noBtn.removeEventListener(MouseEvent.CLICK, currentData.noFunction);
			}
			if(currentData.cancelFunction != null)
			{
				cancelBtn.removeEventListener(MouseEvent.CLICK, currentData.cancelFunction);
			}
			//
			if(alertList.length > 0)
			{
				currentData = alertList.shift();
				Alert.setAlertView();
			}
			else
			{
				alertSP.visible = false;
				currentData = null;
			}
		}
		
		private static function createAlert():void
		{
			alertSP = new Sprite;
			container.addChild(alertSP);
			//
			bg = new Sprite();
			alertSP.addChild(bg);
			bg.graphics.beginFill(0, 0.8);
			bg.graphics.drawRect(0, 0, 100, 100);
			bg.graphics.endFill();
			//
			var tf:TextFormat = new TextFormat("Arial", 14, 0xFFFFFF, true);
			txt = new Label("", tf);
			alertSP.addChild(txt);
			//
			yesBtn = new ButtonOld();
			alertSP.addChild(yesBtn);
			yesBtn.addEventListener(MouseEvent.CLICK, removeHandler);
			//
			noBtn = new ButtonOld();
			alertSP.addChild(noBtn);
			noBtn.addEventListener(MouseEvent.CLICK, removeHandler);
			//
			cancelBtn = new ButtonOld();
			alertSP.addChild(cancelBtn);
			cancelBtn.addEventListener(MouseEvent.CLICK, removeHandler);
			//
			container.addEventListener(Event.RESIZE, resizeHandler);
			//
			setAlertView();
		}
		
		private static function removeHandler(e:MouseEvent):void
		{
			Alert.remove();
		}
		
		private static function setAlertView():void
		{
			bg.width = container.stage.stageWidth;
			bg.height = container.stage.stageHeight;
			//
			txt.text = currentData.label;
			txt.x = (bg.width - txt.width) / 2;
			txt.y = (bg.height - txt.height) / 2;
			//
			var showBtns:Array = new Array();
			var totalWidth:Number = 0;
			if(currentData.showYes)
			{
				yesBtn.visible = true;
				yesBtn.label = currentData.yesLabel;
				if(currentData.yesFunction != null)
				{
					yesBtn.addEventListener(MouseEvent.CLICK, currentData.yesFunction);
				}
				showBtns.push(yesBtn);
				totalWidth += yesBtn.width;
			}
			else
			{
				yesBtn.visible = false;
			}
			if(currentData.showNo)
			{
				noBtn.visible = true;
				noBtn.label = currentData.noLabel;
				if(currentData.noFunction != null)
				{
					noBtn.addEventListener(MouseEvent.CLICK, currentData.noFunction);
				}
				showBtns.push(noBtn);
				totalWidth += noBtn.width;
			}
			else
			{
				noBtn.visible = false;
			}
			if(currentData.showCancel)
			{
				cancelBtn.visible = true;
				cancelBtn.label = currentData.cancelLabel;
				if(currentData.cancelFunction != null)
				{
					cancelBtn.addEventListener(MouseEvent.CLICK, currentData.cancelFunction);
				}
				showBtns.push(cancelBtn);
				totalWidth += cancelBtn.width;
			}
			else
			{
				cancelBtn.visible = false;
			}
			//
			totalWidth += (showBtns.length - 1) * 20;
			var startX:Number = (bg.width - totalWidth) / 2;
			for(var i:int = 0 ; i < showBtns.length ; i++)
			{
				var btn:ButtonOld = showBtns[i] as ButtonOld;
				btn.x = startX;
				startX += btn.width + 20;
				btn.y = txt.y + txt.height + 20;
			}
			//
			alertSP.visible = true;
			//container.toFront();
		}
		
		private static function resizeHandler(e:Event):void
		{
			if(alertSP != null && container.contains(alertSP))
			{
				setAlertView();
			}
		}
	}
}