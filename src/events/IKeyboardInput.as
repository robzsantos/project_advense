package events
{
	import flash.events.KeyboardEvent;
	
	/**
	 * Todos os eventos úteis para uso no jogo
	 * @author RRS
	 */
	public interface IKeyboardInput 
	{
		function onKeyDown( $ev:KeyboardEvent ):void;
		function onKeyUp( $ev:KeyboardEvent ):void;
	}	
}