// Copyright 09-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

import haxe.crypto.Base64;
import haxe.io.Bytes;

/**
    B64 encoder-decoder.
**/
class B64 {

  /**
      B64 dictionary
  **/
  public static final CHARS = Base64.CHARS;

  public static function encodeBytes (bs:Bytes) : String {
    return Base64.encode(bs);
  }

  public static function encode (s:String) : String {
    return Base64.encode(Bytes.ofString(s));
  }

  public static function decodeBytes (s:String): Bytes {
    return Base64.decode(s);
  }

  public static function decode (s:String): String {
    return Base64.decode(s).toString();
  }

}
