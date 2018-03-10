package  {
	import flash.geom.Vector3D;
	
	public class CollisionComponent {

		var possessed;
		
		

		public function CollisionComponent(pObject) {
			//constructor code
			possessed = pObject;
		}
		
		
		
		public function Update(){
				
			if (kernel.tiles[Math.round(possessed.movementComponent.currentPosition.x)][Math.round(possessed.movementComponent.currentPosition.y)].typeOfTile == "waterTile"){ //if touching water
				if(checkTouchingLog()){ //if touching log
					possessed.movementComponent.targetPosition.x += 0.02; //move with log
				} else { //else die
					var splashEffect = new splash(); 
					splashEffect.x = kernel.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).x;
					splashEffect.y = kernel.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).y;
					possessed.mStage.addChild(splashEffect);
					
					possessed.Delete();
				}
			}
			
		}
		
		function checkTouchingLog():Boolean{
			for (var entityIndex:int = 0; entityIndex < kernel.entityList.length; entityIndex++) {
				if (kernel.entityList[entityIndex].typeOfEntity == "log") {
					if (Math.abs(kernel.entityList[entityIndex].xPosition-possessed.movementComponent.currentPosition.x) < 0.9) {//check x position
						if(kernel.entityList[entityIndex].riverPosition == Math.round(possessed.movementComponent.currentPosition.y)){//check y position
							return true;
						}
					}
				}
			}
			return false;
		}

	}
	
}
