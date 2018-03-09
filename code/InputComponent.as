package  {
	import flash.events.*;
	
	public class InputComponent {

		var possessed;
		
		var left: Boolean = false;
		var right: Boolean = false;
		var up: Boolean = false;
		var down: Boolean = false;

		public function InputComponent(pObject) {
			// constructor code
			possessed = pObject;
			
		}
		
		public function KeyDown(e:KeyboardEvent){
			if (e.keyCode == 87){//w
				if (!up){
					possessed.movementComponent.Move(0, 1);
					possessed.gotoAndStop(1);
				}
				up = true;
			}
			if (e.keyCode == 65){//a
				if (!left){
					possessed.movementComponent.Move(-1, 0);
					possessed.gotoAndStop(2);
				}
				left = true;
			}
			if (e.keyCode == 83){//s
				if (!down){
					possessed.movementComponent.Move(0, -1);
					possessed.gotoAndStop(3);
				}
				down = true;
			}
			if (e.keyCode == 68){//d
				if (!right){
					possessed.movementComponent.Move(1, 0);
					possessed.gotoAndStop(4);
				}
				right = true;
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
		}
		
		function Update(){
			
		}

	}
	
}
