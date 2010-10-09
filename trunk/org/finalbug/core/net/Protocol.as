package org.finalbug.core.net
{
	import flash.utils.ByteArray;
	
	public class Protocol
	{
		protected var _len:uint;
		protected var _pos:uint;
		protected var _finished:Boolean = false;
		
		public function get finished():Boolean
		{
			return _finished;
		}
		
		public function get length():uint
		{
			return _len;
		}
		
		public function get position():uint
		{
			return _pos;
		}
		
		public function Protocol()
		{
			_pos = 1;
			_finished = false;
		}
		
		public function parseData(data:ByteArray):ByteArray
		{
			return data;
		}
	}
}