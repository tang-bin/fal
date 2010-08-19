package fal.data
{
	import fal.display.Bin;
	import fal.utils.AdvancedObject;
	
	
	/******************************************
	 * Finalbug ActionScript Library ( http://www.finalbug.org/ )
	 * 
	 * fal.data.LayoutData
	 *
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since Jul 12, 2010 9:10:38 PM
	 *
	 *****************************************/
	public class LayoutData extends AdvancedObject
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		public var width:* = 0;
		public var height:* = 0;
		public var left:* = 0;
		public var right:* = 0;
		public var horizontal:* = 0;
		public var vertical:* = 0;
		
		private var _bindParent:Bin = null;
		private var parentWidth:Number = 0;
		private var parentHeight:Number = 0;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		public function get widthValue():Number
		{
			return 0;
		}
		
		public function get heightValue():Number
		{
			return 0;
		}
		
		public function get xValue():Number
		{
			return 0;
		}
		
		public function get yValue():Number
		{
			return 0;
		}
		
		public function get bindParent():Bin
		{
			return _bindParent;
		}
		public function set bindParent(value:Bin):void
		{
			if(value != _bindParent)
			{
				_bindParent = value;
			}
		}
		
		/****************************************
		 * fal.data.LayoutData constructor.
		 ****************************************/
		public function LayoutData()
		{
			super();
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		public function setParentSize(width:Number, height:Number):void
		{
			
		}
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		private function checkParent():void
		{
			
		}
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}