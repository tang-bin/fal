package org.finalbug.test.tester
{
	import org.finalbug.ui.control.Container;
	import org.finalbug.ui.layout.Grid;
	
	public class GridTester extends Container
	{
		private var gd:Grid;
		
		public function GridTester()
		{
			super();
			gd = new Grid();
			this.addAll(gd);
			
			gd.rows = [100, 90, 80, 200];
			gd.columns = [100, 50, 100, 40, 200];
			gd.rebuild();
		}
	}
}