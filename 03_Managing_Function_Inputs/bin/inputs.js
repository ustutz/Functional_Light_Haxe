// Generated by Haxe 3.4.0
(function () { "use strict";
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
var Main = function() { };
Main.__name__ = true;
Main.ajax = function(url,data,callback) {
	haxe_Log.trace("ajax( url:" + url + " data:" + JSON.stringify(data) + " callback:",{ fileName : "Main.hx", lineNumber : 18, className : "Main", methodName : "ajax"});
	haxe_Log.trace(callback,{ fileName : "Main.hx", lineNumber : 19, className : "Main", methodName : "ajax"});
};
Main.main = function() {
	com_ls3d_HTMLTrace.init();
	Main.ajaxExample();
	Main.addExample();
	Main.reverseArgsExample();
	Main.curryExample();
	Main.identityExample();
	Main.noPointsExample();
	Main.printIfPointless();
};
Main.ajaxExample = function() {
	var getPerson = FnLight.partial(Main.ajax,"http://some.api/person");
	FnLight.partial(Main.ajax,"http://some.api/order");
	Main.CURRENT_USER_ID = "123456";
	var getCurrentUser = FnLight.partial(getPerson,{ user : Main.CURRENT_USER_ID});
	haxe_Log.trace("getCurrentUser():",{ fileName : "Main.hx", lineNumber : 45, className : "Main", methodName : "ajaxExample"});
	getCurrentUser();
};
Main.add = function(x,y) {
	return x + y;
};
Main.addExample = function() {
	haxe_Log.trace("add1: " + Std.string([1,2,3,4,5].map(function(val) {
		return Main.add(3,val);
	})),{ fileName : "Main.hx", lineNumber : 59, className : "Main", methodName : "addExample"});
	haxe_Log.trace("add2: " + Std.string([1,2,3,4,5].map(FnLight.partial(Main.add,3))),{ fileName : "Main.hx", lineNumber : 62, className : "Main", methodName : "addExample"});
};
Main.reverseArgsExample = function() {
	var cacheResult = FnLight.reverseArgs(FnLight.partial(FnLight.reverseArgs(Main.ajax),function(obj) {
	}));
	haxe_Log.trace("cacheResult:",{ fileName : "Main.hx", lineNumber : 74, className : "Main", methodName : "reverseArgsExample"});
	cacheResult("http://some.api/person",{ user : Main.CURRENT_USER_ID});
	var a3 = function(obj1) {
	};
	var cacheResultHaxe = function(a1,a2) {
		Main.ajax(a1,a2,a3);
	};
	haxe_Log.trace("cacheResultHaxe:",{ fileName : "Main.hx", lineNumber : 84, className : "Main", methodName : "reverseArgsExample"});
	cacheResultHaxe("http://some.api/person",{ user : Main.CURRENT_USER_ID});
	var cacheResultPR = FnLight.partialRight(Main.ajax,function(obj2) {
	});
	haxe_Log.trace("cacheResultPR:",{ fileName : "Main.hx", lineNumber : 92, className : "Main", methodName : "reverseArgsExample"});
	cacheResultPR("http://some.api/person",{ user : Main.CURRENT_USER_ID});
};
Main.curryExample = function() {
	var getCurrentUser = (FnLight.curry(Main.ajax)("http://some.api/person"))({ user : Main.CURRENT_USER_ID});
	haxe_Log.trace("getCurrentUser:",{ fileName : "Main.hx", lineNumber : 105, className : "Main", methodName : "curryExample"});
	getCurrentUser(function(user) {
	});
	haxe_Log.trace("[1, 2, 3, 4, 5].map( adder( 3 )): " + Std.string([1,2,3,4,5].map(FnLight.curry(Main.add)(3))),{ fileName : "Main.hx", lineNumber : 112, className : "Main", methodName : "curryExample"});
	haxe_Log.trace("sum( 1, 2, 3, 4, 5 ): " + Std.string(FnLight.sum(1,2,3,4,5)),{ fileName : "Main.hx", lineNumber : 114, className : "Main", methodName : "curryExample"});
	var curriedSum = FnLight.curry(FnLight.sum,5);
	haxe_Log.trace("curriedSum( 1 )( 2 )( 3 )( 4 )( 5 ): " + ((((curriedSum(1))(2))(3))(4))(5),{ fileName : "Main.hx", lineNumber : 120, className : "Main", methodName : "curryExample"});
	haxe_Log.trace("curriedSumLoos( 1 )( 2 , 3 )( 4, 5 ): " + ((FnLight.looseCurry(FnLight.sum,5)(1))(2,3))(4,5),{ fileName : "Main.hx", lineNumber : 123, className : "Main", methodName : "curryExample"});
	haxe_Log.trace("uncurriedSum( 1, 2, 3, 4, 5 ): " + FnLight.uncurry(curriedSum)(1,2,3,4,5),{ fileName : "Main.hx", lineNumber : 127, className : "Main", methodName : "curryExample"});
	var adder = FnLight.looseCurry(FnLight.sum,2);
	haxe_Log.trace("[1,2,3,4,5].map( adder( 3 ): " + Std.string([1,2,3,4,5].map(adder(3))),{ fileName : "Main.hx", lineNumber : 134, className : "Main", methodName : "curryExample"});
	haxe_Log.trace("[1,2,3,4,5].map( FnLight.unary( adder( 3 ))): " + Std.string([1,2,3,4,5].map(FnLight.unary(adder(3)))),{ fileName : "Main.hx", lineNumber : 137, className : "Main", methodName : "curryExample"});
};
Main.identity = function(v) {
	return v;
};
Main.identityExample = function() {
	var words = "   Now is the time for all...  ".split(" ");
	haxe_Log.trace("words: " + Std.string(words),{ fileName : "Main.hx", lineNumber : 148, className : "Main", methodName : "identityExample"});
	haxe_Log.trace("words.filter( identity ): " + Std.string(words.filter(Main.identity)),{ fileName : "Main.hx", lineNumber : 150, className : "Main", methodName : "identityExample"});
	var output = function(msg,formatFn) {
		if(formatFn == null) {
			formatFn = Main.identity;
		}
		msg = formatFn(msg);
		haxe_Log.trace(msg,{ fileName : "Main.hx", lineNumber : 156, className : "Main", methodName : "identityExample"});
	};
	var upper = function(txt) {
		return txt.toUpperCase();
	};
	haxe_Log.trace("output( 'Hello World', upper ):",{ fileName : "Main.hx", lineNumber : 163, className : "Main", methodName : "identityExample"});
	output("Hello World",upper);
	haxe_Log.trace("output( 'Hello World' ):",{ fileName : "Main.hx", lineNumber : 166, className : "Main", methodName : "identityExample"});
	output("Hello World");
};
Main.noPointsExample = function() {
	var $double = function(x) {
		return x * 2;
	};
	haxe_Log.trace("double map1 [1, 2, 3, 4, 5]: " + Std.string([1,2,3,4,5].map(function(v) {
		return $double(v);
	})),{ fileName : "Main.hx", lineNumber : 177, className : "Main", methodName : "noPointsExample"});
	haxe_Log.trace("double map2 [1, 2, 3, 4, 5]: " + Std.string([1,2,3,4,5].map($double)),{ fileName : "Main.hx", lineNumber : 181, className : "Main", methodName : "noPointsExample"});
	haxe_Log.trace("parseInt map ['1', '2', '3']: " + Std.string(["1","2","3"].map(function(v1) {
		return Std.parseInt(v1);
	})),{ fileName : "Main.hx", lineNumber : 184, className : "Main", methodName : "noPointsExample"});
	var output = function(txt) {
		haxe_Log.trace(txt,{ fileName : "Main.hx", lineNumber : 191, className : "Main", methodName : "noPointsExample"});
	};
	var printIf = function(msg,predicate) {
		if(predicate(msg)) {
			output(msg);
		}
	};
	var isShortEnough = function(str) {
		return str.length <= 5;
	};
	var msg2 = "Hello" + " World";
	haxe_Log.trace("printIf( " + "Hello" + ", isShortEnough ):",{ fileName : "Main.hx", lineNumber : 207, className : "Main", methodName : "noPointsExample"});
	printIf("Hello",isShortEnough);
	haxe_Log.trace("printIf( " + msg2 + ", isShortEnough ):",{ fileName : "Main.hx", lineNumber : 209, className : "Main", methodName : "noPointsExample"});
	printIf(msg2,isShortEnough);
	var isLongEnough1 = function(str1) {
		return !isShortEnough(str1);
	};
	haxe_Log.trace("printIf( " + "Hello" + ", isLongEnough1 ):",{ fileName : "Main.hx", lineNumber : 216, className : "Main", methodName : "noPointsExample"});
	printIf("Hello",isLongEnough1);
	haxe_Log.trace("printIf( " + msg2 + ", isLongEnough1 ):",{ fileName : "Main.hx", lineNumber : 218, className : "Main", methodName : "noPointsExample"});
	printIf(msg2,isLongEnough1);
	var isLongEnough2 = FnLight.not(isShortEnough);
	haxe_Log.trace("printIf( " + msg2 + ", isLongEnough2 ):",{ fileName : "Main.hx", lineNumber : 223, className : "Main", methodName : "noPointsExample"});
	printIf(msg2,isLongEnough2);
};
Main.printIfPointless = function() {
	var output = function(txt) {
		haxe_Log.trace(txt,{ fileName : "Main.hx", lineNumber : 231, className : "Main", methodName : "printIfPointless"});
	};
	var isShortEnough = function(str) {
		return str.length <= 5;
	};
	var isLongEnough = FnLight.not(isShortEnough);
	var printIf = FnLight.reverseArgs(FnLight.uncurry(FnLight.partialRight(FnLight.when,output)));
	var msg2 = "Hello" + " World";
	haxe_Log.trace("printIf( " + "Hello" + ", isShortEnough ):",{ fileName : "Main.hx", lineNumber : 247, className : "Main", methodName : "printIfPointless"});
	printIf("Hello",isShortEnough);
	haxe_Log.trace("printIf( " + msg2 + ", isShortEnough ):",{ fileName : "Main.hx", lineNumber : 249, className : "Main", methodName : "printIfPointless"});
	printIf(msg2,isShortEnough);
	haxe_Log.trace("printIf( " + "Hello" + ", isLongEnough ):",{ fileName : "Main.hx", lineNumber : 252, className : "Main", methodName : "printIfPointless"});
	printIf("Hello",isLongEnough);
	haxe_Log.trace("printIf( " + msg2 + ", isLongEnough ):",{ fileName : "Main.hx", lineNumber : 254, className : "Main", methodName : "printIfPointless"});
	printIf(msg2,isLongEnough);
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) {
		v = parseInt(x);
	}
	if(isNaN(v)) {
		return null;
	}
	return v;
};
var com_ls3d_HTMLTrace = function() { };
com_ls3d_HTMLTrace.__name__ = true;
com_ls3d_HTMLTrace.init = function() {
	haxe_Log.trace = function(v,infos) {
		var div = window.document.createElement("div");
		div.innerHTML = v;
		window.document.body.appendChild(div);
	};
};
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.trace = function(v,infos) {
	js_Boot.__trace(v,infos);
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js_Boot.__trace = function(v,i) {
	var msg = i != null ? i.fileName + ":" + i.lineNumber + ": " : "";
	msg += js_Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js_Boot.__string_rec(v1,"");
		}
	}
	var d;
	var tmp;
	if(typeof(document) != "undefined") {
		d = document.getElementById("haxe:trace");
		tmp = d != null;
	} else {
		tmp = false;
	}
	if(tmp) {
		d.innerHTML += js_Boot.__unhtml(msg) + "<br/>";
	} else if(typeof console != "undefined" && console.log != null) {
		console.log(msg);
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0 ? "," : "") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
String.__name__ = true;
Array.__name__ = true;
Main.main();
})();
