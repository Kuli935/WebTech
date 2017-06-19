part of tetris;

class NumberOfRowClearedGoal extends Goal{

  NumberOfRowClearedGoal(TetrisGame model, Level level, double goalValue):
        super(model, level, 'FooBar', goalValue){

  }

  double getProgress(){
    return _level.goalMetrics['numberOfRowsCleared'];
  }

  /**
   * Prueft ob die fuer dieses Level spezifizierte Anzahl an Reihen
   * vervollstaendigt wurde.
   */
  bool isCompleted(){
    if(_level.goalMetrics['numberOfRowsCleared'] >= _goalValue.toInt()){
      return true;
    }
    return false;
  }
}