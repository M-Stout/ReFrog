package  {
	import flash.geom.Vector3D;
	
	public class MovementComponent {

		var possessed;
		
		var currentPosition = new Vector3D(stoutMath.RandomNumberBetween(1, 8), 0, 0);
		var fromPosition = new Vector3D(currentPosition.x, currentPosition.y, 0);
		var targetPosition = new Vector3D(currentPosition.x, 0, 0);
		
		var currentHeight = 0;
		var maxBounceHeight = 50;
		
		var moving = false;

		public function MovementComponent(pObject) {
			// constructor code
			possessed = pObject;
			Move(0, 0);
		}
		
		public function Move(xInput, yInput, pBounceHeight = 0, doubleJump = false){
			if (!moving || doubleJump){
				moving = true;
				
				//set previous position
				fromPosition.x = currentPosition.x;
				fromPosition.y = currentPosition.y;
				
				//move current position by the input
				targetPosition.x += xInput;
				targetPosition.y += yInput;
				
				maxBounceHeight = pBounceHeight;
				
				for (var entityIndex:int = 0; entityIndex < possessed.mEngine.entityList.length; entityIndex++) {
					if (possessed.mEngine.entityList[entityIndex].typeOfEntity == "cakePiece") { 
						if(Vector3D.distance(possessed.mEngine.entityList[entityIndex].movementComponent.currentPosition, targetPosition) < 0.5){ //if going to jump into a cake piece, move the cake piece in the same direction
							possessed.mEngine.entityList[entityIndex].movementComponent.Move(xInput, yInput, 10);
						}
					}
				}
				if (possessed.typeOfEntity == "cakePiece"){ //special movement rules for cake pieces (to keep them safe)
					if(possessed.collisionComponent){
						if (possessed.collisionComponent.checkTile(targetPosition) == "waterTile" || possessed.collisionComponent.checkTile(targetPosition) == "roadTile" ){
							Move(0, yInput, pBounceHeight, true);
						}
					}
				}
			}
		}
		
		public function Update(){
			
			//moves current position towards target position
			currentPosition.x += -(currentPosition.x - targetPosition.x)/5;
			currentPosition.y += -(currentPosition.y - targetPosition.y)/5;
			
			//bounding x and y within 0 - 9t
			currentPosition.x = Math.min(9, Math.max(currentPosition.x, 0));
			currentPosition.y = Math.min(10, Math.max(currentPosition.y, 0));
			targetPosition.x = Math.min(9, Math.max(targetPosition.x, 0));
			targetPosition.y = Math.min(9, Math.max(targetPosition.y, 0));
			
			if (Vector3D.distance(fromPosition, targetPosition) < 0.1){
				currentHeight = 0;
			} else {
				if(moving){
					//this calculates an arc in the air between two points (fromPosition and targetPosition)
					currentHeight = Math.abs( Math.sin((Vector3D.distance(currentPosition, targetPosition) - 0) * 3.14) / (Vector3D.distance(fromPosition, targetPosition) - 0) )*maxBounceHeight;
				}
			}
			
			if (Vector3D.distance(currentPosition, targetPosition) < 0.1){
				moving = false;
				currentHeight = 0;
				if (possessed.typeOfEntity == "player"){
					possessed.gotoAndStop(9*(Math.floor((possessed.currentFrame-1)/9))+1);
				}
			}
			
			if (possessed.typeOfEntity == "cakePiece"){ //special movement rules for cake pieces (to keep them safe)
				if (!moving){
					if(currentPosition.x < 1){
						Move(1, 0, 30, false);
					}
					if(currentPosition.x > 8){
						Move(-1, 0, 30, false);
					}
					if(currentPosition.y < 1){
						Move(0, 1, 30, false);
					}
					if(currentPosition.y > 9){
						Move(0, -1, 30, false);
					}
				}				
			}
			
			possessed.shadowObject.x = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, 0).x;
			possessed.shadowObject.y = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, 0).y;
			possessed.shadowObject.alpha = possessed.alpha*(currentHeight/maxBounceHeight);
			
			//set visual position to isometric perspective
			possessed.x = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, currentHeight).x;
			possessed.y = isoEngine.ToIsometric(currentPosition.x, currentPosition.y, currentHeight).y;
		}

	}
	
}
