package;

import com.ls3d.HTMLTrace;
import haxe.Json;
import js.Lib;

using Lambda;
class Main {
	
	static var CURRENT_USER_ID;
	
	static function ajax( url:String, data:Dynamic, callback:Dynamic ):Void {
		
		trace( "ajax( url:" + url + " data:" + Json.stringify( data ) + " callback:" ); 
		trace( callback );
	}
	
	static function main() {
		
		HTMLTrace.init(); // init custom trace that write the text to html
		
		ajaxExample();
		addExample();
		reverseArgsExample();
		curryExample();
		identityExample();
		noPointsExample();
		printIfPointless();
	}
	
	static function ajaxExample():Void {
		
		var getPerson = FnLight.partial( ajax, "http://some.api/person" );
		var getOrder = FnLight.partial( ajax, "http://some.api/order" );
		
		
		CURRENT_USER_ID = "123456";
		
		var getCurrentUser = FnLight.partial( getPerson, { user: CURRENT_USER_ID });
		
		trace( "getCurrentUser():" );
		getCurrentUser();
	}
	
	static function add( x, y ) {
		return x + y;
	}
	
	static function addExample():Void {
		
		var add1 = [1, 2, 3, 4, 5].map( function adder( val ) {
			return add( 3, val );
		});
		
		trace( 'add1: $add1' );
		
		var add2 = [1, 2, 3, 4, 5].map( FnLight.partial( add, 3 ));
		trace( 'add2: $add2' );
		
	}
	
	static function reverseArgsExample():Void {
		
		var cacheResult = FnLight.reverseArgs( 
			FnLight.partial( FnLight.reverseArgs( ajax ), function onResult( obj ) {
				// do something with obj
		}));
		
		// later
		trace( "cacheResult:" );
		cacheResult( "http://some.api/person", { user: CURRENT_USER_ID } );
		
		
		// Haxe version
		// Haxe allows to bind any argument of a function without a need to use reverse
		var cacheResultHaxe = ajax.bind( _, _, function onResult( obj ) {
			// do something with obj
		});
		
		trace( "cacheResultHaxe:" );
		cacheResultHaxe( "http://some.api/person", { user: CURRENT_USER_ID } );
		
		
		// partialRight function
		var cacheResultPR = FnLight.partialRight( ajax, function onResult( obj ) {
			// do something with obj
		});
		trace( "cacheResultPR:" );
		cacheResultPR( "http://some.api/person", { user: CURRENT_USER_ID } );
		
	}
	
	static function curryExample():Void {
		
		var curriedAjax = FnLight.curry( ajax );
		
		var personFetcher = curriedAjax( "http://some.api/person" );
		
		var getCurrentUser = personFetcher( { user: CURRENT_USER_ID } );
		
		trace( "getCurrentUser:" );
		getCurrentUser( function foundUser( user ) {
			// do something with user
		});
		
		var adder = FnLight.curry( add );
		
		trace( "[1, 2, 3, 4, 5].map( adder( 3 )): " + [1, 2, 3, 4, 5].map( adder( 3 )));
		
		trace( "sum( 1, 2, 3, 4, 5 ): " + FnLight.sum( 1, 2, 3, 4, 5 ));
		
		// now with currying:
		// (5 to indicate how many we should wait for)
		var curriedSum = FnLight.curry( FnLight.sum, 5 );
		
		trace( "curriedSum( 1 )( 2 )( 3 )( 4 )( 5 ): " + curriedSum( 1 )( 2 )( 3 )( 4 )( 5 ) );
		
		var curriedSumLoos = FnLight.looseCurry( FnLight.sum, 5 );
		trace( "curriedSumLoos( 1 )( 2 , 3 )( 4, 5 ): " + curriedSumLoos( 1 )( 2 , 3 )( 4, 5 ) );

		
		var uncurriedSum = FnLight.uncurry( curriedSum );
		trace( "uncurriedSum( 1, 2, 3, 4, 5 ): " + uncurriedSum( 1, 2, 3, 4, 5 ));
		//trace( "uncurriedSum( 1, 2, 3 )( 4 )( 5 ): " + uncurriedSum( 1, 2, 3 )( 4 )( 5 )); // Haxe compiler catches error
		
		
		var adder = FnLight.looseCurry( FnLight.sum, 2 );
		
		// oops...
		trace( "[1,2,3,4,5].map( adder( 3 ): " + [1, 2, 3, 4, 5].map( adder( 3 )));
		
		// fixed with `unary(..)`:
		trace( "[1,2,3,4,5].map( FnLight.unary( adder( 3 ))): " + [1, 2, 3, 4, 5].map( FnLight.unary( adder( 3 ))) );
		
	}
	
