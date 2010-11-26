/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.utils
{
	/**
	 * This class offers some useful methods to deal with string.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class StringUtil
	{
		/**
		 * uppercase
		 */		
		public static const UPPERCASE:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		/**
		 * lowercase
		 */		
		public static const LOWERCASE:String = "abcedfghijklmnopqrstuvwxyz";
		/**
		 * number in string type.
		 */		
		public static const NUMBER:String = "0123456789";
		/**
		 * chars can be used as object's name in AS.
		 */		
		public static const NAME_AVAILABLE:String = "-_%$#";
		
		/**
		 * replace a short string in a long string to another stort string.
		 * 
		 * @param oldStr
		 * @param targetStr
		 * @param newStr
		 * @return
		 * 
		 */		
		public static function getReplaceString(oldStr:String, targetStr:String, newStr:String):String
		{
			if (oldStr != "" && targetStr != "")
			{
				while (oldStr.indexOf(targetStr) != -1)
				{
					var s1:String = oldStr.substring(0, oldStr.indexOf(targetStr));
					var s2:String = oldStr.substring(oldStr.indexOf(targetStr) + targetStr.length);
					oldStr = s1 + newStr + s2;
				}
			}
			return oldStr;
		}
		
		/**
		 * Get a random string which is maked up by lowercase.
		 * @param len Length of the string.
		 * @return 
		 * 
		 */		
		public static function getRandomString(len:Number = 10):String
		{
			var s:String = "";
			for(var i:Number = len ; --i >= 0 ; )
			{
				var index:Number = MathUtil.getRandomInt(0, LOWERCASE.length-1);
				s += LOWERCASE.charAt(index);
			}
			return s;
		}
		
		/**
		 * remove the blank and return/newline in a string.
		 * 
		 * @param str
		 * @return
		 */		
		public static function removeBlankInString(str:String):String
		{
			if(str == "")
			{
				return "";
			}
			else
			{
				str = getReplaceString(str, " ", "");
				str = getReplaceString(str, "\r", "");
				str = getReplaceString(str, "\n", "");
				return str;
			}
		}
		
		/**
		 * account the appear time of one string in another string.
		 * 
		 * @param str
		 * @param subStr
		 * @return
		 */		
		public static function getSubstringSum(str:String, subStr:String):Number
		{
			var num:Number = 0;
			var ary_str:Array = new Array();
			var c_index:Number = str.indexOf(subStr);
			ary_str[num] = c_index;
			if (c_index != -1)
			{
				num++;
			}
			while (str.indexOf(subStr, c_index+1) != -1)
			{
				c_index = str.indexOf(subStr, c_index+1);
				ary_str[num] = c_index;
				num++;
			}
			return num;
		}
				
		/**
		 * remove the blank in front of string.
		 * 
		 * @param str
		 * @return
		 */
		public static function trimLeft(str:String):String
		{
			str = str.replace(/^\s*([^\s]*)/gi, "$1");
			return str;
		}

		/**
		 * remove the blank at the end of string.
		 * 
		 * @param   str 
		 * @return  
		 */
		public static function trimRight(str:String):String
		{
			str = str.replace(/([^\s]*)\s*$/gi, "$1");
			return str;
		}
		
		/**
		 * remove blank in front of string and at the end of string.
		 * 
		 * @param   str 
		 * @return  
		 */
		public static function trim(str:String):String
		{
			str = StringUtil.trimLeft(str);
			str = StringUtil.trimRight(str);
			return str;
		}
		
		/**
		 * remove all blank in string.
		 * 
		 * @param   str 
		 * @return  
		 */
		public static function trimAll(str:String):String
		{
			str = str.replace(/\s+/gi, "");
			return str;
		}
		
		/**
		 * Enter description here
		 * 
		 * @param   str 
		 * @param   num 
		 * @return  
		 */
		public static function leftStr(str:String, num:Number):String
		{
			if(str.length > num)
			{
				str = str.substring(0, num);
			}
			return str;
		}

		/**
		 * Enter description here
		 * 
		 * @param   str 
		 * @param   num 
		 * @return  
		 */
		public static function rightStr(str:String, num:Number):String
		{
			if(str.length > num)
			{
				str = str.substr(-num);
			}
			return str;
		}

		/**
		 * Enter description here
		 * 
		 * @param   str 
		 * @return  
		 */
		public static function removeHTML(str:String):String
		{
			if(str.length == 0)
			{
				return str;
			}
			var temp:String = "";
			var s:Number;
			while((s = str.indexOf("<")) != -1)
			{
				temp += str.substr(0, s);
				str = str.substr(str.indexOf(">") + 1, str.length);
			}
			return temp+str;
		}
		
		/**
		 * check the string if it contains some illegal char.
		 * 
		 * @param   string 
		 * @param   chars  
		 * @return  
		 */
		public static function containChars(str:String, chars:String):Boolean
		{
			if(chars == null || str == null)
			{
				return false;
			}
			for(var i:Number = chars.length-1 ; i >= 0 ; i--)
			{
				if(str.indexOf(chars.charAt(i)) >= 0)
				{
					return true;
				}
			}
			return false;
		}

		/**
		 * Enter description here
		 * 
		 * @usage   
		 * @param   pstr  
		 * @param   str   
		 * @param   where 
		 * @return  
		 */
		public static function insertStr(pstr:String, str:String, where:Number):String
		{
			var leftPart:String = leftStr(pstr, where);
			var rightPart:String = rightStr(pstr, (pstr.length-where));
			var finalStr:String = leftPart + str + rightPart;
			return finalStr;
		}
		
		/**
		 * Enter description here
		 * 
		 * @usage   
		 * @param   str 
		 * @return  
		 */
		public static function prefix(str:String):String
		{
			str = str.substr(str.lastIndexOf("/") + 1);
			str = str.substring(0, str.lastIndexOf("."));
			return str;
		}
		
		/**
		 * Enter description here
		 * 
		 * @usage   
		 * @param   str 
		 * @return  
		 */
		public static function subfix(str:String):String
		{
			str = trim(str.toLowerCase());
			str = str.substring(str.lastIndexOf(".") + 1, str.length);
			return str;
		}
		
		/**
		 * Enter description here
		 * 
		 * @usage   
		 * @param   data 
		 * @return  
		 */
		public static function isValidXML(str:String):Boolean
		{
			var xml:XML;
			try
			{
				xml = new XML(str);
			}
			catch(e:Error)
			{
				return false;
			}
			return xml.nodeKind() != "element" ? false : true;
		}

		/**
		 * Check if a string is Email Address.
		 * 
		 * @usage   
		 * @param   str 
		 * @return  
		 */
		public static function isEmail(str:String):Boolean
		{
			if(str == null || str == "")
			{
				return false;
			}
			str = trim(str);
			var p:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/; 
			var re:Object = p.exec(str);
			return re == null ? false : true;
		}
		
		/**
		 * Check if a string is IP address.
		 * 
		 * @param str
		 * @return 
		 */		
		public static function isIPAddress(str:String):Boolean
		{
			if(str == null || str == "")
			{
				return false;
			}
			var reg:RegExp = /((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)/;
			return reg.test(str);
		}
		
		/**
		 * Enter description here
		 * 
		 * @usage   
		 * @param   str 
		 * @return  
		 */
		public static function isURL(str:String):Boolean
		{
			if(str == null)
			{
				return false;
			}
			str = trim(str).toLowerCase();
			var p:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/; 
			var re:Object = p.exec(str);
			return re == null ? false : true;
		}
		
		public static function getTimeStampString():String
		{
			var d:Date = new Date();
			var str:String = "";
			//str += d.getUTCFullYear().toString() + "_";
			str += d.getUTCHours().toString() + "_";
			str += d.getUTCMinutes().toString() + "_";
			str += d.getUTCSeconds().toString() + "_";
			str += d.getUTCMilliseconds().toString() + "_";
			str += (d.getUTCMonth() + 1).toString() + "_";
			str += d.getUTCDate().toString();
			return str;
		}
		
		public static function isPercnet(str:String):Boolean
		{
			var r1:RegExp = /\d+%/;
			return r1.test(str);
		} 
		
		public static function getLayoutNum(str:String):Number
		{
			var r1:RegExp = /\d+%/;
			var r2:RegExp = /\d+/;
			if(r1.test(str))
			{
				str = str.substr(0, str.length - 1);
				return (Number(str) / 100);
			}
			else if(r2.test(str))
			{
				return Number(str);
			}
			else
			{
				return 0;
			}
		}
		
		public static function getLogStringFromArray(arr:Array, showArea:Boolean = false):String
		{
			var str:String = "";
			var len:uint = arr.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				var obj:* = arr[i];
				if(obj is Array)
				{
					str += " " + getLogStringFromArray(obj, true);
				}
				else
				{
					str += " " + obj.toString();
				}
			}
			if(showArea) str = "[" + str + "]";
			return str;
		}
		
		public static function getBlankSpace(len:uint = 0):String
		{
			var str:String = "";
			for(var i:uint = len ; --i >= 0 ; )
			{
				str += " ";
			}
			return str;
		}
	}
}