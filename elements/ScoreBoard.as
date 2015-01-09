package elements {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class ScoreBoard extends MovieClip {
		
		//スコアボードの表示位置
		public var Point_X:int = 0;
		public var Point_Y:int = 280;
		
		//スコアボードのエリア
		public var Area_X:int = 120;
		public var Area_Y:int = 215;
		
		
		public function ScoreBoard() 
		{
			// constructor code
		}
		
		//ミスの得点加算
		public function addMiss(missPoint:String)
		{
			miss.text = missPoint;
		}
		
		//グッドの得点加算
		public function addGood(goodPoint:String)
		{
			good.text = goodPoint;
		}
		
		//ナイスの得点加算
		public function addNice(nicePoint:String)
		{
			nice.text = nicePoint;
		}
		
		//マーベラスの得点加算
		public function addMarvellous(MarvellousPoint:String)
		{
			marvellous.text = MarvellousPoint;
		}
		
		//パーフェクトの得点加算
		public function addPerfect(PerfectPoint:String)
		{
			perfect.text = PerfectPoint;
		}
	}
	
}
