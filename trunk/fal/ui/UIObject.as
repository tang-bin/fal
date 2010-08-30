package fal.ui
{	
	import fal.events.LoadEvent;
	import fal.motion.FadeMotion;
	import fal.motion.MoveMotion;
	import fal.motion.SizeMotion;
	import fal.app.Tooltip;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	/**
	 * Super class for all UI components.
	 * 
	 * @author	Finalbug
	 * @since 0.1
	 */
	public class UIObject extends Sprite
	{
		public var toolTip:String = "";
		private var showTipTimer:Timer;
		protected var uiName:String = "UIObject";
		
		private var xx:Number = 0; // x
		private var pxx:Number = -1; // percnet x
		private var yy:Number = 0; // y
		private var pyy:Number = -1; // percnet x
		
		private var ww:Number = 0; // width
		private var pww:Number = -1; // percnet width
		private var hh:Number = 0; // height
		private var phh:Number = -1; // percnet height
		
		private var rr:Number = -1; // right
		private var prr:Number = -1; // percnet right
		private var bb:Number = -1; // bottom
		private var pbb:Number = -1; // percent bottom
		
		private var effectAfterChange:Boolean = true;
		
		private var fm:FadeMotion;
		private var mm:MoveMotion;
		private var sm:SizeMotion;
		
		override public function get width() : Number
		{
			if(ww != -1)
			{
				return ww;
			}
			else if(this.parent != null)
			{
				return this.parent.width * pww;
			}
			else
			{
				return 0;
			}
		}
		override public function set width(value:Number) : void
		{
			if(value >= 0)
			{
				ww = value;
				pww = -1;
				if(effectAfterChange)resize();
			}
		}
		public function get percentWidth():Number
		{
			if(pww != -1)
			{
				return pww;
			}
			else if(this.parent != null)
			{
				return ww / this.parent.width;
			}
			else
			{
				return 0;
			}
		}
		public function set percentWidth(value:Number):void
		{
			if(value >= 0)
			{
				pww = value;
				ww = -1;
				if(effectAfterChange)resize();
			}
		}
		
		override public function get height() : Number
		{
			if(hh != -1)
			{
				return hh;
			}
			else if(this.parent != null)
			{
				return this.parent.height * phh;
			}
			else
			{
				return 0;
			}
		}
		override public function set height(value:Number) : void
		{
			if(value >= 0)
			{
				hh = value;
				phh = -1;
				if(effectAfterChange)resize();
			}
		}
		public function get percentHeight():Number
		{
			if(phh != -1)
			{
				return phh;
			}
			else if(this.parent != null)
			{
				return hh / this.parent.height;
			}
			else 
			{
				return 0;
			}
		}
		public function set percentHeight(value:Number):void
		{
			if(value >= 0)
			{
				phh = value;
				hh = -1;
				if(effectAfterChange)resize();
			}
		}
		
		override public function get x() : Number
		{
			var hasP:Boolean = this.parent != null;
			var pw:Number = hasP ? this.parent.width : 0;
			//
			if(xx != -1)
			{
				return xx;
			}
			else if(pxx != -1)
			{
				return hasP ? pw * pxx : 0;
			}
			else if(rr != -1)
			{
				return hasP ? pw - this.width - rr : 0;
			}
			else if(prr != -1)
			{
				return hasP ? pw - this.width - pw * prr : 0;
			}
			else
			{
				return 0;
			}
		}
		override public function set x(value:Number) : void
		{
			xx = value;
			pxx = rr = prr = -1;
			if(effectAfterChange)super.x = this.x;
		}
		
		override public function get y() : Number
		{
			var hasP:Boolean = this.parent != null;
			var ph:Number = hasP ? this.parent.height : 0;
			//
			if(yy != -1)
			{
				return yy;
			}
			else if(pyy != -1)
			{
				return hasP ? ph * pyy : 0;
			}
			else if(bb != -1)
			{
				return hasP ? ph - this.height - bb : 0;
			}
			else if(pbb != -1)
			{
				return hasP ? ph - this.height - ph * pbb : 0;
			}
			else
			{
				return 0;
			}
		}
		override public function set y(value:Number) : void
		{
			yy = value;
			prr = pbb = bb = -1;
			if(effectAfterChange)super.y = this.y;
		}
		
		public function get percentX():Number
		{
			var hasP:Boolean = this.parent != null;
			var pw:Number = hasP ? this.parent.width : 0;
			//
			if(pxx != -1)
			{
				return pxx;
			}
			else if(xx != -1)
			{
				return hasP ? xx / pw : 0;
			}
			else if(rr != -1)
			{
				return hasP ? (pw - rr - this.width) / pw : 0;
			}
			else if(prr != -1)
			{
				return hasP ? (pw - prr * pw - this.width) / pw : 0;
			}
			else
			{
				return 0;
			}
		}
		public function set percentX(value:Number):void
		{
			pxx = value;
			xx = rr = prr = -1;
			if(effectAfterChange)super.x = this.x;
		}
		
		public function get percentY():Number
		{
			var hasP:Boolean = this.parent != null;
			var ph:Number = hasP ? this.parent.height : 0;
			//
			if(pyy != -1)
			{
				return pyy;
			}
			else if(yy != -1)
			{
				return hasP ? yy / ph : 0;
			}
			else if(bb != -1)
			{
				return hasP ? (ph - bb - this.height) / ph : 0;
			}
			else if(pbb != -1)
			{
				return hasP ? (ph - pbb * ph - this.height) / ph : 0;
			}
			else
			{
				return 0;
			}
		}
		public function set percentY(value:Number):void
		{
			pyy = value;
			yy = bb = pbb = -1;
			if(effectAfterChange)super.y = this.y;
		}
		
		public function get right():Number
		{
			var hasP:Boolean = this.parent != null;
			var pw:Number = hasP ? this.parent.width : 0;
			//
			if(rr != -1)
			{
				return rr;
			}
			else if(prr != -1)
			{
				return hasP ? pw * prr : 0;
			}
			else if(xx != -1)
			{
				return hasP ? pw - xx - this.width : 0;
			}
			else if(pxx != -1)
			{
				return hasP ? pw - pw * pxx - this.width : 0;
			}
			else
			{
				return 0;
			}
		}
		public function set right(value:Number):void
		{
			rr = value;
			prr = xx = pxx = -1;
			if(effectAfterChange)super.x = this.x;
		}
		
		public function get bottom():Number
		{
			var hasP:Boolean = this.parent != null;
			var ph:Number = hasP ? this.parent.height : 0;
			//
			if(bb != -1)
			{
				return bb;
			}
			else if(pbb != -1)
			{
				return hasP ? ph * pbb : 0; 
			}
			else if(yy != -1)
			{
				return hasP ? ph - hh - this.height : 0;
			}
			else if(pyy != -1)
			{
				return hasP ? ph - ph * pyy - this.height : 0;
			}
			else
			{
				return 0;
			}
		}
		public function set bottom(value:Number):void
		{
			bb = value;
			pbb = pyy = yy = -1;
			if(effectAfterChange)super.y = this.y;
		}
		
		public function get percentRight():Number
		{
			var hasP:Boolean = this.parent != null;
			var pw:Number = hasP ? this.parent.width : 0;
			//
			if(prr != -1)
			{
				return prr;
			}
			else if(rr != -1)
			{
				return hasP ? rr / pw : 0;
			}
			else if(xx != -1)
			{
				return hasP ? (pw - xx - this.width) / pw : 0;
			}
			else if(pxx != -1)
			{
				return hasP ? (pw - pxx * pw - this.width) / pw : 0;
			}
			else
			{
				return 0;
			}
		}
		public function set percentRight(value:Number):void
		{
			prr = value;
			rr = xx = pxx = -1;
			if(effectAfterChange)super.x = this.x;
		}
			
		public function get percentBottom():Number
		{
			var hasP:Boolean = this.parent != null;
			var ph:Number = hasP ? this.parent.height : 0;
			//
			if(pbb != -1)
			{
				return pbb;
			}
			else if(bb != -1)
			{
				return hasP ? bb / ph : 0;
			}
			else if(yy != -1)
			{
				return hasP ? (ph - this.height - yy) / ph : 0;
			}
			else if(pyy != -1)
			{
				return hasP ? (ph - this.height - pyy * ph) / ph : 0;
			}
			else
			{
				return 0;
			}
		}
		public function set percentBottom(value:Number):void
		{
			pbb = value;
			bb = yy = pyy = -1;
			if(effectAfterChange)super.y = this.y;
		}
		
		public function UIObject()
		{
			super();
			this.addEventListener(MouseEvent.ROLL_OVER, overUIObjectHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outUIObjectHandler);
		}
		
		override public function stopDrag() : void
		{
			this.changeLayoutValue("x", super.x);
			this.changeLayoutValue("y", super.y);
			super.stopDrag();
		}
		
		public function changeLayoutValue(name:String, value:Number):void
		{
			effectAfterChange = false;
			this[name] = value;
			effectAfterChange = true;
		}
		
		override public function toString():String
		{
			return "[" + uiName + ":" + this.name + "]";
		}
		
		public function resize():void
		{
			// resize uiobject. set width, height, x, y.
			super.x = this.x;
			super.y = this.y;
			for(var i:int = this.numChildren ; --i >= 0 ; )
			{
				var child:DisplayObject = this.getChildAt(i);
				if(child is UIObject)
				{
					(child as UIObject).resize();
				}
			}
		}
		
		public function removeAllChildren():void
		{
			for(var i:int = this.numChildren ; --i >= 0 ; )
			{
				this.removeChildAt(i);
			}
		}
		
		public function loadUIObject(name:String, path:String):void
		{
			var uioLoader:Loader = new Loader();
			uioLoader.name = name;
			uioLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, uioLoadedHandler);
			uioLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, uioLoadErrorHandler);
			uioLoader.load(new URLRequest(path));
		}
		
		public function toAlpha(alpha:Number, during:Number = 500):void
		{
			if(fm != null)fm.stop();
			fm = new FadeMotion(this);
			fm.alphaFrom = this.alpha;
			fm.alphaTo = alpha;
			fm.during = during;
			fm.start();
		}
		
		public function toSize(width:Number, height:Number, during:Number = 800):void
		{
			if(sm != null)sm.stop();
			sm = new SizeMotion(this);
			sm.widthFrom = this.width;
			sm.widthTo = width;
			sm.heightFrom = this.height;
			sm.heightTo = height;
			sm.during = 800;
			sm.start();
		}
		
		public function toPosition(x:Number, y:Number, during:Number = 800):void
		{
			if(mm != null)mm.stop();
			mm = new MoveMotion(this);
			mm.xFrom = this.x;
			mm.yFrom = this.y;
			mm.xTo = x;
			mm.yTo = y;
			mm.during = during;
			mm.start();
		}
		
		private function uioLoadedHandler(e:Event):void
		{
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			ee.data = e.target.content as UIObject;
			ee.targetName = (e.currentTarget as LoaderInfo).loader.name;
			this.dispatchEvent(ee);
		}
		
		private function uioLoadErrorHandler(e:IOErrorEvent):void
		{
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			this.dispatchEvent(ee);
		}
		
		private function overUIObjectHandler(e:MouseEvent):void
		{
			if(this.toolTip != null && this.toolTip != "")
			{
				if(showTipTimer != null)
				{
					showTipTimer.stop();
				}
				showTipTimer = new Timer(2000, 1);
				showTipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, showTipTimerHandler);
				showTipTimer.start();
			}
		}
		
		private function showTipTimerHandler(e:TimerEvent):void
		{
			Tooltip.show(this.toolTip);
			showTipTimer.stop();
			showTipTimer = null;
		}
		
		private function outUIObjectHandler(e:MouseEvent):void
		{
			if(this.toolTip != null && this.toolTip != "")
			{
				Tooltip.remove();
			}
			if(showTipTimer != null)
			{
				showTipTimer.stop();
				showTipTimer = null;
			}
		}
	}
}