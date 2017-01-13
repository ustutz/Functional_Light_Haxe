package;

import com.ls3d.HTMLTrace;
import haxe.Json;
import js.Lib;

/**
 * ...
 * @author Urs Stutz
 */
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
	}
}