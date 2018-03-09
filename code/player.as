package  {
	
	import flash.display.MovieClip;
	
	
	
	public class player extends MovieClip {
		
		var movementComponent;
		var inputComponent;
		
		var introPlaying = true;
		var introAnimationPosition = -1;
		
		public function player() {
			// constructor code
			movementComponent = new MovementComponent(this);
			inputComponent = new InputComponent(this);
			gotoAndStop(1);
		}
		
		function Update(){
			movementComponent.Update();
			inputComponent.Update();
			
			if (introPlaying){
				this.alpha = introAnimationPosition;
				introAnimationPosition+= 0.02;
				trace(introAnimationPosition);
				if(introAnimationPosition > 1){
					introPlaying = false;
					this.alpha = 1;
				}
			}
		}
	}
	
}
