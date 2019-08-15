// Copyright 15-Aug-2019 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

package dmhx;

import haxe.PosInfos;

class Exc {

  static function show (msg:String, pos:PosInfos): String {
    return '${pos.fileName}.${pos.methodName}:${pos.lineNumber}: $msg';
  }

  public static function illegalState (msg:String, ?pos:PosInfos): String {
    return show('Illegal state : $msg', pos);
  }

  public static function range (
    begin:Int, end:Int, index:Int, ?pos:PosInfos
  ) {
    return show('Index out of range : $index out of [$begin - $end]', pos);
  }

  public static function illegalArgument<T> (
    argumentName:String, expected:T, actual:T, ?pos:PosInfos
  ) {
    return show(
      'Illegal argument : Variable "$argumentName"\n' +
      'Expected: ${Std.string(expected)}\nActual: ${Std.string(actual)}',
      pos
    );
  }

  public static function io (msg:String, ?pos:PosInfos): String {
    return show('IO error : $msg', pos);
  }

  public static function type (msg:String): EType {
    return msg.indexOf(": Illegal state :") != -1 ? EIllegalState
      : msg.indexOf(": Index out of range :") != -1 ? ERange
      : msg.indexOf(": Illegal argument :") != -1 ? EIllegalArgument
      : msg.indexOf(": IO error :") != -1 ? EIo
      : EUndefined
    ;
  }

  inline public static function raise (msg) {
    #if cpp
      throw msg;
    #else
      throw new js.lib.Error(msg);
    #end
  }

}

enum EType {
  EUndefined;
  EIllegalState;
  ERange;
  EIllegalArgument;
  EIo;
}
