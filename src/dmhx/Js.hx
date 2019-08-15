// Copyright 13-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

import haxe.Json;
import haxe.ds.Option;

/**
    Json utilities
**/
abstract Js (Dynamic) {
  public function new (js: Dynamic) {
    this = js;
  }

  /**
      Trys Json.parse(s) and if it fails, returns None.
  **/
  public static function from (s: String): Option<Js> {
    try {
      return Some(new Js(Json.parse(s)));
    } catch (e:Dynamic) {
      return None;
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
    final r = new Array<Js>();
    for (k => v in o) {
      r.push(k);
      r.push(v);
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

  public static function rb (js: Js): Option<Bool> {
    try{
      return Some(cast(js, Bool));
    } catch (e:String) {
      return None;
    }
  }

  public static function ri (js: Js): Option<Int> {
    try {
      return Some(cast(js, Int));
    } catch (e:String) {
      return None;
    }
  }

  public static function rf (js: Js): Option<Float> {
    try {
      return Some(cast(js, Float));
    } catch (e:String) {
      return None;
    }
  }

  public static function rs (js: Js): Option<String> {
    try {
      return Some(cast(js, String));
    } catch (e:String) {
      return None;
    }
  }

  public static function ra (js: Js): Option<Array<Js>> {
    try {
      return Some(cast(js));
    } catch (e:String) {
      return None;
    }
  }

  public static function ro (js: Js): Option<Map<String, Js>> {
    try {
      final a:Array<Js> = cast(js);
      final r = new Map<String, Js>();
      var i = 0;
      while (i < a.length) {
        r.set(cast(a[i], String), a[i + 1]);
        i += 2;
      }
      return Some(r);
    } catch (e:String) {
      return None;
    }
  }

  /**
      Read an array whose elements can be deserialized with 'ffrom'.<p>
      If it fails, returns None.
  **/
  public static function rArray<T> (
    js:Js, ffrom: Js -> Option<T>
  ): Option<Array<T>> {
    return switch (ra(js)) {
      case Some(a): Opt.map(a, ffrom);
      case None: None;
    }
  }

  /**
      Read a Map whose values can be deserialized with 'ffrom'.<p>
      If it fails, returns None.
  **/
  public static function rMap<T> (
    js:Js, ffrom: Js -> Option<T>
  ): Option<Map<String, T>> {
    final r = new Map<String, T>();
    switch (ro(js)) {
      case Some(o):
        for (k => v in o) {
          switch (ffrom(v)) {
            case Some(e): r.set(k, e);
            case None: return None;
          }
        }
      case None: return None;
    }
    return Some(r);
  }

}
