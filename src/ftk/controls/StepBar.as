// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.controls
{
	import flash.text.TextField;
	import ftk.graphs.Flat;


	/**
	 * StepBar
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class StepBar extends UIControl
	{

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 */
		public function StepBar()
		{
		}

		/******************* OVERRIDE **************************************************/
		override protected function callAtAdded():void
		{
			bg = new Flat();
			slider = new Flat();
			fromTxt = new Label("frome");
			toTxt = new Label("to");
			tipTxt = new TextField();
		}

		/******************* DEFINE ****************************************************/
		private var bg:Flat;

		private var slider:Flat;

		private var fromTxt:Label;

		private var toTxt:Label;

		private var tipTxt:TextField;
		/******************* GETTER and SETTER *****************************************/
		
		/******************* PUBLIC ****************************************************/
		
		
		
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}