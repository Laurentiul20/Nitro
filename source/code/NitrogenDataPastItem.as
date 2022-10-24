package code {
	
  public class NitrogenDataPastItem {
		
		private var _year:int;
		private var hypoxiaAreaInSquareMiles:Number;
		
		public function NitrogenDataPastItem(year:int,
																				 hypoxiaAreaInSM:Number) {
			_year = year;
			hypoxiaAreaInSquareMiles = hypoxiaAreaInSM;
		}
		
		public function get year():int {
			return _year;
		}
		
		public function get hypoxiaArea():Number {
			return hypoxiaAreaInSquareMiles * 2.58998811;
		}
		
	}
}