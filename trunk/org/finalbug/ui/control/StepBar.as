/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.control
{
	
	import flash.text.TextField;
	
	import org.finalbug.ui.glazes.Flat;
	
	/**
	 * StepBar
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class StepBar extends UIObject
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private var bg:Flat;
		private var slider:Flat;
		private var fromTxt:Label;
		private var toTxt:Label;
		private var tipTxt:TextField;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function StepBar()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		override protected function callAtAdded():void
		{
			bg = new Flat();
		}
		
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