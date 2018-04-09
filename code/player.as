package  {
	
	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.geom.Point;
	import flash.events.*;	
	
	
	public class player extends MovieClip {
		
		var typeOfEntity = "player";
		
		var mEngine;
		
		var mStage;
		
		var movementComponent;
		var inputComponent;
		var collisionComponent;
		
		var shadowObject;
		
		var introPlaying = true;
		var introAnimationPosition = -1;
		
		var gameOverScreenInstance;
		
		public function player(pEngine) {
			// constructor code
			mEngine = pEngine;
			mStage = mEngine.mainStage;
			movementComponent = new MovementComponent(this);
			inputComponent = new InputComponent(this);
			collisionComponent = new CollisionComponent(this);
			gotoAndStop(1);
			CreateShadow();
		}
		
		function Update(){
			movementComponent.Update();
			inputComponent.Update();
			collisionComponent.Update();
			
			if (introPlaying){
				if (gameOverScreenInstance){
					mStage.removeChild(gameOverScreenInstance);
					gameOverScreenInstance = null;
				}
				this.alpha = introAnimationPosition;
				introAnimationPosition+= 0.02;
				if(introAnimationPosition > 1){
					introPlaying = false;
					this.alpha = 1;
				}
			}
		}
		
		function Delete(){
			gameOverScreenInstance = new gameOverScreen();
			mStage.addChild(gameOverScreenInstance); //add game over
			mEngine.gameTimer.stop(); //stop timer update
			
			
			this.visible=false;
			shadowObject.visible=false;
			
		}
		
		function CreateShadow(){
			shadowObject = new shadow();
			shadowObject.x = this.x;
			shadowObject.y = this.y;
			mStage.addChild(shadowObject);
		}
	}
	
}
