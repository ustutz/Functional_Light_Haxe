package;

import com.ls3d.HTMLTrace;
import js.Lib;

typedef Randoms = {
	var nums:Array<Float>;
	var smallCount:Int;
	var largeCount:Int;
}
 
class Main {
	
	static function main() {
		
		HTMLTrace.init(); // init custom trace that write the text to html
		
		useSaferGenerateMoreRandoms();
	}
	
	static var nums:Array<Float> = [];
	static var smallCount = 0;
	static var largeCount = 0;
	
	static function generateMoreRandoms( count:Int ):Void {
		
		for ( i in 0...count ) {
			var num = Math.random();
			
			if ( num > 0.5 ) {
				largeCount++;
			} else {
				smallCount++;
			}
			nums.push( num );
		}
	}
	
	static function safer_generateMoreRandoms( count:Int, initial:Randoms ):Randoms {
		
		// (1) save original state
		var orig:Randoms = {
			nums: nums,
			smallCount: smallCount,
			largeCount: largeCount
		}
		
		// (2) setup initial pre-side effects state
		nums = initial.nums.copy();
		smallCount = initial.smallCount;
		largeCount = initial.smallCount;
		
		// (3) beware impurity!
		generateMoreRandoms( count );
		
		// (4) capture side effect state
		var sides:Randoms = {
			nums: nums,
			smallCount: smallCount,
			largeCount: largeCount
		}
		
		// (5) restore original state
		nums = orig.nums;
		smallCount = orig.smallCount;
		largeCount = orig.largeCount;
		
		// (6) expose side effect state directly as output
		return sides;
	}
	
	static function useSaferGenerateMoreRandoms():Void {
		
		var initialStates:Randoms = {
			nums: [0.3, 0.4, 0.5],
			smallCount: 2,
			largeCount: 1
		}
		
		trace( 'safer_generateMoreRandoms( 5, initialStates ) ${safer_generateMoreRandoms( 5, initialStates )}');
		
		trace( 'nums: $nums' );
		trace( 'smallCount: $smallCount' );
		trace( 'largeCount: $largeCount' );
	}
}