part of tetris;

/*
  A simple event handler that detects 4 different swipe directions (up, down,
  left, right) based on the touch gestures registered. The SwipeHandler is a
  singelton, because every app has one window, which needs one way of handling
  touch swipes at most. Different callbacks for each swipe direction can be
  provided.
 */
class SwipeHandler {
  //The singelton instance
  static SwipeHandler instance;
  //callbacks
  var onSwipeUp;
  var onSwipeDown;
  var onSwipeLeft;
  var onSwipeRight;
  var onTap;
  //vars to store the first point of a touch movement
  num xDown;
  num yDown;
  num startTime;

  static SwipeHandler getInstance() {
    if (instance == null) {
      instance = new SwipeHandler();
    }
    return instance;
  }

  //records the first point of a touch movement and the time it happened
  void handleTouchStart(TouchEvent e) {
    if (startTime == null) {
      startTime = new DateTime.now().millisecondsSinceEpoch;
    }
    xDown = e.touches[0].client.x;
    yDown = e.touches[0].client.y;
  }

  void handleTouchEnd(TouchEvent e) {
    if (startTime == null) {
      return null;
    }
    //check how long the user touched
    num stopTime = new DateTime.now().millisecondsSinceEpoch;
    (stopTime - startTime < 200) && (onTap != null) ? onTap() : null;
    startTime = null;
  }

  //The method is looking for swipes. If a swipe motion is recognized, the
  //the callback for this swipe motion is called.
  void handleTouchMove(TouchEvent e) {
    //local helper function for the absolute of a value
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
