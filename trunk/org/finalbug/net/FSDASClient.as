//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import org.finalbug.data.DataModel;
	import org.finalbug.data.SharedData;
	import org.finalbug.errors.FSDASClientError;
	import org.finalbug.events.ConnEvent;
	import org.finalbug.events.DataEvent;
	
	/**
	 * FSD(Finalbug Shared Data) ActionScript Client
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */	
	public class FSDASClient extends DataModel
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var data:Object = new Object();
		private var sk:Socket;
		private var _host:String;
		private var _port:uint;
		private var _connected:Boolean = false;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 */
		public function FSDASClient()
		{
			
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param host
		 * @param port
		 */
		public function connect(host:String, port:uint):void
		{
			if(sk != null && sk.connected)
			{
				sk.close();
			}
			_host = host;
			_port = port;
			try
			{
				sk = new Socket();
				setSKEvent();
				sk.connect(host, port);
			}
			catch(e:Error)
			{
				var ee:ConnEvent = new ConnEvent(ConnEvent.CONNECT_ERROR);
				this.dispatchEvent(ee);
			}
		}
		
		/**
		 * 
		 */
		public function close():void
		{
			
		}
		
		/**
		 * 
		 * @param name
		 * @return 
		 * @throws FSDASClientError
		 */
		public function listenData(name:String):SharedData
		{
			if(data[name] != null)
			{
				throw new FSDASClientError(FSDASClientError.ALREADY_LISTEN);
			}
			else
			{
				var sd:SharedData = new SharedData();
				// TODO: send request
				data[name] = sd;
				sd.addEventListener(DataEvent.CHANGE_DATA, dataChangedHandler, false, 0, false, 0);
				return sd;
			}
		}
		
		/**
		 * 
		 * @param name
		 */
		public function stopListenData(name:String):void
		{
			
		}
		
		//#######################################
		// PRIVATE
		//#######################################
		
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
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function dataChangedHandler(e:DataEvent):void
		{
			// TODO: data is changed by applictions, send it to server now.
		}
		
		private function getDataHandler(e:ProgressEvent):void
		{
			var data:ByteArray = new ByteArray();
			sk.readBytes(data);
			data.position = 0;
			while(data.bytesAvailable)
			{
				
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
