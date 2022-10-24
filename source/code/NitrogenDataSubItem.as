package code {
	
  public class NitrogenDataSubItem extends NitrogenDataBase {
		
		private var subData:NitrogenDataSub;
		private var _name:String;
		private var deliveryIndex:Number;
		private var area:Number;
		private var _croplandArea:Number;
		
		public function NitrogenDataSubItem(data:NitrogenData,
																				subData:NitrogenDataSub,
																				name:String,
																				deliveryIndex:Number,
																				area:Number,
																				croplandArea:Number) {
			super(data);
			this.subData = subData;
			_name = name;
			this.deliveryIndex = deliveryIndex;
			this.area = area;
			_croplandArea = croplandArea;
		}
		
		public function get croplandArea():Number {
			return _croplandArea;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function nitrateDeliveryToGulf():Number {
			return ((1 - super.wetland.actionValue) *
							((1 - super.fertilizer.actionValue) * nitrateSupplyInAYear()))
							* deliveryIndex;
		}
		
		public function totalFertilizerCosts():Number {
			return super.fertilizer.totalCost() * croplandArea / this.subData.croplandArea();
		}
		
		public function totalWetlandCosts():Number {
			return super.wetland.totalCost() * croplandArea / this.subData.croplandArea();
		}
		
		public function weightedCropReduction():Number {
			return super.totalCropReduction() * croplandArea / this.subData.croplandArea();
		}
		
		private function nitrateSupplyInAYear():Number {
			return croplandArea * super.initialNitrateFlux / subData.croplandArea();
		}
		
	}
}