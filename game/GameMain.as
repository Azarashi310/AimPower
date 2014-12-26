package  game
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import elements.Target;
	import elements.ScoreBoard;
	import flash.media.Sound;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import elements.MouseCoursolObject;
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
		var kan:Sound = new Kan();
		
		//メイン
		private var mainPage:Main = new Main();
		
		//マウス
		private var MC:MouseCoursolObject = new MouseCoursolObject();
		
		public function GameMain() {
			// constructor code
			
			//難易度の取得
			difficulty = mainPage.getDifficulty();
			
			//ゲームの初期化
			gameInit();
		}
		
		//初期化
		private function gameInit():void
		{
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
			MC.x = 230;
			MC.y = 150;
			addChild(MC);
			
			//スコアボードの生成
			SB.x = 0;
			SB.y = 280;
			interFace.addChild(SB);
			
			//スコアの初期化
			missPoint = 0;
			goodPoint = 0;
			nicePoint = 0;
			marvellousPoint = 0;
			perfectPoint = 0;
			
			//マウスがターゲットをクリックしたかのイベントリスナー
			stage.addEventListener(MouseEvent.MOUSE_DOWN, taget_MouseDOWN_EventHandler);
			
			//タイマーのスタート
			if (difficulty == 0)
			{
				//制限時間用
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, timer_EventHandler);
				//表示用
				showTimer.start();
				showTimer.addEventListener(TimerEvent.TIMER, showTimer_EventHandler);
				interFace.timeLeft.text = "残り" + showTimerNumber.toString() + "秒";
			}
			else
			{
				interFace.timeLeft.text = "残り ∞ 秒";
			}
			//ここで回す
			addEventListener(Event.ENTER_FRAME, GameEnterFrame_EventHandler);
		}
		
		//ゲームのメインスレッド
		private function GameEnterFrame_EventHandler(e:Event):void 
		{
			//計算系
			calc();
			
			//ターゲットの移動
			targetMove();
		}
		
		//タイマーがカウント終了したら
		private function timer_EventHandler(e:TimerEvent):void 
		{
			//ゲームのメインを止める
			removeEventListener(Event.ENTER_FRAME, GameEnterFrame_EventHandler);
			//時間の表示を止める
			removeEventListener(TimerEvent.TIMER, showTimer_EventHandler);
			//マウスダウンを消す
			removeEventListener(MouseEvent.MOUSE_DOWN, taget_MouseDOWN_EventHandler);
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
			interFace.timeLeft.text = "残り" + showTimerNumber.toString() + "秒";
		}
		
		//計算系
		private function calc():void
		{
			//マウスの位置を取得
			mouse_x = stage.mouseX;
			mouse_y = stage.mouseY;
			
			//マウス代わりを表示
			MC.x = mouse_x - 2.5;
			MC.y = mouse_y - 2.5;
			
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
		
		//マウスダウンしたら
		private function taget_MouseDOWN_EventHandler(e:MouseEvent):void 
		{
			if (TG.goodAreaHit)
			{
				//ポイント加算
				goodPoint++;
				//スコアボード加算
				SB.addGood(goodPoint.toString());
				//次の移動場所生成
				targetMovePoint();
				
				kan.play();
			}
			else if(TG.niceAreaHit)
			{
				nicePoint++;
				SB.addNice(nicePoint.toString());
				targetMovePoint();
				
				kan.play();
			}
			else if (TG.marvellousHit)
			{
				marvellousPoint++;
				SB.addMarvellous(marvellousPoint.toString());
				targetMovePoint();
				
				kan.play();
			}
			else if (TG.perfectHit)
			{
				perfectPoint++;
				SB.addPerfect(perfectPoint.toString());
				targetMovePoint();
				
				kan.play();
			}
			else
			{
				missPoint++;
				SB.addMiss(missPoint.toString());
			}
		}
		
		//ターゲットの移動
		private function targetMove():void
		{
			if ((TG.x != TG.move_X) && (TG.y != TG.move_Y))
			{
				var diffX:Number = (TG.move_X - TG.x) * TG.friction;
				var diffY:Number = (TG.move_Y - TG.y) * TG.friction;
				
				TG.x += diffX;
				TG.y += diffY;
				
				if (Math.abs(diffX) <= 0.1 && Math.abs(diffY) <= 0.1)
				{
					TG.x = TG.move_X;
					TG.y = TG.move_Y;
				}
			}
		}
		
		//ターゲットの移動場所の指定
		private function targetMovePoint():void 
		{
			for (var i:int = 0; i < 10; i++ )
			{
				trace(i);
				TG.move_X = Math.random() * 450 << 0;
				TG.move_Y = Math.random() * 300 << 0;
				if (((TG.x < TG.move_X - TG.MoveUnder) || (TG.move_X + TG.MoveUnder < TG.x)) || 
				((TG.y < TG.move_Y -TG.MoveUnder) || (TG.move_Y + TG.MoveUnder < TG.y)))
				{
					break;
				}
			}
			//スコアボードと重なる場合スコアボードを透明にする
			if ((TG.move_X <= 120) && (215 <=TG.move_Y))
			{
				SB.alpha = 0;
			}
			else
			{
				SB.alpha = 1;
			}
			//表示時間と重なる場合は表示時間を消す
			if (((120 <= TG.move_X) && (TG.move_X <= 360)) && ((0 <= TG.move_Y) && (TG.move_Y <= 40)))
			{
				interFace.timeLeft.alpha = 0;
			}
			else
			{
				interFace.timeLeft.alpha = 1;
			}
			/*trace("target_moveX : " + TG.move_X);
			trace("target_moveY : " + TG.move_Y);
			trace("target_X : " + TG.x);
			trace("target_Y : " + TG.y);*/
		}
	}
	
}
