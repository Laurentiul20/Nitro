package code {

	import flash.errors.IllegalOperationError;
	
  public class NitrogenDataSub implements INitrogenDataOp {
		
		private var items:Vector.<NitrogenDataSubItem>;
		private var data:NitrogenData;
		
		public function NitrogenDataSub(data:NitrogenData) {
			this.data = data;
			setupSubSectionsData();
		}
		
		public function getDataItem(name:String):NitrogenDataSubItem {
			for (var i:uint = 0; i < items.length; i++) {
				if (name == items[i].name)
					return items[i];
			}
			return null;
		}
		
		public function croplandArea():Number {
			var ret:Number = 0;
			for (var i:uint = 0; i < items.length; i++) {
				ret += items[i].croplandArea;
			}
			return ret;
		}

		public function nitrateToGulf(name:String):Number {
			var item:NitrogenDataSubItem = this.getDataItem(name);
			if (item)
				return item.nitrateDeliveryToGulf();
			else
				return 0;
		}

		/// interface INitrogenDataOp;
		public function totalFertilizerCosts():Number {
			var ret:Number = 0;
			for (var i:uint = 0; i < items.length; i++) {
				ret += items[i].totalFertilizerCosts();
			}
			return ret;
		}
		
		public function totalWetlandCosts():Number {
			var ret:Number = 0;
			for (var i:uint = 0; i < items.length; i++) {
				ret += items[i].totalWetlandCosts();
			}
			return ret;
		}
		
		public function hypoxiaArea():Number {
			var ret:Number = (nitrateDeliveryToGulf() - 687.34) * 20 - 5000;
			return (ret <= 0) ? 0 : ret;
		}
		
		public function cropYieldReduction():Number {
			var ret:Number = 0;
			for (var i:uint = 0; i < items.length; i++) {
				ret += items[i].weightedCropReduction();
			}
			return ret;
		}
		
		public function nitrateFluxToGulf():Number {
			return nitrateDeliveryToGulf();
		}
		
		public function denitrification():Number {
			throw new IllegalOperationError("The NitrogenDataSub class does not implement this method.");
		}
		
		public function nitrateFluxToWatershed():Number {
			throw new IllegalOperationError("The NitrogenDataSub class does not implement this method.");
		}
		/// end of interface INitrogenDataOp;
		
		private function nitrateDeliveryToGulf():Number {
			var ret:Number = 0;
			for (var i:uint = 0; i < items.length; i++) {
				ret += items[i].nitrateDeliveryToGulf();
			}
			return ret;
		}
		
		private function setupSubSectionsData():void {
			this.items = new Vector.<NitrogenDataSubItem>();
			var subItem:NitrogenDataSubItem = new NitrogenDataSubItem(
																						this.data, this,
																						NitrogenConsts.LOWER_MISSISSIPPI_NAME,
																						3,
																						200,
																						50);
			items.push(subItem);
			subItem = new NitrogenDataSubItem(this.data, this,
																				NitrogenConsts.ARKANSAS_RED_WHITE_NAME,
																				2,
																				500,
																				120);
			items.push(subItem);
			subItem = new NitrogenDataSubItem(this.data, this,
																				NitrogenConsts.OHIO_NAME,
																				1,
																				500,
																				120);
			items.push(subItem);
			subItem = new NitrogenDataSubItem(this.data, this,
																				NitrogenConsts.TENNESSEE_NAME,
																				1,
																				100,
																				10);
			items.push(subItem);
			subItem = new NitrogenDataSubItem(this.data, this,
																				NitrogenConsts.UPPER_MISSISSIPPI_NAME,
																				1,
																				500,
																				300);
			items.push(subItem);
			subItem = new NitrogenDataSubItem(this.data, this,
																				NitrogenConsts.MISSOURI_NAME,
																				0.45,
																				1200,
																				400);
			items.push(subItem);
		}
	}
}