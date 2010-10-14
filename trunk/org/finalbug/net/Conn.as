package org.finalbug.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import org.finalbug.core.data.DataModel;
	import org.finalbug.core.net.Protocol;
	import org.finalbug.core.net.ProtocolList;
	import org.finalbug.net.events.ConnEvent;
	
	[Event(name="ConnectError", type="fal.events.ConnEvent")]
	[Event(name="connect", type="fal.events.ConnEvent")]
	[Event(name="connectClose", type="fal.events.ConnEvent")]
	[Event(name="getData", type="fal.events.ConnEvent")]
	
	public class Conn extends DataModel
	{
		private static var conn:Conn;
		private static var instanceable:Boolean = false;
		
		private var host:String;
		private var port:uint;
		private var sk:Socket;
		private var currentProtocol:Protocol;
		
		public static function get instance():Conn
		{
			if(conn == null)
			{
				instanceable = true;
				conn = new Conn();
				instanceable = false;
			}
			return conn;
		}
		
		public function Conn()
		{
			if(!instanceable)
			{
				throw new Error("Cannot be instanced");
			}
		}
		
		public function connect(host:String, port:uint):void
		{
			if(sk != null && sk.connected)
			{
				sk.close();
			}
			this.host = host;
			this.port = port;
			try
			{
				sk = new Socket();
				setSKEvent();
				sk.connect(host, port);
			}
			catch(e:Error)
			{
				var ee:ConnEvent = new ConnEvent(ConnEvent.CONNECT_ERROR);
				this.dispatcher.dispatchEvent(ee);
			}
		}
		
		public function close():void
		{
			if(sk != null)
			{
				if(sk.connected)sk.close();
				sk = null;
			}
		}
		
		private function setSKEvent():void
		{
			sk.addEventListener(ProgressEvent.SOCKET_DATA, getDataHandler);
			sk.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			sk.addEventListener(Event.CONNECT, connectHandler);
			sk.addEventListener(Event.CLOSE, closeHandler);
			sk.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		private function removeSKEvent():void
		{
			sk.removeEventListener(ProgressEvent.SOCKET_DATA, getDataHandler);
			sk.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			sk.removeEventListener(Event.CONNECT, connectHandler);
			sk.removeEventListener(Event.CLOSE, closeHandler);
			sk.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		private function getDataHandler(e:ProgressEvent):void
		{
			var data:ByteArray = new ByteArray();
			sk.readBytes(data);
			data.position = 0;
			while(data.bytesAvailable)
			{
				if(currentProtocol == null)
				{
					var pName:String = data.readUTF();
					currentProtocol = new (ProtocolList.instance.getProtocol(pName))() as Protocol;
				}
				currentProtocol.parseData(data);
				if(currentProtocol.finished)
				{
					var ee:ConnEvent = new ConnEvent(ConnEvent.GET_DATE);
					ee.protocol = currentProtocol;
					this.dispatchEvent(ee);
					currentProtocol = null;
				}
			}
		}
		
		private function securityErrorHandler(e:Event):void
		{
			var ee:ConnEvent = new ConnEvent(ConnEvent.CONNECT_ERROR);
			this.dispatchEvent(ee);
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			var ee:ConnEvent = new ConnEvent(ConnEvent.CONNECT_ERROR);
			this.dispatchEvent(ee);
		}
		
		private function connectHandler(e:Event):void
		{
			var ee:ConnEvent = new ConnEvent(ConnEvent.CONNECT);
			this.dispatchEvent(ee);
		}
		
		private function closeHandler(e:Event):void
		{
			var ee:ConnEvent = new ConnEvent(ConnEvent.CONNECT_CLOSE);
			this.dispatchEvent(ee);
		}
	}
}