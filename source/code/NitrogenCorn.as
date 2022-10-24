package code {

  import flash.events.*;
	import flash.display.*;
	
  public class NitrogenCorn extends Sprite {

		private const CORN_X:Number = 20;
		private const CORN_TICK_X:Number = CORN_X + 42;
		private const CORN_TICK_WIDTH:Number = 41;
		private const CORN_MARK_X:Number = CORN_X + 22;
		
		private var data:NitrogenData;
		// top-left point;
		private var xPos:Number;
		private var yPos:Number;
		private var container:Sprite;
		private var cornMC:MovieClip;
		private var cornMaskMC:MovieClip;
		private var cornHeight:Number;
		private var cornWidth:Number;
		private var ticksContainer:Sprite;
		
    public function NitrogenCorn(data:NitrogenData, xPos:Number, yPos:Number) {
			this.data = data;
			this.xPos = xPos;
			this.yPos = yPos;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

      setupComponents();
      updateUsage();
		}
		
		public function updateUsage():void {
			if (container && container.parent)
				removeChild(container);
			container = new Sprite();
			cornMaskMC.mask = null;
			container.addChild(cornMC);
			var cropYield = data.cropYieldReduction();
			if (cropYield > 0) {
				container.addChild(cornMaskMC);
				var h:Number = cornHeight * cropYield / 100;
				var cornMask:Shape = new Shape();
				cornMask.graphics.beginFill(NitrogenConsts.BLACK_COLOR);
				cornMask.graphics.drawRect(xPos + CORN_X, yPos + cornHeight - h, cornWidth + 2, h + 5);
				cornMask.graphics.endFill();
				container.addChild(cornMask);
				cornMaskMC.mask = cornMask;
			}
			addChildAt(container, 0);
		}
		
		private function setupComponents():void {
			cornMC = new CornMC();
			cornMC.x = xPos + CORN_X;
			cornMC.y = yPos;
			cornWidth = cornMC.width;
			cornHeight = cornMC.height;
			
			cornMaskMC = new CornMaskMC();
			cornMaskMC.x = xPos + CORN_X;
			cornMaskMC.y = yPos;
			
			ticksContainer = new Sprite();
			// draw ticks and marks;
			var ticks:Shape = new Shape();
			ticks.graphics.lineStyle(2, NitrogenConsts.BLACK_COLOR, 1,
															 false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			var xBase:Number = xPos + CORN_TICK_X;
			var y:Number;
			var mark:int = 0;
			while (mark <= 100) {
				y = yPos + cornHeight * (100 - mark) / 100;
				ticks.graphics.moveTo(xBase, y);
				ticks.graphics.lineTo(xBase + CORN_TICK_WIDTH, y);
				NitrogenUtils.setupTextFieldR2(ticksContainer,
																			 String(mark),
																			 xPos + CORN_MARK_X,
																			 y - 10,
																			 20,
																			 20,
																			 12,
																			 true);
				mark += 10;
			}
			ticksContainer.addChild(ticks);
			NitrogenUtils.setupTextFieldL1(ticksContainer,
																		 NitrogenConsts.CROP_YIELD_REDUCTION_NAME,
																		 xPos + 10,
																		 yPos + cornHeight,
																		 300,
																		 26,
																		 18);
			addChild(ticksContainer);
		}
		
	}
}
