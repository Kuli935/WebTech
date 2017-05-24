part of tetris;

abstract class Tetromino{

  List<Map<String, int>> _stones;
  TetrisGame _model;
  Symbol _color;
  int _dc;
  int _dr;

  Tetromino(TetrisGame model, List<Map<String, int>> stones, Symbol color){
    _stones = stones;
    _model = model;
    _color = color;
    down();
  }

  /**
   * Abstrakte Definition fuer die Drehung eines Tetrominos. Die Rotation ist
   * fuer jeden Tetromino anders.
   */
  void rotate(int angle);

  void move(){
    //Bewegung berechnen
    var move = new List<Map<String, int>>();
    _stones.forEach((stone) {
      move.add({ 'row' : stone['row'] + _dr,  'col' : stone['col'] + _dc  });
    });
    //pruefen, ob Bewegung Kollision verursacht
    _collisionWithTop(move) ? _model.stop() : null;
    if(!_collisionWithBorder(move) && !_collisionWithGround(move) &&
       !_collisionWithOtherTetromino(move)) {
      //keine Kollisionen => Tetomino kann bewegt werden
      _moveToNewPosition(move);
    } else{
      _handleCollision(move);
    }
    _model.updateField();
  }

  void _handleCollision(List<Map<String, int>> move){
    /*
    Kollisionen mit den Seitenraender des Spielfelds muessen nicht extra
    behandelt werden, da in diesem Fall eine Bewegung einfach nicht moeglich ist
     */
    if(_collisionWithBorder(move)){
      return;
    }
    if(_collisionWithGround(move)){
      //falls der Tetrmino auf den Boden faellt wird er gesetzt
      _stones.forEach((stone) {
        _model.field[stone['row']][stone['col']].isActive = false;
      });
      _model.removeCompletedRows();
    } else if(_collisionWithOtherTetromino(move)){
      bool movesSideways = (this._dc != 0);
      if(movesSideways){
        //ungueltige seitwaerts Bewegung rueckgaening machen
        move.forEach((piece) {piece['col'] -= this._dc;});
        _moveToNewPosition(move);
      } else {
        //Tetromino in der Position fest setzen
        _stones.forEach((stone) {
          _model.field[stone['row']][stone['col']].isActive = false;
        });
        //falls eine oder mehrere Reihen vervollstaendigt sind mussen diese
        //entfernt werden und alle Reihen darueber nachrutschen
        _model.removeCompletedRows();
      }
    }
    //TODO: tell model to drop the next tetromino
  }

  void _moveToNewPosition(List<Map<String, int>> move){
    _stones.forEach((stone) {
      _model.field[stone['row']][stone['col']].isActive = false;
      _model.field[stone['row']][stone['col']].color = #empty;
    });
    _stones = move;
    _stones.forEach((stone) {
      _model.field[stone['row']][stone['col']].isActive = true;
    });
  }

  bool _collisionWithBorder(List<Map<String, int>> move){
    bool isCollision = false;
    move.forEach((stone){
      if(stone['col'] < 0 || stone['col'] >= _model._sizeWidth){
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

  bool _collisionWithTop(List<Map<String, int>> move){
    bool isCollision = false;
    move.forEach((stone){
      (stone['row'] <= 0) ? isCollision = true : null;
    });
    return isCollision;
  }

  bool _collisionWithOtherTetromino(List<Map<String, int>> move){
    bool isCollision = false;
    /*
    Alle Zellen des Moves pruefen, ob sie belegt und inaktiv sind. Falls
    ja liegt eine Kollision mit einem bereits gesetzten Tetromino vor.
     */
    move.forEach((stone){
      if(_model.field[stone['row']][stone['col']].color != #empty &&
        !_model.field[stone['row']][stone['col']].isActive){
          isCollision = true;
      }
    });
    return isCollision;
  }
  /**
   * Teilt dem Tetromino keine Bewegung mit, somit stoppt der Tetromino.
   */
  void stop()  { _dr =  0; _dc =  0; }

  /**
   * Teilt dem Tetromino die Bewegung nach unten mit.
   */
  void down()  { _dr =  1; _dc =  0; }

  /**
   * Teilt dem Tetromino die Bewegung nach links mit.
   */
  void left()  { _dr =  0; _dc = -1; }

  /**
   * Teilt dem Tetromino die Bewegung nach rechts mit.
   */
  void right() { _dr =  0; _dc =  1; }

  get stones => _stones;

  get color => _color;
}