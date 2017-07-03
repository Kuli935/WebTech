part of tetris;

///
/// Definiert die interne Repraesentation des Spielfelds.
///
class Cell {
  /// [isActive] der fallende Tetromino der gerade aktiv ist und sich bewegen kann
  bool _isActive;

  /// [row] Reihe
  int _row;

  /// [col] Spalte
  int _col;

  /// [color] Farbe des Tetrominoes
  Symbol _color;

  ///
  /// Konstruktor um ein Cell Objekte zu erzeugen.
  /// [row] Reihe
  /// [col] Spalte
  /// [color] Farbe des Tetromino
  ///
  Cell(int row, int col, Symbol color) {
    this._isActive = false;
    this._row = row;
    this._col = col;
    this._color = color;
  }

  ///
  /// Gibt den Status isActive zurück.
  ///
  bool get isActive => this._isActive;

  ///
  /// Gibt die Reihe zurück.
  ///
  int get row => this._row;

  ///
  /// Gibt die Spalte zurück.
  ///
  int get col => this._col;

  ///
  /// Gibt die Farbe des Tetromino zurück.
  ///
  Symbol get color => this._color;

  ///
  /// Setzt den Status von isActive.
  ///
  set isActive(bool newState) => this._isActive = newState;

  ///
  /// Setzt die Farbe des Tetromino zurück.
  ///
  set color(Symbol newColor) => this._color = newColor;
}
