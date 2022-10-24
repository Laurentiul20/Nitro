package code {
	
	import flash.display.*;
	import flash.geom.Matrix;

  public class NitrogenRestorableWetlands extends Sprite {
		
//		wetland1 width/2: 109
//		wetland1 height/2: 131
//		wetland2 width/2: 142.5
//		wetland2 height/2: 117.5
//		wetland3 width/2: 72.5
//		wetland3 height/2: 61
//		wetland4 width/2: 100
//		wetland4 height/2: 211.5
//		private const WETLAND1_X:Number = 340;
//		private const WETLAND1_Y:Number = 155;
//		private const WETLAND2_X:Number = 458;
//		private const WETLAND2_Y:Number = 235;
//		private const WETLAND3_X:Number = 464;
//		private const WETLAND3_Y:Number = 317;
//		private const WETLAND4_X:Number = 408;
//		private const WETLAND4_Y:Number = 356;
//		private const BASE_SCALE_X:Number = 0.25;
//		private const BASE_SCALE_Y:Number = 0.29;
    // 20% more;
		private const BASE_SCALE_X:Number = 0.3;
		private const BASE_SCALE_Y:Number = 0.348;
		private const WETLAND1_X:Number = 340 - 109 * (BASE_SCALE_X - 0.25);
		private const WETLAND1_Y:Number = 155 - 131 * (BASE_SCALE_Y - 0.29);
		private const WETLAND2_X:Number = 458 - 142.5 * (BASE_SCALE_X - 0.25);
		private const WETLAND2_Y:Number = 235;
		private const WETLAND3_X:Number = 464 - 72.5 * (BASE_SCALE_X - 0.25);
		private const WETLAND3_Y:Number = 317 - 61 * (BASE_SCALE_Y - 0.29);
		private const WETLAND4_X:Number = 408 - 100 * (BASE_SCALE_X - 0.25);
		private const WETLAND4_Y:Number = 356 - 211.5 * (BASE_SCALE_Y - 0.29);
		
		public function NitrogenRestorableWetlands() {
		}
		
		public function updateUsage(percentage:int):void {
			if (percentage < 0 || percentage > 100)
				return;
			removeChildren();
			if (percentage > 0) {
				updateWetland1(percentage);
				updateWetland2(percentage);
				updateWetland3(percentage);
				updateWetland4(percentage);
			}
		}
		
		private function removeChildren():void {
			for (var i:int = this.numChildren - 1; i >= 0; i--) {
				removeChildAt(i);
			}
		}
		
		private function updateWetland(percentage:int,
																	 alpha:Number,
																	 commands:Vector.<int>,
																	 coord:Vector.<Number>,
																	 x:Number,
																	 y:Number):void {
			var shape:Shape = new Shape();
			shape.graphics.beginFill(NitrogenConsts.WETLAND_COLOR, alpha);
			shape.graphics.drawPath(commands, coord);
			var a:Number = this.BASE_SCALE_X * percentage / 100;
			var d:Number = this.BASE_SCALE_Y * percentage / 100;
			var matrix:Matrix = new Matrix(a, 0, 0, d);
			shape.transform.matrix = matrix;
			var tx:Number = this.midCoord(coord, 0) * this.BASE_SCALE_X * (100 - percentage) / 100;
			var ty:Number = this.midCoord(coord, 1) * this.BASE_SCALE_Y * (100 - percentage) / 100;
			shape.x = x + tx;
			shape.y = y + ty;
			addChild(shape);
		}
		
		private function updateWetland1(percentage:int):void {
			var commands:Vector.<int> = new Vector.<int>(); 
			commands.push(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
			var coord:Vector.<Number> = new Vector.<Number>();
			coord.push(0,30, 15,14, 32,3, 60,0, 83,7, 112,31,
          			 145,55, 175,85, 196,130, 218,196, 205,217, 193,248,
          			 165,259, 148,261, 114,262, 74,233, 60,227, 39,199,
          			 38,180, 17,137, 26,99, 8,58, 0,30);
			this.updateWetland(percentage, 0.6, commands, coord, WETLAND1_X, WETLAND1_Y);
		}
		
		private function updateWetland2(percentage:int):void {
			var commands:Vector.<int> = new Vector.<int>(); 
			commands.push(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
			var coord:Vector.<Number> = new Vector.<Number>();
			coord.push(0,192, 8,154, 35,110, 92,77, 90,50, 106,20,
			           151,3, 170,0, 193,37, 232,42, 237,69, 273,83,
			           285,190, 247,210, 237,227, 215,235, 200,225, 181,217,
			           152,210, 104,223, 50,220, 0,192);
			this.updateWetland(percentage, 0.6, commands, coord, WETLAND2_X, WETLAND2_Y);
		}
		
		private function updateWetland3(percentage:int):void {
			var commands:Vector.<int> = new Vector.<int>(); 
			commands.push(1,2,2,2,2,2,2,2,2,2,2);
			var coord:Vector.<Number> = new Vector.<Number>();
			coord.push(0,56, 14,34, 52,42, 78,0, 105,21, 129,56,
			           145,69, 125,122, 53,108, 8,90, 0,56);
			this.updateWetland(percentage, 0.7, commands, coord, WETLAND3_X, WETLAND3_Y);
		}
		
		private function updateWetland4(percentage:int):void {
			var commands:Vector.<int> = new Vector.<int>(); 
			commands.push(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
			var coord:Vector.<Number> = new Vector.<Number>();
			coord.push(0,237, 23,210, 38,198, 69,127, 88,75, 115,39,
			           173,0, 200,23, 183,67, 177,91, 130,200, 122,227,
			           120,235, 115,255, 147,285, 146,333, 133,369, 121,399,
			           88,423, 57,383, 71,331, 43,288, 14,273, 0,237);
			this.updateWetland(percentage, 0.6, commands, coord, WETLAND4_X, WETLAND4_Y);
		}
		
		private function midCoord(coord:Vector.<Number>, startingIdx:uint):Number {
			var max:Number = 0;
			for (var i:uint = startingIdx; i < coord.length; i += 2) {
				if (max < coord[i])
					max = coord[i];
			}
			return max / 2;
		}
	}
}