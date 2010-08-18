package fal.errors
{
	public class UIError extends Error
	{
		public static const RESIZE_UNFULFILMENT:String = "resize method is not found in this UI component."
		public static const WIDTH_UNFULFILMENT:String = "get/set methods for width parameter are not found in this UI component.";
		public static const HEIGHT_UNFULFILMENT:String = "get/set methods for height parameter are not found in this UI component.";
		public static const TARGET_NULL:String = "Target object is null.";
		public static const OBJECT_IN_USE:String = "Target object is be using, cannot be remove or set null.";
		public static const WRONG_SCROLLBAR_TYPE:String = "ScrollBar component type error.";
		public static const WRONG_MENUITEM_TYPE:String = "Menu component item type error.";
		
		public static const WIDTH_DISABLED:String = "FOS UI Component's width cannot be modified directly," + 
				"please use 'Size' Object.";
		public static const HEIGHT_DISABLED:String = "FOS UI Component's height cannot be modified directly," + 
				"Please use 'Size' Object";
		
		public static const WIDTH_LESS_THAN_ZERO:String = "width less than 0.";
		public static const HEIGHT_LESS_THAN_ZERO:String = "height less than 0.";
		
		public static const THICKNESS_LESS_THAN_ZERO:String = "Object's thickness cannot less than 0.";
		public static const LINE_NOT_STRAIGHT:String = "Line is neither vertical nor horizontal.";
		
		public static const NO_IUI:String = "Target object must implement interface IUIObject.";
		
		public static const OUT_LESS_THAN_INNER:String = "Inner radio radius must less than outer radius.";
		
		public function UIError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}