package  {
	
	import flash.display.MovieClip;	
	import flash.utils.getDefinitionByName;
	
	public class customScoreDisplayer extends MovieClip {

		var xPosition;
		var yPosition;
		var numberToDisplay: String;
		
		var arrayOfClassNames = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];

		public function customScoreDisplayer(pXPosition, pYPosition) {
			// constructor code
			xPosition = pXPosition;
			yPosition = pYPosition;
		}

		function DisplayNumbers(pNumberToDisplay){
			numberToDisplay = pNumberToDisplay.toString();
			
			for (var i:int = 0; i < numberToDisplay.length; i++) {
				DisplayNumber(xPosition + (i*100), yPosition, int(numberToDisplay.charAt(i)));
			}
		}
		
		function DisplayNumber(xPosition, yPosition, number){
			var currentNumberClass: Class = getDefinitionByName(arrayOfClassNames[number]) as Class;
			var currentNumber = new currentNumberClass();
			currentNumber.x = xPosition;
			currentNumber.y = yPosition;
			currentNumber.width = 100;
			currentNumber.height = 100;
			this.addChild(currentNumber);
		}
		
		function RemoveAllChildren(){
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
	
	}
	
}
