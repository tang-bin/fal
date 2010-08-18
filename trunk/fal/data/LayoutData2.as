package fas.data
{
	import fas.ui.UIObject;
	import fas.utils.Chars;
	
	public class LayoutData2
	{
		public static const TOP_LEFT:String = "topLeft";
		public static const AROUND:String = "around";
		
		public var type:String = "";
		public var enabled:Boolean = false;
		
		private var owner:UIObject;
		
		public function LayoutData2()
		{
			
		}
		
		private var ww:Number = 0;
		private var wwp:Boolean = false;
		
		private var hh:Number = 0;
		private var hhp:Boolean = false;
		
		private var tt:Number = 0;
		private var ttp:Boolean = false;
		
		private var bb:Number = 0;
		private var bbp:Boolean = false;
		
		private var ll:Number = 0;
		private var llp:Boolean = false;
		
		private var rr:Number = 0;
		private var rrp:Boolean = false;
		
		private var hor:Number = 0;
		private var horp:Boolean = false;
		private var sethor:Boolean = false;
		
		private var ver:Number = 0;
		private var verp:Boolean = false;
		private var setver:Boolean = false;
		
		public function sizeLayout(x:String = "0", y:String = "0", width:String = "0", height:String = "0"):void
		{
			llp = Chars.isPercnet(x);
			ll = Chars.getLayoutNum(x);
			//
			ttp = Chars.isPercnet(y);
			tt = Chars.getLayoutNum(y);
			//
			wwp = Chars.isPercnet(width);
			ww = Chars.getLayoutNum(width);
			//
			hhp = Chars.isPercnet(height);
			hh = Chars.getLayoutNum(height);
			//
			type = LayoutData2.TOP_LEFT;
			//
			sethor = setver = false;
			this.enabled = true;
		}
		
		public function roundLayout(top:String, right:String, bottom:String, left:String):void
		{
			llp = Chars.isPercnet(top);
			ll = Chars.getLayoutNum(top);
			//
			ttp = Chars.isPercnet(right);
			tt = Chars.getLayoutNum(right);
			//
			bbp = Chars.isPercnet(bottom);
			bb = Chars.getLayoutNum(bottom);
			//
			rrp = Chars.isPercnet(right);
			rr = Chars.getLayoutNum(right);
			//
			type = LayoutData2.AROUND;
			//
			sethor = setver = false;
			this.enabled = true;
		}
		
		public function get width():Number
		{
			if(this.enabled)
			{
				if(type == LayoutData2.TOP_LEFT)
				{
					return wwp ? owner.parent.width * ww : ww;
				}
				else if(type == LayoutData2.AROUND)
				{
					var left:Number = llp ? owner.parent.width * ll : ll;
					var right:Number = rrp ? owner.parent.width * rr : rr;
					return owner.parent.width - left - right;
				}
				else
				{
					return this.owner.width;
				}
			}
			else
			{
				return 0;
			}
		}
		
		public function get height():Number
		{
			if(this.enabled)
			{
				if(type == LayoutData2.TOP_LEFT)
				{
					return hhp ? owner.parent.height * hh : hh;
				}
				else if(type == LayoutData2.AROUND)
				{
					var top:Number = ttp ? owner.parent.height * tt : tt;
					var bottom:Number = bbp ? owner.parent.height * bb : bb;
					return owner.parent.height - top - bottom;
				}
				else
				{
					return this.owner.height;
				}
			}
			else
			{
				return 0;
			}
		}
		public function get x():Number
		{
			if(this.enabled)
			{
				if(sethor)
				{
					var horValue:Number = horp ? owner.parent.width * hor : hor;
					return (owner.parent.width - this.width) / 2 + horValue; 
				}
				else if(type != "")
				{
					return llp ? owner.parent.width * ll : ll;
				}
				else
				{
					return this.owner.x;
				}
			}
			else
			{
				return 0;
			}
		}
		public function get y():Number
		{
			if(this.enabled)
			{
				if(setver)
				{
					var verValue:Number = verp ? owner.parent.height * ver : ver;
					return (owner.parent.height - this.height) / 2 + verValue; 
				}
				else if(type != "")
				{
					return ttp ? owner.parent.height * tt : tt;
				}
				else
				{
					return this.owner.y;
				}
			}
			else
			{
				return 0;
			}
		}
		
		public function set horizon(value:String):void
		{
			horp = Chars.isPercnet(value);
			hor = Chars.getLayoutNum(value);
			sethor = true;
			this.enabled = true;
		}
		public function get horizon():String
		{
			if(sethor)
			{
				if(horp)
				{
					return (hor * 100) + "%";
				}
				else
				{
					return hor.toString();
				}
			}
			return "";
		}
		
		public function set vertical(value:String):void
		{
			verp = Chars.isPercnet(value);
			ver = Chars.getLayoutNum(value);
			setver = true;
			this.enabled = true;
		}
		public function get vertical():String
		{
			if(setver)
			{
				if(verp)
				{
					return (ver * 100) + "%";
				}
				else
				{
					return ver.toString();
				}
			}
			return "";
		}
		
		public function toString():String
		{
			var str:String = "[LayoutData: width = " + this.width + ", ";
			str += "height = " + this.height + ", ";
			str += "x = " + this.x + ", ";
			str += "y = " + this.y + "]";
			return str;
		}
	}
}