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
						var splatEffect = new splat();
						splatEffect.x = isoEngine.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).x;
						splatEffect.y = isoEngine.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).y;
						possessed.mStage.addChild(splatEffect);
						
						possessed.Delete();
					}
				}
				else if (checkTile(possessed.movementComponent.currentPosition) == "waterTile" && !possessed.movementComponent.moving){ //if touching water
					if(checkTouchingLog() && possessed.typeOfEntity == "player"){ //if touching log
						possessed.movementComponent.targetPosition.x += checkTouchingLog().logSpeed; //move with log ( could be set to the speed of the log, but we'll assume they're always the same speed :) )
					} else { //else die
						var splashEffect = new splash();
						splashEffect.x = isoEngine.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).x;
						splashEffect.y = isoEngine.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).y;
						possessed.mStage.addChild(splashEffect);
						
						possessed.Delete();
					}
				}
				else if (checkTile(possessed.movementComponent.currentPosition) == "finishTile"  && !possessed.movementComponent.moving){ //if touching finish tile
					if (possessed.typeOfEntity == "player") {
						isoEngine.instance.FinishLevel();
					}
					if (possessed.typeOfEntity == "cakePiece") {
						possessed.Delete();
						isoEngine.cakeNumber++;
					}
				}
			}
			
		}
		
		function checkTile(position: Vector3D):String{
			if (isoEngine.tiles[Math.round(position.x)][Math.round(position.y)]){
				return isoEngine.tiles[Math.round(position.x)][Math.round(position.y)].typeOfTile;
			} else {
				//trace("object with collider cannot get out of bounds :)");
				return "";
			}
		}
		
		function checkTouchingLog(){
			for (var entityIndex:int = 0; entityIndex < isoEngine.entityList.length; entityIndex++) {
				if (isoEngine.entityList[entityIndex].typeOfEntity == "log") {
					if (Math.abs(isoEngine.entityList[entityIndex].xPosition-possessed.movementComponent.currentPosition.x) < 0.9) {//check x position
						if(isoEngine.entityList[entityIndex].riverPosition == Math.round(possessed.movementComponent.currentPosition.y)){//check y position
							return isoEngine.entityList[entityIndex];
						}
					}
				}
			}
			return false;
		}
		
		function checkTouchingCar():Boolean{
			for (var entityIndex:int = 0; entityIndex < isoEngine.entityList.length; entityIndex++) {
				if (isoEngine.entityList[entityIndex].typeOfEntity == "car") {
					if (Math.abs(isoEngine.entityList[entityIndex].xPosition-possessed.movementComponent.currentPosition.x) < 0.5) {//check x position
						if(isoEngine.entityList[entityIndex].roadPosition == Math.round(possessed.movementComponent.currentPosition.y)){//check y position
							return true;
						}
					}
				}
			}
			return false;
		}

	}
	
}
