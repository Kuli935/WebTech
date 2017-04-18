part of tetris;

/**
 *  * Definiert ein Tetris-Block im Tetris Spiel.
 */
class Tetris {




}




/**
 * Definiert ein Tetris Spiel. Eine Tetris Spielkonstante ist das n x m Feld.
 */
class TetrisGame {

  // Die Feldgröße des Spiels (n x m Feld)
  final int _sizeHeight;
  final int _sizeWidth;


  // Spielzustand #running or #stopped.
  Symbol _gamestate;

  /**
   * Startet des Spiel
   */
  void start() { _gamestate = #running; }

  /**
   * Stopt das Spiel
   */
  void stop() { _gamestate = #stopped; }

  /**
   * Konstruktor um ein neues Tetris Spiel zu erzeugen
   */
  TetrisGame(this._sizeHeight, this._sizeWidth) {
    start();
  }


  /**
   * Returns ein Spielfeld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus zwei gültigen Zustände (Symbole).
   * #empty #blocked
   */
  List<List<Symbol>> get field {
    var _field = new Iterable.generate(sizeHeight, (row) {
      return new Iterable.generate(sizeWidth, (col) => #empty).toList();
    }).toList();
    //andere Elemente
    return _field;
  }



  /**
   * Returns die Größe des Spielffeldes. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeHeight => _sizeHeight;
  int get sizeWidth => _sizeWidth;

}