package elements {
	
	import flash.display.MovieClip;
	
	
	public class Rating_Anim extends MovieClip {
		
		//レーティングの位置
		public var pointX:int = 64;
		public var pointY:int = 262;
		
		public function Rating_Anim() {
			// constructor code
		}
		
		public function changeRating(score:int):void 
		{
			if (score < 30)
			{
				//レーティングの変更
				rating.gotoAndStop("F");
				//レーティング（エフェクト）の変更
				rating_effect.gotoAndStop("F");
			}
			else if ((30 < score) && (score < 40))
			{
				rating.gotoAndStop("F+");
				rating_effect.gotoAndStop("F+");
			}
			else if ((40 < score) && (score < 60))
			{
				rating.gotoAndStop("E");
				rating_effect.gotoAndStop("E");
			}
			else if ((60 < score) && (score < 70))
			{
				rating.gotoAndStop("E+");
				rating_effect.gotoAndStop("E+");
			}
			else if ((70 < score) && (score <= 100))
			{
				rating.gotoAndStop("D");
				rating_effect.gotoAndStop("D");
			}
			else if ((100 < score) && (score <= 110))
			{
				rating.gotoAndStop("D+");
				rating_effect.gotoAndStop("D+");
			}
			else if ((110 < score) && (score <= 140))
			{
				rating.gotoAndStop("C");
				rating_effect.gotoAndStop("C");
			}
			else if ((140 < score) && (score <= 150))
			{
				rating.gotoAndStop("C+");
				rating_effect.gotoAndStop("C+");
			}
			else if ((150 < score) && (score <= 180))
			{
				rating.gotoAndStop("B");
				rating_effect.gotoAndStop("B");
			}
			else if ((190 < score) && (score <= 200))
			{
				rating.gotoAndStop("B+");
				rating_effect.gotoAndStop("B+");
			}
			else if ((200 < score) && (score <= 230))
			{
				rating.gotoAndStop("A");
				rating_effect.gotoAndStop("A");
			}
			else if ((230 < score) && (score <= 240))
			{
				rating.gotoAndStop("A+");
				rating_effect.gotoAndStop("A+");
			}
			else if ((240 < score) && (score <= 270))
			{
				rating.gotoAndStop("S");
				rating_effect.gotoAndStop("S");
			}
			else if (270 < score)
			{
				rating.gotoAndStop("S+");
				rating_effect.gotoAndStop("S+");
			}
		}
	}
	
}
