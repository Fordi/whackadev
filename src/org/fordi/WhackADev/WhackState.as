package org.fordi.WhackADev 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class WhackState extends FlxState
	{
		private var _letters:Array;
		
		protected function createLetter(letter:String, x:Number, y:Number, theta:Number, size:Number = 8, color:Number = -1, duration:Number = 1):void {
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
			
			var text:FlyText = new FlyText(startX, startY, size, letter);
			text.angle = Math.round(Math.random() * 1080)-540;
			text.size = size;
			if (color == -1) {
				color = [0xdb0049, 0xff6e00, 0x69be28, 0x0056af][Math.floor(Math.random() * 4)];
			}
			text.color = color;
			text.tx = x;
			text.ty = y;
			text.ta = theta;
			text.tt = duration;
			text.td = duration;
			if (!_letters) _letters = new Array();
			_letters.push(text);
			add(text);
		}
		protected function lettersDone():Boolean {
			var allDone:Boolean = true,
				index:Number;
			for (index = 0; index < _letters.length; index++) {
				if (_letters[index].tt > 0) allDone = false;
			}
			return allDone;
		}
		private function easing(input:Number):Number {
			return 0.5-Math.cos(Math.max(0, Math.min(1, input))*Math.PI)/2;
		}
		protected function tickLetter(allLettersPlaced:Function):void {
			if (lettersDone()) return;
			var index:Number,
				allDone:Boolean = true;
			for (index = 0; index < _letters.length; index++) {
				var textObj:FlyText = _letters[index];
				_letters[index].tt -= FlxG.elapsed;
				var dt:Number = easing(1-(textObj.tt / textObj.td));
				textObj.x = textObj.x + (textObj.tx - textObj.x) * dt;
				textObj.y = textObj.y + (textObj.ty - textObj.y) * dt;
				textObj.angle = textObj.angle + (textObj.ta - textObj.angle) * dt;
				
				
				if (_letters[index].tt <= 0) {
					textObj.x = textObj.tx;
					textObj.y = textObj.ty;
					textObj.angle = textObj.ta;
					_letters[index].tt = 0;
				} else allDone = false;
			}
			if (allDone) allLettersPlaced();
		}		
	}

}