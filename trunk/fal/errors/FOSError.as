package fas.errors
{
	/**
	 * This class defines some popular errors.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class FOSError extends Error
	{
		public static const canNotInstance:String = "This class is singleton that cannot be instance.";
		public static const URLisEmpty:String = "URL address is empty."
		public static const NAME_EXIST:String = "The name of this data already exist.";
		public static const NAME_NOT_EXIST:String = "Object not exist.";
		public static const INVALID_VAR_NAME:String = "Invalid variable name.";
		public static const LEVEL_NOT_EXIST:String = "Character level not exist.";
		public static const NAME_EMPTY:String = "Name is empty.";
		
		public function FOSError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}