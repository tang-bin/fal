/******************************************
 * Finalbug ActionScript Library( http://www.finalbug.org/ )
 * 
 * fal.debuger.Debuger
 *
 * @author Tang Bin (tangbin@finalbug.org)
 * @since Jul 12, 2010 11:41:25 PM
 *
 *****************************************/
package fal.debuger
{
	import fal.display.Bin;
	import fal.utils.AdvancedObject;
	
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Debugger extends AdvancedObject
	{
		/****************************************
		 * 
		 * DEFINE
		 * 
		 ****************************************/
		
		private static var _initialized:Boolean = false;
		private static var container:Bin;
		private static var stage:Stage;
		
		private static var txt:TextField;
		
		/****************************************
		 * 
		 * GETTER & SETTER
		 * 
		 ****************************************/
		
		public static function get initialized():Boolean
		{
			return _initialized;
		}
		
		/****************************************
		 * 
		 * fal.debuger.Debuger constructor.
		 * 
		 ****************************************/
		public function Debugger()
		{
			super();
		}
		
		/****************************************
		 * 
		 * OVERRIDE METHODS
		 * 
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 * 
		 ****************************************/
		
		/****************************************
		 * 
		 * PUBLIC
		 * 
		 ****************************************/
		
		public static function init(stage:Stage):void
		{
			if(stage != null)
			{
				Debugger.stage = stage;
				container = new Bin();
				stage.addChild(container);
				swapToTop();
				_initialized = true;
				//
				txt = new TextField();
				container.addChild(txt);
				txt.width = 300;
				txt.height = 200;
				txt.defaultTextFormat = new TextFormat("Arial", 12, 0xFF9900);
				txt.wordWrap = true;
				txt.multiline = true;
				txt.border = true;
			}
		}
		
		public static function print(...args):void
		{
			var str:String = "";
			var len:uint = args.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				str += args[i].toString();
				if(i < len - 1)str += " ";
			}
			txt.appendText(str + "\n");
		}
		
		/****************************************
		 * 
		 * PROTECTED
		 * 
		 ****************************************/
		
		/****************************************
		 * 
		 * PRIVATE
		 * 
		 ****************************************/
		
		private static function swapToTop():void
		{
			stage.setChildIndex(container, stage.numChildren - 1);
		}
		
		/****************************************
		 * 
		 * HANDLER
		 * 
		 ****************************************/
	}
}