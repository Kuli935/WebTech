part of tetris;

class ITetromino extends Tetromino{

  ITetromino(TetrisGame model) : super(model, [
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 - 2 },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 - 1 },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2     },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 + 1 }
  ], #cyan);

  void rotate(int direction){
    //Drehmatrix fuer diese Beispieltransition
    List<List<int>> transition = [
      [-3, 1], [-2, 0], [-1, -1], [0, -2]
    ];
    //Tetromino vom feld entfernen, damit nach der Drehung die alten Zellen
    //nicht mehr aktiv sind
    removeFromField();
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