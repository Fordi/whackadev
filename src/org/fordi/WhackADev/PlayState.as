package org.fordi.WhackADev 
{

	import flash.utils.setTimeout;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class PlayState extends WhackState implements MoleHoleDelegate {
		[Embed(source = "../../../../data/emptyHole.png")] private var ImgEmptyHole:Class;
		[Embed(source = "../../../../data/moleHole.png")] private var ImgMoleHole:Class;
		[Embed(source = "../../../../data/hitHole.png")] private var ImgHitMole:Class;
		[Embed(source = "../../../../data/stubHole.png")] private var ImgStubHole:Class;
		
		private var moleHoles:Array;
		private var _hits:Number;
		private var _misses:Number;
		private var _stubs:Number;
		private var _gameOver:Boolean;
		private var _gameTime:Number;
		private var _lblScoreValue:FlxText;
		private var _lblTimeLeft:FlxText;
		private var _gameSaid:Boolean;
		private var _overSaid:Boolean;
		
		/* Implementation of MoleHoleDelegate methods */
		public function hitMole():void {
			_hits++;
			
		}
		public function missMole():void {
			_misses++;
		}
		public function stubHammer():void {
			_stubs++;
			FlxG.quake.start(0.05, 0.25);
		}
		public function emptyHole():Class {
			return ImgEmptyHole;
		}
		public function moleHole():Class {
			return ImgMoleHole;
		}
		public function hitHole():Class {
			return ImgHitMole;
		}
		public function stubHole():Class {
			return ImgStubHole;
		}
		
		private function createHUD():void {
			var lblScore:FlxText = new FlxText(8, 216, 56, "Score: ", true);
			lblScore.color = 0x0;
			lblScore.scrollFactor.x = lblScore.scrollFactor.y = 0;
			add(lblScore);
			
			_lblScoreValue = new FlxText(64, 216, 128, "0/0/0", true);
			_lblScoreValue.color = 0x0;
			_lblScoreValue.scrollFactor.x = _lblScoreValue.scrollFactor.y = 0;
			add(_lblScoreValue);
			
			_lblTimeLeft = new FlxText(192, 216, 128, "60.00", true);
			_lblTimeLeft.color = 0x0;
			_lblTimeLeft.scrollFactor.x = _lblTimeLeft.scrollFactor.y = 0;
			_lblTimeLeft.alignment = "right";
			add(_lblTimeLeft);
		}
		private function updateHUD():void {
			_lblScoreValue.text = _hits + '/' + _misses + '/' + _stubs;
			_lblTimeLeft.text = Math.floor(_gameTime) + '.' + Math.floor((_gameTime * 10) % 10) * 10;
		}
		
		override public function create():void {
			_hits = _misses = _stubs = 0;
			var i:Number;
			var hole:MoleHole;
			moleHoles = new Array();
			for (i = 0; i < 6; i++) {
				hole = new MoleHole(
					Math.floor(8 + (i % 3) * (96 + 8)),
					Math.floor(8 + Math.floor(i / 3) * (96 + 8)),
					this
				);
				moleHoles.push(hole);
				add(hole);
			}
			
			_gameOver = false;
			_gameTime = 30;
			
			createHUD();
		}
		public function reset():void {
			FlxG.state = new MenuState();
		}
		public function sayGameOver():void {
			setTimeout(reset, 1000);
		}
		
		override public function update():void {
			if (_gameOver) {
				if (!_gameSaid) {
					createLetter('G', 112, 36, Math.round(Math.random() * 30 - 15), 32, -1, 1);
					createLetter('A', 144, 36, Math.round(Math.random() * 30 - 15), 32, -1, 1.125);
					createLetter('M', 176, 36, Math.round(Math.random() * 30 - 15), 32, -1, 1.25);
					createLetter('E', 208, 36, Math.round(Math.random() * 30 - 15), 32, -1, 1.375);
					createLetter('O',  80, 76, Math.round(Math.random() * 30 - 15), 32, -1, 1.75);
					createLetter('V', 112, 76, Math.round(Math.random() * 30 - 15), 32, -1, 1.875);
					createLetter('E', 144, 76, Math.round(Math.random() * 30 - 15), 32, -1, 2);
					createLetter('R', 176, 76, Math.round(Math.random() * 30 - 15), 32), -1, 2.125;
				}
				_gameSaid = true;
				tickLetter(sayGameOver);
				return;
			}
			_gameTime -= FlxG.elapsed;
			if (_gameTime <= 0) {
				_gameOver = true;
				_gameTime = 0;
				//showGameOver();
/*				for (var i:Number = 0; i < moleHoles.length; i++) {
					moleHoles[i].hideMole(MoleHole.MISS);
				}*/
			}
			
			if (Math.random() < (1 / (30 * 1))) {
				var index:Number = Math.floor(Math.random() * moleHoles.length);
				moleHoles[index].showMole();
			}
			updateHUD();
			super.update();
		}
	}

}