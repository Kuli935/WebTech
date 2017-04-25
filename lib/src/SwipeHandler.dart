part of tetris;

/**
 * Klasse zum Erkennen verschiedener Touchgesten. Fuer die unterschiedlichen
 * Touch Gesten koennen Callback function registriert werden.
 */
class SwipeHandler {
  static SwipeHandler instance;
  //callbacks
  var onSwipeUp;
  var onSwipeDown;
  var onSwipeLeft;
  var onSwipeRight;
  var onTap;
  num xDown;
  num yDown;
  num startTime;

  static SwipeHandler getInstance() {
    if (instance == null) {
      instance = new SwipeHandler();
    }
    return instance;
  }

  /**
   * Event Handler fuer onTouchstart Events. Speichert den Punkt und den
   * Zeitpunkt zu dem die Touch Geste beginnt.
   */
  void handleTouchStart(TouchEvent e) {
    if (startTime == null) {
      startTime = new DateTime.now().millisecondsSinceEpoch;
    }
    xDown = e.touches[0].client.x;
    yDown = e.touches[0].client.y;
  }

  /**
   * Event Handler fuer onTouchEnd Events. Erkennts 'Tap' Gesten und
   * loest die entsprechende Callback Funktion aus.
   */
  void handleTouchEnd(TouchEvent e) {
    if (startTime == null) {
      return null;
    }
    num stopTime = new DateTime.now().millisecondsSinceEpoch;
    (stopTime - startTime < 200) && (onTap != null) ? onTap() : null;
    startTime = null;
  }

  /**
   * Event Handler fuer onTouchMove Events. Erkennt unterschiedliche Swipe Gesten
   * und loest die entsprechende Callback Funktion aus.
   */
  void handleTouchMove(TouchEvent e) {
    //lokale Hilfsfunktion fue den Betrag einer Zahl
    num _abs(num x) => x > 0 ? x : -x;

    if (xDown == null || yDown == null) {
      return null;
    }

    var xUp = e.touches[0].client.x;
    var yUp = e.touches[0].client.y;

    var xDiff = xDown - xUp;
    var yDiff = yDown - yUp;

    if (_abs(xDiff) > _abs(yDiff)) {
      if (xDiff > 0) {
        onSwipeLeft != null ? onSwipeLeft() : null;
      } else {
        onSwipeRight != null ? onSwipeRight() : null;
      }
    } else {
      if (yDiff > 0) {
        onSwipeUp != null ? onSwipeUp() : null;
      } else {
        onSwipeDown != null ? onSwipeDown() : null;
      }
    }
    xDown = null;
    yDown = null;
  }
}
