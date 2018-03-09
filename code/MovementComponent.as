package  {
	import flash.geom.Vector3D;
	
	public class MovementComponent {

		var possessed;
		
		var currentPosition = new Vector3D(kernel.RandomNumberBetween(1, 8), 0, 0);
		var targetPosition = new Vector3D(currentPosition.x, 0, 0);
		
		var currentHeight = 0;
		
		var moving = false;

		public function MovementComponent(pObject) {
			// constructor code
			possessed = pObject;
			Move(0, 0);
		}
		
		public function Move(xInput, yInput){
			if (!moving){
				moving = true;
				//move current position by the input
				targetPosition.x += xInput;
				targetPosition.y += yInput;
				
				//bounding x and y within 0 - 9
				currentPosition.x = Math.min(9, Math.max(currentPosition.x, 0));
				currentPosition.y = Math.min(9, Math.max(currentPosition.y, 0));
				targetPosition.x = Math.min(9, Math.max(targetPosition.x, 0));
				targetPosition.y = Math.min(9, Math.max(targetPosition.y, 0));
			}
		}
		
		public function Update(){
			
			currentPosition.x = (currentPosition.x + targetPosition.x)/2;
			currentPosition.y = (currentPosition.y + targetPosition.y)/2;
			
			currentHeight = Vector3D.distance(currentPosition, targetPosition)*10;
			if (currentHeight < 0.1){
				moving = false;
			}
			
			//set visual position to isometric perspective
			possessed.x = kernel.ToIsometric(currentPosition.x, currentPosition.y, currentHeight).x;
			possessed.y = kernel.ToIsometric(currentPosition.x, currentPosition.y, currentHeight).y;
		}

	}
	
}