	static function identity( v:Dynamic ):Dynamic {
		return v;
	}
	
	static function identityExample():Void {
		
		var words = "   Now is the time for all...  ".split( " " );
		trace( "words: " + words );
		
		trace( "words.filter( identity ): " + words.filter( identity ));
		
		function output( msg:String, ?formatFn:Dynamic ) {
			if ( formatFn == null ) formatFn = identity;
			
			msg = formatFn( msg );
			trace( msg );
		}
		
		function upper( txt:String ):String {
			return txt.toUpperCase();
		}
		
		trace( "output( 'Hello World', upper ):" );
		output( 'Hello World', upper );
		
		trace( "output( 'Hello World' ):" );
		output( 'Hello World' );
		
	}
	
	static function noPointsExample():Void {
		
		function double( x ) {
			return x * 2;
		}
		
		trace( "double map1 [1, 2, 3, 4, 5]: " + [1, 2, 3, 4, 5].map( function mapper( v ) {
			return double( v );
		}));
		
		trace( "double map2 [1, 2, 3, 4, 5]: " + [1, 2, 3, 4, 5].map( double ));
		
		// is not useful because Haxe parseInt doesn't have an radix argument
		trace( "parseInt map ['1', '2', '3']: " + ['1', '2', '3'].map( function mapper( v ) {
			return Std.parseInt( v );
		}));
		
		
		
		function output( txt:String ):Void {
			trace( txt );
		}
		
		function printIf( msg:String, predicate:String->Bool ):Void {
			if ( predicate( msg )) {
				output( msg );
			}
		}
		
		function isShortEnough( str:String ):Bool {
			return str.length <= 5;
		}
		
		var msg1 = "Hello";
		var msg2 = msg1 + " World";
		
		trace( "printIf( " + msg1 + ", isShortEnough ):" );
		printIf( msg1, isShortEnough );
		trace( "printIf( " + msg2 + ", isShortEnough ):" );
		printIf( msg2, isShortEnough );
		
		function isLongEnough1( str:String ):Bool {
			return !isShortEnough( str );
		}
		
		trace( "printIf( " + msg1 + ", isLongEnough1 ):" );
		printIf( msg1, isLongEnough1 );
		trace( "printIf( " + msg2 + ", isLongEnough1 ):" );
		printIf( msg2, isLongEnough1 );
		
		var isLongEnough2 = FnLight.not( isShortEnough );
		
		trace( "printIf( " + msg2 + ", isLongEnough2 ):" );
		printIf( msg2, isLongEnough2 );
		
	}
	
	static function printIfPointless():Void {
		
		function output( txt:String ):Void {
			trace( txt );
		}
		
		function isShortEnough( str:String ):Bool {
			return str.length <= 5;
		}
		
		var isLongEnough = FnLight.not( isShortEnough );
		
		var printIf = FnLight.reverseArgs(
			FnLight.uncurry( FnLight.partialRight( FnLight.when, output ))
		);
		
		var msg1 = "Hello";
		var msg2 = msg1 + " World";
		
		trace( 'printIf( $msg1, isShortEnough ):' );
		printIf( msg1, isShortEnough );
		trace( 'printIf( $msg2, isShortEnough ):' );
		printIf( msg2, isShortEnough );

		trace( 'printIf( $msg1, isLongEnough ):' );
		printIf( msg1, isLongEnough );
		trace( 'printIf( $msg2, isLongEnough ):' );
		printIf( msg2, isLongEnough );
		
	}
}