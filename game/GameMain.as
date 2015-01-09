package  game
{
	import elements.GoBackTitle_Button;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import elements.Target;
	import elements.ScoreBoard;
	import elements.InterFace;
	import elements.MouseCoursolObject;
	import a24.tween.Tween24;
	import Main;
	
	public class GameMain extends MovieClip 
	{		
		//難易度
		private var difficulty:int;
		
		//マウスの座標取得
		private var mouse_x:int;
		private var mouse_y:int;
		
		//スコア
		private var missPoint:int;
		private var goodPoint:int;
		private var nicePoint:int;
		private var marvellousPoint:int;
		private var perfectPoint:int;
		
		//インターフェース
		private var IF:InterFace = new InterFace();
		
		//スコア記憶
		private var SB:ScoreBoard = new ScoreBoard();
		
		//ターゲット
		private var TG:Target = new Target();
		
		//マウスとオブジェクトのヒット判定
		private var hitMousebyObject:Boolean;
		
		//制限時間用
		var timer:Timer = new Timer(20000,1);
		
		//時間表示用
		var showTimer:Timer = new Timer(1000, 0);
		var showTimerNumber:int = 20;
		
		//ヒットさせた時の音
		private var kan:Sound = new Kan();
		
		//外した時の音
		private var miss:Sound = new Miss();
		
		//メイン
		private var mainPage:Main = new Main();
		
		//マウス
		private var MC:MouseCoursolObject = new MouseCoursolObject();
		
		//モーショントゥイーン
		private var targetTween:Tween24;
		
		//（エンドレスモードのみ）タイトルに戻るボタン
		private var goBackTitle:GoBackTitle_Button = new GoBackTitle_Button();
		
		public function GameMain() {
			// constructor code
			
			//難易度の取得
			difficulty = mainPage.getDifficulty();
			
			//ゲームの初期化
			gameInit();
			
			//タイトルに戻るボタンが押された
			goBackTitle.addEventListener(MouseEvent.MOUSE_UP,goBackTitle_MOUSE_UP_EventHandler)
		}
		
		//初期化
		private function gameInit():void
		{
			//インターフェースの位置設定
			IF.x = IF.Point_X;
			IF.y = IF.Point_Y;
			
			//インターフェースを追加
			addChild(IF);
			
			//ターゲットの生成( + ~~ は広げたぶん)
			TG.width = 50;
			TG.height = 50;
			TG.x = 230;
			TG.y = 150;
			TG.move_X = 220;
			TG.move_Y = 150;
			addChild(TG);
			
			//マウスの表示を消す
			Mouse.hide();
			
			//マウスを点にする
			MC.x = 0;
			MC.y = 0;
			addChild(MC);
			
			//エンドレスモードに限ってはスコアボードとタイトルに戻るボタンを表示させる
			if (difficulty == 9)
			{
				//スコアボードの位置
				SB.x = SB.Point_X;
				SB.y = SB.Point_Y;
				
				//タイトルに戻るボタンの位置
				goBackTitle.x = goBackTitle.pointX - 32;
				goBackTitle.y = goBackTitle.pointY;
				
				//インターフェースに追加
				IF.addChild(SB);
				this.addChild(goBackTitle);
			}
			
			//スコアの初期化
			missPoint = 0;
			goodPoint = 0;
			nicePoint = 0;
			marvellousPoint = 0;
			perfectPoint = 0;
			
			//マウスがターゲットをクリックしたかのイベントリスナー
			this.addEventListener(MouseEvent.MOUSE_DOWN, taget_MouseDOWN_EventHandler);
			
			//タイマーのスタート
			if (difficulty == 0)
			{
				//制限時間用
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, timer_EventHandler);
				
				//表示用
				showTimer.start();
				showTimer.addEventListener(TimerEvent.TIMER, showTimer_EventHandler);
				IF.timeLeft.text = "残り" + showTimerNumber.toString() + "秒";
			}
			else
			{
				IF.timeLeft.text = "残り ∞ 秒";
			}
			
			//マウスを動かす
			addEventListener(MouseEvent.MOUSE_MOVE, MOUSE_MOVE_EventHandler);
		}
		
		
		
		//マウスを動かす
		private function MOUSE_MOVE_EventHandler(e:MouseEvent):void 
		{
			e.updateAfterEvent();
			
			//マウスの位置を取得
			mouse_x = stage.mouseX;
			mouse_y = stage.mouseY;
			
			//マウス代わりを表示
			MC.x = mouse_x - 2.5;
			MC.y = mouse_y - 2.5;
		}
		
		//タイマーがカウント終了したら
		private function timer_EventHandler(e:TimerEvent):void 
		{
			//ゲームのメインを止める
			//removeEventListener(Event.ENTER_FRAME, GameEnterFrame_EventHandler);
			//時間の表示を止める
			removeEventListener(TimerEvent.TIMER, showTimer_EventHandler);
			//マウスダウンを消す
			removeEventListener(MouseEvent.MOUSE_DOWN, taget_MouseDOWN_EventHandler);
			//マウスムーブを消す
			removeEventListener(MouseEvent.MOUSE_MOVE, MOUSE_MOVE_EventHandler);
			//スコアを渡す
			var scoreArray:Array = [missPoint, goodPoint, nicePoint, marvellousPoint, perfectPoint];
			mainPage.setScore(scoreArray);
			//リザルトに飛ぶ
			MovieClip(parent).gotoAndStop("result");
		}
		
		//表示用
		private function showTimer_EventHandler(e:TimerEvent):void 
		{
			showTimerNumber = showTimerNumber - 1;
			IF.timeLeft.text = "残り" + showTimerNumber.toString() + "秒";
		}
		
		//マウスダウンしたら
		private function taget_MouseDOWN_EventHandler(e:MouseEvent):void 
		{
			//マウスとターゲットの位置の再取得
			getMousePoint();
			
			if (TG.goodAreaHit)
			{
				//ポイント加算
				goodPoint++;
				
				//スコアボード加算
				SB.addGood(goodPoint.toString());
				
				//次の移動場所生成
				targetMovePoint();
				
				//ターゲットの移動
				targetTween = Tween24.tween(TG, TG.easying, Tween24.ease.ExpoInOut).xy(TG.move_X, TG.move_Y);
				targetTween.play();
				
				//ヒット音の再生
				kan.play();
			}
			else if(TG.niceAreaHit)
			{
				nicePoint++;
				SB.addNice(nicePoint.toString());
				targetMovePoint();
				
				targetTween = Tween24.tween(TG, TG.easying, Tween24.ease.ExpoInOut).xy(TG.move_X, TG.move_Y);
				targetTween.play();
				
				kan.play();
			}
			else if (TG.marvellousHit)
			{
				marvellousPoint++;
				SB.addMarvellous(marvellousPoint.toString());
				targetMovePoint();
				
				targetTween = Tween24.tween(TG, TG.easying, Tween24.ease.ExpoInOut).xy(TG.move_X, TG.move_Y);
				targetTween.play();
				
				kan.play();
			}
			else if (TG.perfectHit)
			{
				perfectPoint++;
				SB.addPerfect(perfectPoint.toString());
				targetMovePoint();
				
				targetTween = Tween24.tween(TG, TG.easying, Tween24.ease.ExpoInOut).xy(TG.move_X, TG.move_Y);
				targetTween.play();
				
				kan.play();
			}
			else
			{
				missPoint++;
				SB.addMiss(missPoint.toString());
				
				miss.play();
			}			
		}
		
		//ターゲットにヒットしたらマウスの位置を再取得
		private function getMousePoint():void
		{
			//ヒット判定
			//goodエリアへのヒット
			TG.goodAreaHit = TG.GA.hitTestPoint(mouse_x, mouse_y, true);
			
			//niceエリアへのヒット
			TG.niceAreaHit = TG.NA.hitTestPoint(mouse_x, mouse_y, true);
			
			//marvellousエリアへのヒット
			TG.marvellousHit = TG.MA.hitTestPoint(mouse_x, mouse_y, true);
			
			//perfectエリアへのヒット
			TG.perfectHit = TG.PA.hitTestPoint(mouse_x, mouse_y, true);
		}
		
		//ターゲットの移動場所の指定
		private function targetMovePoint():void 
		{
			for (var i:int = 0; i < 10; i++ )
			{
				TG.move_X = Math.random() * TG.MoveArea_X << 0;
				TG.move_Y = Math.random() * TG.MoveArea_Y << 0;
				if (((TG.x < TG.move_X - TG.MoveUnder) || (TG.move_X + TG.MoveUnder < TG.x)) || 
				((TG.y < TG.move_Y -TG.MoveUnder) || (TG.move_Y + TG.MoveUnder < TG.y)))
				{
					break;
				}
			}
			//表示時間と重なる場合は表示時間を消す
			if (((120 <= TG.move_X) && (TG.move_X <= 360)) && ((0 <= TG.move_Y) && (TG.move_Y <= 40)))
			{
				IF.timeLeft.alpha = 0;
			}
			else
			{
				IF.timeLeft.alpha = 1;
			}
			/*
			 * 
			 * エンドレスモードのみ
			 * 
			 * */
			//スコアボードと重なる場合スコアボードを透明にする
			if ((TG.move_X <= SB.Area_X) && (SB.Area_Y <=TG.move_Y))
			{
				SB.alpha = 0;
			}
			else
			{
				SB.alpha = 1;
			}
			//タイトルに戻るボタンとかぶる場合
			if ((goBackTitle.Area_X <= TG.move_X) && (goBackTitle.Area_Y <= TG.move_Y))
			{
				goBackTitle.alpha = 0;
			}
			else
			{
				goBackTitle.alpha = 1;
			}
		}
		
		//タイトルに戻るボタンが押された
		private function goBackTitle_MOUSE_UP_EventHandler(e:MouseEvent):void 
		{
			if (goBackTitle.alpha != 0)
			{
				//時間の表示を止める
				removeEventListener(TimerEvent.TIMER, showTimer_EventHandler);
				//マウスダウンを消す
				removeEventListener(MouseEvent.MOUSE_DOWN, taget_MouseDOWN_EventHandler);
				//マウスムーブを消す
				removeEventListener(MouseEvent.MOUSE_MOVE, MOUSE_MOVE_EventHandler);
				//マウスの表示を戻す
				Mouse.show();
				//タイトルに戻る
				MovieClip(parent).gotoAndPlay("Title");
			}
		}
		
		//traceDebug
		private function traceDebug():void
		{
			trace("Difficult : " + difficulty);
			trace("target_moveX : " + TG.move_X);
			trace("target_moveY : " + TG.move_Y);
			trace("target_X : " + TG.x);
			trace("target_Y : " + TG.y);
		}
	}
	
}
