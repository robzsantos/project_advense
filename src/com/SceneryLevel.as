package com
{
	import com.Entity;
	import flash.display.Sprite;
	import flash.geom.Point;
	import mvc.GameView;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class SceneryLevel extends Entity
	{
		private var hasHorizontalScroll:Boolean;
		
		private var hasVerticalScroll:Boolean;
		
		private var isLastLevelVisible:Boolean;
		
		private var isFirstLevelVisible:Boolean;
		
		private var lastPosX:Number;
		
		private var initPosX:Number;
		
		public function SceneryLevel($world:GameWorld,$sceneryObject:*,$id:int,$category:String,$position:Point,$dimensions:Point)
		{
			super($world, $id, $category, $position, $dimensions);
			
			$sceneryObject.x = 0;
			$sceneryObject.y = 0;
			//sceneryObject = $sceneryObject;
			isLastLevelVisible = false;
			lastPosX = 0;
			initPosX = this.x;
			this.addChild($sceneryObject);			
		}
		
		public function get getHorizontalScroll():Boolean
		{
			return hasHorizontalScroll;
		}
		
		public function get getVerticalScroll():Boolean
		{
			return hasVerticalScroll;
		}
		
		public function set setHorizontalScroll($value:Boolean):void
		{
			hasHorizontalScroll = $value;
		}
		
		public function set setVerticalScroll($value:Boolean):void
		{
			hasVerticalScroll = $value;
		}
		
		public function set setIsLastLevelVisible(value:Boolean):void 
		{
			isLastLevelVisible = value;			
		}
		
		public function get getIsLastLevelVisible():Boolean
		{
			return isLastLevelVisible;
		}
		
		public function set setIsFirstLevelVisible(value:Boolean):void 
		{
			isFirstLevelVisible = value;			
		}
		
		public function get getIsFirstLevelVisible():Boolean
		{
			return isFirstLevelVisible;
		}
		
		public function get getLastPosX():Number
		{
			return lastPosX;
		}
		
		public function get getInitPosX():Number
		{
			return initPosX;
		}
		
		public function setLastPosX($value:Point):void
		{
			lastPosX = (GameView.STAGE_DIMENSIONS.x + (~($value.x) + 1)) - this.width;
		}
		
		public function moveHorizontalToStart():void
		{
			this.x += PlayerActor.VELOCITY;			
		}
		
		public function moveHorizontalToEnd():void
		{
			this.x -= PlayerActor.VELOCITY;
		}
		
		public function moveVertical():void
		{
			
		}
	}
}