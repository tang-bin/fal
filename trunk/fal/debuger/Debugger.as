/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.debuger
{
	import fal.display.Bin;
	
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * fal.debugger.Debugger
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class Debugger extends Bin
	{
		/****************************************
		 * 
		 * DEFINE
		 * 
		 ****************************************/
		
		private static var _container:Bin;
		
		private static var txt:TextField;
		
		/****************************************
		 * 
		 * GETTER & SETTER
		 * 
		 ****************************************/
		
		public static function set container(value:Bin):void
		{
			_container = value;
			init();
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
		
		public static function log(...args):void
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
		
		public static function init():void
		{
			if(_container != null)
			{
				txt = new TextField();
				_container.addChild(txt);
				txt.width = 300;
				txt.height = 200;
				txt.defaultTextFormat = new TextFormat("Arial", 12, 0xFF9900);
				txt.wordWrap = true;
				txt.multiline = true;
				txt.border = true;
			}
		}
		
		/****************************************
		 * 
		 * HANDLER
		 * 
		 ****************************************/
	}
}