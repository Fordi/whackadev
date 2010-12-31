package org.fordi.WhackADev 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public interface MoleHoleDelegate 
	{
		function hitMole():void;
		function missMole():void;
		function stubHammer():void;
		function emptyHole():Class;
		function moleHole():Class;
		function hitHole():Class;
		function stubHole():Class;
	}
	
}