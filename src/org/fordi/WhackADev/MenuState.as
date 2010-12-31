package org.fordi.WhackADev 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	
	
	public class MenuState extends WhackState {
		
		[Embed(source = "../../../../data/btnStartGame.png")] private var ImgStartGame:Class;
		[Embed(source = "../../../../data/cursor.png")] private var ImgCursor:Class;
		
		
		private var _whackSaid:Boolean;
		private var _aSaid:Boolean;
		private var _devSaid:Boolean;
		private var _startingGame:Boolean;
		

		private function sayWhack():void {
			if (_whackSaid) return;
			_whackSaid = true;
			createLetter('W',  80, 36, Math.round(Math.random() * 30 - 15), 32);
			createLetter('H', 112, 36, Math.round(Math.random() * 30 - 15), 32);
			createLetter('A', 144, 36, Math.round(Math.random() * 30 - 15), 32);
			createLetter('C', 176, 36, Math.round(Math.random() * 30 - 15), 32);
			createLetter('K', 208, 36, Math.round(Math.random() * 30 - 15), 32);
		}
		private function sayA():void {
			if (_aSaid) return;
			_aSaid = true;
			createLetter('-', 130, 72, 0, 20);
			createLetter('a', 150, 72, Math.round(Math.random() * 30 - 15), 20);
			createLetter('-', 170, 72, 0, 20);
		}
		private function sayDev():void {
			if (_devSaid) return;
			_devSaid = true;
			createLetter('D', 112, 96, Math.round(Math.random() * 30 - 15), 32);
			createLetter('E', 144, 96, Math.round(Math.random() * 30 - 15), 32);
			createLetter('V', 176, 96, Math.round(Math.random() * 30 - 15), 32);			
		}
		private function lettersPlaced():void {
			if (!_whackSaid) return sayWhack();
			if (!_aSaid) return sayA();
			if (!_devSaid) return sayDev();
		}
		
		private function gameStart():void {
			FlxG.flash.start(0xffffffff,0.5);
			FlxG.fade.start(0xff000000,1, gotoGameState);
		}
		private function gotoGameState():void {
			if (_startingGame) return;
			_startingGame = true;
			
			FlxG.state = new PlayState();
		}
		
		override public function create():void {
			_whackSaid = false;
			_aSaid = false;
			_devSaid = false;
			
			sayWhack();
			
			var button:FlxButton = new FlxButton(FlxG.width / 2 - 62, 172, gameStart);
			button.loadGraphic((new FlxSprite()).loadGraphic(ImgStartGame));
			add(button);
			
			FlxG.mouse.show(ImgCursor);
			
			super.create();
		}
		override public function update():void {
			tickLetter(lettersPlaced);
			super.update();
		}
		
	}

}