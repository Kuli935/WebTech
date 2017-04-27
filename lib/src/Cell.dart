part of tetris;

class Cell{
  bool _isActive;
  int _row;
  int _col;
  Symbol _color;

  Cell(int row, int col, Symbol color){
    this._isActive = false;
    this._row = row;
    this._col = col;
    this._color = color;
  }

  bool get isActive => this._isActive;
  int get row => this._row;
  int get col => this._col;
  Symbol get color => this._color;

  set isActive(bool newState) => this._isActive = newState;
  set color(Symbol newColor) => this._color = newColor;
}