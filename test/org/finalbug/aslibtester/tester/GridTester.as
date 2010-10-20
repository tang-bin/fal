package org.finalbug.aslibtester.tester
{
	import org.finalbug.framework.layout.Container;
	import org.finalbug.framework.layout.Grid;
	
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