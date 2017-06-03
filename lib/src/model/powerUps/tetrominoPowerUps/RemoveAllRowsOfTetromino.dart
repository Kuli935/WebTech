part of tetris;

/**
 * Dieses PowerUp entfernt alle bereits gesetzten Steine die in den selben
 * Zeilen sind, wie der Tetromino welcher das PowerUp auslöst. Es kann nur
 * aktiviert werden, wenn der Tetromio auf den Boden aufsetzt oder mit einem
 * anderen Tetromino kollidiert.
 */
class RemoveAllRowsOfTetromino extends PowerUp{
  Tetromino _tetromino;

  RemoveAllRowsOfTetromino(TetrisGame model, Tetromino tetromino):
        super(model, 'RemoveAllRowsOfTetromino'){
    _tetromino = tetromino;
  }

  bool _isConsumable(Map<String, Object> kwargs){
    //prufen, ob alle benoetigten Daten uebergeben wurden
    if(!kwargs.containsKey('tetrominoMove')){
      return false;
    }
    if(_tetromino._collisionWithGround(kwargs['tetrominoMove']) ||
       _tetromino._collisionWithOtherTetromino(kwargs['tetrominoMove'])){
      return true;
    } else{
      return false;
    }
  }

  void consume(Map<String, Object> kwargs) {
    if (_isConsumable(kwargs)) {
      //Datentyp Set nutzen, um Duplikate zu vermeiden
      Set<num> rowsToRemove = new HashSet();
      _tetromino.stones.forEach((stone) {
        rowsToRemove.add(stone['row']);
      });
      _model.removeRows(rowsToRemove.toList());
    }
  }
}