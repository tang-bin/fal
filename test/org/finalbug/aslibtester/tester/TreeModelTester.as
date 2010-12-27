/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.aslibtester.tester
{
	import org.finalbug.data.TreeModel;
	import org.finalbug.ui.control.Container;
	
	
	/**
	 * TreeModelTester
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class TreeModelTester extends Container
	{
		private var tm:TreeModel = new TreeModel();
		
		public function TreeModelTester()
		{
			super();
			var xml:XML = 
				<root a="A" b="B">
					<node name="a1" gender="dog">
						<node name="a11">aa11</node>
					</node>
					<node name="a2">aa2</node>
					<node name="a3">
						<node name="a31">
							<node name="a311"/>
							<node name="a312"/>
							<node name="a313"/>
							<node name="a314"/>
							<node name="a315"/>
						</node>
					</node>
					<node name="a4">aa4</node>
					<node name="a5">aa5</node>
					<node name="a6">aa6</node>
					<node name="a7">aa7</node>
				</root>;
			tm.xml = xml;
			var nodes:Array = tm.getNodeByAttribute("name", "a31");
			trace(tm.getNodes(tm.root));
			//tm.traceAll();
		}
	}
}