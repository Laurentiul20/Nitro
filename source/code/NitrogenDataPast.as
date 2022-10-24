package code {

	import flash.errors.IllegalOperationError;
	import fl.data.DataProvider;
	
  public class NitrogenDataPast implements INitrogenDataOp {
		
		private var items:Vector.<NitrogenDataPastItem>;
		private var _selectedYear:int;
		private var _dataProvider:DataProvider;
		
		public function NitrogenDataPast() {
			_selectedYear = 1985;
			setupPastHypoxicZonesData();
		}
		
		public function get selectedYear():int {
			return _selectedYear;
		}
		
		public function set selectedYear(value:int):void {
			_selectedYear = value;
		}
		
		public function get dataProvider():DataProvider {
			return _dataProvider;
		}
		
		public function selectedIndex():int {
			var ret:int = -1;
			var item:Object;
			for (var i:uint = 0; i < _dataProvider.length; i++) {
				item = _dataProvider.getItemAt(i);
				if (_selectedYear == int(item.label))
				  ret = item.data;
			}
			return ret;
		}
		
		/// interface INitrogenDataOp;
		public function totalFertilizerCosts():Number {
			throw new IllegalOperationError("The NitrogenDataPast class does not implement this method.");
		}
		
		public function totalWetlandCosts():Number {
			throw new IllegalOperationError("The NitrogenDataPast class does not implement this method.");
		}
		
		public function hypoxiaArea():Number {
			var item:NitrogenDataPastItem = getDataItem(_selectedYear);
			return (item != null) ? item.hypoxiaArea : 0;
		}
		
		public function cropYieldReduction():Number {
			throw new IllegalOperationError("The NitrogenDataPast class does not implement this method.");
		}
		
		public function nitrateFluxToGulf():Number {
			throw new IllegalOperationError("The NitrogenDataPast class does not implement this method.");
		}
		
		public function denitrification():Number {
			throw new IllegalOperationError("The NitrogenDataPast class does not implement this method.");
		}
		
		public function nitrateFluxToWatershed():Number {
			throw new IllegalOperationError("The NitrogenDataPast class does not implement this method.");
		}
		/// end of interface INitrogenDataOp;
		
		private function getDataItem(year:int):NitrogenDataPastItem {
			for (var i:uint = 0; i < items.length; i++) {
				if (year == items[i].year)
					return items[i];
			}
			return null;
		}
		
		private function setupPastHypoxicZonesData():void {
			this.items = new Vector.<NitrogenDataPastItem>();
			items.push(new NitrogenDataPastItem(1985, 3700));
			items.push(new NitrogenDataPastItem(1986, 3600));
			items.push(new NitrogenDataPastItem(1987, 2500));
			items.push(new NitrogenDataPastItem(1990, 3500));
			items.push(new NitrogenDataPastItem(1991, 4500));
			items.push(new NitrogenDataPastItem(1992, 4100));
			items.push(new NitrogenDataPastItem(1993, 6700));
			items.push(new NitrogenDataPastItem(1994, 6300));
			items.push(new NitrogenDataPastItem(1995, 6900));
			items.push(new NitrogenDataPastItem(1996, 6800));
			items.push(new NitrogenDataPastItem(1997, 6000));
			items.push(new NitrogenDataPastItem(1998, 4700));
			items.push(new NitrogenDataPastItem(1999, 7600));
			items.push(new NitrogenDataPastItem(2000, 1600));
			items.push(new NitrogenDataPastItem(2001, 7900));
			items.push(new NitrogenDataPastItem(2002, 8400));
			items.push(new NitrogenDataPastItem(2003, 3200));
			items.push(new NitrogenDataPastItem(2004, 5700));
			items.push(new NitrogenDataPastItem(2005, 4500));
			items.push(new NitrogenDataPastItem(2006, 6600));
			items.push(new NitrogenDataPastItem(2007, 7800));
			items.push(new NitrogenDataPastItem(2008, 7900));
			items.push(new NitrogenDataPastItem(2009, 3000));
			// setup data provider;
			_dataProvider = new DataProvider();
			for (var i:uint = 0; i < items.length; i++) {
				_dataProvider.addItem( {label: String(items[i].year), data: i} );
			}
		}
	}
}