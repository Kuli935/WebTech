part of 'tetris';

abstract class Tetromino{

  List<Map<String, int>> _stones;
  TetrisGame _model;
  Symbol _color;
  int _dc;
  int _dr;

  Tetromino(TetrisGame model, List<Map<String, int>> stones, Symbol color){
    this._stones = stones;
    this._model = model;
    this._color = color;
  }

  /**
   * Abstrakte Definition fuer die Drehung eines Tetrominos. Die Rotation ist
   * fuer jeden Tetromino anders.
   */
  void rotate();

  void move(){
    //Bewegung berechnen
    final _move = new List<Map<String, int>>();
    _stones.forEach((stone) {
      _move.add({ 'row' : stone['row'] + _dr,  'col' : stone['col'] + _dc  });
    });
    //pruefen, ob Bewegung Kollision verursacht
    //falls: nein Tetromino bewegen
  }

  get stones => _stones;

  get color => _color;
}