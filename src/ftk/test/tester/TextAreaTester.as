// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.test.tester
{
	import flash.events.MouseEvent;
	import ftk.ui.control.Button;
	import ftk.ui.control.Container;
	import ftk.ui.control.TextArea;


	/**
	 * TextAreaTester
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class TextAreaTester extends Container
	{

		/****************************************
		 *
		 * DEFINE
		 *
		 *************************************************************/
		private var txt:TextArea;

		private var btn:Button;

		/****************************************
		 *
		 * GETTER and SETTER
		 *
		 *************************************************************/
		/****************************************
		 *
		 * org.finalbug.faltester.tester.TextAreaTester constructor.
		 *
		 *************************************************************/
		public function TextAreaTester()
		{
			super();
		}

		/****************************************
		 *
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 *
		 *************************************************************/
		override protected function callAtAdded():void
		{
			super.callAtAdded();
			if (txt == null)
			{
				txt = new TextArea();
				txt.x = txt.y = 100;
				// txt.layoutStyle = new LayoutStyle();
				//
				btn = new Button("CLICK");
				btn.x = btn.y = 20;
				btn.addEventListener(MouseEvent.CLICK, clickBtnHandler);
				//
				this.addAll(btn, txt);
				this.horizontalRank(20);
			}
		}

		/****************************************
		 *
		 * PUBLIC
		 *
		 *************************************************************/
		/****************************************
		 *
		 * PROTECTED
		 *
		 *************************************************************/
		/****************************************
		 *
		 * PRIVATE
		 *
		 *************************************************************/
		/****************************************
		 *
		 * HANDLER
		 *
		 *************************************************************/
		private function clickBtnHandler(e:MouseEvent):void
		{
			txt.layoutStyle.setValue("width", "50%");
			txt.layoutStyle.setValue("height", "50%");
		}
	}
}