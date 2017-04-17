package;

using Lambda;
class Main {
	
	public static function compose2<A,B,C>( f:B->C, g:A->B ):A->C 									{ return function( x:A ) return f( g( x )); }


	static function main() {
		
		var one = function():Int return 1;
		var two = function():Int return 2;
		var three = function():Int return 3;
		
		var result1 = [one, two, three].map( function( f:Void->Int ) return f());
		
		trace( '[one, two, three].map: $result1' );
		
		
		var increment = function( v:Int ) return ++v;
		var decrement = function( v:Int ) return --v;
		var square = function( v:Int ) return v * v;
		
		var double = function( v:Int ) return v * 2;
		
		var result2 = [increment, decrement, square].map( function( fn:Int->Int ) return compose2( fn, double )).map( function( fn:Int->Int ) return fn( 3 ));
		
		trace( '[increment, decrement, square].map: $result2' );
		
		
		var isOdd = function( v:Int ):Bool return v % 2 == 1;
		
		var result3 = [1, 2, 3, 4, 5].filter( isOdd );
		
		trace( '[1, 2, 3, 4, 5].filter( isOdd ): $result3' );
		
		
		
		
	}
	
	static var filterIn = Lambda.filter;
	
	static function filterOut( predicateFn, arr ) {
		return filterIn( not( predicateFn ), arr );
	}
	
}