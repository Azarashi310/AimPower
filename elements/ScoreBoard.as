package elements {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class ScoreBoard extends MovieClip {
		
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
