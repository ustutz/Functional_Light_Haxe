package;
import com.ls3d.HTMLTrace;
import haxe.Json;

typedef User = {
	var name:String;
	var lastLogin:Float;
}
 
class Main {
	
	static function main() {
		
		HTMLTrace.init(); // init custom trace that write the text to html

		valueToValueExample();
		updateExample();
	}
	
	static function addValue( arr:Array<Int> ):Array<Int> {
		
		var newArr:Array<Int> = arr.concat( [4] );
		return newArr;
		
	}
	
	static function valueToValueExample():Void {
		
		var a123 = [1, 2, 3];
		
		trace( 'addValue( [1,2,3] ): ${addValue( a123 )}' );
		trace( 'a123: ${a123.toString()}' );
	}
	
	static function updateLastLogin( user:User ):User {
		
		var newUserRecord = Reflect.copy( user );
		Reflect.setProperty( newUserRecord, "lastLogin", Date.now().getTime());
		return newUserRecord;
	}
	
	static function updateExample():Void {
		
		var user:User = {
			name: "Hans",
			lastLogin: 0
		}
		
		trace( 'user init ${Json.stringify( user )}' );
		
		user = updateLastLogin( user );
		trace( 'user updated ${Json.stringify( user )}' );
	}
	
}