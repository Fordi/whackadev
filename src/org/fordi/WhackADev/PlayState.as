package org.fordi.WhackADev 
{
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class PlayState extends FlxState  {
		private var moleHoles:Array;
		
		private function point():void {
			
		}
		
		private function miss():void {
			
		}
		
		override public function create():void {
			var i:Number;
			var hole:MoleHole;
			moleHoles = new Array();
			for (i = 0; i < 6; i++) {
				hole = new MoleHole(
					8 + (i % 3) * (96 + 8),
					16 + Math.floor(i / 3) * (96 + 16)
				);
				moleHoles.push(hole);
				add(hole);
				trace('Added', hole);
			}
		}
		override public function update():void {
			if (Math.random() < (1 / (30 * 1))) {
				var index:Number = Math.floor(Math.random() * moleHoles.length);
				moleHoles[index].showMole(point, miss);
			}
			
		}
	}

}