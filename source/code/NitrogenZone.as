package code {

  import flash.events.*;
	import flash.display.*;
  import flash.geom.*;
	import fl.text.*;
	import flash.text.*;
	
  public class NitrogenZone extends Sprite {

		private const RULER_MARKS_ARRAY:Array = ["0 km2", "5,000", "10,000", "15,000", "20,000", "25,000"];
		private const BASE_HYPOXIC:Number = 25000;
		private const RULER_X:Number = 0;
		private const RULER_Y:Number = 93;
		private const RULER_HEIGHT:Number = 8;
		private const RULER_SPAN:Number = 290;
		private const BASE_Y_RATIO:Number = 0.4;

		private var data:NitrogenData;
		// top-left point; zone width: 285.6; zone height: 91.6;
		private var xPos:Number;
		private var yPos:Number;
		private var container:Sprite;
		private var zoneMC:MovieClip;
		private var zoneHeight:Number;
		private var rulerContainer:Sprite;
		
    public function NitrogenZone(data:NitrogenData, xPos:Number, yPos:Number) {
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
			var hypoxia:Number = data.hypoxiaArea();
			if (hypoxia > 0) {
				container = new Sprite();
				var ratio:Number = hypoxia / BASE_HYPOXIC;
				var uiR:Number = Math.sqrt(ratio);
				var mtx:Matrix = new Matrix(ratio, 0, 0, uiR);
				zoneMC.transform.matrix = mtx;
				zoneMC.x = xPos;
				zoneMC.y = yPos + zoneHeight - zoneMC.height - (zoneHeight - zoneMC.height) * BASE_Y_RATIO;
				container.addChild(zoneMC);
				addChildAt(container, 0);
			}
		}
		
		// 286.6 x 92.6 24853.2
		// 290 => 25000
		private function setupComponents():void {
			zoneMC = new HypoxicZoneMC();
			zoneHeight = zoneMC.height;
			
			rulerContainer = new Sprite();
			// draw ruler and marks;
			var ruler:Shape = new Shape();
			ruler.graphics.lineStyle(2, NitrogenConsts.BLACK_COLOR, 1,
															 false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			var xBase:Number = xPos + RULER_X;
			var y1:Number = yPos + RULER_Y;
			var y2:Number = y1 + RULER_HEIGHT;
			var xx:Number;
			var mark:int = 0;
			while (mark <= 10) {
				xx = xBase + RULER_SPAN * mark / 10;
				ruler.graphics.moveTo(xx, y1);
				ruler.graphics.lineTo(xx, y2);
				// special handle the superscript
//				if (mark == 0) {
//          var tlfTxt:TLFTextField = new TLFTextField();
//					tlfTxt.tlfMarkup = tFlow;
//          tlfTxt.wordWrap = false;
//          tlfTxt.width = 60;
//          tlfTxt.autoSize = TextFieldAutoSize.CENTER;
//          tlfTxt.x = xx - 30;
//					tlfTxt.y = y2 + 5;
//					tlfTxt.width = 60;
//					tlfTxt.height = 20;
//					addChild(tlfTxt);
//				}
//				else
				if (mark % 2 == 0) {
					NitrogenUtils.setupTextFieldC2(rulerContainer,
																			 RULER_MARKS_ARRAY[mark >> 1],
																			 xx - 30,
																			 y2 + 5,
																			 60,
																			 20,
																			 12,
																			 true);
				}
				mark++;
			}
			rulerContainer.addChild(ruler);
			addChild(rulerContainer);
		}
		
	}
}
