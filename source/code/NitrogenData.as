package code {

  public class NitrogenData {
		
		private var _watershed:String;
		private var _initialNitrateFlux:int;
		private var _cropPriceIndex:int;
		private var _whole:NitrogenDataWhole;
		private var _subSections:NitrogenDataSub;
		private var _pastHypoxicZones:NitrogenDataPast;
		private var currentDataBase:INitrogenDataOp;
		
		public function NitrogenData() {
			_initialNitrateFlux = 2180;
			_cropPriceIndex = 3;
			_whole = new NitrogenDataWhole(this);
			_subSections = new NitrogenDataSub(this);
			_pastHypoxicZones = new NitrogenDataPast();
			watershed = NitrogenConsts.WHOLE_NAME;
		}
		
		public function get watershed():String {
			return _watershed;
		}
		
		public function set watershed(value:String):void {
			if (value == _watershed)
				return;
			_watershed = value;
			if (value == NitrogenConsts.WHOLE_NAME)
				currentDataBase = whole;
			else if (value == NitrogenConsts.SUB_WATERSHEDS_NAME)
				currentDataBase = subSections;
			else if (value == NitrogenConsts.PAST_HYPOXIC_ZONES_NAME)
			  currentDataBase = pastHypoxicZones;
		}
		
		public function get initialNitrateFlux():int {
			return _initialNitrateFlux;
		}
		
		public function set initialNitrateFlux(value:int):void {
			_initialNitrateFlux = value;
		}
		
		public function get cropPriceIndex():int {
			return _cropPriceIndex;
		}
		
		public function set cropPriceIndex(value:int):void {
			_cropPriceIndex = value;
		}
		
		public function get whole():NitrogenDataWhole {
			return _whole;
		}
		
		public function get subSections():NitrogenDataSub {
			return _subSections;
		}
		
		public function get pastHypoxicZones():NitrogenDataPast {
			return _pastHypoxicZones;
		}
		
		public function isPastData() {
			return currentDataBase == pastHypoxicZones;
		}
		
		public function totalFertilizerCosts():Number {
			return currentDataBase.totalFertilizerCosts();
		}
		
		public function totalWetlandCosts():Number {
			return currentDataBase.totalWetlandCosts();
		}
		
		public function hypoxiaArea():Number {
			return currentDataBase.hypoxiaArea();
		}
		
		public function cropYieldReduction():Number {
			return currentDataBase.cropYieldReduction();
		}
		
		public function nitrateFluxToGulf():Number {
			return currentDataBase.nitrateFluxToGulf();
		}
		
		public function denitrification():Number {
			return currentDataBase.denitrification();
		}
		
		public function nitrateFluxToWatershed():Number {
			return currentDataBase.nitrateFluxToWatershed();
		}
	}
}