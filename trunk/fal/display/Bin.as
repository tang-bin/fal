/******************************************
 * Finalbug ActionScript Library
 * 
 * fal.display.Bin
 * @author Tang Bin (tangbin@finalbug.org)
 * @since 2010 6:54:46 PM
 *
 *****************************************/
package fal.display
{
	import fal.data.ErrorCode;
	import fal.style.CSSFile;
	import fal.style.CSSManager;
	
	import flash.display.Sprite;
	
	import mx.managers.PopUpManager;
	
	public class Bin extends Sprite
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		private var ww:Number = 0;
		private var hh:Number = 0;
		private var xx:Number = 0;
		private var yy:Number = 0;
		
		private var targetW:Number = 0;
		private var targetH:Number = 0;
		private var targetX:Number = 0;
		private var targetY:Number = 0;
		
		private var CPath:String = "";
		private var CFile:CSSFile;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		override public function get width():Number
		{
			return ww;
		}
		override public function set width(value:Number):void
		{
			
		}
		
		override public function get height():Number
		{
			return hh;
		}
		override public function set height(value:Number):void
		{
			
		}
		
		public function get bindCSS():String
		{
			return CPath;
		}
		
		public function set bindCSS(value:String):void
		{
			if(value == null || value == "")
			{
				// reset CSS
			}
			else
			{
				if(!CSSManager.instance.CSSRegistered(value))
				{
					// if css file is unregistered.
					throw new Error(ErrorCode.CSS_UNREGISTERED);
				}
				else
				{
					CPath = value;
					//CFile = CSSManager.instance.getCSSFile(CPath);
					this.updateView();
				}
			}
		}
		
		/****************************************
		 * 
		 * fal.display.Bin Constructor
		 * 
		 ****************************************/
		
		public function Bin()
		{
			super();
		}
		
		/****************************************
		 * OVERRIDE
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		/**
		 * Change Bin's size to target width and height immediately.
		 */	
		public function resize(width:Number, height:Number):void
		{
			
		}
		
		/**
		 * Change Bin's size to target width and height smoothly.
		 * 
		 * @param width Target width.
		 * @param height Target height.
		 * @param during Time spend to change, in millisecond.
		 */	
		public function zoom(width:Number, height:Number, during:uint = 500):void
		{
			
		}
		
		public function put(x:Number, y:Number):void
		{
			
		}
		
		public function move(x:Number, y:Number, during:uint = 500):void
		{
			
		}
		
		public function toFront():void
		{
			if(this.parent != null)
			{
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
			}
		}
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		protected function doResize():void
		{
			
		}
		
		protected function updateView():void
		{
			
		}
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}