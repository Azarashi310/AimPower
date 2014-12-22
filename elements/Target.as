package elements {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import elements.Target_GoodArea;
	
	public class Target extends MovieClip {
		
		//ヒット判定
		public var goodAreaHit:Boolean;
		public var niceAreaHit:Boolean;
		public var marvellousHit:Boolean;
		public var perfectHit:Boolean;
		
		//判定の生成準備
		public var GA:Target_GoodArea = new Target_GoodArea();
		public var NA:Target_NiceArea = new Target_NiceArea();
		public var MA:Target_MarvellousArea = new Target_MarvellousArea();
		public var PA:Target_PerfectArea = new Target_PerfectArea();
		
		//ターゲットの移動場所
		public var move_X:int;
		public var move_Y:int;
		
		//ターゲットのイージング
		public var friction:Number = 0.2;
		
		//ターゲットの最低移動距離
		public var MoveUnder:int = 50;
		
		public function Target() {
			// constructor code
			
			//判定の初期化
			init();
		}
		
		//Init
		private function init():void
		{
			//GoodAreaの生成
			GA.x = 0;
			GA.y = 0;
			addChild(GA);
			//NiceAreaの生成
			NA.x = 10;
			NA.y = 10;
			addChild(NA);
			//marvellousAreaの生成
			MA.x = 25;
			MA.y = 25;
			addChild(MA);
			//perfectAreaの生成
			PA.x = 38;
			PA.y = 38;
			addChild(PA);
		}
		
	}
	
}
