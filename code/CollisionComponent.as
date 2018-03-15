package  {
	import flash.geom.Vector3D;
	
	public class CollisionComponent {

		var possessed;
		
		

		public function CollisionComponent(pObject) {
			//constructor code
			possessed = pObject;
		}
		
		
		
		public function Update(){
			
			if (possessed.movementComponent){
				if(checkTile(possessed.movementComponent.currentPosition) == "roadTile"){
					if (checkTouchingCar()){
						//play splat effect?
						possessed.Delete();
					}
				}
				else if (checkTile(possessed.movementComponent.currentPosition) == "waterTile"){ //if touching water
					if(checkTouchingLog()){ //if touching log
						possessed.movementComponent.targetPosition.x += 0.02; //move with log ( could be set to the speed of the log, but we'll assume they're always the same speed :) )
					} else { //else die
						var splashEffect = new splash(); 
						splashEffect.x = kernel.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).x;
						splashEffect.y = kernel.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).y;
						possessed.mStage.addChild(splashEffect);
						
						possessed.Delete();
					}
				}
				else if (checkTile(possessed.movementComponent.currentPosition) == "finishTile"){ //if touching finish tile
					if (possessed.typeOfEntity == "player") {
						kernel.instance.FinishLevel();
					}
				}
			}
			
		}
		
		function checkTile(position: Vector3D):String{
			return kernel.tiles[Math.round(position.x)][Math.round(position.y)].typeOfTile;
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
		
		function checkTouchingCar():Boolean{
			for (var entityIndex:int = 0; entityIndex < kernel.entityList.length; entityIndex++) {
				if (kernel.entityList[entityIndex].typeOfEntity == "car") {
					if (Math.abs(kernel.entityList[entityIndex].xPosition-possessed.movementComponent.currentPosition.x) < 0.5) {//check x position
						if(kernel.entityList[entityIndex].roadPosition == Math.round(possessed.movementComponent.currentPosition.y)){//check y position
							return true;
						}
					}
				}
			}
			return false;
		}

	}
	
}
