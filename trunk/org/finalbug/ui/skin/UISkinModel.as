/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.DataModel;
	import org.finalbug.errors.DataError;
	
	
	/**
	 * UISkinModel
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class UISkinModel extends DataModel
	{
		//***************************************
		// SINGLETON
		//***************************************/
		
		private static var instanceable:Boolean = false;
		private static var sm:UISkinModel;
		
		public static function get instance():UISkinModel
		{
			if(sm == null)
			{
				instanceable = true;
				sm = new UISkinModel();
				instanceable = false;
			}
			return sm;
		}
		
		//***************************************
		// DEFINE
		//***************************************/
		
		private var UISkins:Dictionary = new Dictionary();
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get buttonSkinData():ButtonSkinData
		{
			if(UISkins["buttonSkinData"] == null) UISkins["buttonSkinData"] = new ButtonSkinData();
			return UISkins["buttonSkinData"];
		}
		
		public function get scrollBarSkinData():ScrollBarSkinData
		{
			if(UISkins["scrollBarSkinData"] == null) UISkins["scrollBarSkinData"] = new ScrollBarSkinData();
			return UISkins["scrollBarSkinData"];
		}
		
		public function get checkBoxSkinData():CheckBoxSkinData
		{
			if(UISkins["checkBoxSkinData"] == null) UISkins["checkBoxSkinData"] = new CheckBoxSkinData();
			return UISkins["checkBoxSkinData"];
		}
		
		public function get radioSkinData():RadioSkinData
		{
			if(UISkins["radioSkinData"] == null) UISkins["radioSkinData"] = new RadioSkinData();
			return UISkins["radioSkinData"];
		}
		
		public function get textSkinData():TextSkinData
		{
			if(UISkins["textSkinData"] == null) UISkins["textSkinData"] = new TextSkinData();
			return UISkins["textSkinData"];
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function UISkinModel()
		{
			super();
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}