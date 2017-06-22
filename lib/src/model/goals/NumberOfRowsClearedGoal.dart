part of tetris;

class NumberOfRowClearedGoal extends Goal {

  NumberOfRowClearedGoal(Level level, double goalValue) :
        super(level, 'Reihen vervollständigen', goalValue) {

  }

  double getProgress() {
    return _level.goalMetrics['numberOfRowsCleared'];
  }

  ///
  /// Prueft ob die fuer dieses Level spezifizierte Anzahl an Reihen
  /// vervollstaendigt wurde.
  ///
  bool isCompleted() {
    if (_level.goalMetrics['numberOfRowsCleared'] >= _goalValue.toInt()) {
      return true;
    }
    return false;
  }
}