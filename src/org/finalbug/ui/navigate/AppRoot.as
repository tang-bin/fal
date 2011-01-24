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
package org.finalbug.ui.navigate
{
	import flash.events.Event;
	
	import org.finalbug.ui.control.Container;
	
	/**
	 * AppRoot
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */	
	public class AppRoot extends Container
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		public function AppRoot()
		{
			super();
			stage.scaleMode = "noScale";
			stage.align = "TL";
			this.resize(stage.stageWidth, stage.stageHeight);
			stage.addEventListener(Event.RESIZE, resizeStageHandler);
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
		
		private function resizeStageHandler(e:Event):void
		{
			this.resize(stage.stageWidth, stage.stageHeight);
		}
	}
}