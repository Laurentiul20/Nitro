package code {

  public class NitrogenDataWhole extends NitrogenDataBase implements INitrogenDataOp {
		
		public function NitrogenDataWhole(data:NitrogenData) {
			super(data);
		}
		
		/// interface INitrogenDataOp;
		public function totalFertilizerCosts():Number {
			return fertilizer.totalCost();
		}
		
		public function totalWetlandCosts():Number {
			return wetland.totalCost();
		}
		
		public function hypoxiaArea():Number {
			var niToGulf:Number = fertilizer.nitrateFluxToGulf();
			var ret:Number = (niToGulf - wetland.actionValue * niToGulf) * 20 - 5000;
			return (ret <= 0) ? 0 : ret;
		}
		
		public function cropYieldReduction():Number {
			return super.totalCropReduction();
		}
		
		public function nitrateFluxToGulf():Number {
			return fertilizer.nitrateFluxToGulf();
		}
		
		public function denitrification():Number {
			return wetland.denitrification();
		}
		
		public function nitrateFluxToWatershed():Number {
			return fertilizer.nitrateFluxToWatershed();
		}
		/// end of interface INitrogenDataOp;
	}
}