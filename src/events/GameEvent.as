package events
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameEvent
	{
		public static const XML_LOADED = "xmlLoaded";
		public static const ALL_ASSETS_IS_READY = "allAssetsIsReady";
		public static const STAGE_ELEMENTS_ARE_HIDDEN = "stageElementsAreHidden";
		public static const STAGE_ELEMENTS_ARE_VISIBLE = "stageElementsAreVisible";
		
		public static const ROLE_IS_READY = "roleIsReady";
		
		private var pName:String;
		
		public function GameEvent($type:String)
		{
			pName = $type;
		}
		
		public function get name():String
		{
			return pName;
		}
		
		/*public function GameEvent($type:String, /*$sliderValue,*//*$bubbles:Boolean=false, $cancelable:Boolean=false):void
		{*/
			//_sliderValue = $sliderValue;
		/*	super($type,$bubbles,$cancelable);
		}
		
		override public function clone():Event 
		{
			return new GameEvent(type, bubbles, cancelable);
		}
		
		override public function toString () :String 
		{
			return formatToString("GameEvent", "$type", "$bubbles",
			"$cancelable", "eventPhase");
		}
		
		/*public function get sliderValue():Number 
		{
			return _sliderValue;
		}*/
	}
}