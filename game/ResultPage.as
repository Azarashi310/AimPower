package game {
	
	import flash.display.MovieClip;
	import Main;
	
	public class ResultPage extends MovieClip {
		
		//スコアの格納
		private var scoreArray:Array;
		
		//Mainを持ってくる
		private var mainPage:Main = new Main();
		
		public function ResultPage() {
			// constructor code
			//trace(resultScore.missCounter);
			scoreInit();
		}
		
		//スコアの初期化
		private function scoreInit():void
		{
			//スコアの取得
			scoreArray = mainPage.getScore();
			//ミススコア
			resultScore.missCounter.text = scoreArray[0];
			//グッドスコア
			resultScore.goodCounter.text = scoreArray[1];
			//ナイススコア
			resultScore.niceCounter.text = scoreArray[2];
			//マーヴェラススコア
			resultScore.marvelousCounter.text = scoreArray[3];
			//パーフェクトスコア
			resultScore.perfectCounter.text = scoreArray[4];
			
			//得点計算
			resultScore.missScore.text = (scoreArray[0] * -2)
			resultScore.goodScore.text = scoreArray[1];
			resultScore.niceScore.text = (scoreArray[2] * 2);
			resultScore.marvelousScore.text = (scoreArray[3] * 5);
			resultScore.perfectScore.text = (scoreArray[4] * 10);
			resultScore.totalScore.text = (scoreArray[0] * -2) + scoreArray[1] + (scoreArray[2] * 2) + (scoreArray[3] * 5) + (scoreArray[4] * 10);
		}
	}
	
}
