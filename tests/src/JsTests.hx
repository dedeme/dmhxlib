// Copyright 13-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

import dmhx.Test;
import dmhx.Js;

class Tst {
  public final s: String;
  public final i: Int;
  var i2: Int = 0;
  public function new (s:String, i:Int) {
    this.s = s;
    this.i = i;
  }
  public function setI2 (n: Int) {
    i2 = n;
  }
  public function getI2 (): Int {
    return i2;
  }
  public static function toJs (t:Tst): Js {
    return Js.wa([
      Js.ws(t.s),
      Js.wi(t.i),
      Js.wi(t.i2)
    ]);
  }
  public static function fromJs (js:Js): Tst {
    final a = Js.ra(js);
    final r = new Tst(Js.rs(a[0]), Js.ri(a[1]));
    r.i2 = Js.ri(a[2]);
    return r;
  }
}

class JsTests {
  public static function run() {
    final t = new Test("Js");

    t.eq(Js.rb(Js.from(Js.wb(true).to())), true);
    t.eq(Js.wb(true).to(), "true");
    t.eq(Js.rb(Js.from(Js.wb(false).to())), false);
    t.eq(Js.wb(false).to(), "false");
    t.eq(Js.ri(Js.from(Js.wi(12).to())), 12);
    t.eq(Js.wi(12).to(), "12");
    t.eq(Js.rf(Js.from(Js.wf(12.34).to())), 12.34);
    t.eq(Js.wf(12.34).to(), "12.34");
    t.eq(Js.rs(Js.from(Js.ws("\"Cañón\"").to())), "\"Cañón\"");
    t.eq(Js.ws("\"Cañón\"").to(), "\"\\\"Cañón\\\"\"");
    var a = Js.ra(Js.from(Js.wa([true, 3]).to()));
    t.eq(Js.rb(a[0]), true);
    t.eq(Js.ri(a[1]), 3);
    t.eq(Js.wa([true, 3]).to(), "[true,3]");
    var o = Js.ro(Js.from(Js.wo(["a" => true, "b" => 3]).to()));
    t.eq(Js.rb(o.get("a")), true);
    t.eq(Js.ri(o.get("b")), 3);
    var r = Js.wo(["a" => true, "b" => 3]).to();
    t.eq(r, StringTools.startsWith(r, "[\"a")
      ? "[\"a\",true,\"b\",3]"
      : "[\"b\",3,\"a\",true]"
    );

    var tst = new Tst("a", 2);
    tst.setI2(4);
    var tst2 = Tst.fromJs(Js.from(Tst.toJs(tst).to()));
    t.eq(tst.s, tst2.s);
    t.eq(tst.i, tst2.i);
    t.eq(tst.getI2(), tst2.getI2());

    var tstb = new Tst("b", 22);
    tstb.setI2(44);

    //trace(Js.wArray([tst, tstb], Tst.toJs).to());
    var a2 = Js.rArray(
      Js.from(Js.wArray([tst, tstb], Tst.toJs).to()), Tst.fromJs
    );
    tst2 = a2[0];
    var tstb2 = a2[1];
    t.eq(tst.s, tst2.s);
    t.eq(tst.i, tst2.i);
    t.eq(tst.getI2(), tst2.getI2());
    t.eq(tstb.s, tstb2.s);
    t.eq(tstb.i, tstb2.i);
    t.eq(tstb.getI2(), tstb2.getI2());

    t.log();
  }
}
