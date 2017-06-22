part of tetris;


/// Diese Konstante beschreibt Zeit (in ms), welche zwischen zwei Bewegungen
/// eines Tetrominoes vergeht.
/// 
/// Ein [tetrominoSpeed] von 1000ms bestimmt 1 Bewegungen pro Sekunde.
const tetrominoSpeed = const Duration(milliseconds: 1000);

///
/// TODO: .....
/// Ein [TetrisController]-Objekt registriert mehrere Handler
/// um die Interaktion von einem Benutzers zu greifen für das [TetrisGame] und
/// diese zu übersetzen in gültige [TetrisGame] Taten.
///
/// Des weiteren löst ein [TetrisGameController]-Objekt die
/// Bewegungen eines Objekts [Tetromino].
///
/// Erforderliche Updates für die Ansicht sind, das [TetisView]-Objekt übertragen
/// um den Benutzer zu informieren, was sich im [TetrisGame] verändert
///
class TetrisController {

  /// Das zu diesem Controller zugehoerige Model.
  TetrisGame game;

  /// Die zu diesem Controller zugehoerige Ansicht.
  final TetrisView _view = new TetrisView();

  /// Periodischer Timer, welcher das Spiel
  Timer tetrominoTrigger;

  /// Ein [Reader] welcher die Konfiguration fuer die zu diesem Controller
  /// zugehoerige Spielinstanz bereit stellt.
  final JsonReader _configReader;

  /// Erstellt einen neuen TetrisContoroller, dessen Model nach der
  /// Konfiguration des uebergebenen [Reader] konfiguriert wird.
  TetrisController(Reader configReader) : _configReader = configReader {
    //start a new game, the games configuration is read from the _configReader
    TetrisGameBuilder modelBuilder = new TetrisGameBuilder(_configReader);
    game = modelBuilder.build('modelDefault');

    // Erzeugen des Spielfeldes
    _view.generateField(game.fieldRepresentation, 1, "field");
    // Erzeugen des Nächsten-Tetromino-Feldes
    _view.generateField(game.nextStoneField, 2, "nextstone");
    // Erzeugen des Gehalteten-Tetromino-Feldes
    _view.generateField(game.holdStoneField, 3, "holdstone");
    _registerControlCallbacks();
  }

  /// Initialisiert ein neues Spiel.
  dynamic _newGame() async{
    TetrisGameBuilder modelBuilder = new TetrisGameBuilder(_configReader);
    game = modelBuilder.build('modelDefault');
    // Erzeugen des Spielfeldes
    _view.generateField(game.fieldRepresentation, 1, "field");
    // Erzeugen des Nächsten-Tetromino-Feldes
    _view.generateField(game.nextStoneField, 2, "nextstone");
    // Erzeugen des Gehalteten-Tetromino-Feldes
    _view.generateField(game.holdStoneField, 3, "holdstone");
    game.start();
    _view.update(game);
  }

  /// Bewegt den Tetromino.
  void _moveTetromino() {
    game.moveTetromino();
    _view.update(game);
  }

  /// Registriert die Callbacks fuer die Steuerund des Spiels.
  void _registerControlCallbacks(){
    // Button Steuerung
    // Nach links bewegen
    _view.leftButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.left();
      game.moveTetromino();
      game.tetromino.down();
      _view.update(game);
    });

    // Nach rechts bewegen
    _view.rightButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.right();
      game.moveTetromino();
      game.tetromino.down();
      _view.update(game);
    });

    // Nach unten bewegen
    _view.downButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.down();
      game.moveTetromino();
      _view.update(game);
    });

    // Drehen um 90 Grad (rechts Drehung)
    _view.rightRotationButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.rotate(1);
      _view.update(game);
    });


    // Drehen um -90 Grad (links Drehung)
    _view.leftRotationButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.tetromino.rotate(-1);
      _view.update(game);
    });

    // ruft Menü / Pause auf
    _view.menuButton.onClick.listen((_) {
      if (game.stopped) return;
      game.pauseTetromino();
      _view.update(game);
    });

    // Direkter Fall
    _view.hardDropButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.hardDropCurrentTetromino();
      _view.update(game);
    });

    // Tetromino halten
    _view.holdButton.onClick.listen((_) {
      if (game.stopped || game.paused) return;
      game.holdCurrentTetrominoe();
      _view.update(game);
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
        _view.update(game);
      }

      // Nach rechts bewegen
      if (ev.keyCode == KeyCode.RIGHT) {
        if (game.paused) return;
        game.tetromino.right();
        game.moveTetromino();
        game.tetromino.down();
        _view.update(game);
      }

      // Nach unten bewegen
      if (ev.keyCode == KeyCode.DOWN) {
        if (game.paused) return;
        game.tetromino.down();
        game.moveTetromino();
        _view.update(game);
      }

      // Drehen um 90 Grad (rechts Drehung)
      if (ev.keyCode == KeyCode.UP) {
        if (game.paused) return;
        game.tetromino.rotate(1);
        _view.update(game);
      }


      // Drehen um -90 Grad (links Drehung)
      if (ev.keyCode == KeyCode.Y) {
        if (game.paused) return;
        game.tetromino.rotate(-1);
        _view.update(game);
      }

      // ruft Menü / Pause auf
      if (ev.keyCode == KeyCode.ESC) {
        game.pauseTetromino();
        _view.update(game);
      }

      // Direkter Fall
      if (ev.keyCode == KeyCode.SPACE) {
        if (game.paused) return;
        game.hardDropCurrentTetromino();
        _view.update(game);
      }

      // Tetromino halten
      if (ev.keyCode == KeyCode.C) {
        if (game.paused) return;
        game.holdCurrentTetrominoe();
        _view.update(game);
      }
    });


    // Ein neues Spiel wurde von dem Benutzer gestarted
    _view.startButton.onClick.listen((_) {
      if (tetrominoTrigger != null) tetrominoTrigger.cancel();
      tetrominoTrigger =
      new Timer.periodic(tetrominoSpeed, (_) => _moveTetromino());
      game.start();
      _view.update(game);
    });

    // Fortsetzen Button wurde gedrückt
    _view.continueButton.onClick.listen((_) {
      game.pauseTetromino();
      _view.update(game);
    });

    // Neues Spiel Button wurde gedrückt
    _view.newGameButton.onClick.listen((_) {
      _newGame();
      _view.update(game);
    });
  }

}