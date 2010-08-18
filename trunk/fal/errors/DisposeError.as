package fas.errors
{
	public class DisposeError extends Error
	{
		public static const UNIT_DATA_INEXIST:String = "The unit data inexistence.";
		public static const UNIT_DATA_EXIST:String = "The unit with the same name already exist.";
		
		public function DisposeError(message:String="", id:int=0)
		{
			super(message, id);
		}
	}
}