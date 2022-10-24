package code {
	
	import flash.errors.IllegalOperationError;

  public class NitrogenDataItem {
		
		protected var data:NitrogenDataBase;
		protected var _value:Number;
		
		public function NitrogenDataItem(data:NitrogenDataBase) {
			this.data = data;
			_value = 0;
		}
		
		public function totalCost():Number {
			return totalCostOfLostCrops() + otherCosts();
		}
		
		public function get value():int {
			return _value;
		}
		
		public function set value(val:int):void {
			_value = val;
		}
		
		public function get actionValue():Number {
			return value / 100;
		}
		
		protected function totalNitrateRemoved():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		public function nitrateFluxToWatershed():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		public function denitrification():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		public function nitrateFluxToGulf():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		public function cropYieldReduction():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		protected function maximumYield():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		protected function costOfLostCropsPerUnit():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
		
		protected function totalCostOfLostCrops():Number {
			return costOfLostCropsPerUnit() * this.data.cropPriceIndex;
		}
		
		protected function otherCosts():Number {
			throw new IllegalOperationError("The NitrogenDataItem class does not implement this method.");
		}
	}
}