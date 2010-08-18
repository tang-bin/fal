package fas.net
{
	public class ProtocolList
	{
		private static var list:ProtocolList;
		private static var instanceable:Boolean = false;
		
		private var p:Object;
		
		public static function get instance():ProtocolList
		{
			if(list == null)
			{
				instanceable = true;
				list = new ProtocolList();
				instanceable = false;
			}
			return list;
		}
		
		public function ProtocolList()
		{
			if(!instanceable)
			{
				throw new Error("Cannot be instanced");
			}
			p = new Object();
		}
		
		public function addProtocol(name:String, cls:Class):void
		{
			if(p[name] != null)
			{
				throw new Error("Protocol " + name + " exists");
			}
			p[name] = cls;
		}
		
		public function removeProtocol(name:String):void
		{
			if(p[name] == null)
			{
				throw new Error("Protocol " + name + " does not exist");
			}
			p[name] = null;
		}
		
		public function getProtocol(name:String):Class
		{
			if(p[name] == null)
			{
				throw new Error("Protocol " + name + " does not exist");
			}
			return p[name] as Class;
		}
		
		public function hasProtocol(name:String):Boolean
		{
			return p[name] != null;
		}
	}
}