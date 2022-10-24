package code {

  public class NitrogenDataBase {
		
		protected var _data:NitrogenData;
		protected var _fertilizer:NitrogenDataItem;
		protected var _wetland:NitrogenDataItem;
		
		public function NitrogenDataBase(data:NitrogenData) {
			_data = data;
			_fertilizer = new NitrogenDataFertilizer(this);
			_wetland = new NitrogenDataWetland(this);
		}
		
		public function get data():NitrogenData {
			return _data;
		}
		
		public function get fertilizer():NitrogenDataItem {
			return _fertilizer;
		}
		
		public function get wetland():NitrogenDataItem {
			return _wetland;
		}
		
		public function get initialNitrateFlux():int {
			return data.initialNitrateFlux;
		}
		
		public function get cropPriceIndex():int {
			return data.cropPriceIndex;
		}

		public function totalCropReduction():Number {
			return 100 - (100 - fertilizer.cropYieldReduction()) * (1 - wetland.cropYieldReduction() / 100);
		}
		
	}
}