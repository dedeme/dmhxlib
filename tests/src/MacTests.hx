// Copyright 26-Mar-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

import dm.Test;
import dm.Mac;
import dm.Js;

private enum TstType {A; B;}

@:build(dm.Mac.enumeration())
private class JsTstType {}

@:build(dm.Mac.record([
  "v0: Array<Array<Bool>>",
  "v1: Int",
  "v3: Map<String, Map<String, Int>>",
  "v4: Array<TstType>",
  "v5: Array<Tst>"
], true))
private class Tst {}

class MacTests {
  public static function run() {
    final t = new Test("Mac");
    final t1 = new Tst(
      [[true]], 32, ["a" => ["aa" => 1, "bb" => 2]], [A, B, A], [null]
    );

    t.eq(t1.v1, 32);

    final t2 = new Tst([], 12, [], [], [t1]);
    final t2Js = t2.toJs();

    final t3 = Tst.fromJs(t2Js);
    t.eq(t3.toJs().to(), t2Js.to());

    t.eq(JsTstType.to(B).to(), "\"B\"");
    t.eq(JsTstType.from(Js.ws("B")), B);

    t.log();
  }

}
