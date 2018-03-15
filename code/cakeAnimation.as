package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class cakeAnimation extends MovieClip {
		
		var numberOfPieces = 0;
		var currentTotalFrame = 0;
		
		var secondLayer: cakeAnimation;
		var thirdLayer: cakeAnimation;
		
		public function cakeAnimation(pNumberOfPieces: Number) {
			// constructor code
			numberOfPieces = pNumberOfPieces
			visible = true;
			play();
			
			if (numberOfPieces > 8) {
				secondLayer = new cakeAnimation(numberOfPieces - 8);
				secondLayer.x = 900;
				secondLayer.y = 450;
				secondLayer.width = secondLayer.width*0.8;
				secondLayer.height = secondLayer.height*0.8;
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
			if(currentFrame == totalFrames){
				stop();
				secondLayer.visible = true;
				kernel.instance.stage.setChildIndex(secondLayer, kernel.instance.stage.numChildren-1);
				secondLayer.play();
			}
			
		}
		
		public function Delete(){
			kernel.instance.stage.removeChild(secondLayer);
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
	}
	
}
