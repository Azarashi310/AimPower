package game {
	
	import elements.GoBackTitle_Button;
	import flash.events.MouseEvent;
	import elements.Rating_Anim;
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import Main;
	
	public class ResultPage extends MovieClip {
		
		//スコアの格納
		private var scoreArray:Array;
		
		//Mainを持ってくる
		private var mainPage:Main = new Main();
		
		//レーティングのインスタンス化
		private var rating:Rating_Anim = new Rating_Anim();
		
		//タイトルに戻るボタン
		private var goBackTitle:GoBackTitle_Button = new GoBackTitle_Button();
		
		public function ResultPage() 
		{
			// constructor code
			
			//表示するスコアの初期化
			scoreInit();
			
			//タイトルに戻るボタン
			goBackTitle.addEventListener(MouseEvent.MOUSE_UP, goBackTitleButton_MOUSE_UP_EventHandler);
		}
		
		//スコアの初期化
		private function scoreInit():void
		{
			//タイトルに戻るボタンの位置
			goBackTitle.x = goBackTitle.pointX;
			goBackTitle.y = goBackTitle.pointY;
			
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
			
			//合計スコアを数値として格納
			var score:int = (scoreArray[0] * -2) + scoreArray[1] + (scoreArray[2] * 2) + (scoreArray[3] * 5) + (scoreArray[4] * 10);
			
			//レーティングの表示位置
			rating.x = rating.pointX;
			rating.y = rating.pointY;
			
			//レーティングを変える
			rating.changeRating(score);
			
			//表示する
			addChild(rating);
			
			//動かす
			rating.play();
			
			//マウスの表示を戻す
			Mouse.show();
			
			//タイトルに戻るボタンの表示
			addChild(goBackTitle);
		}
		
		//タイトルに戻るボタンを押したら
		private function goBackTitleButton_MOUSE_UP_EventHandler(e:MouseEvent):void 
		{
			MovieClip(parent).gotoAndPlay("Title");
		}
	}
	
}
