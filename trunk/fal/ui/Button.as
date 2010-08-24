package fal.ui
{
	import fal.data.FillData;
	import fal.display.Flat;
	
	import flash.display.DisplayObjectContainer;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Button extends BaseButton
	{
		private const DEFAULT_WIDTH:Number = 80;
		private const DEFAULT_HEIGHT:Number = 20;
		
		private var _label:String = "Button";
		private var txt:TextField;
		
		private var _icon:DisplayObjectContainer;
		
		private var _lockSize:Boolean = false;
		
		override public function resize() : void
		{
			super.resize();
			normalLayer.width = overLayer.width = downLayer.width = disableLayer.width = holdLayer.width = this.width;
			normalLayer.height = overLayer.height = downLayer.height = disableLayer.height = holdLayer.height = this.height;
			//
			if(_icon == null)
			{
				txt.x = (normalLayer.width - txt.width) / 2;
				txt.y = (normalLayer.height - txt.height) / 2;
			}
			else
			{
				_icon.x = (normalLayer.width - _icon.width) / 2;
				_icon.y = (normalLayer.height - _icon.height) / 2;
			}
		}
		
		public function get lockSize():Boolean
		{
			return _lockSize;
		}
		public function set lockSize(value:Boolean):void
		{
			if(value != _lockSize)
			{
				_lockSize = value;
			}
		}
		
		public function set label(value:String):void
		{
			_label = value;
			setLabel();
		}
		public function get label():String
		{
			return _label;
		}
		
		public function set icon(value:DisplayObjectContainer):void
		{
			if(_icon != null)
			{
				this.removeChild(_icon);
			}
			_icon = value;
			if(_icon != null)
			{
				this.addChild(_icon);
				txt.visible = false;
				if(_lockSize)
				{
					this.resize();
				}
				else
				{
					this.width = _icon.width + 10;
					this.height = _icon.height + 10;
				}
			}
			else
			{
				txt.visible = true;
				if(_lockSize)
				{
					this.resize();
				}
				else
				{
					this.width = txt.width + 10;
					this.height = txt.height + 4;
				}
			}
		}
		public function get icon():DisplayObjectContainer
		{
			return _icon;
		}
		
		public function Button(label:String = "Button")
		{
			super();
			this.uiName = "Button";
			_label = label;
			//
			createFlat();
			//
			txt = new TextField();
			var tf:TextFormat = new TextFormat("Arial", 13, 0xFFFFFF, true);
			txt.defaultTextFormat = tf;
			txt.selectable = false;
			//
			var gf:GlowFilter = new GlowFilter(0, 0.5, 2, 2, 2, 1, true);
			txt.filters = [gf];
			//
			this.addChild(txt);
			setLabel();
		}
		
		private function setLabel():void
		{
			txt.text = _label;
			txt.width = txt.textWidth + 4;
			txt.height = txt.textHeight + 4;
			//
			if(_lockSize)
			{
				this.resize();				
			}
			else
			{
				this.width = txt.width + 10;
				this.height = txt.height + 4;
			}
		}
		
		private function createFlat():void
		{
			// normal layer
			/*
			var normalStyle:FillData = new FillData(false);
			normalFD.radius = 3;
			normalFD.borderAlpha = 0;
			normalFD.gradient = true;
			normalFD.bodyColor = 0x990000;
			normalFD.rotate = 90;
			normalFD.glowBlur = 2;
			this.normalLayer = new Flat(this.DEFAULT_WIDTH, this.DEFAULT_HEIGHT, normalFD);
			//
			var overFD:FillData = normalFD.clone();
			overFD.glowBlur = 4;
			overFD.bodyColor = 0;
			this.overLayer = new Flat(this.DEFAULT_WIDTH, this.DEFAULT_HEIGHT, overFD);
			//
			var downFD:FillData = overFD.clone();
			downFD.glowBlur = 2;
			this.downLayer = new Flat(this.DEFAULT_WIDTH, this.DEFAULT_HEIGHT, downFD);
			//
			var disableFD:FillData = normalFD.clone();
			disableFD.bodyColor = 0xCCCCCC;
			this.disableLayer = new Flat(this.DEFAULT_WIDTH, this.DEFAULT_HEIGHT, disableFD);
			//
			var holdFD:FillData = normalFD.clone();
			holdFD.borderAlpha = 1;
			holdFD.borderSize = 2;
			holdFD.borderColor = 0xFFFFFF;
			holdFD.gradient = false;
			this.holdLayer = new Flat(this.DEFAULT_WIDTH, this.DEFAULT_HEIGHT, holdFD);
			*/
		}
	}
}