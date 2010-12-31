package org.fordi.WhackADev 
{
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class FlyText extends FlxText {
		public var tx:Number;
		public var ty:Number;
		public var ta:Number;
		public var tt:Number;
		public var td:Number;
		public function FlyText(X:Number, Y:Number, Width:uint, Text:String = null, EmbeddedFont:Boolean = true) {
			super(X, Y, Width, Text, EmbeddedFont);
		}
	}

}