package fas
{
	/**
	 * @author Finalbug
	 */	
	public class Version
	{
		public static const VersionNum:Number = 1;
		public static const RevisionNum:Number = 5;
		public static const PulishDate:String = "091224";
		
		public static function get VersionString():String
		{
			return VersionNum + "." + RevisionNum + "." + PulishDate;
		}
	}
}