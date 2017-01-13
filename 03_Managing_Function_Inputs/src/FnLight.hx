package;
import haxe.extern.Rest;
/**
 * ...
 * @author Urs Stutz
 */
extern class FnLight {

	public static function curry( fn:Dynamic, ?length:Int ):Dynamic;
	public static function looseCurry( fn:Dynamic, ?length:Int ):Dynamic;
	public static function not( fn:Dynamic ):Dynamic;
	public static function partial( fn:Dynamic, presentArgs:Rest<Dynamic> ):Dynamic;
	public static function partialRight( fn:Dynamic, presentArgs:Rest<Dynamic> ):Dynamic;
	public static function reverseArgs( fn:Dynamic ):Dynamic;
	public static function sum( args:Rest<Dynamic> ):Dynamic;
	public static function unary( fn:Dynamic ):Dynamic;
	public static function uncurry( fn:Dynamic ):Dynamic;
	public static function when( predicate:Dynamic, fn:Dynamic ):Dynamic;
	
}