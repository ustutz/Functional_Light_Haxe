// Generated by Haxe 3.4.0
(function () { "use strict";
var EReg = function(r,opt) {
	this.r = new RegExp(r,opt.split("u").join(""));
};
EReg.__name__ = true;
EReg.prototype = {
	match: function(s) {
		if(this.r.global) {
			this.r.lastIndex = 0;
		}
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	com_ls3d_HTMLTrace.init();
	Main.outputToInputExample();
	Main.skipWordsExample();
	Main.skipWordsExample2();
	Main.pipeExample();
	Main.revisitingPointsExample();
};
Main.words = function(str) {
	var alpha = function(v) {
		return new EReg("^[\\w]+$","").match(v);
	};
	return str.toLowerCase().split(" ").filter(alpha);
};
Main.unique = function(list) {
	var uniqList = [];
	var _g1 = 0;
	var _g = list.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(uniqList.indexOf(list[i]) == -1) {
			uniqList.push(list[i]);
		}
	}
	return uniqList;
};
Main.outputToInputExample = function() {
	haxe_Log.trace("wordsUsed: " + Std.string(Main.unique(Main.words("To compose two functions together, pass the output of the first function call as the input of the second function call."))),{ fileName : "Main.hx", lineNumber : 55, className : "Main", methodName : "outputToInputExample"});
};
Main.skipShortWords = function(list) {
	var filteredList = [];
	var _g = 0;
	while(_g < list.length) {
		var word = list[_g];
		++_g;
		if(word.length > 4) {
			filteredList.push(word);
		}
	}
	return filteredList;
};
Main.skipWordsExample = function() {
	haxe_Log.trace("bigger wordsUsed: " + FnLight.compose(Main.skipShortWords,Main.unique,Main.words)("To compose two functions together, pass the output of the first function call as the input of the second function call.") + " ",{ fileName : "Main.hx", lineNumber : 78, className : "Main", methodName : "skipWordsExample"});
};
Main.skipLongWords = function(list) {
	var filteredList = [];
	var _g = 0;
	while(_g < list.length) {
		var word = list[_g];
		++_g;
		if(word.length <= 4) {
			filteredList.push(word);
		}
	}
	return filteredList;
};
Main.skipWordsExample2 = function() {
	var filterWords = FnLight.partialRight(FnLight.compose,Main.unique,Main.words);
	var biggerWords = filterWords(Main.skipShortWords);
	var shorterWords = filterWords(Main.skipLongWords);
	haxe_Log.trace("biggerWords( text ): " + biggerWords("To compose two functions together, pass the output of the first function call as the input of the second function call."),{ fileName : "Main.hx", lineNumber : 102, className : "Main", methodName : "skipWordsExample2"});
	haxe_Log.trace("shorterWords( text ): " + shorterWords("To compose two functions together, pass the output of the first function call as the input of the second function call."),{ fileName : "Main.hx", lineNumber : 103, className : "Main", methodName : "skipWordsExample2"});
};
Main.pipeExample = function() {
	haxe_Log.trace("pipe bigger wordsUsed: " + FnLight.pipe(Main.words,Main.unique,Main.skipShortWords)("To compose two functions together, pass the output of the first function call as the input of the second function call.") + " ",{ fileName : "Main.hx", lineNumber : 114, className : "Main", methodName : "pipeExample"});
};
Main.ajax = function(url,data,callback) {
	haxe_Log.trace("ajax( url:" + url + " data:" + JSON.stringify(data),{ fileName : "Main.hx", lineNumber : 119, className : "Main", methodName : "ajax"});
	callback(data);
};
Main.output = function(str) {
	haxe_Log.trace("output: " + str,{ fileName : "Main.hx", lineNumber : 124, className : "Main", methodName : "output"});
};
Main.revisitingPointsExample = function() {
	var getPerson = FnLight.partial(Main.ajax,"http://some.api/person");
	var getLastOrder = FnLight.partial(Main.ajax,"http://some.api/order",{ id : -1});
	var prop = function(name,obj) {
		return obj.name;
	};
	var lookupPerson = FnLight.compose(FnLight.partialRight(getPerson,FnLight.compose(Main.output,FnLight.partial(prop,"name"))),FnLight.partial(function(name1,value) {
		return { name : value};
	},"id"),FnLight.partial(prop,"personId"));
	haxe_Log.trace("getLastOrder( lookupPerson ):",{ fileName : "Main.hx", lineNumber : 147, className : "Main", methodName : "revisitingPointsExample"});
	getLastOrder(lookupPerson);
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
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
