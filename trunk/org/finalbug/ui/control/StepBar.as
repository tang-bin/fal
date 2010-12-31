//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
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
		//#######################################
		// DEFINE
		//#######################################
		
		private var bg:Flat;
		private var slider:Flat;
		private var fromTxt:Label;
		private var toTxt:Label;
		private var tipTxt:TextField;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function StepBar()
		{
			super();
		}
		
		//#######################################
		// OVERRIDE
		// Whit out getter, setter and handler
		// include public, protected and private.
		//#######################################
		
		override protected function callAtAdded():void
		{
			bg = new Flat();
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}