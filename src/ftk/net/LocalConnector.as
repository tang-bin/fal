// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.net
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class LocalConnector
	{
		/**
		 * 
		 * @param localName
		 * @param remoteName
		 */
		public function LocalConnector(localName:String, remoteName:String):void
		{
			this.bytes = new ByteArray();
			this._connected = false;
			this.localName = localName;
			this.remoteName = remoteName;
		}

		/**
		 * 
		 * @default 
		 */
		public var receiveHandler:Function;

		/**
		 * 
		 * @default 
		 */
		public var sendFailedHandler:Function;

		/**
		 * 
		 * @default 
		 */
		protected var _connected:Boolean;

		private var bytes:ByteArray;

		private var localConn:LocalConnection;

		private var remoteConn:LocalConnection;

		private var localName:String;

		private var remoteName:String;

		/**
		 * 
		 * @return 
		 */
		public function get connected():Boolean
		{
			return this._connected;
		}

		/**
		 * 
		 * @param data
		 */
		public function send(data:Object):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.endian = Endian.BIG_ENDIAN;
			bytes.objectEncoding = ObjectEncoding.AMF3;
			bytes.writeObject(data);

			var byteLimit:uint = 40 * 1000;
			var totalBytes:uint = bytes.length;
			var i:int;
			var c:int = totalBytes / byteLimit;
			var r:uint = totalBytes % byteLimit;

			var count:int = c + (r > 0 ? 1 : 0);

			for (i = 0; i < c; i++)
			{
				this.sendData(bytes, i * byteLimit, byteLimit, i, count);
			}
			if (r > 0)
			{
				this.sendData(bytes, c * byteLimit, r, c, count);
			}
		}

		/**
		 * 
		 * @param item
		 * @param index
		 * @param count
		 */
		public function onReceiveData(item:Object, index:Object, count:Object):void
		{
			this.getData(item, index, count);
		}

		/**
		 * 
		 * @return 
		 */
		public function getDataHandler():String
		{
			return "onReceiveData";
		}

		/**
		 * 
		 */
		public function connect():void
		{
			this.remoteConn = new LocalConnection();
			this.remoteConn.addEventListener(StatusEvent.STATUS, sendStatusHandler);

			this.localConn = new LocalConnection();
			this.localConn.allowDomain("*");
			this.localConn.client = this;

			try
			{
				this.localConn.connect(localName);
			}
			catch(e:Error)
			{
				trace(e.getStackTrace());
			}
			this._connected = true;
		}

		private function getData(item:Object, indexObj:Object, countObj:Object):void
		{
			var index:int = indexObj as int;
			var count:int = countObj as int;
			if (index == 0) this.bytes = new ByteArray();

			var temp:ByteArray = item as ByteArray;
			bytes.writeBytes(temp, 0, temp.bytesAvailable);

			if (index == (count - 1))
			{
				bytes.position = 0;
				var obj:Object = bytes.readObject();
				if (this.receiveHandler != null) this.receiveHandler(obj);
			}
		}

		private function sendData(bytes:ByteArray, offset:uint, length:uint, index:Object, count:Object):void
		{
			var tempBytes:ByteArray = new ByteArray();
			tempBytes.endian = Endian.BIG_ENDIAN;
			tempBytes.objectEncoding = ObjectEncoding.AMF3;
			tempBytes.writeBytes(bytes, offset, length);
			tempBytes.position = 0;

			this.doSendData(tempBytes, index, count);
		}

		private function doSendData(obj:Object, index:Object, count:Object):void
		{
			remoteConn.send(remoteName, this.getDataHandler(), obj, index, count);
		}

		private function sendStatusHandler(event:StatusEvent):void
		{
			switch (event.level)
			{
				case "status":
					break;
				case "error":
					if (sendFailedHandler != null) sendFailedHandler.call(this);
					break;
			}
		}
	}
}