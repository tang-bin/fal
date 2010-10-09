/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.framework.css
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.finalbug.core.data.DataModel;
	import org.finalbug.core.utils.StringUtil;
	
	/**
	 * org.finalbug.fal.css.CSSFile
	 *  
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class CSSFile extends DataModel
	{
		//***************************************
		// 
		// DEFINE
		// 
		//***************************************/
		
		private var _url:String = "";
		private var loader:URLLoader;
		private var _ready:Boolean = false;
		private var _error:Boolean = false;
		private var styleList:StyleList = new StyleList();
		
		//***************************************
		// 
		// GETTER & SETTER
		// 
		//***************************************/
		
		public function get url():String
		{
			return _url;
		}
		
		public function get ready():Boolean
		{
			return _ready;
		}
		
		public function get error():Boolean
		{
			return _error;
		}
		
		//***************************************
		// 
		// org.finalbug.fal.css.CSSFile constructor.
		// 
		//***************************************/
		public function CSSFile(url:String = "")
		{
			super();
			if(url != null && url != "" && url != _url)
			{
				this.loadFile(url);
			}
		}
		
		//***************************************
		// 
		// OVERRIDE METHODS
		// 
		// Whit out getter, setter and handler
		// include public, protected and private.
		// 
		//***************************************/
		
		//***************************************
		// 
		// PUBLIC
		// 
		//***************************************/
		
		public function loadFile(url:String):void
		{
			if(url != null && url != "" && url != _url)
			{
				_url = url;
				_ready = _error = false;
				loader = new URLLoader(new URLRequest(url));
				loader.addEventListener(Event.COMPLETE, fileLoadedHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, fileLoadErrorHandler);
			}
		}
		
		//***************************************
		// 
		// PROTECTED
		// 
		//***************************************/
		
		//***************************************
		// 
		// PRIVATE
		// 
		//***************************************/
		
		/**
		 * Parse CSS string to CSSStyle
		 * 
		 * @param str
		 */		
		private function parseCSS(str:String):void
		{
			//Debugger.print(str);
			str = str.replace(/\/\*.*?\*\//gi, ""); // remove /**/ type comments
			var styleStrs:Array = str.match(/([^\}\{]+)\{[^\}]*\}/gi);
			var len:uint = styleStrs.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				var styleStr:String = styleStrs[i].toString();
				
				var styleName:String = styleStr.replace(/([^\}\{]+)\{[^\}]*\}/, "$1");
				styleName = StringUtil.trimAll(styleName);
				var style:CSSFilter = styleList.addStyle(styleName);
				
				var styleValues:String = styleStr.replace(/[^\}\{]+\{([^\}]*)\}/, "$1");
				styleValues = StringUtil.trimAll(styleValues);
				
				// styleVarList is the list of all styles in one CSS class.
				var styleVarList:Array = styleValues.split(";");
				for(var j:uint = styleVarList.length ; --j >= 0 ; )
				{
					var oneStyleStr:String = styleVarList[j].toString();
					if(oneStyleStr == "")
					{
						// if style string is empty, go to next.
						styleVarList.splice(j, 1);
					}
					else
					{
						// if tyle string is not empty, it must be format as "width:100px"
						var styleVar:Array = oneStyleStr.split(":");
						if(styleVar.length != 2 || styleVar[0] == "" || styleVar[1] == "")
						{
							// if cannot be separated to 2 parts by ":"
							// if any of the 2 parts is empty
							// css format error
							styleVarList.splice(j, 1);
						}
						else
						{
							style.addStyle(styleVar[0], styleVar[1]);
						}
					}
				}
			}
		}
		
		//***************************************
		// 
		// HANDLER
		// 
		//***************************************/
		
		private function fileLoadedHandler(e:Event):void
		{
			var str:String = loader.data.toString();
			parseCSS(str);
			loader = null;
			_ready = true;
			_error = false;
		}
		
		private function fileLoadErrorHandler(e:IOErrorEvent):void
		{
			loader = null;
			_ready = false;
			_error = true;
		}
	}
}
import org.finalbug.framework.css.CSSFilter;

class StyleList
{
	private var classList:Object = new Object(); // css classes whose names are start with "."
	private var idList:Object = new Object(); // css classes whose names are start with "#"
	private var selectorList:Object = new Object(); // no start with..
	
	public function addStyle(name:String):CSSFilter
	{
		var char:String = name.charAt(0);
		if(char == ".")
		{
			name = name.substring(1);
			if(classList[name] == null)
			{
				classList[name] = new CSSFilter(name, CSSFilter.CLASS_TYPE);
			}
			return classList[name];
		}
		else if(char == "#")
		{
			name = name.substring(1);
			if(idList[name] == null)
			{
				idList[name] = new CSSFilter(name, CSSFilter.ID_TYPE);
			}
			return idList[name];
		}
		else
		{
			if(selectorList[name] == null)
			{
				selectorList[name] = new CSSFilter(name, CSSFilter.SELECTOR_TYPE);
			}
			return selectorList[name];
		}
	}
	
	public function removeStyle(name:String):void
	{
		
	}
	
	public function getStyle(name:String):void
	{
		
	}
}