package org.fordi.WhackADev 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class PlayState extends FlxState implements MoleHoleDelegate {
		
		[Embed(source = "../../../../data/moleHole.png")] private var ImgEmptyHole:Class;
		[Embed(source = "../../../../data/dev.png")] private var ImgMoleHole:Class;
		[Embed(source = "../../../../data/augh.png")] private var ImgHitMole:Class;
		[Embed(source = "../../../../data/moleHole.png")] private var ImgStubHole:Class;
		
		private var moleHoles:Array;
		private var _hits:Number;
		private var _misses:Number;
		private var _stubs:Number;
		
		/* Implementation of MoleHoleDelegate methods */
		public function hitMole():void {
			trace('Hit!');
			_hits++;
		}
		public function missMole():void {
			trace('Missed one!');
			_misses++;
		}
		public function stubHammer():void {
			trace('Ow!');
			_stubs++;
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

		
		
		private function Fucker() {
			trace ('WTF?!');
		}
		override public function create():void {
			_hits = _misses = _stubs;
			var i:Number;
			var hole:MoleHole;
			moleHoles = new Array();
			for (i = 0; i < 6; i++) {
				hole = new MoleHole(
					Math.floor(8 + (i % 3) * (96 + 8)),
					Math.floor(16 + Math.floor(i / 3) * (96 + 16)),
					this
				);
				moleHoles.push(hole);
				add(hole);
				//trace('Added', hole);
			}
		}
		override public function update():void {
			if (Math.random() < (1 / (30 * 1))) {
				var index:Number = Math.floor(Math.random() * moleHoles.length);
				moleHoles[index].showMole();
				trace('showed hole #', index);
			}
			super.update();
		}
	}

}