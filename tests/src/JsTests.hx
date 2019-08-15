// Copyright 13-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

import dmhx.Test;
import dmhx.Js;
import dmhx.Opt;
import haxe.ds.Option;

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
      t.s,
      t.i,
      t.i2
    ]);
  }
  public static function fromJs (js:Js): Option<Tst> {
    final a = Opt.get(Js.ra(js));
    if (a == null) return None;

    final s = Opt.get(Js.rs(a[0]));
    final i = Opt.get(Js.ri(a[1]));
    final i2 = Opt.get(Js.ri(a[2]));

    if (s == null || i == null || i2 == null) return None;

    final r = new Tst(s, i);
    r.i2 = i2;
    return Some(r);
  }
}

class JsTests {
  public static function run() {
    final t = new Test("Js");

    t.eq(Opt.get(Js.rb(Opt.get(Js.from(Js.wb(true).to())))), true);
    t.eq(Js.wb(true).to(), "true");
    t.eq(Opt.get(Js.rb(Opt.get(Js.from(Js.wb(false).to())))), false);
    t.eq(Js.wb(false).to(), "false");
    t.eq(Opt.get(Js.ri(Opt.get(Js.from(Js.wi(12).to())))), 12);
    t.eq(Js.wi(12).to(), "12");
    t.eq(Opt.get(Js.rf(Opt.get(Js.from(Js.wf(12.34).to())))), 12.34);
    t.eq(Js.wf(12.34).to(), "12.34");
    t.eq(
      Opt.get(Js.rs(Opt.get(Js.from(Js.ws("\"Cañón\"").to())))),
      "\"Cañón\""
    );
    t.eq(Js.ws("\"Cañón\"").to(), "\"\\\"Cañón\\\"\"");
    var a = Opt.get(Js.ra(Opt.get(Js.from(Js.wa([true, 3]).to()))));
    t.eq(Opt.get(Js.rb(a[0])), true);
    t.eq(Opt.get(Js.ri(a[1])), 3);
    t.eq(Js.wa([true, 3]).to(), "[true,3]");
    var o = Opt.get(Js.ro(Opt.get(Js.from(
      Js.wo(["a" => true, "b" => 3]).to()
    ))));
    t.eq(Opt.get(Js.rb(o.get("a"))), true);
    t.eq(Opt.get(Js.ri(o.get("b"))), 3);
    var r = Js.wo(["a" => true, "b" => 3]).to();
    t.eq(r, StringTools.startsWith(r, "[\"a")
      ? "[\"a\",true,\"b\",3]"
      : "[\"b\",3,\"a\",true]"
    );

    var tst = new Tst("a", 2);
    tst.setI2(4);
    var tst2 = Opt.get(Tst.fromJs(Opt.get(Js.from(Tst.toJs(tst).to()))));
    t.eq(tst.s, tst2.s);
    t.eq(tst.i, tst2.i);
    t.eq(tst.getI2(), tst2.getI2());

    var tstb = new Tst("b", 22);
    tstb.setI2(44);

    //trace(Js.wArray([tst, tstb], Tst.toJs).to());
    var a2 = Opt.get(Js.rArray(
      Opt.get(Js.from(Js.wArray([tst, tstb], Tst.toJs).to())), Tst.fromJs
    ));
    tst2 = a2[0];
    var tstb2 = a2[1];
    t.eq(tst.s, tst2.s);
    t.eq(tst.i, tst2.i);
    t.eq(tst.getI2(), tst2.getI2());
    t.eq(tstb.s, tstb2.s);
    t.eq(tstb.i, tstb2.i);
    t.eq(tstb.getI2(), tstb2.getI2());

    var m = Opt.get(Js.rMap(
      Opt.get(Js.from(Js.wMap(["a" => tst, "b" => tstb], Tst.toJs).to())),
      Tst.fromJs
    ));
    tst2 = m["a"];
    tstb2 = m["b"];
    t.eq(tst.s, tst2.s);
    t.eq(tst.i, tst2.i);
    t.eq(tst.getI2(), tst2.getI2());
    t.eq(tstb.s, tstb2.s);
    t.eq(tstb.i, tstb2.i);
    t.eq(tstb.getI2(), tstb2.getI2());

    t.log();
  }
}
