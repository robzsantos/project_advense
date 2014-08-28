package com
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class Entity extends Sprite
	{
		private var _dimensions:Point;
		private var _position:Point;
		private var _category:String;
		private var _id:int;
		private var _isActive:Boolean;
		private var _depth:int;
		private var gWorld:GameWorld;
		
		public function Entity($world:GameWorld,$id:int,$category:String,$position:Point,$dimensions:Point)
		{
			_position = new Point();
			_dimensions = new Point();
			
			gWorld = $world;
			id = $id;
			category = $category;
			position = $position;
			dimensions = $dimensions;
			
			isActive = true;
			depth = 0;
			
			this.x = position.x;
			this.y = position.y;
		}
		
		public function get dimensions():Point 
		{
			return _dimensions;
		}
		
		public function set dimensions(value:Point):void 
		{
			_dimensions.x = value.x;
			_dimensions.y = value.y;
		}		
		
		public function get position():Point 
		{
			return _position;
		}
		
		public function set position(value:Point):void 
		{
			_position.x = value.x;
			_position.y = value.y;
		}
		
		public function get category():String 
		{
			return _category;
		}
		
		public function set category(value:String):void 
		{
			_category = value;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function set isActive(value:Boolean):void 
		{
			_isActive = value;
		}
		
		public function set depth($value:int):void
		{
			_depth = $value;
		}
		
		public function get depth():int 
		{
			return _depth;
		}
		
		public function getWorld():GameWorld 
		{
			return gWorld;
		}
	}
}