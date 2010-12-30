package org.fordi.WhackADev 
{
	import flash.utils.setTimeout;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class MoleHole extends FlxButton
	{
		[Embed(source = "../../../../data/moleHole.png")] private var ImgMoleHole:Class;
		[Embed(source = "../../../../data/dev.png")] private var ImgDev:Class;
		[Embed(source = "../../../../data/augh.png")] private var ImgAugh:Class;
		
		private var _moleHole:FlxSprite;
		private var _dev:FlxSprite;
		private var _augh:FlxSprite;
		private var _hasMole:Number;
		private var _success:Function;
		private var _failure:Function;
		
		private function handleClick():void {
			if (_hasMole != -1) {
				hideMole();
				_success();
			} else {
				_failure();
			}
		}
		
		public function MoleHole(x:Number, y:Number) {
			super(x, y, handleClick);
			_moleHole = new FlxSprite();
			_moleHole.loadGraphic(ImgMoleHole, true);
			
			add(_moleHole);
			
			_hasMole = -1;
			
			width = 96;
			height = 96;
			
		}
		
		private function hideMole():void {
			_hasMole = -1;
		}
		
		private function k():void {
			
		}
		
		public function showMole(success:Function = null, failure:Function = null):void {
			if (_hasMole != -1) return;
			_hasMole = setTimeout(hideMole, 2000);
			_success = success == null ? k : success;
			_failure = failure == null ? k : failure;
		}
	}

}