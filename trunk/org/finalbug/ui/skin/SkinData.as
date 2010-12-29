/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	
	/**
	 * SkinData
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class SkinData
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		public static const FILL_TYPE:String = "fillType";
		public static const VECTORIAL_TYPE:String = "vectorialType";
		public static const BITMAP_TYPE:String = "bitmapType";
		
		private var _status:String;
		private var _type:String;
		private var _data:*;
		private var _asDefalut:Boolean = false;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get status():String
		{
			return _status;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get data():*
		{
			return _data;
		}
		
		public function get asDefault():Boolean
		{
			return _asDefalut;
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function SkinData(status:String, type:String, data:*, asDefault:Boolean = false)
		{
			this._status = status;
			this._type = type;
			this._data = data;
			this._asDefalut = asDefault;
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