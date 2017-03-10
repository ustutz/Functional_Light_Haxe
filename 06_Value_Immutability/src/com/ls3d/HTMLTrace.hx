package com.ls3d;
import js.Browser;
import haxe.Log;
import haxe.PosInfos;

class HTMLTrace {

	public static function init():Void {
		
		Log.trace = function( v:Dynamic, ?infos:haxe.PosInfos ):Void {
			var div = Browser.document.createDivElement();
			div.innerHTML = v;
			Browser.document.body.appendChild( div );
		}
	}
}