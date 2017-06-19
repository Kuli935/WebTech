part of tetris;

abstract class Goal{

  TetrisGame _model;
  Level _level;
  String _description;
  double _goalValue;

  Goal(TetrisGame model, Level level,  String description, double goalValue):
        _model = model,
        _level = level,
        _description = description,
        _goalValue = goalValue{}

  String get description => _description;

  double getProgress();

  bool isCompleted();

  double get goalValue => _goalValue;
}