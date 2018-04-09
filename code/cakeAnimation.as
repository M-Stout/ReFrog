package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class cakeAnimation extends MovieClip {
		
		var mStage;
		
		var numberOfPieces = 0;
		var currentTotalFrame = 0;
		
		var secondLayer: cakeAnimation;
		//var thirdLayer: cakeAnimation;
		
		public function cakeAnimation(xInput, yInput, pNumberOfPieces: Number, scale, pStage) {
			// constructor code
			this.x = xInput;
			this.y = yInput;
			numberOfPieces = pNumberOfPieces;
			this.scaleX = scale;
			this.scaleY = scale;
			
			pStage = mStage;
			
			visible = true;
			play();
			
			if (numberOfPieces < 1){
				visible = false;
			}
			if (numberOfPieces > 8) {
				secondLayer = new cakeAnimation(this.x, this.y-(50*this.scaleY), numberOfPieces - 8, this.scaleX*0.8, mStage);
				secondLayer.gotoAndStop(0);
				secondLayer.visible = false;
				mStage.addChild(secondLayer);
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
				mStage.setChildIndex(secondLayer, isoEngine.instance.stage.numChildren-1);
				secondLayer.play();
			}
			
		}
		
		public function Delete(){
			if(secondLayer){
				secondLayer.Delete();
				mStage.removeChild(secondLayer);
			}
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
	}
	
}
