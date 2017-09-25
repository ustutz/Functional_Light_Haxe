package;

import neko.Lib;

class Main {
	
	var step:Int;
	
	static function main() {
		new Main();
	}
	
	public function new() {
		
		step = 1;
		trace( 'recursion1( 16 ): ${recursion1( 16 )}' );
		
		step = 1;
		trace( 'isPrime( 17 ): ${isPrime( 17 )}' );
		
		trace( 'fib( 3 ): ${fib( 3 )}' );
		
		trace( 'isOdd 5: ${isOdd( 5 )}' );
		
		trace( 'maxEvenDeclarative([ 1, 10, 3, 2 ]): ${maxEvenDeclarative([ 1, 10, 3, 2 ])}' );
		
		trace( 'maxEvenRecursive([ 1, 10, 3, 2 ]): ${maxEvenRecursive([ 1, 10, 3, 2 ])}' );
		
		// nodetree
		//     node0
		//    /     \
		// node11 node12
		//  \       /   \
		// node21 node22 node23
		//        /
		//      node31
		
		var node31 = new Node();
		
		var node21 = new Node();
		var node22 = new Node( node31 );
		var node23 = new Node();
		
		var node11 = new Node( null, node21 );
		var node12 = new Node( node22, node23 );
		
		var node0 = new Node( node11, node12 );
		
		trace( 'depth node0: ${depth( node0 )}' );
	}
	
	// 1st example
	function recursion1( x:Float ):Float {
		
		trace( 'step ${step++}: x $x' );
		
		if ( x < 5 ) return x;
		return recursion1( x / 2 );
	}
	
	// is prime number
	function isPrime( num:Int, divisor:Int = 2 ):Bool {
		
		trace( 'step ${step++}: num $num divisor $divisor' );
		
		if ( num < 2 || ( num > 2 && num % divisor == 0 )) {
			return false;
		}
		
		if ( divisor <= Math.sqrt( num )) {
			return isPrime( num, divisor + 1 );
		}
		
		return true;
	}
	
	// fibonacci number
	function fib( n:Int ):Int {
		
		trace( 'fib( $n )' );
		
		if ( n <= 1 ) return n;
		return fib( n - 2 ) + fib( n - 1 );
	}
	
	// mutual recursion
	function isOdd( v:Int ):Bool {
		
		trace( 'isOdd $v' );
		
		if ( v == 0 ) return false;
		return isEven( Std.int( Math.abs( v ) - 1 ));
	}
	
	function isEven( v:Int ):Bool {
		
		trace( 'isEven $v' );
		
		if ( v == 0 ) return true;
		return isOdd( Std.int( Math.abs( v ) - 1 ));
	}
	
	// declarative recursion
	function maxEvenDeclarative( nums:Array<Float> ):Null<Float> {
		
		var num = Math.NEGATIVE_INFINITY;
		
		for ( i in 0...nums.length ) {
			if ( nums[i] % 2 == 0 && nums[i] > num ) {
				num = nums[i];
			}
		}
		
		if ( num != Math.NEGATIVE_INFINITY ) {
			return num;
		} else {
			return null;
		}
	}
	
	function maxEvenRecursive( nums:Array<Float> ):Null<Float> {
		
		var maxRest = nums.length > 1 ? maxEvenRecursive( nums.slice( 1 )) : null;
		
		return( nums[0] % 2 != 0 || nums[0] < maxRest ) ? maxRest : nums[0];
	}
	
	// binary tree recursion
	function depth( node:Node ):Int {
		
		if ( node != null ) {
			var depthLeft = depth( node.left );
			var depthRight = depth( node.right );
			return 1 + Std.int( Math.max( depthLeft, depthRight ));
		}
		return 0;
	}
	
}