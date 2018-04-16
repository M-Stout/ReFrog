package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.geom.Vector3D;
	import flash.utils.getDefinitionByName;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import stoutMath;
	
	public class isoEngine extends MovieClip {
		
		public static var instance:isoEngine;
		
		public var mainStage;
		
		var tiles = []; //this array is tiles
		
		var introPlaying: Boolean = true;
		var introAnimationPosition: Number = 1000;
		var introDirection: Number = Math.round(Math.random()*4);
		
		var entityList = [];
		
		var riverPositions = [];
		var carSpawnCountdown = 60;
		var roadPositions = [];
		var logSpawnCountdown = 200;
		
		var playerObject;
		
		var cakePieces = [];
		
		var titleScreen;
		
		var cakeNumber;
		var scoreTextField;
		var textFormat: TextFormat;
		var scoreScreenBackground;
		var scoreScreenCakeAnimation;
		
		var isPaused = false;
		
		//game timer
		var _period:Number = 1000/60;
		var gameTimer:Timer = new Timer(_period);
		
		public function isoEngine(pStage) {
			// constructor code
			
			mainStage = pStage;
			
			instance = this;
			
			trace("Hello World (isoEngine Constructor)");
			
			
			Loaded(new Event("isometric engine loaded"));
		}
		
		function Loaded(e:Event) {
			
			trace("isoEngine Loaded!");
			
			//this.removeEventListener(Event.ADDED_TO_STAGE, Loaded); // ensure Loaded events loads just once
			
			
			//create 2d array for tiles
			for (var i:int = 0; i < 11; i++) {
				tiles[i] = [];
			}
			
			GenerateLevel();
		
			playerObject = new player(this);
			entityList.push(playerObject);
			mainStage.addChild(playerObject);
			
			//add cake pieces
			generateCakePieces();
			
			//score screen
			createScoreScreen();
			
			gameTimer.addEventListener(TimerEvent.TIMER, Update);
			//gameTimer.start(); //starts the game timer (is now started after the first key press that also removes the title screen)
			
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			mainStage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			
			titleScreen = new startScreen();
			mainStage.addChild(titleScreen);
		}
		
		function KeyDown(e:KeyboardEvent){
			for (var entityIndex:int = 0; entityIndex < entityList.length; entityIndex++) { //run keydown in inputcomponents
				if (playerObject){ //there's only one entity with an input component: the player
					if(playerObject.inputComponent){
						playerObject.inputComponent.KeyDown(e);
					}
				}
			}
			
			if (e.keyCode == 82){//r
				ResetLevel();
			}
			
			if (e.keyCode == 80){ //p for pause
				if (isPaused){
					isPaused = false;
					gameTimer.start();
				} else {
					isPaused = true;
					gameTimer.stop();
				}
			}
			if (scoreScreenBackground.visible) {
				hideScoreScreen();
			}
			if (titleScreen){ //removes title screen and starts game
				mainStage.removeChild(titleScreen);
				titleScreen = null;
				gameTimer.start();
			}
		}
		function KeyUp(e:KeyboardEvent){
			for (var entityIndex:int = 0; entityIndex < entityList.length; entityIndex++) {//run keyup in inputcomponents
				if (playerObject){ //there's only one entity with an input component: the player
					if(playerObject.inputComponent){
						playerObject.inputComponent.KeyUp(e);
					}
				}
			}
		}
		
		function Update(e:Event){
			
			if (introPlaying){
				IntroAnimation();
			}
			
			for (var entityIndex:int = 0; entityIndex < entityList.length; entityIndex++) {
				entityList[entityIndex].Update();
			}
			
			logSpawnCountdown++;
			if (logSpawnCountdown > (5*60)){ //5 seconds at 60fps
				logSpawnCountdown = 0;
				for (var riverIndex:int = 0; riverIndex < riverPositions.length; riverIndex++) {
					spawnLog(riverPositions[riverIndex]);
				}
			}
			carSpawnCountdown++;
			if (carSpawnCountdown > (2*60)){ //5 seconds at 60fps
				carSpawnCountdown = 0;
				for (var roadIndex:int = 0; roadIndex < roadPositions.length; roadIndex++) {
					spawnCar(roadPositions[roadIndex]);
				}
			}
			
		}
		
		function PlaceTile(x: Number, y: Number, tileTypeName: String = "grassTile"){
			if (tiles[x][y]){
				mainStage.removeChild(tiles[x][y]);
				tiles[x][y]=null;
			}
			var tileTypeClass: Class = getDefinitionByName(tileTypeName) as Class;
			tiles[x][y] = new tileTypeClass();	
			tiles[x][y].x = ToIsometric(x, y).x;
			tiles[x][y].y = ToIsometric(x, y).y; /*tiles[x][y].y = ToIsometric(x, y, Math.random()*3).y;*/
			
			tiles[x][y].typeOfTile = tileTypeName;
			
			tiles[x][y].SetProperPosition();
			tiles[x][y].y -= 1000;
			
			tiles[x][y].SetBiome(2);
			
			tiles[x][y].width = 120;
			tiles[x][y].height = 114.4;
			mainStage.addChild(tiles[x][y]);
		}
		
		//River Placer
		function PlaceRiver(y: Number){
			riverPositions.push(y);
			for (var x:int = 0; x < 10; x++) {
				PlaceTile(x, y, "waterTile");
			}
		}
		
		// Road Placer
		function PlaceRoad(y: Number){
			roadPositions.push(y);
			for (var x:int = 0; x < 10; x++) {
				PlaceTile(x, y, "roadTile");
			}
		}
		
		function spawnLog(riverPosition) {
			var spawningLog = new log(riverPosition, this);
			mainStage.addChild(spawningLog);
			entityList.push(spawningLog);
			
			if (playerObject){
				mainStage.setChildIndex(playerObject, mainStage.numChildren-1);
				mainStage.setChildIndex(playerObject.shadowObject, mainStage.numChildren-2);
			}
		}
		
		function spawnCar(roadPosition) {
			var spawningCar = new car(roadPosition, this);
			mainStage.addChild(spawningCar);
			entityList.push(spawningCar);
			
			if (playerObject){
				mainStage.setChildIndex(playerObject, mainStage.numChildren-1);
				mainStage.setChildIndex(playerObject.shadowObject, mainStage.numChildren-2);
			}
		}
		
		function GenerateLevel(){
			var numberOfRivers: Number = Math.round(Math.random()*2)+1; //should be a number between 1 and 3
			var numberOfRoads: Number = Math.round(Math.random()*2)+1; //should be a number between 1 and 3
			
			for (var y:int = 0; y < 10; y++) {
				for (var x:int = 0; x < 10; x++) {
					PlaceTile(x, y, "grassTile");
				}
			}
			
			for (var r:int = 0; r < numberOfRivers; r++) {
				//places random rivers between y 2 and 7
				while (true) {
					var riverCheck = stoutMath.RandomNumberBetween(2, 7);
					if (riverPositions.indexOf(riverCheck) == -1 && roadPositions.indexOf(riverCheck) == -1) { //if river position not already used
						PlaceRiver(riverCheck);
						break;
					}
				}
			}
			
			for (var j:int = 0; j < numberOfRoads; j++) {
				//places random roads between y 2 and 7
				while (true) {
					var roadCheck = stoutMath.RandomNumberBetween(2, 7);
					if (riverPositions.indexOf(roadCheck) == -1 && roadPositions.indexOf(roadCheck) == -1) { //if road position not already used
						PlaceRoad(roadCheck);
						break;
					}
				}
			}
			
			PlaceTile(stoutMath.RandomNumberBetween(2, 7), 9, "finishTile");
			
			ArrangeTiles();
		}
		
		function generateCakePieces() {
			
			var totalNumberOfCakePieces = stoutMath.RandomNumberBetween(2, 5);
			for (var i:int = 0; i < totalNumberOfCakePieces; i++) {
				cakePieces[i] = new cakePiece(this);
				entityList.push(cakePieces[i]);
				mainStage.addChild(cakePieces[i]);
			}
		}
		
		function FinishLevel(){
			ResetLevel();
			//pause
			showScoreScreen();//show score screen
			//wait for key press
			//unpause
		}
		
		function ResetLevel(){
			
			gameTimer.start();
			
			introPlaying = true;
			introAnimationPosition = 1000;
			introDirection = Math.round(Math.random()*4);
			
			playerObject.introPlaying = true;
			playerObject.introAnimationPosition = -1;
			playerObject.visible = true;
			playerObject.shadowObject.visible = true;
			
			playerObject.movementComponent.currentPosition = new Vector3D(stoutMath.RandomNumberBetween(1, 8), 0, 0);
			playerObject.movementComponent.fromPosition = new Vector3D(playerObject.movementComponent.currentPosition.x, playerObject.movementComponent.currentPosition.y, 0);
			playerObject.movementComponent.targetPosition = new Vector3D(playerObject.movementComponent.currentPosition.x, 0, 0);
			
			for (var entityIndex:int = 0; entityIndex < entityList.length; entityIndex++) {
				mainStage.removeChild(entityList[entityIndex]);
			}
			entityList.splice(0);
			entityList.push(playerObject);
			mainStage.addChild(playerObject);
			
			riverPositions.splice(0);
			logSpawnCountdown = 200;
			
			roadPositions.splice(0);
			
			GenerateLevel();
			
			generateCakePieces();
			
		}
		
		function ArrangeTiles(){
			for (var y:int = 0; y < 10; y++) {
				for (var x:int = 0; x < 10; x++) {
					if (tiles[x][y]){
						mainStage.setChildIndex(tiles[x][y], x);
					}
				}
			}
		}
		
		function createScoreScreen(){
			
			cakeNumber = 0; //default number of cake pieces collected
			scoreScreenBackground = new scoreScreen();
			
			scoreScreenBackground.x = 0;
			scoreScreenBackground.y = 0;
			
			textFormat = new TextFormat();  // text format no longer necessary, proabably should delete
            textFormat.font = "Bubble Letters"; 
            textFormat.color = 0xF701FA; 
            textFormat.size = 58; 
			
			scoreTextField = new customScoreDisplayer(100, 240);
			
			mainStage.addChild(scoreScreenBackground);
			mainStage.addChild(scoreTextField);
			
			scoreTextField.visible = false;
			scoreScreenBackground.visible = false;
		}
		
		function showScoreScreen(){
			
			scoreTextField.DisplayNumbers(cakeNumber);
			
			mainStage.setChildIndex(scoreScreenBackground, mainStage.numChildren-1);
			mainStage.setChildIndex(scoreTextField, mainStage.numChildren-1);
			scoreTextField.visible = true;
			scoreScreenBackground.visible = true;
			
			scoreScreenCakeAnimation = new cakeAnimation(900, 600, cakeNumber, 1.2, this);
			mainStage.addChild(scoreScreenCakeAnimation);
			
			gameTimer.stop();
			isPaused = true;
			
		}
		
		function hideScoreScreen(){
			scoreScreenBackground.visible = false;
			scoreTextField.visible = false;
			scoreTextField.RemoveAllChildren();
			isPaused = false;
			gameTimer.start();
			
			scoreScreenCakeAnimation.Delete();
			mainStage.removeChild(scoreScreenCakeAnimation);
		}
		
		function IntroAnimation(){
			introAnimationPosition -= 20;
			for (var y:int = 0; y < 10; y++) {
				for (var x:int = 0; x < 10; x++) {
					if (introAnimationPosition > -1000){
						if (tiles[x][y].y < tiles[x][y].properPosition.y){
							switch (introDirection){
								case 0:
									tiles[x][y].y = tiles[x][y].properPosition.y - introAnimationPosition - (-y*100) - 1000;
									break;
								case 1:
									tiles[x][y].y = tiles[x][y].properPosition.y - introAnimationPosition - (y*100);
									break;
								case 2:
									tiles[x][y].y = tiles[x][y].properPosition.y - introAnimationPosition - (-x*100) - 1000;
									break;
								default:
									tiles[x][y].y = tiles[x][y].properPosition.y - introAnimationPosition - (x*100);
									break;
							}
						} else {
							tiles[x][y].y = tiles[x][y].properPosition.y;
						}
					}
					else {
						for (var y:int = 0; y < 10; y++) {
							for (var x:int = 0; x < 10; x++) {
								tiles[x][y].y = tiles[x][y].properPosition.y;
							}
						}
						introPlaying = false;								
					}
				}
			}
		}
		
		function RemoveAllInputListeners(){
			mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown); //stops all key inputs
			mainStage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
		}
		
		static function ToIsometric(inputX: Number, inputY: Number, yOffset: Number = 0){
			return new Vector3D(100+(inputX*0.6 + inputY*0.6)*100, ((720-360)-(inputX*-0.35 + inputY*0.35)*100) -yOffset, 0);
		}
		
	}
	
}
