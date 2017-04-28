part of tetris;

/**
 * Definiert die interne Representation des Spielfelds.
 */
class Cell {
  bool _isActive;
  int _row;
  int _col;
  Symbol _color;

  /**
   * Konstruktor um ein Cell Objekte zu erzeugen.
   * @param int row = Reihe
   * @param int col = Spalte
   * @param Symbol color = Farbe des Tetromino
   */
  Cell(int row, int col, Symbol color) {
    this._isActive = false;
    this._row = row;
    this._col = col;
    this._color = color;
  }

  /**
   * Gibt den Status isActive zurück.
   */
  bool get isActive => this._isActive;

  /**
   * Gibt die Reihe zurück.
   */
  int get row => this._row;

  /**
   * Gibt die Spalte zurück.
   */
  int get col => this._col;

  /**
   * Gibt die Farbe des Tetromino zurück.
   */
  Symbol get color => this._color;

  /**
   * Setzt den Status von isActive.
   */
  set isActive(bool newState) => this._isActive = newState;

  /**
   * Setzt die Farbe des Tetromino zurück.
   */
  set color(Symbol newColor) => this._color = newColor;
}
