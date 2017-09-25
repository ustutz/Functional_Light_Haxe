package;
import com.ls3d.HTMLTrace;

using Lambda;
class Main {
	

	static function main() {
		
		HTMLTrace.init(); // init custom trace that write the text to html
		
		map();
		filter();
		reduce();
		mapAsReduce();
		filterAsReduce();
		advancedListOperations();
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
		
		trace( '[increment, decrement, square].map <- 3: $result2' );
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
		
		trace( '[5, 10, 15].fold( product * v, 3 ): $reduced' );
		
		var hyphenate = function( str:String, char:String ) return str + "-" + char;
		trace( '["a", "b", "c"].fold( hyphenate ): ' + ["a", "b", "c"].fold( hyphenate, "" ) );
		
		var a = ["a", "b", "c"];
		a.reverse();
		trace( 'reversed ["a", "b", "c"].fold( hyphenate, "" ): ' + a.fold( hyphenate, "" ) );
		
	}
	
	static function mapAsReduce():Void {
		
		var double = function( v:Int ) return v * 2;
		
		var d1 = [1, 2, 3, 4, 5].map( double );
		trace( '[1,2,3,4,5].map( double ): ' + d1 );
		
		var reduceMap = function rm( v:Int, a:Array<Int> ):Array<Int> {
			a.push( double( v ));
			return a;
		}
		
		var d2 = [1, 2, 3, 4, 5].fold( reduceMap, [] );
		trace( '[1,2,3,4,5].fold( reduceMap, [] ): ' + d2 );
		
	}
	
	static function filterAsReduce():Void {
		
		var isOdd = function( v:Int ):Bool return v % 2 == 1;
		
		var f1 = [1, 2, 3, 4, 5].filter( isOdd );
		trace( '[1,2,3,4,5].filter( isOdd ): ' + f1 );
		
		var reduceFilter = function rf( v:Int, a:Array<Int> ):Array<Int> {
			if ( isOdd( v )) a.push( v );
			return a;
		}
		
		var f2 =  [1, 2, 3, 4, 5].fold( reduceFilter, [] );
		trace( '[1,2,3,4,5].fold( reduceFilter, [] ): ' + f2 );
		
	}
	
	static function flatten( arr:Array<Dynamic> ) {
		return arr.fold( function( v:Dynamic, list:Array<Dynamic> ):Array<Dynamic> {
			return list.concat( Std.is( v, Array ) ? flatten( v ) : v );
		}, [] );
	}
		
	static function advancedListOperations():Void {
		
		var f1 = flatten( [[0, 1], 2, 3, [4, [5, 6, 7], [8, [9, [10, [11, 12], 13]]]]] );
		trace( 'flatten( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]] ): ' + f1 );
	}
}