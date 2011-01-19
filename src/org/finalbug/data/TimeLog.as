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
package org.finalbug.data
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.finalbug.errors.DataError;
	
	/**
	 * TimeLog
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */	
	public class TimeLog
	{
		//#######################################
		// SINGLETON
		//#######################################
		
		private static var tl:TimeLog;
		private static var instanceable:Boolean = false;
		
		/**
		 * 
		 * @return 
		 */
		public static function get instance():TimeLog
		{
			if(tl == null)
			{
				instanceable = true;
				tl = new TimeLog();
				instanceable = false;
			}
			return tl;
		}
		
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var logList:Array = new Array();
		private var consLogList:Dictionary = new Dictionary();
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 * @throws DataError
		 */
		public function TimeLog()
		{
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
		}
				
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param txt
		 * @param id
		 */
		public function log(txt:String, group:String = ""):void
		{
			var data:LogData = new LogData();
			data.time = flash.utils.getTimer();
			data.timestamp = new Date();
			data.txt = txt;
			data.group = group;
			logList.push(data);
			//
			if(group != null)
			{
				if(consLogList[group] == null)
				{
					consLogList[group] = new Array();
				}
				consLogList[group].push(data);
			}
		}
		
		/**
		 * 
		 * @param group
		 * @return 
		 */
		public function getConsLogs(group:String):Array
		{
			var arr:Array = consLogList[group] as Array;
			var rs:Array = new Array();
			var lastTime:int;
			if(arr != null)
			{
				var str:String = "";
				var len:uint = arr.length;
				for(var i:uint = 0 ; i < len ; i++)
				{
					var data:LogData = arr[i] as LogData;
					if(i == 0)
					{
						str += "[" + data.group + " - " + data.date + "] ";
					}
					else
					{
						str += " =" + (data.time - lastTime) + "=> ";
					}
					str += "{" + data.txt + "}";
					lastTime = data.time;
				}
				rs.push(str);
			}
			return rs;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function getAllLogs():Array
		{
			var rs:Array = new Array();
			var len:uint = logList.length;
			for(var i:uint = 0 ; i < len ; i++)
			{
				var data:LogData = logList[i] as LogData;
				var str:String = "[";
				if(data.group != "")
				{
					str += data.group + " - ";
				}
				str += data.date + "](" + data.time + ") " + data.txt;
				rs.push(str);
			}
			return rs;
		}
		
		/**
		 * 
		 */
		public function clean():void
		{
			logList = new Array();
			consLogList = new Dictionary();
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}
class LogData
{
	/**
	 * 
	 * @default 
	 */
	public var time:int;
	/**
	 * 
	 * @default 
	 */
	public var timestamp:Date;
	/**
	 * 
	 * @default 
	 */
	public var group:String;
	/**
	 * 
	 * @default 
	 */
	public var txt:String;
	
	/**
	 * 
	 * @return 
	 */
	public function get date():String
	{
		var str:String = timestamp.hours + ":";
		str += timestamp.minutes + ":";
		str += timestamp.seconds;
		return str;
	}
}