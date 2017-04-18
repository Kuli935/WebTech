part of tetris;

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
  var game = new TetrisGame(gameHeight, gameWidth);

  /**
   * Erzeugen der Tetrisansicht. Aufruf aus der Datei view.dart.
   */
  final view = new TetrisView();


  /**
   * Konstuktor um ein Controller für Objekte zu erzeugen.
   * Registriert alle notwendigen Ereignishandler die notwendig sind
   * für den Benutzer zu der Interaktion mit dem Tetris Spiel.
   */
  TetrisGameController() {

    view.generateField(game);

    // Ein neues Spiel wurde von dem Benutzer gestarted
    view.startButton.onClick.listen((_) {
      game.start();
      view.update(game);
    });

    // Steuerung des Tetris Blocks

  }



  /**
   * Inizalisiert ein neues Spiel.
   */
  dynamic _newGame() async {
    game = new TetrisGame(gameWidth, gameHeight);
  }


}