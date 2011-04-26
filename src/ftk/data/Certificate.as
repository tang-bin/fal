// ##########################################################
// # __________.__              .__ ___.
// # \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// #  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// #  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// #  \__|     |__|___|__(______/____/_____/____/\___  /
// #                                            /_____/
// # Flex ToolKits by Finalbug
// # http://www.finalbug.org
// ##########################################################
package ftk.data
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import ftk.errors.ConnError;
	import ftk.events.ConnEvent;


	/**
	 * Certificate is used to connect to remote server and verify name and key value.
	 * Not finished, not tested.
	 *
	 * @author Tang Bin
	 * @since 2011-1-27
	 */
	public class Certificate extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		// send type: verify
		private const TYPE_SEND_VERIFY:uint = 0;

		// send type: normal data
		private const TYPE_SEND_NORMAL:uint = 1;

		// get data type: verify.
		private const TYPE_GET_VERIFY:uint = 2;

		// get data type: normal data.
		private const TYPE_GET_NORMAL:uint = 3;

		// verify success, read only type.
		private const VERIFY_RS_READ_ONLY:uint = 11;

		// verify success, write only type.
		private const VERIFY_RS_WRITE_ONLY:uint = 12;

		// verify success, read and write type.
		private const VERIFY_RS_FULL:uint = 13;

		// verify failed, server deny.
		private const VERIFY_RS_DENY:uint = 14;

		// name used to verify.
		private var _name:String = "";

		// key used to verify.
		private var _key:String = "";

		// verified or not.
		private var _verified:Boolean = false;

		// connected to server or not.
		private var _connected:Boolean = false;

		// remote server host.
		private var _host:String = "";

		// remote server port
		private var _port:uint = 0;

		// keep connect to server after verified, only effect if verified successful.
		private var _keepConnect:Boolean = false;

		// socket
		private var sk:Socket;

		private var _verifyType:uint = 0;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * Name will be used to verify.
		 */
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			if (_connected)
			{
				throw new ConnError(ConnError.CHANGE_NAME_CONNECTED);
			}
			else if (value != _name)
			{
				_name = value;
				setVerified(false);
			}
		}

		/**
		 * key will be used to verify.
		 */
		public function get key():String
		{
			return _key;
		}

		public function set key(value:String):void
		{
			if (_connected)
			{
				throw new ConnError(ConnError.CNANGE_KEY_CONNECTED);
			}
			else if (value != _key)
			{
				_key = value;
				setVerified(false);
			}
		}

		/**
		 * is verified of not.
		 */
		public function get verified():Boolean
		{
			return _verified;
		}

		/**
		 * Is connected to server or not.
		 */
		public function get connected():Boolean
		{
			return _connected;
		}

		/**
		 * host of remote server.
		 * You cannot set this value directly.
		 * Please use verify() method to set host and port.
		 */
		public function get host():String
		{
			return _host;
		}

		/**
		 * port of remote server.
		 * You cannot set this value directly, 
		 * please use verify() method to set host and port.
		 */
		public function get port():uint
		{
			return _port;
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new Certificate object.
		 */
		public function Certificate()
		{
			super();
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Verify the connection.
		 * 
		 * @param host Server host
		 * @param port Server port
		 * @param keepConnect Keep connect to server after verified.
		 * 			Only effect after verify successful.
		 */
		public function verify(host:String, port:uint, keepConnect:Boolean = false):void
		{
			// save data
			_host = host;
			_port = port;
			_keepConnect = keepConnect;
			// close connection if connected.
			this.close();
			// connect to server.
			sk = new Socket();
			setSKEvent();
			sk.connect(_host, _port);
		}

		/**
		 * send data to server.
		 * Must be connected to server and verified.
		 * 
		 * @param data The data will be send to server.
		 */
		public function send(data:ByteArray):void
		{
			if (_connected && _verified)
			{
				sk.writeInt(TYPE_SEND_NORMAL);
				sk.writeBytes(data);
				sk.flush();
			}
			else
			{
				throw new ConnError(ConnError.NO_CONN_AND_VERIFY);
			}
		}

		/**
		 * Close connect.
		 */
		public function close():void
		{
			if (sk.connected)
			{
				removeSKEvent();
				sk.close();
			}
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function setVerified(value:Boolean):void
		{
			if (value != _verified)
			{
				_verified = value;
				var ee:ConnEvent = new ConnEvent(value ? ConnEvent.VERIFIED : ConnEvent.UNVERIFIED);
				this.dispatchEvent(ee);
			}
		}

		private function setConnect(value:Boolean):void
		{
			if (value != _connected)
			{
				_connected = value;
				var ee:ConnEvent = new ConnEvent(value ? ConnEvent.CONNECTED : ConnEvent.UNCONNECTED);
				this.dispatchEvent(ee);
			}
		}

		/**
		 * Add socket event listeners.
		 */
		private function setSKEvent():void
		{
			sk.addEventListener(ProgressEvent.SOCKET_DATA, getDataHandler);
			sk.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			sk.addEventListener(Event.CONNECT, connectHandler);
			sk.addEventListener(Event.CLOSE, closeHandler);
			sk.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		/**
		 * Remove all socket event listeners.
		 */
		private function removeSKEvent():void
		{
			sk.removeEventListener(ProgressEvent.SOCKET_DATA, getDataHandler);
			sk.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			sk.removeEventListener(Event.CONNECT, connectHandler);
			sk.removeEventListener(Event.CLOSE, closeHandler);
			sk.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function sendVaildInfo():void
		{
			this.setVerified(false);
			var ba:ByteArray = new ByteArray();
			ba.writeInt(TYPE_SEND_VERIFY);
			ba.writeUTF(_name);
			ba.writeUTF(_key);
			if (_connected)
			{
				sk.writeBytes(ba);
				sk.flush();
			}
		}

		/******************* HANDLER ***************************************************/
		private function getDataHandler(e:ProgressEvent):void
		{
			var data:ByteArray = new ByteArray();
			sk.readBytes(data);
			data.position = 0;
			//
			var type:uint = data.readInt();
			if (type == TYPE_GET_VERIFY)
			{
				// if get verify result.
				var rs:uint = data.readInt();
				switch(rs)
				{
					case VERIFY_RS_DENY:
						// verify failed. server deny
						this.setVerified(false);
						this.sk.close();
						break;
					case VERIFY_RS_FULL:
					case VERIFY_RS_READ_ONLY:
					case VERIFY_RS_WRITE_ONLY:
						// verify success, server accept.
						this._verifyType = rs;
						this.setVerified(true);
						if (!_keepConnect)
						{
							// close connect if not keep connect.
							this.sk.close();
						}
						break;
				}
			}
			else if (type == TYPE_GET_NORMAL)
			{
				// TODO: dispatch data arrived.
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

		/**
		 * Handler of connect to server successful.
		 */
		private function connectHandler(e:Event):void
		{
			sendVaildInfo();
			this.setConnect(true);
			if (!_keepConnect)
			{
				sk.close();
			}
		}

		private function closeHandler(e:Event):void
		{
			this.setConnect(false);
		}
	}
}
