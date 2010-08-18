package fal.ui
{
	import fal.data.Status;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * @author Finalbug
	 * @since 1.0
	 */	
	public class BaseButton extends UIObject
	{
		private var normalSP:DisplayObjectContainer;
		private var overSP:DisplayObjectContainer;
		private var downSP:DisplayObjectContainer;
		private var holdSP:DisplayObjectContainer;
		private var disableSP:DisplayObjectContainer;
		
		private var currentStatus:String;
		private var currentSP:DisplayObjectContainer;
		private var targetSP:DisplayObjectContainer;
		
		private var canHold:Boolean = false;
		
		private var front:Sprite;
		
		private var _enabled:Boolean = true;
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				showStatus(_enabled ? Status.NORMAL_STATUS : Status.DISABLE_STATUS);
			}
		}
		
		public function set enableHold(value:Boolean):void
		{
			if(canHold != value)
			{
				canHold = value;
				if(currentStatus == Status.HOLD_STATUS && !canHold)
				{
					showStatus(Status.NORMAL_STATUS);
				}
			}
			refreshSPs();
		}
		public function get enableHold():Boolean
		{
			return canHold;
		}
		
		public function get isHold():Boolean
		{
			return currentStatus == Status.HOLD_STATUS;
		}
		
		public function set normalLayer(value:DisplayObjectContainer):void
		{
			if(normalSP != null)this.removeChild(normalSP);
			normalSP = value;
			this.addChild(normalSP);
			refreshSPs();
		}
		public function get normalLayer():DisplayObjectContainer
		{
			return normalSP;
		}
		
		public function set overLayer(value:DisplayObjectContainer):void
		{
			if(overSP != null)this.removeChild(overSP);
			overSP = value;
			this.addChild(overSP);
			refreshSPs();
		}
		public function get overLayer():DisplayObjectContainer
		{
			return overSP;
		}
		
		public function set downLayer(value:DisplayObjectContainer):void
		{
			if(downSP != null)this.removeChild(downSP);
			downSP = value;
			this.addChild(downSP);
			refreshSPs();
		}		
		public function get downLayer():DisplayObjectContainer
		{
			return downSP;
		}
		
		public function set holdLayer(value:DisplayObjectContainer):void
		{
			if(holdSP != null)this.removeChild(holdSP);
			holdSP = value;
			this.addChild(holdSP);
			refreshSPs();
		}
		public function get holdLayer():DisplayObjectContainer
		{
			return holdSP;
		}
		
		public function set disableLayer(value:DisplayObjectContainer):void
		{
			if(disableSP != null)this.removeChild(disableSP);
			disableSP = value;
			this.addChild(disableSP);
			refreshSPs();
		}
		public function get disableLayer():DisplayObjectContainer
		{
			return disableSP;
		}
		
		public function BaseButton()
		{
			super();
			front = new Sprite();
			this.addChild(front);
			front.graphics.beginFill(0, 0);
			front.graphics.drawRect(0, 0, 10, 10);
			front.graphics.endFill();
			//
			showStatus(Status.NORMAL_STATUS);
			//
			this.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		private function showStatus(status:String):void
		{
			if(status != currentStatus)
			{
				cleanSPs();
				currentSP = getSPByStatus(currentStatus);
				targetSP = getSPByStatus(status);
				if(currentSP != null)
				{
					currentSP.visible = true;
				}
				if(targetSP != null)
				{
					if(currentSP != null)
					{
						targetSP.alpha = 0;
						targetSP.visible = true;
						// swap 2 SPs
						var timer:Timer = new Timer(30, 15);
						timer.addEventListener(TimerEvent.TIMER, swapSPHandler);
						timer.addEventListener(TimerEvent.TIMER_COMPLETE, swapSPEndHandler);
						timer.start();
						//
						front.width = currentSP.width;
						front.height = currentSP.height;
					}
					else
					{
						targetSP.alpha = 1;
						targetSP.visible = true;
						//
						front.width = targetSP.width;
						front.height = targetSP.height;
					}
				}
			}
			currentStatus = status;
		}
		
		private function refreshSPs():void
		{
			cleanSPs();
			//
			if(canHold && currentStatus == Status.HOLD_STATUS && holdSP != null)
			{
				holdSP.visible = true;
				holdSP.alpha = 1;
				currentSP = holdSP;
			}
			else
			{
				if(normalSP != null)
				{
					currentSP = normalSP;
					normalSP.visible = true;
					normalSP.alpha = 1;
				}
				currentStatus = Status.NORMAL_STATUS;
			}
			//
			this.setChildIndex(front, this.numChildren - 1);
		}
		
		private function cleanSPs():void
		{
			if(normalSP != null)normalSP.visible = false;
			if(holdSP != null)holdSP.visible = false;
			if(overSP != null)overSP.visible = false;
			if(downSP != null)downSP.visible = false;
			if(disableSP != null)disableSP.visible = false;
		}
		
		private function getSPByStatus(status:String):DisplayObjectContainer
		{
			switch(status)
			{
				case Status.NORMAL_STATUS:return normalSP;break;
				case Status.HOLD_STATUS:return holdSP;break;
				case Status.MOUSE_OVER_STATUS:return overSP;break;
				case Status.MOUSE_DOWN_STATUS:return downSP;break;
				case Status.DISABLE_STATUS:return disableSP;break;
			}
			return null;
		}
		
		private function swapSPHandler(e:TimerEvent):void
		{
			targetSP.alpha += (1 - targetSP.alpha) / 5;
			if(currentSP != null)currentSP.alpha -= currentSP.alpha / 5;
			e.updateAfterEvent();
		}
		
		private function swapSPEndHandler(e:TimerEvent):void
		{
			targetSP.alpha = 1;
			if(currentSP != null)
			{
				currentSP.alpha = 0;
				currentSP.visible = false;
			}
		}
		
		private function downHandler(e:MouseEvent):void
		{
			if(currentStatus != Status.DISABLE_STATUS && currentStatus != Status.HOLD_STATUS)
			{
				this.showStatus(Status.MOUSE_DOWN_STATUS);
			}
		}
		
		private function upHandler(e:MouseEvent):void
		{
			if(currentStatus != Status.DISABLE_STATUS)
			{
				if(this.canHold)
				{
					if(currentStatus == Status.HOLD_STATUS)
					{
						this.showStatus(Status.MOUSE_OVER_STATUS);
					}
					else
					{
						this.showStatus(Status.HOLD_STATUS);
					}
				}
				else
				{
					this.showStatus(Status.MOUSE_OVER_STATUS);
				}
			}
		}
		
		private function overHandler(e:MouseEvent):void
		{
			if(currentStatus != Status.DISABLE_STATUS && currentStatus != Status.HOLD_STATUS)
			{
				this.showStatus(Status.MOUSE_OVER_STATUS);
			}
		}
		
		private function outHandler(e:MouseEvent):void
		{
			if(currentStatus != Status.DISABLE_STATUS && currentStatus != Status.HOLD_STATUS)
			{
				this.showStatus(Status.NORMAL_STATUS);
			}
		}
	}
}