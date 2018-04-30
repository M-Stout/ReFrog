package  {
	import flash.geom.Vector3D;
	
	public class MovementComponent {

		var possessed;
		
		var currentPosition = new Vector3D(stoutMath.RandomNumberBetween(1, 8), 0, 0);
		//var fromPosition = new Vector3D(currentPosition.x, currentPosition.y, 0);
		//var targetPosition = new Vector3D(currentPosition.x, 0, 0);
		
		var currentVelocity = new Vector3D(0, 0, 0);
		var drag = 0.90;
		
		var currentHeight = 0;
		var maxBounceHeight = 50;
		
		var onFloor = false;
		var floatingObject = false;

		public function MovementComponent(pObject) {
			// constructor code
			possessed = pObject;
			Move(0, 0);
		}
		
		public function Move(xInput, yInput, pBounceHeight = 0, doubleJump = false){
		
			//deprecated function
			
		}
		
		public function AddForce(inputForce: Vector3D){
			currentVelocity = currentVelocity.add(inputForce);
		}
		
		public function Update(){
			
			currentPosition = currentPosition.add(currentVelocity); //trace(currentVelocity + currentPosition);
			
			if (floatingObject) {
				onFloor = false;
				currentPosition.z = 0;
			} else {
			if (currentPosition.z > 0) {
				currentVelocity.z+= -1;
				onFloor = false;
			} else {
					currentPosition.z = 0;
					
					onFloor = true;
					if (possessed.typeOfEntity == "player"){
						possessed.gotoAndStop(9*(Math.floor((possessed.currentFrame-1)/9))+1);
					}
				}
			}
			
			//currentVelocity *= dragVector;
			currentVelocity.scaleBy(drag);

			if (possessed.shadowObject != null){
				possessed.shadowObject.x = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, 0).x;
				possessed.shadowObject.y = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, 0).y;
				possessed.shadowObject.alpha = possessed.alpha*(currentPosition.z/25);
			}
				
			//set visual position to isometric perspective
			possessed.x = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, currentPosition.z).x;
			possessed.y = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, currentPosition.z).y;

		}

	}
	
}
