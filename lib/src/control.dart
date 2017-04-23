part of tetris;

/**
 * Diese Konstante beschreibt die Geschwindigkeit von dem Tetris Stein
 * Ein [tetrisSpeed] von 1000ms bestimmt 1 Bewegungen pro Sekunde.
 */
const tetrisSpeed = const Duration(milliseconds: 1000);

/**
 * Ein [TetrisGameController]-Objekt registriert mehrere Handler
 * um die Interaktion von einem Benutzers zu greifen für das [TetrisGame] und
 * diese zu übersetzen in gültige [TetrisGame] Taten.
 *
 * Des weiteren löst ein [TetrisGameController]-Objekt die
 * Bewegungen eines Objekts [Tetris].
 *
 * Erforderliche Updates für die Ansicht sind, das [TetisView]-Objekt übertragen
 * um den Benutzer zu informieren, was sich im [TetrisGame] verändert
 */
class TetrisGameController {

  /**
   * Erzeugen eines Tetris Game. Aufruf aus der Datei model.dart.
   */
  var game = new TetrisGame(gameHeight, gameWidth, nextStoneFieldHeight, nextStoneFieldWidth);

  /**
   * Erzeugen der Tetrisansicht. Aufruf aus der Datei view.dart.
   */
  final view = new TetrisView();

  /**
   * Periodischer Auslöser, der Tetrisbewegungen steuert
   */
  Timer tetrisTrigger;


  /**
   * Konstuktor um ein Controller für Objekte zu erzeugen.
   * Registriert alle notwendigen Ereignishandler die notwendig sind
   * für den Benutzer zu der Interaktion mit dem Tetris Spiel.
   */
  TetrisGameController() {

    view.generateField(game);
    view.generateNextStoneField(game);

    // Ein neues Spiel wurde von dem Benutzer gestarted
    view.startButton.onClick.listen((_) {
      if (tetrisTrigger != null) tetrisTrigger.cancel();
      tetrisTrigger = new Timer.periodic(tetrisSpeed, (_) => _moveTetris());
      game.start();
      view.update(game);
    });

    // Steuerung des Tetris Blocks
  }


  /**
   * Bewegt den Tetris Stein.
   */
  void _moveTetris() {
    game.moveTetris();
    view.update(game);
  }


  /**
   * Inizalisiert ein neues Spiel.
   */
  dynamic _newGame() async {
    game = new TetrisGame(gameWidth, gameHeight, nextStoneFieldHeight, nextStoneFieldWidth);


  }


}