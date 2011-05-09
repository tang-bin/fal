package ftk.controls
{
	/**
	 * @author Tang Bin
	 * @since 2011.05
	 */
	public interface IListItemInterface
	{
		function get labelField():String;

		function set labelField(value:String):void;

		function get data():Object;

		function set data(value:Object):void;

		function get selected():Boolean;

		function set selected(value:Boolean):void;
	}
}
