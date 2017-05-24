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

  //TODO: check if a rotation is possible
  //prevent tetrominoes from being rotated off the field
  void rotate(int direction){
    //Tetromino vom feld entfernen, damit nach der Drehung die alten Zellen
    //nicht mehr aktiv sind
    removeFromField();

    /*
    Die richtige Drehmatrix wird in Abhaengigkeit des Zustandes und der
    Drehrichtung ausgewält.
     */
    List<List<int>> transition;

    if(direction > 0){
      transition = _transitions.elementAt(_state);
      _state = (_state + 1) % _numberOfStates; //2 is max number of states
    } else{
      (_state == 0) ? _state = _numberOfStates - 1 : _state--;
      transition = _transitions.elementAt(_state);
    }
    //Tetromino drehen
    for(int i=0; i < _stones.length; i++){
      _stones[i]['row'] += direction * transition[i][0];
      _stones[i]['col'] += direction * transition[i][1];
    }
    //gedrehten Tetrominoe wieder zum Feld hinzufuegen, damit er sichtbar und
    //aktiv wird.
    addToField();
    _model.updateField();
  }
}