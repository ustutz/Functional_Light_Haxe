package;
import haxe.extern.Rest;
/**
 * ...
 * @author Urs Stutz
 */
extern class FnLight {

	public static function curry( fn:Dynamic, ?length:Int ):Dynamic;
	public static function partial( fn:Dynamic, presentArgs:Rest<Dynamic> ):Dynamic;
	public static function partialRight( fn:Dynamic, presentArgs:Rest<Dynamic> ):Dynamic;
	public static function reverseArgs( fn:Dynamic ):Dynamic;
}