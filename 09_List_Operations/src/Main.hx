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
		mappingThenFlattening();
		zipIt();
	}
	
	public static function compose2<A,B,C>( f:B->C, g:A->B ):A->C { return function( x:A ) return f( g( x )); }

	static function map():Void {
		
		var one = () -> 1;
		var two = () -> 2;
		var three = () -> 3;
		
		var result1 = [one, two, three].map( fn -> fn());
		
		trace( '[one, two, three].map: $result1' );
		
		
		var increment = v -> ++v;
		var decrement = v -> --v;
		var square = v -> v * v;
		
		var double = v -> v * 2;
		
		var result2 = [increment, decrement, square].map( fn -> compose2( fn, double )).map( fn -> fn( 3 ));
		
		trace( '[increment, decrement, square].map <- 3: $result2' );
	}
	
	
	
	static function filter():Void {
		
		var isOdd = v -> v % 2 == 1;
		var isEven = v -> !isOdd( v );
		
		var result3 = [1, 2, 3, 4, 5].filter( isOdd );
		
		trace( '[1, 2, 3, 4, 5].filter( isOdd ): $result3' );
		
		
		trace( 'isOdd( 3 ): ${isOdd( 3 )}' );
		trace( 'isEven( 2 ): ${isEven( 2 )}' );
		
		var filterInIsEven = filterIn( isEven, [1, 2, 3, 4, 5] );
		
		trace( 'filterIn( isOdd, [1, 2, 3, 4, 5] ): ${filterIn( isOdd, [1, 2, 3, 4, 5] )}' );
		trace( 'filterIn( isEven, [1, 2, 3, 4, 5] ): ${filterIn( isEven, [1, 2, 3, 4, 5] )}' );
		
	}
	
	static function not<A>( predicateFn:A->Bool ):A->Bool {
		return ( v:A ) -> !predicateFn( v );
	}
	
	static function filterIn<A>( predicateFn:A->Bool, iterable:Iterable<A> ) { 
		return Lambda.filter( iterable, predicateFn );
	}
	
	static function filterOut<A>( predicateFn:A->Bool, iterable:Iterable<A> ) {
		return filterIn( not( predicateFn ), iterable );
	}
	
	
	
	static function reduce():Void { // = Lambda.fold
		
		var reduced = [5, 10, 15].fold( ( product, v ) -> product * v, 3 );
		
		trace( '[5, 10, 15].fold( product * v, 3 ): $reduced' );
		
		var hyphenate = ( str, char ) -> str + "-" + char;
		
		trace( '["a", "b", "c"].fold( hyphenate ): ' + ["a", "b", "c"].fold( hyphenate, "" ) );
		
		var a = ["a", "b", "c"];
		a.reverse();
		trace( 'reversed ["a", "b", "c"].fold( hyphenate, "" ): ' + a.fold( hyphenate, "" ) );
		
	}
	
	static function mapAsReduce():Void {
		
		var double = v -> v * 2;
		
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
		
		var isOdd = v -> v % 2 == 1;
		
		var f1 = [1, 2, 3, 4, 5].filter( isOdd );
		trace( '[1,2,3,4,5].filter( isOdd ): ' + f1 );
		
		var reduceFilter = function rf( v:Int, a:Array<Int> ):Array<Int> {
			if ( isOdd( v )) a.push( v );
			return a;
		}
		
		var f2 =  [1, 2, 3, 4, 5].fold( reduceFilter, [] );
		trace( '[1,2,3,4,5].fold( reduceFilter, [] ): ' + f2 );
		
	}
	
	static function flatten1( arr:Array<Dynamic> ):Array<Dynamic> {
		return arr.fold( ( v:Dynamic, list:Array<Dynamic> ) -> list.concat( Std.is( v, Array ) ? flatten1( v ) : v ) , [] );
	}
	
	static function flatten2( arr:Array<Dynamic>, depth:Null<Float> ):Array<Dynamic> {
		if ( depth == null ) depth = Math.POSITIVE_INFINITY;
		return arr.fold( ( v:Dynamic, list:Array<Dynamic> ) -> list.concat( depth > 0 ? ( depth > 1 && Std.is( v, Array ) ? flatten2( v, depth - 1 ) : v ) : [v] ), [] );
	}
	
	static function advancedListOperations():Void {
		
		var f1 = flatten1( [[0, 1], 2, 3, [4, [5, 6, 7], [8, [9, [10, [11, 12], 13]]]]] );
		trace( 'flatten1( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]] ): ' + f1 );
		
		var f20 = flatten2( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]], 0 );
		trace( 'flatten20: $f20' );
		
		var f21 = flatten2( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]], 1 );
		trace( 'flatten21: $f21' );
		
		var f22 = flatten2( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]], 2 );
		trace( 'flatten22: $f22' );
		
		var f23 = flatten2( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]], 3 );
		trace( 'flatten23: $f23' );
		
		var f24 = flatten2( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]], 4 );
		trace( 'flatten24: $f24' );
		
		var f25 = flatten2( [[0,1],2,3,[4,[5,6,7],[8,[9,[10,[11,12],13]]]]], 5 );
		trace( 'flatten25: $f25' );
		
	}
	
	static function mappingThenFlattening():Void {
		
		var firstNames = [
			{ name: "Jonathan", variations: [ "John", "Jon", "Jonny" ] },
			{ name: "Stephanie", variations: [ "Steph", "Stephy" ] },
			{ name: "Frederick", variations: [ "Fred", "Freddy" ] }
		];
		
		var mapResult = firstNames.map( ( entry ) -> [entry.name].concat( entry.variations ));
		trace( 'firstnames.map $mapResult' );
		
		var flatMap1 = ( mapperFn, arr:Array<Dynamic> ) -> flatten2( arr.map( mapperFn ), 1 );
		
		var flatMap1Result = flatMap1( ( entry ) -> [entry.name].concat( entry.variations ), firstNames );
		trace( 'flatMap1 firstnames $flatMap1Result' );
		
		var flatMap2 = 
			( mapperFn:Dynamic->Dynamic, arr:Array<Dynamic> ) -> 
				arr.fold(
					( v:Dynamic, list:Array<Dynamic> ) -> 
						list.concat( mapperFn( v ))
				, [] );
		
		var flatMap2Result = flatMap2( ( entry ) -> [entry.name].concat( entry.variations ), firstNames );
		trace( 'flatMap2 firstnames $flatMap2Result' );
	}
	
	static function zip<T>( arr1:Array<T>, arr2:Array<T> ):Array<Array<T>> {
		
		var zipped:Array<Array<T>> = [];
		var arr1 = arr1.slice( 0 );
		var arr2 = arr2.slice( 0 );
		
		while ( arr1.length > 0 && arr2.length > 0 ) {
			zipped.push( [ arr1.shift(), arr2.shift() ] );
		}
		
		return zipped;
	}
	
	static function mergeLists<T>( arr1:Array<T>, arr2:Array<T> ):Array<T> {
		
		var merged:Array<T> = [];
		var arr1 = arr1.slice( 0 );
		var arr2 = arr2.slice( 0 );
		
		while ( arr1.length > 0 || arr2.length > 0 ) {
			if ( arr1.length > 0 ) {
				merged.push( arr1.shift() );
			}
			if ( arr2.length > 0 ) {
				merged.push( arr2.shift() );
			}
		}
		
		return merged;
	}
	
	static function zipIt():Void {
		
		var z1 = zip( [1, 3, 5, 7, 9], [2, 4, 6, 8, 10] );
		trace( 'zip( [1, 3, 5, 7, 9], [2, 4, 6, 8, 10] ): $z1' );
		
		var f1 = flatten1( [ [1, 2], [3, 4], [5, 6], [7, 8], [9, 10] ] );
		trace( 'flatten( [ [1, 2], [3, 4], [5, 6], [7, 8], [9, 10] ] ): $f1' );
		
		var fz = flatten1( zip ( [1, 3, 5, 7, 9], [2, 4, 6, 8, 10] ));
		trace( 'flatten1( zip ( [1, 3, 5, 7, 9], [2, 4, 6, 8, 10] )): $fz' );
		
		var m1 = mergeLists( [1, 3, 5, 7, 9], [2, 4, 6] );
		trace( 'mergeLists( [1, 3, 5, 7, 9], [2, 4, 6] ): $m1' );
	}
}