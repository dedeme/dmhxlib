// Copyright 10-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

import haxe.ds.Option;

class Opt {

  /**
      Returns 'o' value if 'o' is 'Some(value)'. Otherwise it returns null.
  **/
  public static function get<T> (o:Option<T>): Null<T> {
    switch (o){
      case Some(value): return value;
      default: return null;
    }
  }

  /**
      Returns 'o' value if 'o' is 'Some(value)'. Otherwise it returns 'v'.
  **/
  public static function oget<T> (o:Option<T>, v:T): T {
    switch (o){
      case Some(value): return value;
      default: return v;
    }
  }

  /**
      Returns an Array with values of 'i' mapped to 'U', unless some 'fn(value)'
      is None. Then it returns None.
  **/
  public static function map<T, U> (
    i:Iterable<T>, fn:T->Option<U>
  ): Option<Array<U>> {
    final it = i.iterator();
    final r:Array<U> = [];
    while (it.hasNext ()) {
      final v = fn(it.next());
      switch (v) {
        case Some(e): r.push(e);
        case None: return None;
      }
    }
    return Some(r);
  }

}
