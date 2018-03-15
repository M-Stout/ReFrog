package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class cakeAnimation extends MovieClip {
		
		var numberOfPieces = 0;
		
		public function cakeAnimation(pNumberOfPieces: Number) {
			// constructor code
			numberOfPieces = pNumberOfPieces
			visible = true;
			play();

			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
		function EnterFrame(e:Event){
			if(currentFrame >= numberOfPieces*20){
				gotoAndStop(numberOfPieces*20);
			}
		}
		
	}
	
}
