part of tetris;

abstract class Goal {

  Level _level;
  String _description;
  double _goalValue;

  Goal(Level level, String description, double goalValue)
      :
        _level = level,
        _description = description,
        _goalValue = goalValue {}

  String get description => _description;

  double getProgress();

  bool isCompleted();

  double get goalValue => _goalValue;
}