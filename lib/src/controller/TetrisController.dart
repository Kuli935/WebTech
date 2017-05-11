part of tetris;

/**
 * Diese Konstante beschreibt die Geschwindigkeit von dem Tetromino
 * Ein [tetrominoSpeed] von 1000ms bestimmt 1 Bewegungen pro Sekunde.
 */

const tetrominoSpeed = const Duration(milliseconds: 1000);

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
  var game = new TetrisGame(gameHeight, gameWidth, extraFieldHeight, extraFieldWidth);

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

    // Erzeugen des Spielfeldes
    view.generateField(game.field, 1, "field");
    // Erzeugen des Nächsten-Tetromino-Feldes
    view.generateField(game.nextStoneField, 2, "nextstone");
    // Erzeugen des Gehalteten-Tetromino-Feldes
    view.generateField(game.holdStoneField, 3, "holdstone");

    // Button Steuerung
    // Nach links bewegen
    view.leftButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.left();
      game.moveTetromino();
      game.tetromino.down();
      view.update(game);
    });

    // Nach rechts bewegen
    view.rightButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.right();
      game.moveTetromino();
      game.tetromino.down();
      view.update(game);
    });

    // Nach unten bewegen
    view.downButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.down();
      game.moveTetromino();
      view.update(game);
    });

    // Drehen um 90 Grad (rechts Drehung)
    view.rightRotationButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.rotate(90);
      view.update(game);
    });


    // Drehen um -90 Grad (links Drehung)
    view.leftRotationButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.rotate(-90);
      view.update(game);
    });

    // ruft Menü / Pause auf
    view.menuButton.onClick.listen((_) {
      if (game.stopped) return;
      game.pauseTetromino();
      view.update(game);
    });

    // Direkter Fall
    view.hardDropButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.hardDropCurrentTetromino();
      view.update(game);
    });

    // Tetromino halten
    view.holdButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.hold();
      view.update(game);
    });


    // Steuerung des Tetromino über Tastatur
    window.onKeyDown.listen((KeyboardEvent ev) {
      if (game.stopped) return;
      // Nach links bewegen
      if (ev.keyCode == KeyCode.LEFT) {
        if (game.paused) return;
        game.tetromino.left();
        game.moveTetromino();
        game.tetromino.down();
        view.update(game);
      }

      // Nach rechts bewegen
      if (ev.keyCode == KeyCode.RIGHT) {
        if (game.paused) return;
        game.tetromino.right();
        game.moveTetromino();
        game.tetromino.down();
        view.update(game);
      }

      // Nach unten bewegen
      if (ev.keyCode == KeyCode.DOWN) {
        if (game.paused) return;
        game.tetromino.down();
        game.moveTetromino();
        view.update(game);
      }

      // Drehen um 90 Grad (rechts Drehung)
      if (ev.keyCode == KeyCode.UP) {
        if (game.paused) return;
        game.tetromino.rotate(90);
        view.update(game);
      }


      // Drehen um -90 Grad (links Drehung)
      if (ev.keyCode == KeyCode.Y) {
        if (game.paused) return;
        game.tetromino.rotate(-90);
        view.update(game);
      }

      // ruft Menü / Pause auf
      if (ev.keyCode == KeyCode.ESC) {
        game.pauseTetromino();
        view.update(game);
      }

      // Direkter Fall
      if (ev.keyCode == KeyCode.SPACE) {
        if (game.paused) return;
        game.hardDropCurrentTetromino();
        view.update(game);
      }

      // Tetromino halten
      if (ev.keyCode == KeyCode.C) {
        if (game.paused) return;
        game.tetromino.hold();
        view.update(game);
      }


    });


    // Ein neues Spiel wurde von dem Benutzer gestarted
    view.startButton.onClick.listen((_) {
      if (tetrominoTrigger != null) tetrominoTrigger.cancel();
      tetrominoTrigger = new Timer.periodic(tetrominoSpeed, (_) => _moveTetromino());
      game.start();
      view.update(game);
    });

    // Fortsetzen Button wurde gedrückt
    view.continueButton.onClick.listen((_) {
      game.pauseTetromino();
      view.update(game);
    });

    // Neues Spiel Button wurde gedrückt
    view.newGameButton.onClick.listen((_) {
      _newGame();
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
    game = new TetrisGame(gameHeight, gameWidth, extraFieldHeight, extraFieldWidth);
    // Erzeugen des Spielfeldes
    view.generateField(game.field, 1, "field");
    // Erzeugen des Nächsten-Tetromino-Feldes
    view.generateField(game.nextStoneField, 2, "nextstone");
    // Erzeugen des Gehalteten-Tetromino-Feldes
    view.generateField(game.holdStoneField, 3, "holdstone");
    game.start();
    view.update(game);
  }


}