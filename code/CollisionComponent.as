﻿package  {
	import flash.geom.Vector3D;
	
	public class CollisionComponent {

		var possessed;
		
		var ignoreBoundingBoxChecks = false;
		
		var colliderCircleRadius = 0.5;

		public function CollisionComponent(pObject) {
			//constructor code
			possessed = pObject;
		}
		
		
		
		public function Update(){
			
			if (!ignoreBoundingBoxChecks){
				//bounding box checks
				if(possessed.movementComponent.currentPosition.x > 9){
					possessed.movementComponent.currentPosition.x = 9;
					if (possessed.movementComponent.currentVelocity.x > 0){
						possessed.movementComponent.currentVelocity.x *= -1;
					}
				}
				if(possessed.movementComponent.currentPosition.x < 0){
					possessed.movementComponent.currentPosition.x = 0;
					if (possessed.movementComponent.currentVelocity.x < 0){
						possessed.movementComponent.currentVelocity.x *= -1;
					}
				}
				if(possessed.movementComponent.currentPosition.y > 9){
					possessed.movementComponent.currentPosition.y = 9;
					if (possessed.movementComponent.currentVelocity.y > 0){
						possessed.movementComponent.currentVelocity.y *= -1;
					}
				}
				if(possessed.movementComponent.currentPosition.y < 0){
					possessed.movementComponent.currentPosition.y = 0;
					if (possessed.movementComponent.currentVelocity.y < 0){
						possessed.movementComponent.currentVelocity.y *= -1;
					}
				}
			}
			
			if (possessed.movementComponent){
				if (possessed.typeOfEntity == "cakePiece"){ //special collision behaviours for cake pieces

					if (checkTouchingEntity()){
						if (checkTouchingEntity().typeOfEntity == "player" || checkTouchingEntity().typeOfEntity == "cakePiece"){
							
							var forceToAdd = new Vector3D();
							forceToAdd = possessed.movementComponent.currentPosition.subtract(checkTouchingEntity().movementComponent.currentPosition);
							forceToAdd.scaleBy(0.1);
							if (Math.abs(forceToAdd.x) > Math.abs(forceToAdd.y)){
								forceToAdd.y = 0;
							} else {
								forceToAdd.x = 0;
							}
							possessed.movementComponent.AddForce(forceToAdd);
						}
					}
					if (checkTile(possessed.movementComponent.currentPosition) == "waterTile"){
						possessed.movementComponent.onFloor = false;
						if (possessed.movementComponent.currentPosition.z < 10){
							possessed.movementComponent.AddForce(new Vector3D(0, 0, 1));
						}
						if (possessed.movementComponent.currentVelocity.lengthSquared < 1) { //if the cake piece is REALLY slow on the water, speed it up a bit more
							possessed.movementComponent.currentVelocity.scaleBy(1.2);
						}
						possessed.movementComponent.currentVelocity.scaleBy(1.1);
					}
					
				}
				
				
				if(checkTile(possessed.movementComponent.currentPosition) == "roadTile"){
					if (checkTouchingEntity() != null){
						if (checkTouchingEntity().typeOfEntity == "car"){
							if (possessed.typeOfEntity == "car"){ //if a car is touching a car
								possessed.carSpeed = checkTouchingEntity().carSpeed;
 							} else { //if a car is touching anything other than another car
								var splatEffect = new splat();
								splatEffect.x = isoEngine.ToIsometric(possessed.movementComponent.currentPosition.x, possessed.movementComponent.currentPosition.y, 0).x;
								splatEffect.y = isoEngine.ToIsometric(possessed.movementComponent.currentPosition.x, possessed.movementComponent.currentPosition.y, 0).y;
								possessed.mStage.addChild(splatEffect);
								
								possessed.Delete();
							}
						}
					}
				}
				else if (checkTile(possessed.movementComponent.currentPosition) == "waterTile"){ //if touching water
					if (possessed.movementComponent.onFloor){ //if not floating (which would avoid the water)
						if (checkTouchingEntity() != null){ //prevent errors when checking entity type
							if(checkTouchingEntity().typeOfEntity == "log"){ //if touching log
								if (possessed.typeOfEntity == "player"){//if a player is touching a log
									possessed.movementComponent.currentVelocity.x += checkTouchingEntity().logSpeed/10; //move with log
								}
							}
						} else { //else die
							var splashEffect = new splash();
							splashEffect.x = isoEngine.ToIsometric(possessed.movementComponent.currentPosition.x, possessed.movementComponent.currentPosition.y, 0).x;
							splashEffect.y = isoEngine.ToIsometric(possessed.movementComponent.currentPosition.x, possessed.movementComponent.currentPosition.y, 0).y;
							possessed.mStage.addChild(splashEffect);
							
							possessed.Delete();
						}
					} 
					if (checkTouchingEntity() != null){ //prevent errors when checking entity type
						if(checkTouchingEntity().typeOfEntity == "log"){ //if touching log
							if (possessed.typeOfEntity == "log"){ //if a log is touching a log
								possessed.logSpeed = checkTouchingEntity().logSpeed;
							}
						}
					}								
				}
				else if (checkTile(possessed.movementComponent.currentPosition) == "finishTile"  && possessed.movementComponent.onFloor){ //if touching finish tile
					if (possessed.typeOfEntity == "player") { //go to score screen
						possessed.mEngine.FinishLevel();
					}
					if (possessed.typeOfEntity == "cakePiece") { //add cake point
						possessed.Delete();
						possessed.mEngine.cakeNumber++;
					}
				}
			}
			
		}
		
		function checkTile(position: Vector3D):String{
			if (position.x >= 0 && position.x < possessed.mEngine.tiles.length-1) {
				if (possessed.mEngine.tiles[Math.round(position.x)][Math.round(position.y)] != null){
					return possessed.mEngine.tiles[Math.round(position.x)][Math.round(position.y)].typeOfTile;
				} else {
					//trace("object with collider cannot get out of bounds :)");
					return "";
				}
			} else {
				return "";
			}
		}
		
		function checkTouchingEntity(){
			for (var entityIndex:int = 0; entityIndex < possessed.mEngine.entityList.length; entityIndex++) {
				if (possessed.mEngine.entityList[entityIndex] != possessed) {
					if (Vector3D.distance(possessed.mEngine.entityList[entityIndex].movementComponent.currentPosition, possessed.movementComponent.currentPosition) < possessed.mEngine.entityList[entityIndex].collisionComponent.colliderCircleRadius){
							return possessed.mEngine.entityList[entityIndex];
					}
				}
			}
			return null;
		}
		

	}
	
}
