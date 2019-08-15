// Copyright 14-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

import dmhx.Test;
import dmhx.Dt;
import dmhx.Opt;

class DtTests {
  public static function run() {
    final t = new Test("Dt");

    var d = Date.now();
    t.eq(Dt.to(d).length, 8);
    t.eq(Dt.dif(Dt.add(Dt.add(d, 25), -25), d), 0);
    t.eq(Dt.dif(Dt.add(Dt.add(d, 30), -25), d), 5);
    t.eq(Dt.dif(Dt.add(Dt.add(d, 20), -25), d), -5);

    d = Dt.mk(2, 4, 2010);
    t.eq(Dt.to(d), "20100402");
    t.eq(Dt.toIso(d), "02/04/2010");
    t.eq(Dt.toEn(d), "04/02/2010");
    t.eq(Dt.toIso(d, "-"), "02-04-2010");
    t.eq(Dt.toEn(d, "-"), "04-02-2010");

    d = Opt.get(Dt.from("19881231"));
    t.eq(Dt.toIso(d), "31/12/1988");
    t.eq(Dt.toEn(d), "12/31/1988");

    d = Opt.get(Dt.fromIso("01/02/2020"));
    t.eq(Dt.to(d), "20200201");
    t.eq(Dt.toEn(d), "02/01/2020");

    d = Opt.get(Dt.fromEn("06/30/2000"));
    t.eq(Dt.to(d), "20000630");
    t.eq(Dt.toIso(d), "30/06/2000");

    var d1 = Dt.mk(29, 2, 2013);
    var d2 = Dt.mk(6, 3, 2013);
    var d3 = Dt.mk(30, 4, 2013);

    t.eq(Dt.dif(d1, d2), -5);
    t.eq(Dt.dif(d3, d2), 55);
    t.yes(Dt.eq(d1, Dt.add(d2, -5)));
    t.yes(Dt.eq(d3, Dt.add(d2, 55)));

    t.yes(Dt.day(d1) == 1 && Dt.day(d2) == 6 && Dt.day(d3) == 30);
    t.yes(Dt.month(d1) == 3 && Dt.month(d2) == 3 && Dt.month(d3) == 4);
    t.yes(Dt.year(d1) == 2013);

    t.yes(Dt.isLeap(2020));
    t.yes(Dt.isLeap(2000));
    t.yes(!Dt.isLeap(2100));

    d = Opt.get(Dt.fromTime("13:12:50"));
    t.eq(Dt.toTime(d), "13:12:50");
    t.eq(d.getHours(), 13);
    t.eq(d.getMinutes(), 12);
    t.eq(d.getSeconds(), 50);
trace(Dt.weekDay(Dt.mk(14, 7, 2019)));
    t.log();
  }
}
