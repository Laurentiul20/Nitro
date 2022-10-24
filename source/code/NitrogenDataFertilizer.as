package code {
	
	import flash.errors.IllegalOperationError;

  public class NitrogenDataFertilizer extends NitrogenDataItem {
		
		public function NitrogenDataFertilizer(data:NitrogenDataBase) {
			super(data);
		}
		
		override protected function totalNitrateRemoved():Number {
			var av:Number = super.actionValue;
			return (av == 0) ? 0 : -867.13 * av * av + 1550.8 * av + 39.93;
		}
		
		override public function nitrateFluxToWatershed():Number {
			return super.data.initialNitrateFlux - totalNitrateRemoved();
		}
		
		override public function denitrification():Number {
			throw new IllegalOperationError("The NitrogenDataFertilizer class does not implement this method.");
		}
		
		override public function nitrateFluxToGulf():Number {
			var ret:Number = nitrateFluxToWatershed() - super.data.wetland.denitrification();
			return (ret < 0) ? 0 : ret;
		}
		
		override public function cropYieldReduction():Number {
			var av:Number = super.actionValue;
			return (av == 0) ? 0 : 68.881 * av * av + 0.8462 * av + 0.1958;
		}
		
		override protected function maximumYield():Number {
			return 20;
		}
		
		override protected function costOfLostCropsPerUnit():Number {
			return maximumYield() * cropYieldReduction() / 100;
		}
		
		override protected function otherCosts():Number {
			return 0;
		}
	}
}