package  {
	import flash.geom.Vector3D;
	
	public class CollisionComponent {

		var possessed;
		
		

		public function CollisionComponent(pObject) {
			//constructor code
			possessed = pObject;
		}
		
		
		
		public function Update(){
			
			if(checkTile() == "roadTile"){
				if (checkTouchingCar()){
					//play splay effect?
					possessed.Delete();
				}
			}
				
			if (checkTile() == "waterTile"){ //if touching water
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
			if (checkTile() == "finishTile"){
				if (possessed.typeOfEntity == "player") {
					kernel.instance.FinishLevel();
				}
			}
			
		}
		
		function checkTile():String{
			return kernel.tiles[Math.round(possessed.movementComponent.currentPosition.x)][Math.round(possessed.movementComponent.currentPosition.y)].typeOfTile;
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
					if (Math.abs(kernel.entityList[entityIndex].xPosition-possessed.movementComponent.currentPosition.x) < 0.8) {//check x position
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
