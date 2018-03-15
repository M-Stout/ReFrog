package  {
	import flash.events.*;
	
	public class InputComponent {

		var possessed;
		
		var left: Boolean = false;
		var right: Boolean = false;
		var up: Boolean = false;
		var down: Boolean = false;
		var anyKeyDown: Boolean = false;

		public function InputComponent(pObject) {
			// constructor code
			possessed = pObject;
			
		}
		
		public function KeyDown(e:KeyboardEvent){
			if (e.keyCode == 87){//w
				if (!up && !anyKeyDown){
					possessed.movementComponent.Move(0, 1, 40);
					possessed.gotoAndPlay(1);
				}
				up = true; anyKeyDown = true;
			}
			if (e.keyCode == 65){//a
				if (!left && !anyKeyDown){
					possessed.movementComponent.Move(-1, 0, 40);
					possessed.gotoAndPlay(10);
				}
				left = true; anyKeyDown = true;
			}
			if (e.keyCode == 83){//s
				if (!down && !anyKeyDown){
					possessed.movementComponent.Move(0, -1, 40);
					possessed.gotoAndPlay(19);
				}
				down = true; anyKeyDown = true;
			}
			if (e.keyCode == 68){//d
				if (!right && !anyKeyDown){
					possessed.movementComponent.Move(1, 0, 40);
					possessed.gotoAndPlay(28);
				}
				right = true; anyKeyDown = true;
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
		}
		
		function Update(){
			
		}

	}
	
}
