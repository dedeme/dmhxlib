// Copyright 09-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

private typedef Tuple3<T, U, V> = { e1:T, e2:U, e3:V }

/**
    Tuple of three elements.
**/
abstract Tp3<T, U, V> (Tuple3<T, U, V>) {

  inline public function new (tp:Tuple3<T, U, V>) {
    this = tp;
  }

  /**
      Static constructor.
  **/
  public static function mk<T, U, V> (e1:T, e2:U, e3:V): Tp3<T, U, V> {
    return new Tp3({e1: e1, e2: e2, e3: e3});
  }

  public var e1(get, never): T;
  public function get_e1 (): T {
    return this.e1;
  }

  public var e2(get, never): U;
  public function get_e2 (): U {
    return this.e2;
  }

  public var e3(get, never): V;
  public function get_e3 (): V {
    return this.e3;
  }

  @:op(A == B)
  public static function equals<T, U, V> (
    tp1:Tp3<T, U, V>, tp2: Tp3<T, U, V>
  ): Bool {
    return tp1.e1 == tp2.e1 && tp1.e2 == tp2.e2 && tp1.e3 == tp2.e3;
  }

  @:op(A != B)
  public static function nequals<T, U, V> (
    tp1:Tp3<T, U, V>, tp2: Tp3<T, U, V>
  ):Bool {
      return !(tp1 == tp2);
  }

  public function toString () {
    return '(${this.e1}, ${this.e2}, ${this.e3})';
  }
}
