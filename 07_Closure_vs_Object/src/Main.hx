package;

import neko.Lib;

class Main {
	
	static function main() {
		
		simpleFunctionClosureExample();
		simpleObjectExample();
	}
	
	static function simpleFunctionClosureExample():Void {
		
		function outer():Void->Float {
			var one = 1;
			var two = 2;
			
			return function inner():Float {
				return one + two;
			}
		}
		
		var three = outer();
		
		trace( 'three(): ${three()}' );
	}
	
	static function simpleObjectExample():Void {
		
		var obj = {
			one: 1,
			two: 2
		};
		
		function three( outer ) {
			return outer.one + outer.two;
		}
		
		trace( 'three( obj ): ${three( obj )}' );
	}
}