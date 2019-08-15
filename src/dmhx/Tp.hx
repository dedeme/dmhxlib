// Copyright 09-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

private typedef Tuple<T, U> = { e1:T, e2:U }

/**
    Tuple of two elements.
**/
abstract Tp<T, U> (Tuple<T, U>) {

  inline public function new (tp:Tuple<T, U>) {
    this = tp;
  }

  /**
      Static constructor.
  **/
  public static function mk<T, U> (e1:T, e2:U): Tp<T, U> {
    return new Tp({e1: e1, e2: e2});
  }

  public var e1(get, never): T;
  public function get_e1 (): T {
    return this.e1;
  }

  public var e2(get, never): U;
  public function get_e2 (): U {
    return this.e2;
  }

  @:op(A == B)
  public static function equals<T, U> (tp1:Tp<T, U>, tp2:Tp<T, U>):Bool {
    return tp1.e1 == tp2.e1 && tp1.e2 == tp2.e2;
  }

  @:op(A != B)
  public static function nequals<T, U> (tp1:Tp<T, U>, tp2:Tp<T, U>):Bool {
      return !(tp1 == tp2);
  }

  public function toString (): String {
    return '(${this.e1}, ${this.e2})';
  }

}
