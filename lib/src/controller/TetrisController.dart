part of tetris;

/**
 * Diese Konstante beschreibt die Geschwindigkeit von dem Tetromino
 * Ein [tetrominoSpeed] von 1000ms bestimmt 1 Bewegungen pro Sekunde.
 */

const tetrominoSpeed = const Duration(milliseconds: 500);

/**
 * Ein [TetrisController]-Objekt registriert mehrere Handler
 * um die Interaktion von einem Benutzers zu greifen für das [TetrisGame] und
 * diese zu übersetzen in gültige [TetrisGame] Taten.
 *
 * Des weiteren löst ein [TetrisGameController]-Objekt die
 * Bewegungen eines Objekts [Tetromino].
 *
 * Erforderliche Updates für die Ansicht sind, das [TetisView]-Objekt übertragen
 * um den Benutzer zu informieren, was sich im [TetrisGame] verändert
 */
class TetrisController {

  /**
   * Erzeugen eines Tetris Game. Aufruf aus der Datei Tetromino.dart.
   */
  var game = new TetrisGame(gameHeight, gameWidth, nextStoneFieldHeight, nextStoneFieldWidth);

  /**
   * Erzeugen der Tetrisansicht. Aufruf aus der Datei TetrisView.dart im Ordner view.
   */
  final view = new TetrisView();

  /**
   * Periodischer Auslöser, der Tetrisbewegungen steuert
   */
  Timer tetrominoTrigger;


  /**
   * Konstuktor um ein Controller für Objekte zu erzeugen.
   * Registriert alle notwendigen Ereignishandler die notwendig sind
   * für den Benutzer zu der Interaktion mit dem Tetris Spiel.
   */
  TetrisController() {

    view.generateField(game);
    view.generateNextStoneField(game);

    //Vorbereiten der Touch Steuerung des Tetromino
    SwipeHandler sw = SwipeHandler.getInstance();
    // Nach links bewegen
    sw.onSwipeLeft = (){
        game.tetromino.left();
        game.moveTetromino();
        game.tetromino.down();
        view.update(game);
    };

    // Nach rechts bewegen
    sw.onSwipeRight = (){
        game.tetromino.right();
        game.moveTetromino();
        game.tetromino.down();
        view.update(game);
    };

    // Nach unten bewegen
    sw.onSwipeDown = (){
      game.tetromino.down();
      game.moveTetromino();
      view.update(game);
    };

    // Drehen um 90 Grad
    sw.onSwipeUp = (){
      game.tetromino.rotate(90);
      view.update(game);
    };

    // Steuerung des Tetromino über Tastatur
    window.onKeyDown.listen((KeyboardEvent ev) {
      if (game.stopped) return;
      // Nach links bewegen
      if (ev.keyCode == KeyCode.LEFT) {
        game.tetromino.left();
        game.moveTetromino();
        game.tetromino.down();
        view.update(game);
      }

      // Nach rechts bewegen
      if (ev.keyCode == KeyCode.RIGHT) {
        game.tetromino.right();
        game.moveTetromino();
        game.tetromino.down();
        view.update(game);
      }

      // Nach unten bewegen
      if (ev.keyCode == KeyCode.DOWN) {
        game.tetromino.down();
        game.moveTetromino();
        view.update(game);
      }

      // Drehen um 90 Grad
      if (ev.keyCode == KeyCode.UP) {
        game.tetromino.rotate(90);
        view.update(game);
      }
    });


    // Ein neues Spiel wurde von dem Benutzer gestarted
    view.startButton.onClick.listen((_) {
      if (tetrominoTrigger != null) tetrominoTrigger.cancel();
      tetrominoTrigger = new Timer.periodic(tetrominoSpeed, (_) => _moveTetromino());
      game.start();
      //Touch Steuerung registieren
      window.onTouchStart.listen(sw.handleTouchStart);
      window.onTouchMove.listen(sw.handleTouchMove);
      window.onTouchEnd.listen(sw.handleTouchEnd);
      view.update(game);
    });

  }


  /**
   * Bewegt den Tetromino.
   */
  void _moveTetromino() {
    //window.console.log('SPEED INCREASED FOR DEBUG.');
    game.moveTetromino();
    view.update(game);
  }


  /**
   * Inizalisiert ein neues Spiel.
   */
  dynamic _newGame() async {
    game = new TetrisGame(gameWidth, gameHeight, nextStoneFieldHeight, nextStoneFieldWidth);
  }


}