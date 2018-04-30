package  {
	import flash.events.*;
	import flash.ui.KeyLocation;
	import flash.geom.Vector3D;
	
	public class InputComponent {

		var possessed;
		
		var left: Boolean = false;
		var right: Boolean = false;
		var up: Boolean = false;
		var down: Boolean = false;
		var anyKeyDown: Boolean = false;
		
		var shift: Boolean = false;
		
		var speedMultiplier = 1;

		public function InputComponent(pObject) {
			// constructor code
			possessed = pObject;
			
		}
		
		
		public function KeyDown(e:KeyboardEvent){
			if (possessed.movementComponent.onFloor){
				if (e.keyCode == 87){//w
					if (!up && !anyKeyDown){
						possessed.movementComponent.AddForce(new Vector3D(0, 0.1*speedMultiplier, 10));
						possessed.gotoAndPlay(1);
					}
					up = true; anyKeyDown = true;
				}
				if (e.keyCode == 65){//a
					if (!left && !anyKeyDown){
						possessed.movementComponent.AddForce(new Vector3D(-0.1*speedMultiplier, 0, 10));
						possessed.gotoAndPlay(10);
					}
					left = true; anyKeyDown = true;
				}
				if (e.keyCode == 83){//s
					if (!down && !anyKeyDown){
						possessed.movementComponent.AddForce(new Vector3D(0, -0.1*speedMultiplier, 10));
						possessed.gotoAndPlay(19);
					}
					down = true; anyKeyDown = true;
				}
				if (e.keyCode == 68){//d
					if (!right && !anyKeyDown){
						possessed.movementComponent.AddForce(new Vector3D(0.1*speedMultiplier, 0, 10));
						possessed.gotoAndPlay(28);
					}
					right = true; anyKeyDown = true;
				}
			}
			if (e.keyCode == 16){//shift
				shift = true;
			}
			if (e.keyCode == 69){//e (debug)
				possessed.movementComponent.Move(0, 0.9, 100);
				possessed.movementComponent.currentPosition.y = 9;
			}
		}
		
		public function KeyUp(e:KeyboardEvent){
			if (e.keyCode == 87){//w
				up = false;
			}
			if (e.keyCode == 65){//a
				left = false;
			}
			if (e.keyCode == 83){//s
				down = false;
			}
			if (e.keyCode == 68){//d
				right = false;
			}
			if (!up && !left && !down && !right){
				anyKeyDown = false;
			}
			if (e.keyCode == 16){//shift
				shift = false;
			}
		}
		
		function Update(){
			
			if (shift){
				speedMultiplier = 0.5;
			} else {
				speedMultiplier = 1;
			}
			
		}

	}
	
}
