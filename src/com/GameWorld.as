package com
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class GameWorld
	{
		private var _mWorldDimensions:Point;
		
		public function GameWorld(pDimensions:Point)
		{
			_mWorldDimensions = new Point(pDimensions.x, pDimensions.y);
		}
		
		/*public function step(pTimer:Number):void
		{
			
		}*/
		
		public function get mWorldDimensions():Point 
		{
			return _mWorldDimensions;
		}
		
		public function set mWorldDimensions($value:Point):void 
		{
			if($value.x > _mWorldDimensions.x)
				_mWorldDimensions.x = $value.x;
			if($value.y > _mWorldDimensions.y)
				_mWorldDimensions.y = $value.y;
		}
	}
}