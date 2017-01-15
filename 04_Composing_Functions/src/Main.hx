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
	
	static function main() {
		
		HTMLTrace.init(); // init custom trace that write the text to html
		
		outputToInputExample();
		skipWordsExample();
		skipWordsExample2();
		pipeExample();
		revisitingPointsExample();
	}
	
	static function words( str:String ):Array<String> {
		
		return 	str
				.toLowerCase()
				.split( " " )
				.filter( function alpha( v:String ) {
					return ~/^[\w]+$/.match( v );
				});
	}
	
	static function unique( list:Array<String> ) {
		
		var uniqList:Array<String> = [];
		
		for ( i in 0...list.length ) {
			// value not yet in the new list?
			if ( uniqList.indexOf( list[i] ) == -1 ) {
				uniqList.push( list[i] );
			}
		}
		return uniqList;
	}
	
	static function outputToInputExample():Void {
		
		var text = "To compose two functions together, pass the output of the first function call as the input of the second function call.";
		
		var wordsFound = words( text );
		var wordsUsed = unique( wordsFound );
		
		trace( 'wordsUsed: $wordsUsed' );
	}
	
	static function skipShortWords( list:Array<String> ):Array<String> {
		
		var filteredList:Array<String> = [];
		
		for ( word in list ) {
			if ( word.length > 4 ) {
				filteredList.push( word );
			}
		}
		return filteredList;
	}
	
	static function skipWordsExample():Void {
		
		var text = "To compose two functions together, pass the output of the first function call as the input of the second function call.";

		var biggerWords = FnLight.compose( skipShortWords, unique, words );
		
		var wordsUsed = biggerWords( text );
		
		trace( 'bigger wordsUsed: $wordsUsed ');
	}
	
	static function skipLongWords( list:Array<String> ):Array<String> {
		
		var filteredList:Array<String> = [];
		
		for ( word in list ) {
			if ( word.length <= 4 ) {
				filteredList.push( word );
			}
		}
		return filteredList;
	}
	
	static function skipWordsExample2():Void {
		
		var text = "To compose two functions together, pass the output of the first function call as the input of the second function call.";
		
		var filterWords = FnLight.partialRight( FnLight.compose, unique, words );
		
		var biggerWords = filterWords( skipShortWords );
		var shorterWords = filterWords( skipLongWords );
		
		trace( 'biggerWords( text ): ${biggerWords( text )}' );
		trace( 'shorterWords( text ): ${shorterWords( text )}' );
	}
	
	static function pipeExample():Void {
		
		var text = "To compose two functions together, pass the output of the first function call as the input of the second function call.";
		
		var biggerWords = FnLight.pipe( words, unique, skipShortWords );
		
		var wordsUsed = biggerWords( text );
		
		trace( 'pipe bigger wordsUsed: $wordsUsed ');
	}
	
	static function ajax( url:String, data:Dynamic, callback:Dynamic ):Void {
		
		trace( "ajax( url:" + url + " data:" + Json.stringify( data ) ); 
		callback( data );
	}
	
	static function output( str:String ):Void {
		trace( 'output: $str' );
	}
	
	static function revisitingPointsExample():Void {
		
		var getPerson = FnLight.partial( ajax, "http://some.api/person" );
		var getLastOrder = FnLight.partial( ajax, "http://some.api/order", { id: -1 } );
		
		function prop( name:String, obj:Dynamic ) {
			return obj.name;
		}
		
		function setProp( name:String, value:Dynamic ) {
			return { name: value }
		}
		
		var extractName = FnLight.partial( prop, "name" );
		var outputPersonName = FnLight.compose( output, extractName );
		var processPerson = FnLight.partialRight( getPerson, outputPersonName );
		var personData = FnLight.partial( setProp, "id" );
		var extractPersonId = FnLight.partial( prop, "personId" );
		var lookupPerson = FnLight.compose( processPerson, personData, extractPersonId );
		
		trace( 'getLastOrder( lookupPerson ):' );
		getLastOrder( lookupPerson );
	}
	
}