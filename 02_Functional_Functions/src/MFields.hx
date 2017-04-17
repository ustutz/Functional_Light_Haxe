package;
import haxe.macro.Context;
import haxe.macro.Expr;

class MFields {

	public static function build():Array<Field> {	
		
		var fields = Context.getBuildFields();
		for ( f in fields ) {
			if( f.name == "runningCounter" ) {
				trace( f.kind );
			}
		}
		return fields;
	}
}