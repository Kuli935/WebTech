part of tetris;

///
/// Dieses PowerUp entfernt alle bereits gesetzten Steine die in den selben
/// Zeilen sind, wie der Tetromino welcher das PowerUp auslöst. Es kann nur
/// aktiviert werden, wenn der Tetromio auf den Boden aufsetzt oder mit einem
/// anderen Tetromino kollidiert.
///
class RemoveAllRowsOfTetromino extends PowerUp {
  Tetromino _tetromino;

  ///
  /// Entfernt alle Steine um den Tetromino.
  /// [model] TetrisGame Klasse
  /// [tetromino] Tetromino Klasse
  ///
  RemoveAllRowsOfTetromino(TetrisGame model, Tetromino tetromino) :
        super(model, 'RemoveAllRowsOfTetromino') {
    _tetromino = tetromino;
  }

  ///
  /// Gibt den Status isActive zurück.
  /// [kwargs] enthaelt Daten, die benoetigt werden, um zu ueberpruefen ob
  /// die Bedingung erfuellt wurde
  ///
  bool _isConsumable(Map<String, Object> kwargs) {
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

  ///
  /// Benutzen des PowerUps.
  /// [kwargs] enthaelt Daten, die benoetigt werden, um zu ueberpruefen ob
  /// die Bedingung erfuellt wurde
  ///
  void consume(Map<String, Object> kwargs) {
    if (_isConsumable(kwargs)) {
      // Datentyp Set nutzen, um Duplikate zu vermeiden
      Set<num> rowsToRemove = new HashSet();
      _tetromino.stones.forEach((stone) {
        rowsToRemove.add(stone['row']);
      });
      _model.removeRows(rowsToRemove.toList());
    }
  }
}