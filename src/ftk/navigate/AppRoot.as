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
package ftk.navigate
{
	import flash.events.Event;

	import ftk.layout.Container;

	/**
	 * AppRoot
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class AppRoot extends Container
	{
		public function AppRoot()
		{
			super();
			stage.scaleMode = "noScale";
			stage.align = "TL";
			this.resize(stage.stageWidth, stage.stageHeight);
			stage.addEventListener(Event.RESIZE, resizeStageHandler);
			//
			this.backgroundAlpha = 1;
			this.backgroundColor = 0xEEEEEE;
		}

		private function resizeStageHandler(e:Event):void
		{
			this.resize(stage.stageWidth, stage.stageHeight);
		}
	}
}