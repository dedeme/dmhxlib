// Copyright 15-Jun-2020 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dm;

import haxe.Json;
import haxe.ds.Option;

/// Json utilities
abstract Js (Dynamic) {

  static function getType (e: Dynamic): String {
    return Std.string(Type.typeof(e));
  }

  function new (js: Dynamic) {
    this = js;
  }

  /**
      Trys Json.parse(s) and if it fails, throws a exception.
  **/
  public static function from (s: String): Js {
    try {
      return new Js(Json.parse(s));
    } catch (e: Dynamic) {
      throw Exc.illegalArgument('s = $s', "Json string", "Invalid Json");
    }
  }

  /**
      Returns Json.stringify(this).
  **/
  public function to (): String {
    return Json.stringify(this);
  }

  @:from
  public static function wb (b: Bool): Js {
    return new Js(b);
  }

  @:from
  public static function wi (i: Int): Js {
    return new Js(i);
  }

  @:from
  public static function wf (f: Float): Js {
    return new Js(f);
  }

  @:from
  public static function ws (s: String): Js {
    return new Js(s);
  }

  @:from
  public static function wa (a:Array<Js>): Js {
    return new Js(a);
  }

  @:from
  public static function wo (o:Map<String, Js>): Js {
    final fn1: () ->  Dynamic = () -> return untyped js.Syntax.code("{}");
    final fn2: Dynamic -> String -> Js -> Void = (o, k, v) ->
      untyped js.Syntax.code("o[k]=v");

    var r = fn1();
    for (k => v in o) {
      fn2(r, k , v);
    }
    return new Js(r);
  }

  /**
      Creates a Js (Array) from 'it' using fto to convert its elements.
  **/
  public static function wArray<T> (it: Iterable<T>, fto: T -> Js): Js {
    return wa(Lambda.map(it, fto));
  }

  /**
      Creates a Js (Object) from 'm' using fto to convert its values.
  **/
  public static function wMap<T> (m: Map<String, T>, fto: T -> Js): Js {
    final r = new Map<String, Js>();
    for (k => v in m)
      r.set(k, fto(v));
    return wo(r);
  }

  @:to
  public static function rb (js: Js): Bool {
    try {
      return cast(js, Bool);
    } catch (e: String) {
      throw Exc.illegalArgument("js", "Bool", getType(js));
    }
  }

  @:to
  public static function ri (js: Js): Int {
    try {
      return cast(js, Int);
    } catch (e: String) {
      throw Exc.illegalArgument("js", "Int", getType(js));
    }
  }

  @:to
  public static function rf (js: Js): Float {
    try {
      return cast(js, Float);
    } catch (e: String) {
      throw Exc.illegalArgument("js", "Float", getType(js));
    }
  }

  @:to
  public static function rs (js: Js): String {
    try {
      return cast(js, String);
    } catch (e: String) {
      throw Exc.illegalArgument("js", "String", getType(js));
    }
  }

  @:to
  public static function ra (js: Js): Array<Js> {
    try {
      return cast(js);
    } catch (e: String) {
      throw Exc.illegalArgument("js", "Array<Js>", getType(js));
    }
  }

  @:to
  public static function ro (jsv: Js): Map<String, Js> {
    try {
      final fn1: Dynamic -> Array<String> = o ->
        return untyped js.Syntax.code("Object.keys(o)");
      final fn2: Dynamic -> String -> Js = (o, k) ->
        return untyped js.Syntax.code("o[k]");

      final obj:Dynamic = cast(jsv);
      final r = new Map<String, Js>();
      for (k in fn1(obj)) r.set(k, fn2(obj, k));
      return r;
    } catch (e: String) {
      throw Exc.illegalArgument("jsv", "Map<String, Js>", getType(jsv));
    }
  }

  /**
      Read an array whose elements can be deserialized with 'ffrom'.<p>
      If it fails, returns None.
  **/
  public static function rArray<T> (js:Js, ffrom: Js -> T): Array<T> {
    return js.ra().map(ffrom);
  }

  /**
      Read a Map whose values can be deserialized with 'ffrom'.<p>
      If it fails, returns None.
  **/
  public static function rMap<T> (js:Js, ffrom: Js -> T): Map<String, T> {
    final r = new Map<String, T>();
    for (k => v in js.ro())
      r.set(k, ffrom(v));
    return r;
  }

}
