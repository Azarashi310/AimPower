package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main
	{
		//難易度
		public static var difficulty:int;
		
		//スコア
		public static var score:Array;
		/*
		public static var missCount:int;
		public static var goodCount:int;
		public static var niceCount:int;
		public static var marvelousCount:int;
		public static var perfectCount:int;
		*/
		
		public function Main()
		{}
		
		//難易度をセット
		public function setDifficulty(number:int):void
		{
			difficulty = number;
		}
		
		//難易度をゲット
		public function getDifficulty():int
		{
			return difficulty;
		}
		
		//スコアをセット
		public function setScore(scoreArray:Array):void
		{
			score = scoreArray;
		}
		
		//スコアをゲット
		public function getScore():Array
		{
			return score;
		}
	}
}
