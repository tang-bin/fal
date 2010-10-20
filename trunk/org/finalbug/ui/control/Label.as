/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.control
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * controls.Label
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class Label extends UIObject
	{
		private var str:String;
		private var ft:TextFormat;
		private var img:Bitmap;
		private var textWidth:Number = 0;
		
		public function get text():String
		{
			return str;
		}
		public function set text(v:String):void
		{
			str = v;
			createLabel();
		}
		
		public function get textColor():uint
		{
			return uint(ft.color);
		}
		public function set textColor(v:uint):void
		{
			ft.color = v;
			createLabel();
		}
		
		public function get textFormat():TextFormat
		{
			return ft;
		}
		public function set textFormat(value:TextFormat):void
		{
			ft = value;
			createLabel();
		}
		
		override public function set width(value:Number):void
		{
			textWidth = value > 0 ? value : 0;
			createLabel();
		}
		override public function get width():Number
		{
			return img.width;
		}
		
		override public function set height(value:Number):void
		{
			//trace("Label's height value cannot be set.");
		}
		override public function get height():Number
		{
			return img.height;
		}
		
		public function Label(text:String, textFormat:TextFormat = null)
		{
			super();
			str = text;
			if(textFormat == null)
			{
				ft = new TextFormat("Verdana", 12, 0x333333);
			}
			else
			{
				ft = textFormat;
			}
			createChildren();
		}
		
		private function createChildren():void
		{
			createLabel();
		}
		
		private function createLabel():void
		{
			var t:TextField = new TextField();
			t.multiline = true;
			t.setTextFormat(ft);
			t.defaultTextFormat = ft;
			if(this.textWidth > 0)
			{
				t.text = "...";
				var addedWidth:Number = t.textWidth;
				//
				t.text = str.charAt(0);
				var index:uint = 1;
				while(t.textWidth + addedWidth < this.textWidth && index < str.length)
				{
					t.appendText(str.charAt(index++));
				}
				if(index < str.length)
				{
					t.appendText("...");
				}
			}
			else
			{
				t.text = str;
			}
			t.width = t.textWidth + 4;
			t.height = t.textHeight + 4;
			var bd:BitmapData = new BitmapData(t.width, t.height, true, 0x00000000);
			bd.draw(t);
			//
			if(img != null)
			{
				this.removeChild(img);
			}
			img = new Bitmap(bd);
			this.addChild(img);
		}
	}
}