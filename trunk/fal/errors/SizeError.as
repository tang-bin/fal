package fal.errors
{
	public class SizeError extends Error
	{
		public static const WIDTH_OUTSIDE:String = "width value outside the range.";
		public static const HEIGHT_OUTSIDE:String = "height value outside the range.";
		
		public function SizeError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}