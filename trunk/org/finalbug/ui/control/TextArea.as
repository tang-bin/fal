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
package org.finalbug.ui.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	
	import org.finalbug.data.Status;
	import org.finalbug.events.DataEvent;
	import org.finalbug.events.UIEvent;
	import org.finalbug.ui.skin.SkinElement;
	import org.finalbug.ui.skin.TextSkinData;
	import org.finalbug.ui.skin.UISkinDataBase;
	
	/**
	 * @eventType events.DataEvent.CHANGE_DATA
	 */	
	[Event(name="ChangeData", type="fal.events.DataEvent")]
	
	/**
	 * Text area component.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class TextArea extends ScrollBox
	{
		private var bg:SkinElement;
		private var txt:TextField;
		private var _embed:Boolean = false;
		private var scrollManual:Boolean = false;
		private var _editable:Boolean = true;
		
		/**
		 * If this text area can input in or not.
		 */		
		public function get editable():Boolean
		{
			return this._editable;
		}
		/**
		 * 
		 * @param value
		 */
		public function set editable(value:Boolean):void
		{
			if(value != this._editable)
			{
				this._editable = value;
				txt.type = value && enabled ? "input" : "dynamic";
			}
		}
		
		/**
		 * text string
		 */		
		public function get text():String
		{
			return txt.text;
		}
		/**
		 * 
		 * @param value
		 */
		public function set text(value:String):void
		{
			txt.text = value;
		}
		
		/**
		 * embed font or not.
		 */
		public function get embed():Boolean
		{
			return _embed;
		}
		/**
		 * 
		 * @param b
		 */
		public function set embed(b:Boolean):void
		{
			_embed=b;
			txt.embedFonts = _embed;
		}
		
		/**
		 * in Class TextArea, if x scrollbar is disabled, the text input will auto warp.
		 */		
		override public function set xScrollEnabled(value:Boolean):void
		{
			super.xScrollEnabled = value;
			txt.wordWrap = !value;
		}
		
		override public function set status(value:String):void
		{
			if(this.enabled)
			{
				if(stage.focus == txt)
				{
					value = Status.ACTIVE;
				}
				else
				{
					value = Status.NORMAL;
				}
			}
			else
			{
				value = Status.DISABLE;
			}
			if(value != this.status) super.status = value;
		}
		
		/**
		 * create a new TextArea.
		 * 
		 * @param size
		 * @param wordwrap wrap word
		 * @param style DipslayStyle
		 */		
		public function TextArea(skin:UISkinDataBase = null)
		{
			super(true, true, skin);
			this.initSize(200, 200);
			this.autoResizeChildren = false;
			this.fillStyle = null;
			//
			// create children.
			bg = new SkinElement();
			bg.resize(this.displayWidth, this.displayHeight);
			txt = new TextField();
			txt.wordWrap = !enableX;
			txt.multiline = true;
			this.addAll(bg, txt);
			bg.toBack(); // move bg to the back of all children.
			txt.type = "input";
			setEvent();
			//
			// set skin data.
			if(uiSkinData == null)
			{
				uiSkinData = new TextSkinData();
			}
			uiSkinData.setSkin(bg, txt);
		}
		
		override protected function updateView():void
		{
			super.updateView();
			if(bg != null)
			{
				bg.width = this.displayWidth;
				bg.height = this.displayHeight;
			}
			if(txt != null)
			{
				txt.width = containerWidth;
				txt.height = containerHeight;
			}
		}
		
		private function setEvent():void
		{
			txt.addEventListener(FocusEvent.FOCUS_IN, txtFocusInHandler);
			txt.addEventListener(FocusEvent.FOCUS_OUT, txtFocusOutHandler);
			txt.addEventListener(Event.CHANGE, changeTextHandler);
			txt.addEventListener(Event.SCROLL, scrollTextHandler);
		}
		
		override protected function xScrollHandler(e:UIEvent):void
		{
			scrollManual = true;
			txt.scrollH = e.position * txt.maxScrollH;
			scrollManual = false;
		}
		
		override protected function yScrollHandler(e:UIEvent):void
		{
			scrollManual = true;
			txt.scrollV = e.position * txt.maxScrollV;
			scrollManual = false;
		}
		
		private function scrollTextHandler(e:Event):void
		{
			if(!scrollManual)
			{
				setScrollView();
			}
		}
		
		private function setScrollView():void
		{
			if(enableY && enabled)
			{
				if(txt.maxScrollV > 1)
				{
					yBar.enabled = true;
					yBar.scale = txt.numLines / (txt.numLines + txt.maxScrollV);
					yBar.position = txt.scrollV / txt.maxScrollV;
				}
				else if(yBar != null && yBar.enabled)
				{
					yBar.enabled = false;
				}
			}
			if(enableX && enabled)
			{
				if(txt.maxScrollH > 1)
				{
					xBar.enabled = true;
					xBar.scale = txt.width / (txt.width + txt.maxScrollH);
					xBar.position = txt.scrollH / txt.maxScrollH;
				}
				else if(xBar != null && xBar.enabled)
				{
					xBar.enabled = false;
				}
			}
		}
		
		private function txtFocusInHandler(e:FocusEvent):void
		{
			this.status = Status.ACTIVE;
		}
		
		private function txtFocusOutHandler(e:FocusEvent):void
		{
			this.status = Status.NORMAL;
		}
		
		private function changeTextHandler(e:Event):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			//ee.oldData = oldText;
			//ee.newData = txt.text;
			this.dispatchEvent(ee);
			//oldText = txt.text;
		}
	}
}
