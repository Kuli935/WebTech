part of tetris;

class ITetromino extends Tetromino{

  int _state;
  int _numberOfStates;
  List<List<List<int>>> _transitions;

  ITetromino(TetrisGame model) : super(model, [
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 - 2 },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 - 1 },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2     },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 + 1 }
  ], #cyan){
    _state = 0;
    _numberOfStates = 4;
    _transitions = [
      [[-3, 1], [-2, 0], [-1, -1], [0, -2]], //t0: s0 -> s1
      [[3, -1], [2, 0], [1, 1], [0, 2]], //t1: s1 -> s2
      [[-3, 1], [-2, 0], [-1, -1], [0, -2]], //t2: s2 -> s0
      [[3, -1], [2, 0], [1, 1], [0, 2]]
    ];
  }

  void rotate(int direction){
    /*
    Die richtige Drehmatrix wird in Abhaengigkeit des Zustandes und der
    Drehrichtung ausgewält.
     */
    List<List<int>> transition;
    int nextState;

    if(direction > 0){
      transition = _transitions.elementAt(_state);
      nextState = (_state + 1) % _numberOfStates;
    } else{
      (_state == 0) ? nextState = _numberOfStates - 1 : nextState--;
      transition = _transitions.elementAt(nextState);
    }
    List<Map<String, int>> move = new List();
    //Position des gedrehten Tetrominoes berechnen
    for(int i=0; i < _stones.length; i++){
      if(_stones[i]['row'] + direction * transition[i][0] < 0) return;
      move.add({'row': _stones[i]['row'] + direction * transition[i][0],
                'col': _stones[i]['col'] + direction * transition[i][1]});
    }
    //pruefen, ob Drehung Kollisionen verursacht, falls ja Drehung nicht moeglich
    if(!_collisionWithBorder(move) && !_collisionWithGround(move) &&
        !_collisionWithOtherTetromino(move)) {
      //durch die Drehung wird der Tetromino in den naechsten Zustand ueberfuehrt
      _state = nextState;
      _moveToNewPosition(move);
      _model.updateField();
    }
  }
}