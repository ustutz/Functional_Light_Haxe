package;

import com.ls3d.HTMLTrace;
import haxe.Json;
import js.Lib;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function ajax( url:String, data:Dynamic, callback:String ):Void {
		
		trace( "ajax( url:" + url + " data:" + Json.stringify( data ) + " callback:" + callback ); 
	}
	
	static function main() {
		
		HTMLTrace.init(); // init custom trace that write the text to html
		
		ajaxExample();
	}
	
	static function ajaxExample():Void {
		
		var getPerson = FnLight.partial( ajax, "http://some.api/person" );
		var getOrder = FnLight.partial( ajax, "http://some.api/order" );
		
		
		var CURRENT_USER_ID = "123456";
		
		var getCurrentUser = FnLight.partial( getPerson, { user: CURRENT_USER_ID });
		
		trace( "getCurrentUser():" );
		getCurrentUser();
	}
	
	
}