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

  bool _collisionWithBorder(List<Map<String, int>> move){
    bool isCollision = false;
    move.forEach((stone){
      if(stone['col'] <= 0 || stone['col'] >= _model._sizeWidth){
        isCollision = true;
      }
    });
    return isCollision;
  }

  bool _collisionWithGround(List<Map<String, int>> move){
    bool isCollision = false;
    move.forEach((stone){
      (stone['row'] >= _model.sizeHeight) ? isCollision = true : null;
    });
    return isCollision;
  }
  
  get stones => _stones;

  get color => _color;
}