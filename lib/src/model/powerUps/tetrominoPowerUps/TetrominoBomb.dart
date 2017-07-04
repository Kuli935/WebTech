part of tetris;

/// Dieses PowerUp laesst den zugehoerigen tetromino explodieren, wenn er
/// gesetzt wird. Die Explosion hat breitet sich 2 Felder in jede Richtung aus.
class TetrominoBomb extends PowerUp{

  /// Der Tetromino zu dem dieses PowerUp gehoert
  Tetromino _tetromino;

  /// Erstellt ein neues [TrteominoBomb] PowerUp. Dieses gehoesrt zum TetrisGame
  /// [model] und ist an den Tetromino [tetrominoe] gebunden.
  TetrominoBomb(TetrisGame model, Tetromino tetromino):
    _tetromino = tetromino,
    super(model, 'TetrominoBomb'){}

  /// Prueft, ob das PowerUp eingesetzt werden kann. Das [kwargs] Argument
  /// musss alle relevanten Daten zur Ueberpruefung enthalten.
  bool _isConsumable(Map<String, Object> kwargs){
    // prufen, ob alle benoetigten Daten uebergeben wurden
    if (!kwargs.containsKey('tetrominoMove')) {
      return false;
    }
    if (_tetromino._collisionWithGround(kwargs['tetrominoMove']) ||
        _tetromino._collisionWithOtherTetromino(kwargs['tetrominoMove'])) {
      return true;
    } else {
      return false;
    }
  }

  /// Aktiviert das PowerUp
  void consume(Map<String, Object> kwargs){
    if(_isConsumable(kwargs)) {
      List<Map<String, int>> potentialCellsToClear = new List();
      // alle moeglichen Positionen errechnen
      _tetromino.stones.forEach((stone) {
        potentialCellsToClear.add({'row': stone['row'], 'col': stone['col'] - 1});
        potentialCellsToClear.add({'row': stone['row'], 'col': stone['col'] - 2});
        potentialCellsToClear.add({'row': stone['row'], 'col': stone['col'] + 1});
        potentialCellsToClear.add({'row': stone['row'], 'col': stone['col'] + 2});
        potentialCellsToClear.add({'row': stone['row'] - 1, 'col': stone['col']});
        potentialCellsToClear.add({'row': stone['row'] - 2, 'col': stone['col']});
        potentialCellsToClear.add({'row': stone['row'] + 1, 'col': stone['col']});
        potentialCellsToClear.add({'row': stone['row'] + 2, 'col': stone['col']});
        potentialCellsToClear.add(stone);
      });
      List<Map<String, int>> cellsToClear = new List();
      potentialCellsToClear.forEach((cell){
        // nur die Positionen weiter verwenden, die auch auf dem Spielfeld sind
        if(cell['row'] < _model.sizeHeight && cell['row'] > 0 &&
            cell['col'] >= 0 && cell['col'] < _model.sizeWidth){
          cellsToClear.add(cell);
        }
      });
      _model.removeTetrominoFromCells(cellsToClear);
    }
  }

}