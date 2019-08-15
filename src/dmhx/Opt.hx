// Copyright 10-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

import haxe.ds.Option;

class Opt {

  public static function none<T> (): Option<T> {
    return None;
  }

  public static function some<T> (value:T): Option<T> {
    return Some(value);
  }

  public static function get<T> (o:Option<T>): Null<T> {
    switch (o){
      case Some(value): return value;
      default: return null;
    }
  }

  public static function oget<T> (o:Option<T>, v:T): T {
    switch (o){
      case Some(value): return value;
      default: return v;
    }
  }

}
