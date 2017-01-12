package;

import neko.Lib;

/**
 * ...
 * @author Urs Stutz
 */
//@:build( MFields.build())
class Main {
	
	static function main() {
		
		keepingScope1();
		keepingScope2();
		keepingScope3();
		addTo();
		format();
	}
	
	static function keepingScope1():Void {
		
		var foo = function( msg:String ):Void->Void {
			var fn = function():Void {
				trace( msg );
			}
			return fn;
		}
		
		var helloFn = foo( "Hello" );
		
		helloFn(); // Hello
	}
	
	static function person( id:String ):Void->Void {
		
		var randNumber = Math.random();
		
		return function identify() {
			trace( "I am " + id + ": " + randNumber );
		}
	}
	
	static function keepingScope2():Void {
		
		var fred = person( "Fred" );
		var susan = person( "Susan" );
		
		fred();
		susan();

	}
	
	static function runningCounter( start:Int ) {
		
		var val = start;
		
		return function current( increment:Int = 1 ):Int {
			
			val += increment;
			return val;
		}
	}
	
	static function keepingScope3() {
		
		var score = runningCounter( 0 );
		
		trace( "score(): " + score());
		trace( "score(): " + score());
		trace( "score( 13 ): " + score( 13 ));
		
	}
	
	static function makeAdder( x:Int ):Int->Int {
		return function sum( y:Int ):Int {
			return x + y;
		}
	}
	
	static function addTo():Void {
		
		var addTo10 = makeAdder( 10 );
		var addTo37 = makeAdder( 37 );
		
		trace( "addTo10( 3 ): " + addTo10( 3 ));
		trace( "addTo10( 90 ): " + addTo10( 90 ));
		
		trace( "addTo37( 13 ): " + addTo37( 13 ));
	}
	
	static function formatter( formatFn:String->String ):String->String {
		return function inner( str:String ):String {
			return formatFn( str );
		}
	}
	
	static function format():Void {
		
		var lower = formatter( function formatting( v:String ):String {
			return v.toLowerCase();
		});
		
		var upperFirst = formatter( function formatting( v:String ):String {
			return v.charAt( 0 ).toUpperCase() + v.substr( 1 ).toLowerCase();
		});
	
	
		trace( "lower( 'WOW' ) : " + lower( 'WOW' ));
		trace( "upperFirst( 'hello' ) : " + upperFirst( 'hello' ));
		
	}
}