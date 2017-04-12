package;

using Lambda;
class Main {
	

	static function main() {
		map();
		filter();
		reduce();
	}
	
	public static function compose2<A,B,C>( f:B->C, g:A->B ):A->C { return function( x:A ) return f( g( x )); }

	static function map():Void {
		
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
	}
	
	
	
	static function filter():Void {
		
		var isOdd = function( v:Int ):Bool return v % 2 == 1;
		var isEven = function( v:Int ):Bool return !isOdd( v );
		
		var result3 = [1, 2, 3, 4, 5].filter( isOdd );
		
		trace( '[1, 2, 3, 4, 5].filter( isOdd ): $result3' );
		
		
		trace( 'isOdd( 3 ): ${isOdd( 3 )}' );
		trace( 'isEven( 2 ): ${isEven( 2 )}' );
		
		var filterInIsEven = filterIn( isEven, [1, 2, 3, 4, 5] );
		
		trace( 'filterIn( isOdd, [1, 2, 3, 4, 5] ): ${filterIn( isOdd, [1, 2, 3, 4, 5] )}' );
		trace( 'filterIn( isEven, [1, 2, 3, 4, 5] ): ${filterIn( isEven, [1, 2, 3, 4, 5] )}' );
		
	}
	
	static function not<A>( predicateFn:A->Bool ):A->Bool {
		return function( v:A ):Bool {
			return !predicateFn( v );
		}
	}
	
	static function filterIn<A>( predicateFn:A->Bool, iterable:Iterable<A> ) { 
		return Lambda.filter( iterable, predicateFn );
	}
	
	static function filterOut<A>( predicateFn:A->Bool, iterable:Iterable<A> ) {
		return filterIn( not( predicateFn ), iterable );
	}
	
	
	
	static function reduce():Void { // = Lambda.fold
		
		
		var reduced = [5, 10, 15].fold( function( product, v ) { return product * v; }, 3 );
		
		trace( '[5, 10, 15].fold: $reduced' );
	}
}