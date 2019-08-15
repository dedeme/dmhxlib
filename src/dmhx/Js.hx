// Copyright 13-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

import haxe.Json;

/**
    Json utilities
**/
abstract Js (Dynamic) {
  public function new (js: Dynamic) {
    this = js;
  }

  public static function from (s: String) {
    return new Js(Json.parse(s));
  }

  public function to () {
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
    final r = new Array<Js>();
    for (k => v in o) {
      r.push(k);
      r.push(v);
    }
    return new Js(r);
  }

  public static function wArray<T> (it: Iterable<T>, fto: T -> Js): Js {
    return wa(Lambda.map(it, fto));
  }

  public static function wMap<T> (m: Map<String, T>, fto: T -> Js): Js {
    final r = new Map<String, Js>();
    for (k => v in m)
      r.set(k, fto(v));
    return wo(r);
  }

  @to
  public static function rb (js: Js): Bool {
    return cast(js, Bool);
  }

  @to
  public static function ri (js: Js): Int {
    return cast(js, Int);
  }

  @to
  public static function rf (js: Js): Float {
    return cast(js, Float);
  }

  @to
  public static function rs (js: Js): String {
    return cast(js, String);
  }

  @to
  public static function ra (js: Js): Array<Js> {
    return cast(js);
  }

  @to
  public static function ro (js: Js): Map<String, Js> {
    final a:Array<Js> = cast(js);
    final r = new Map<String, Js>();
    var i = 0;
    while (i < a.length) {
      r.set(cast(a[i], String), a[i + 1]);
      i += 2;
    }
    return r;
  }

  public static function rArray<T> (js:Js, ffrom: Js -> T): Array<T> {
    return Lambda.map(ra(js), ffrom);
  }

  public static function rMap<T> (js:Js, ffrom: Js -> T): Map<String, T> {
    final r = new Map<String, T>();
    for (k => v in Js.ro(js))
      r.set(k, ffrom(v));
    return r;
  }

}
