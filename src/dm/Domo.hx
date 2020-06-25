// Copyright 15-Jun-2020 ºDeme
// GNU General Public License - V3 <http://www.gnu.org/licenses/>

/// Class for envelopping DOM objects.

package dm;

/// Constants to use with '.on()'
enum ActionType {
  BLUR; CHANGE; CLICK; DBLCLICK; FOCUS; KEYDOWN; KEYPRESS; KEYUP;
  LOAD; MOUSEDOWN; MOUSEMOVE; MOUSEOUT; MOUSEOVER; MOUSEUP; MOUSEWHEEL;
  SELECT; SELECTSTART; SUBMIT;
}

/// Class for envelopping DOM objects
class Domo {

  ///
  public var e(default, null): js.html.DOMElement;

  ///
  public function new (e: js.html.DOMElement) {
    this.e = e;
  }

  ///
  public function getHtml (): String {
    return e.innerHTML;
  }

  ///
  public function html (tx: String): Domo {
    e.innerHTML = tx;
    return this;
  }

  ///
  public function getText (): String {
    return e.textContent;
  }

  ///
  public function text (tx: String): Domo {
    e.textContent = tx;
    return this;
  }

  ///
  public function getClass (): String {
    return e.className;
  }

  ///
  public function klass (tx: String): Domo {
    e.className = tx;
    return this;
  }

  ///
  public function getStyle (): String {
    return e.getAttribute("style");
  }

  ///
  public function style (tx: String): Domo {
    e.setAttribute("style", tx);
    return this;
  }

  ///
  public function setStyle (key: String, tx: String): Domo {
    e.style.setProperty(key, tx);
    return this;
  }

  ///
  public function getAtt (key: String): Dynamic {
    return e.getAttribute(key);
  }

  ///
  public function att (key: String, value: Dynamic): Domo {
    e.setAttribute(key, value);
    return this;
  }

  ///
  public function isDisabled (): Bool {
    return (cast(e)).disabled;
  }

  ///
  public function disabled (v: Bool): Domo {
    (cast(e)).disabled = v;
    return this;
  }

  ///
  public function getValue (): Dynamic {
    return (cast(e)).value;
  }

  ///
  public function value (v: Dynamic): Domo {
    (cast(e)).value = v;
    return this;
  }

  ///
  public function getChecked (): Bool {
    return (cast(e)).checked;
  }

  ///
  public function checked (v: Bool): Domo {
    (cast(e)).checked = v;
    return this;
  }

  ///
  public function add (o: Domo): Domo {
    e.appendChild(o.e);
    return this;
  }

  ///
  public function adds (obs: Iterable<Domo>): Domo {
    for (ob in obs) e.appendChild(ob.e);
    return this;
  }

  ///
  public function remove (o: Domo): Domo {
    e.removeChild(o.e);
    return this;
  }

  ///
  public function removeAll (): Domo {
    e.innerHTML = "";
    return this;
  }

  /// Adds an EventListener.
  /// To replace it use obj.e.onXXX = Event. For example:
  ///   td.e.onclick = e -> Ui.alert("Here");
  public function on (type: ActionType, action: Dynamic -> Void): Domo {
    var act = switch type {
      case BLUR: "blur";
      case CHANGE: "change";
      case CLICK: "click";
      case DBLCLICK: "dblclick";
      case FOCUS: "focus";
      case KEYDOWN: "keydown";
      case KEYPRESS: "keypress";
      case KEYUP: "keyup";
      case LOAD: "load";
      case MOUSEDOWN: "mousedown";
      case MOUSEMOVE: "mousemove";
      case MOUSEOUT: "mouseout";
      case MOUSEOVER: "mouseover";
      case MOUSEUP: "mouseup";
      case MOUSEWHEEL: "mouseweel";
      case SELECT: "select";
      case SELECTSTART: "selectstart";
      case SUBMIT: "submit";
    }
    e.addEventListener(act, action, false);
    return this;
  }

}
