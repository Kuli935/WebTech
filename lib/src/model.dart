part of tetris;

/**
 *  * Definiert ein Tetris-Block im Tetris Spiel.
 */
class Tetris {

  /**
   * Verweist auf das Spiel.
   */
  final TetrisGame _game;

  /**
   * Konstuktor um ein [Tetris] Objekt für ein [TetrisGame] zu erzeugen.
   */
  Tetris.on(this._game) {

  }


}




/**
 * Definiert ein Tetris Spiel. Eine Tetris Spielkonstante ist das n x m Feld.
 */
class TetrisGame {

  // Die Feldgröße des Spiels (n x m Feld)
  final int _sizeHeight;
  final int _sizeWidth;

  // Die Feldgröße für nächsten Tetris Stein (n x m Feld)
  final int _nextStoneFieldHeight;
  final int _nextStoneFieldWidth;


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
  TetrisGame(this._sizeHeight, this._sizeWidth, this._nextStoneFieldHeight, this._nextStoneFieldWidth) {
    start();
  }


  /**
   * Returns ein Spielfeld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   */
  List<List<Symbol>> get field {
    var _field = new Iterable.generate(sizeHeight, (row) {
      return new Iterable.generate(sizeWidth, (col) => #empty).toList();
    }).toList();
    //andere Elemente
    return _field;
  }

  /**
   * Returns Nächster-Tetris-Stein-Feld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   */
  List<List<Symbol>> get nextStoneField {
    var _nextStoneField = new Iterable.generate(nextStoneFieldHeight, (row) {
      return new Iterable.generate(nextStoneFieldWidth, (col) => #empty).toList();
    }).toList();
    //andere Elemente
    return _nextStoneField;
  }

  /**
   * Returns die Größe des Spielffeldes. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeHeight => _sizeHeight;
  int get sizeWidth => _sizeWidth;

  /**
   * Returns die Größe des Feldes für den nächsten Stein.
   */
  int get nextStoneFieldHeight => _nextStoneFieldHeight;
  int get nextStoneFieldWidth => _nextStoneFieldWidth;
}