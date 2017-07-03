part of tetris;

class NumberOfTetrominoesFallenGoal extends Goal {

  NumberOfTetrominoesFallenGoal(Level level, double goalValue) :
        super(level, 'Tetrominoes setzen', goalValue) {

  }

  double getProgress() {
    return _level.goalMetrics['numberOfTetrominoesFallen'];
  }

  ///
  /// Prueft ob die fuer dieses Level spezifizierte Anzahl an Reihen
  /// vervollstaendigt wurde.
  ///
  bool isCompleted() {
    if (_level.goalMetrics['numberOfTetrominoesFallen'] >= _goalValue.toInt()) {
      return true;
    }
    return false;
  }
}