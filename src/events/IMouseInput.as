package events
{
	import flash.events.MouseEvent;
	
	/**
	 * Todos os eventos úteis para uso no jogo
	 * @author RRS
	 */
	public interface IMouseInput 
	{
		function onClick( $ev:MouseEvent ):void;
		function onDown( $ev:MouseEvent ):void;
		function onUp( $ev:MouseEvent ):void;
		function onOut( $ev:MouseEvent ):void;
		function onOver( $ev:MouseEvent ):void;
	}	
}