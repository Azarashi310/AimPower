package  game
{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import elements.Target;
	import elements.ScoreBoard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Main;
	
	public class GameMain extends MovieClip 
	{		
		
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
		
		//ウェイトタイマー（エンドレスモード用に切り分けできるようにする）
		var timer:Timer = new Timer(20000,1);
		
		//メイン
		private var mainPage:Main = new Main();
		
		public function GameMain() {
			// constructor code
			//ゲームの初期化
			gameInit();
		}
		
		//タイマーがカウント終了したら
		private function timer_EventHandler(e:TimerEvent):void 
		{
			removeEventListener(Event.ENTER_FRAME, GameEnterFrame_EventHandler);
			MovieClip(parent).gotoAndStop("result");
		}
		
		//初期化
		private function gameInit():void
		{
			//ターゲットの生成
			TG.width = 50;
			TG.height = 50;
			TG.x = 220;
			TG.y = 150;
			TG.move_X = 220;
			TG.move_Y = 150;
			addChild(TG);
			
			//スコアボードの生成
			SB.x = 0;
			SB.y = 280;
			addChild(SB);
			
			//スコアの初期化
			missPoint = 0;
			goodPoint = 0;
			nicePoint = 0;
			marvellousPoint = 0;
			perfectPoint = 0;
			
			//マウスがターゲットをクリックしたかのイベントリスナー
			stage.addEventListener(MouseEvent.MOUSE_DOWN, taget_MouseDOWN_EventHandler);
			
			//タイマーのスタート
			if (mainPage.difficulty == 0)
			{
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, timer_EventHandler);
			}
			
			//ここで回す
			addEventListener(Event.ENTER_FRAME, GameEnterFrame_EventHandler);
		}
		
		//ゲームのメインスレッド
		private function GameEnterFrame_EventHandler(e:Event):void 
		{
			//マウスの位置を取得
			getMousePointByTarget();
			
			//ヒット判定
			hitObject();
			
			//ターゲットの移動
			targetMove();
		}
		
		//ターゲットに対しての座標位置取得
		private function getMousePointByTarget():void 
		{
			mouse_x = stage.mouseX;
			mouse_y = stage.mouseY;
		}
		
		//ヒット判定
		private function hitObject():void
		{
			//goodエリアへのヒット
			TG.goodAreaHit = TG.GA.hitTestPoint(mouse_x, mouse_y, true);
			
			//niceエリアへのヒット
			TG.niceAreaHit = TG.NA.hitTestPoint(mouse_x, mouse_y, true);
			
			//marvellousエリアへのヒット
			TG.marvellousHit = TG.MA.hitTestPoint(mouse_x, mouse_y, true);
			
			//perfectエリアへのヒット
			TG.perfectHit = TG.PA.hitTestPoint(mouse_x, mouse_y, true);
		}
		
		//マウスアップしたら
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
			}
			else if(TG.niceAreaHit)
			{
				nicePoint++;
				SB.addNice(nicePoint.toString());
				targetMovePoint();
			}
			else if (TG.marvellousHit)
			{
				marvellousPoint++;
				SB.addMarvellous(marvellousPoint.toString());
				targetMovePoint();
			}
			else if (TG.perfectHit)
			{
				perfectPoint++;
				SB.addPerfect(perfectPoint.toString());
				targetMovePoint();
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
				TG.move_X = Math.random() * 500 << 0;
				TG.move_Y = Math.random() * 350 << 0;
				if (((TG.x < TG.move_X - TG.MoveUnder) || (TG.move_X + TG.MoveUnder < TG.x)) || 
				((TG.y < TG.move_Y -TG.MoveUnder) || (TG.move_Y + TG.MoveUnder < TG.y)))
				{
					break;
				}
			}
			if ((TG.move_X <= 100) && (180 <=TG.move_Y))
			{
				SB.alpha = 0;
			}
			else
			{
				SB.alpha = 1;
			}
		}
	}
	
}
