package code {
	
	import flash.events.*;
	import flash.display.*;
	import fl.managers.IFocusManagerComponent;
	import fl.core.UIComponent;
	import fl.events.*;
	
	// this NitrogenSlider is for fertilizer;
	public class NitrogenSlider extends UIComponent implements IFocusManagerComponent {

		protected var thumb:NitrogenSliderThumb;
		protected var track:NitrogenSliderTrack;
		protected var _minimum:Number = 0;
		protected var _maximum:Number = 100;
		protected var _value:Number = 0;

		public function NitrogenSlider(min:Number, max:Number, val:Number) {
			_minimum = min;
			_maximum = max;
			_value = val;

			track = new NitrogenSliderTrack();
			track.x = 0;
			track.y = 0;
			track.width = 100;
			track.height = 30;
			track.addEventListener(MouseEvent.CLICK,onTrackClick,false,0,true);
			addChild(track);
			
			setupSliderThumb(val);
			thumb.x = -15;
			thumb.width = 30;
			thumb.height = 28;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,thumbPressHandler,false,0,true);
			addChild(thumb);
			
		}
		
		protected function setupSliderThumb(val:Number):void {
			thumb = new NitrogenSliderThumbF(val);
			thumb.y = 0;
		}
		
		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
			if (w > 0 && h > 0) {
				track.width = w;
			}
		}

		override protected function draw():void {
			positionThumb();
			super.draw();
		}

    public function get minimum():Number {
			return _minimum;
		}
		public function set minimum(value:Number):void {
			_minimum = value;
			this.value = Math.max(value, this.value);
		}

		public function get maximum():Number {
			return _maximum;
		}		
		public function set maximum(value:Number):void {
			_maximum = value;
			this.value = Math.min(value, this.value);
		}

		public function get value():Number {
			return _value;
		}
		public function set value(value:Number):void {
			doSetValue(value);
		}
		
		public function setThumbValue(val:Number):void {
			thumb.setValue(val);
		}

		protected function doSetValue(val:Number, clickTarget:String=null):void {
			var oldVal:Number = _value;
			_value = Math.max(minimum, Math.min(maximum, Math.round(val)));
			// Only dispatch if value has changed
			// Dispatch when dragging			
			if (oldVal != _value && clickTarget != null) {
				dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, clickTarget, InteractionInputType.MOUSE));
			}
			positionThumb();
		}

		protected function positionThumb():void {
			var pos = (value - minimum)/(maximum - minimum) * _width
			thumb.x = pos;
			thumb.setValue(value);
		}
		
    protected function thumbPressHandler(event:MouseEvent):void {
			var myForm:DisplayObjectContainer = focusManager.form;
			myForm.addEventListener(MouseEvent.MOUSE_MOVE, doDrag, false, 0, true);
			myForm.addEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler, false, 0, true);
    }

		protected function thumbReleaseHandler(event:MouseEvent):void {
			var myForm:DisplayObjectContainer = focusManager.form;
			myForm.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
			myForm.removeEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler);
			dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, SliderEventClickTarget.THUMB, InteractionInputType.MOUSE));
		}

		protected function doDrag(event:MouseEvent):void {
			calculateValue(track.mouseX * track.scaleX, SliderEventClickTarget.THUMB);
		}

		protected function calculateValue(pos:Number, clickTarget:String):void {
			var newValue:Number = (pos / _width) * ( maximum - minimum) + minimum;
			doSetValue(newValue, clickTarget);
		}

    protected function onTrackClick(event:MouseEvent):void {
			calculateValue(track.mouseX * track.scaleX, SliderEventClickTarget.TRACK);
//   		it's already dispatched during dragging;
//			dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, SliderEventClickTarget.TRACK, InteractionInputType.MOUSE));
		}
		
	}
}
