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
package org.finalbug.ui.widgets
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	import org.finalbug.data.AlertData;
	import org.finalbug.data.Language;
	import org.finalbug.errors.DataError;
	import org.finalbug.errors.UIError;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.Label;
	import org.finalbug.utils.DrawUtil;

	/**
	 * Alert
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Alert
	{

		// ******************* OVERRIDE *****************************
		// ******************* DEFINE *******************************
		/**
		 * 
		 * @default 
		 */
		public static var alertList:Array = new Array();

		private static var alertContainer:Sprite;

		private static var bg:Sprite;

		private static var txt:Label;

		private static var yesBtn:Button;

		private static var noBtn:Button;

		private static var cancelBtn:Button;

		private static var stage:Stage;

		private static var currentData:AlertData;

		// ******************* GETTER and SETTER ********************
		// ******************* CONSTRUCTOR **************************
		public function Alert()
		{
			throw new DataError(DataError.STATIC_CLASS);
		}

		// ******************* PUBLIC *******************************
		/**
		 * 
		 * @param owner
		 * @param data
		 * @throws UIError
		 */
		public static function show(owner:DisplayObject, data:AlertData):void
		{
			if (owner == null || owner.stage == null)
			{
				throw new UIError(UIError.DISPLAY_OBJECT_NULL);
			}
			stage = owner.stage;
			//
			if (currentData != null)
			{
				Alert.alertList.push(data);
			}
			else
			{
				currentData = data;
				if (alertExist())
				{
					Alert.setAlertView();
				}
				else
				{
					Alert.createAlert();
				}
			}
		}

		/**
		 * 
		 * @param owner
		 * @param text
		 */
		public static function showAlert(owner:DisplayObject, text:String):void
		{
			var ad:AlertData = new AlertData();
			ad.label = text;
			ad.yesLabel = Language.Yes;
			Alert.show(owner, ad);
		}

		/**
		 * 
		 * @param owner
		 * @param text
		 * @param yesHandler
		 * @param noHandler
		 */
		public static function show2Confirm(owner:DisplayObject, text:String, yesHandler:Function = null, noHandler:Function = null):void
		{
			var ad:AlertData = new AlertData();
			ad.label = text;
			ad.yesFunction = yesHandler;
			ad.noFunction = noHandler;
			ad.showNo = true;
			ad.yesLabel = Language.Yes;
			ad.noLabel = Language.No;
			Alert.show(owner, ad);
		}

		/**
		 * 
		 * @param owner
		 * @param text
		 * @param yesHandler
		 * @param noHandler
		 * @param cancelHandler
		 */
		public static function show3Confirm(owner:DisplayObject, text:String, yesHandler:Function = null, noHandler:Function = null, cancelHandler:Function = null):void
		{
			var ad:AlertData = new AlertData();
			ad.label = text;
			ad.yesFunction = yesHandler;
			ad.noFunction = noHandler;
			ad.cancelFunction = cancelHandler;
			ad.showNo = ad.showCancel = true;
			ad.yesLabel = Language.Yes;
			ad.noLabel = Language.No;
			ad.cancelLabel = Language.cancel;
			Alert.show(owner, ad);
		}

		/**
		 * 
		 */
		public static function remove():void
		{
			if (alertExist())
			{
				if (currentData.yesFunction != null)
				{
					yesBtn.removeEventListener(MouseEvent.CLICK, currentData.yesFunction);
				}
				if (currentData.noFunction != null)
				{
					noBtn.removeEventListener(MouseEvent.CLICK, currentData.noFunction);
				}
				if (currentData.cancelFunction != null)
				{
					cancelBtn.removeEventListener(MouseEvent.CLICK, currentData.cancelFunction);
				}
				//
				if (alertList.length > 0)
				{
					currentData = alertList.shift();
					Alert.setAlertView();
				}
				else
				{
					stage.removeChild(alertContainer);
					currentData = null;
				}
			}
		}

		// ******************* PROTECTED ****************************
		// ******************* PRIVATE ******************************
		private static function createAlert():void
		{
			alertContainer = new Sprite;
			stage.addChild(alertContainer);
			//
			bg = new Sprite();
			alertContainer.addChild(bg);
			DrawUtil.drawBlock(bg.graphics, 10, 0, 0.6);
			//
			var tf:TextFormat = new TextFormat("Arial", 14, 0xFFFFFF, true);
			txt = new Label("", tf);
			alertContainer.addChild(txt);
			//
			yesBtn = new Button();
			alertContainer.addChild(yesBtn);
			yesBtn.addEventListener(MouseEvent.CLICK, removeHandler);
			//
			noBtn = new Button();
			alertContainer.addChild(noBtn);
			noBtn.addEventListener(MouseEvent.CLICK, removeHandler);
			//
			cancelBtn = new Button();
			alertContainer.addChild(cancelBtn);
			cancelBtn.addEventListener(MouseEvent.CLICK, removeHandler);
			//
			stage.addEventListener(Event.RESIZE, resizeHandler);
			//
			setAlertView();
		}

		private static function setAlertView():void
		{
			stage.setChildIndex(alertContainer, stage.numChildren - 1);
			//
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			//
			txt.text = currentData.label;
			txt.x = (bg.width - txt.width) / 2;
			txt.y = (bg.height - txt.height) / 2;
			//
			var showBtns:Array = new Array();
			var totalWidth:Number = 0;
			if (currentData.showYes)
			{
				yesBtn.visible = true;
				yesBtn.label = currentData.yesLabel;
				if (currentData.yesFunction != null)
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
			if (currentData.showNo)
			{
				noBtn.visible = true;
				noBtn.label = currentData.noLabel;
				if (currentData.noFunction != null)
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
			if (currentData.showCancel)
			{
				cancelBtn.visible = true;
				cancelBtn.label = currentData.cancelLabel;
				if (currentData.cancelFunction != null)
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
			for (var i:int = 0 ; i < showBtns.length ; i++)
			{
				var btn:Button = showBtns[i] as Button;
				btn.x = startX;
				startX += btn.width + 20;
				btn.y = txt.y + txt.height + 20;
			}
		}

		private static function alertExist():Boolean
		{
			return alertContainer != null && stage != null && stage.contains(alertContainer);
		}

		// ******************* HANDLER ******************************
		private static function resizeHandler(e:Event):void
		{
			if (alertExist())
			{
				setAlertView();
			}
		}

		private static function removeHandler(e:MouseEvent):void
		{
			Alert.remove();
		}
	}
}