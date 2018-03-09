package  {
	
	import flash.display.MovieClip;
	
	
	public class player extends MovieClip {
		
		var movementComponent;
		var inputComponent;
		
		public function player() {
			// constructor code
			movementComponent = new MovementComponent(this);
			inputComponent = new InputComponent(this);
			gotoAndStop(1);
		}
		
		function Update(){
			movementComponent.Update();
			inputComponent.Update();
		}
	}
	
}
