package code {
	
	import flash.errors.IllegalOperationError;

  public class NitrogenDataWetland extends NitrogenDataItem {
		
		public function NitrogenDataWetland(data:NitrogenDataBase) {
			super(data);
		}
		
		override protected function totalNitrateRemoved():Number {
			throw new IllegalOperationError("The NitrogenDataWetland class does not implement this method.");
		}
		
		override public function nitrateFluxToWatershed():Number {
			return super.data.initialNitrateFlux;
		}
		
		override public function denitrification():Number {
			var av:Number = super.actionValue;
			return -375.29 * av * av + 766.2 * av + 687.34;
		}
		
		override public function nitrateFluxToGulf():Number {
			throw new IllegalOperationError("The NitrogenDataWetland class does not implement this method.");
		}
		
		override public function cropYieldReduction():Number {
			var av:Number = super.actionValue;
			return (av == 0) ? 0 : 18.531 * av * av + 1.8322 * av + 0.007;
		}
		
		override protected function maximumYield():Number {
			throw new IllegalOperationError("The NitrogenDataWetland class does not implement this method.");
		}
		
		override protected function costOfLostCropsPerUnit():Number {
			return cropYieldReduction() / 5;
		}
		
		override protected function otherCosts():Number {
			return 20 * super.actionValue;
		}
	}
}