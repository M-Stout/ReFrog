package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class cakeAnimation extends MovieClip {
		
		var numberOfPieces = 0;
		var currentTotalFrame = 0;
		
		var secondLayer: cakeAnimation;
		//var thirdLayer: cakeAnimation;
		
		public function cakeAnimation(xInput, yInput, pNumberOfPieces: Number, scale) {
			// constructor code
			this.x = xInput;
			this.y = yInput;
			numberOfPieces = pNumberOfPieces;
			this.scaleX = scale;
			this.scaleY = scale;
			
			visible = true;
			play();
			
			if (numberOfPieces < 1){
				visible = false;
			}
			if (numberOfPieces > 8) {
				secondLayer = new cakeAnimation(this.x, this.y-(50*this.scaleY), numberOfPieces - 8, this.scaleX*0.8);
				secondLayer.gotoAndStop(0);
				secondLayer.visible = false;
				kernel.instance.stage.addChild(secondLayer);
			}

			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
		function EnterFrame(e:Event){
			if(currentFrame >= numberOfPieces*20){
				gotoAndStop(numberOfPieces*20);
			}
			if(currentFrame == totalFrames-1){
				gotoAndStop(totalFrames);
				secondLayer.visible = true;
				kernel.instance.stage.setChildIndex(secondLayer, kernel.instance.stage.numChildren-1);
				secondLayer.play();
			}
			
		}
		
		public function Delete(){
			if(secondLayer){
				secondLayer.Delete();
				kernel.instance.stage.removeChild(secondLayer);
			}
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
	}
	
}
