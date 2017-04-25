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

    //Vorbereiten der Touch Steuerung
    SwipeHandler sw = SwipeHandler.getInstance();
    sw.onSwipeLeft = (){
      bool canMove = true;
      //pruefen ob der Stein am Rand des Spielfelds ist
      game.tetris._stone.forEach((var element){
        element['col'] == 0 ? canMove = false : null;
      });
      if(canMove){
        game.tetris.left();
        game.moveTetris();
        game.tetris.down();
        view.update(game);
      }
    };
    sw.onSwipeRight = (){
      bool canMove = true;
      game.tetris._stone.forEach((var element){
        element['col'] == 9 ? canMove = false : null;
      });
      if(canMove){
        game.tetris.right();
        game.moveTetris();
        game.tetris.down();
        view.update(game);
      }
    };
    // Ein neues Spiel wurde von dem Benutzer gestarted
    view.startButton.onClick.listen((_) {
      if (tetrisTrigger != null) tetrisTrigger.cancel();
      tetrisTrigger = new Timer.periodic(tetrisSpeed, (_) => _moveTetris());
      game.start();
      //Touch Steuerung registieren
      window.onTouchStart.listen(sw.handleTouchStart);
      window.onTouchMove.listen(sw.handleTouchMove);
      window.onTouchEnd.listen(sw.handleTouchEnd);
      view.update(game);
    });
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