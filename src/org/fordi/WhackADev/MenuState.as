package org.fordi.WhackADev 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	
	
	public class MenuState extends FlxState {
		
		[Embed(source = "../../../../data/btnStartGame.png")] private var ImgStartGame:Class;
		[Embed(source = "../../../../data/cursor.png")] private var ImgCursor:Class;
		
		private var _letters:Array;
		private var _whackSaid:Boolean;
		private var _aSaid:Boolean;
		private var _devSaid:Boolean;
		private var _startingGame:Boolean;
		private function createLetter(letter:String, x:Number, y:Number, theta:Number, size:Number = 8, color:Number = 0, duration:Number = 1):void {
			var startX:Number, startY:Number, side:Number, line:Number;
			side = Math.floor(Math.random() * 4);
			line = Math.random();
			switch (side) {
				case 0: 
					startX = Math.floor((FlxG.width - size) * line);
					startY = -size;
					break;
				case 1:
					startX = FlxG.width;
					startY = Math.floor((FlxG.height - size) * line);
					break;
				case 2:
					startX = Math.floor((FlxG.width - size) * line);
					startY = FlxG.height;
					break;
				case 3:
					startX = -size;
					startY = Math.floor((FlxG.height - size) * line);
			}
			
			var text:FlxText = new FlxText(startX, startY, size, letter);
			text.angle = Math.round(Math.random() * 1080)-540;
			text.size = size;
			if (color == 0) {
				color = [0xdb0049, 0xff6e00, 0x69be28, 0x0056af][Math.floor(Math.random() * 4)];
			}
			text.color = color;
			_letters.push({
				spr: text,
				x: x,
				y: y,
				theta: theta,
				targetTime: duration,
				duration: duration
			});
			add(text);
		}
		private function lettersDone():Boolean {
			var allDone:Boolean = true,
				index:Number;
			for (index = 0; index < _letters.length; index++) {
				if (_letters[index].targetTime > 0) allDone = false;
			}
			return allDone;
		}
		private function easing(input:Number):Number {
			return 0.5-Math.cos(Math.max(0, Math.min(1, input))*Math.PI)/2;
		}
		private function tickLetter(allLettersPlaced:Function):void {
			if (lettersDone()) return;
			var index:Number,
				allDone:Boolean = true;
			for (index = 0; index < _letters.length; index++) {
				var textObj:Object = _letters[index];
				_letters[index].targetTime -= FlxG.elapsed;
				var dt:Number = easing(1-(textObj.targetTime / textObj.duration));
				textObj.spr.x = textObj.spr.x + (textObj.x - textObj.spr.x) * dt;
				textObj.spr.y = textObj.spr.y + (textObj.y - textObj.spr.y) * dt;
				textObj.spr.angle = textObj.spr.angle + (textObj.theta - textObj.spr.angle) * dt;
				
				
				if (_letters[index].targetTime <= 0) {
					textObj.spr.x = textObj.x;
					textObj.spr.y = textObj.y;
					textObj.spr.angle = textObj.theta;
					_letters[index].targetTime = 0;
				} else allDone = false;
			}
			if (allDone) allLettersPlaced();
		}
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
			_letters = new Array();
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