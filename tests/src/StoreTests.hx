// Copyright 15-Jun-2020 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

import dm.Test;
import dm.Dt;
import dm.Store;
import dm.Opt;

class StoreTests {
  public static function run () {
    var t = new Test("Store");

    Store.expires("StoreTests_ex1", ["StoreTests_k1"], 0);
    Store.expires("StoreTests_ex2", ["StoreTests_k2"], 11);

    Store.put("StoreTests_k1", "StoreTests_one");
    Store.put("StoreTests_k2", "StoreTests_");
    Store.put("StoreTests_", "StoreTests_none");
    t.eq(Opt.get(Store.get("StoreTests_k1")), "StoreTests_one");
    t.eq(Opt.get(Store.get("StoreTests_k2")), "StoreTests_");
    t.eq(Opt.get(Store.get("StoreTests_")), "StoreTests_none");
    t.eq(Opt.get(Store.get("StoreTests_xx")), null);

    t.eq(Store.size(), 5);
    t.yes(Store.keys().contains("StoreTests_k2"));
    t.yes(Store.keys().contains("StoreTests_k1"));
    t.yes(Store.keys().contains("StoreTests_"));
    t.yes(Store.keys().count() == 5);

    t.yes(Store.values().map(v -> Opt.get(v)).contains("StoreTests_none"));
    t.yes(Store.values().map(v -> Opt.get(v)).contains("StoreTests_one"));
    t.yes(Store.values().map(v -> Opt.get(v)).contains("StoreTests_"));
    t.yes(Store.values().count() == 5);

    Store.del("StoreTests_");
    Store.del("StoreTests_xx");
    t.yes(Store.size() == 4);

    Store.expires("StoreTests_ex1", ["StoreTests_k1"], 0);
    Store.expires("StoreTests_ex2", ["StoreTests_k2"], 0);
    t.eq(Store.size(), 3);

    t.yes(!Store.keys().contains("StoreTests_k1"));
    t.yes(Store.keys().contains("StoreTests_k2"));

    Store.clear("StoreTests_");
    t.yes(Store.size() == 0);

    t.log();
  }
}
